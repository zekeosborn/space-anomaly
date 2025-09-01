import gamesIdAbi from '@/lib/blockchain/games-id-abi';
import { account, publicClient, walletClient } from '@/lib/blockchain/viem';
import { verifyHmac } from '@/lib/hmac';
import { NextRequest, NextResponse } from 'next/server';
import { type Address } from 'viem';
import z from 'zod';

const gamesIdAddress = process.env.GAMES_ID_ADDRESS as Address;
const gameAddress = process.env.GAME_ADDRESS as Address;

if (!gamesIdAddress) throw new Error('GAMES_ID_ADDRESS is not set');
if (!gameAddress) throw new Error('GAME_ADDRESS is not set');

export async function POST(request: NextRequest) {
  try {
    // Validate request body
    const body = await request.json();
    const validation = schema.safeParse(body);

    if (!validation.success) {
      return NextResponse.json(validation.error.format(), { status: 400 });
    }

    const { address, score } = validation.data;
    const playerAddress = address as Address;

    // HMAC authentication
    const timestamp = parseInt(request.headers.get('x-timestamp') ?? '0', 10);
    const signature = request.headers.get('x-signature') ?? '';
    const isHmacValid = verifyHmac(JSON.stringify(body), timestamp, signature);

    if (!isHmacValid) {
      return NextResponse.json({ error: 'Forbidden' }, { status: 403 });
    }

    // Check if score is higher than current score
    const [currentScore] = await publicClient.readContract({
      address: gamesIdAddress,
      abi: gamesIdAbi,
      functionName: 'playerDataPerGame',
      args: [gameAddress, playerAddress],
    });

    if (score <= currentScore) {
      return NextResponse.json({ error: 'Not high score' }, { status: 409 });
    }

    // Submit score to monad games id
    const score_diff = BigInt(score) - currentScore;

    const { request: submitScore } = await publicClient.simulateContract({
      address: gamesIdAddress,
      abi: gamesIdAbi,
      functionName: 'updatePlayerData',
      args: [playerAddress, score_diff, BigInt(0)],
      account,
    });

    await walletClient.writeContract(submitScore);

    return NextResponse.json({
      message: 'Score submitted successfully',
    });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: 'Failed to submit score' },
      { status: 500 },
    );
  }
}

const schema = z.object({
  address: z.string().regex(/^0x[a-fA-F0-9]{40}$/, {
    message: 'Invalid address',
  }),
  score: z.number().int().nonnegative(),
});
