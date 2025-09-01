import {
  type Address,
  createPublicClient,
  createWalletClient,
  http,
} from 'viem';
import { privateKeyToAccount } from 'viem/accounts';
import { monadTestnet } from 'viem/chains';

const rpcUrl = process.env.NEXT_PUBLIC_RPC_URL;
const privateKey = process.env.PRIVATE_KEY as Address;
if (!privateKey) throw new Error('PRIVATE_KEY is not set');

export const publicClient = createPublicClient({
  chain: monadTestnet,
  transport: http(rpcUrl),
});

export const walletClient = createWalletClient({
  chain: monadTestnet,
  transport: http(rpcUrl),
});

export const account = privateKeyToAccount(privateKey);
