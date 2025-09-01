import {
  addRpcUrlOverrideToChain,
  type PrivyClientConfig,
} from '@privy-io/react-auth';
import { monadTestnet } from 'viem/chains';

const rpcUrl = process.env.NEXT_PUBLIC_RPC_URL;
const crossAppId = process.env.NEXT_PUBLIC_CROSS_APP_ID!;
if (!crossAppId) throw new Error('NEXT_PUBLIC_CROSS_APP_ID is not set');

const monadTestnetOverride = addRpcUrlOverrideToChain(
  monadTestnet,
  rpcUrl || 'https://testnet-rpc.monad.xyz',
);

const privyConfig: PrivyClientConfig = {
  defaultChain: monadTestnetOverride,
  supportedChains: [monadTestnetOverride],
  loginMethodsAndOrder: {
    primary: [`privy:${crossAppId}`],
  },
};

export default privyConfig;
