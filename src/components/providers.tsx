'use client';

import privyConfig from '@/lib/configs/privy-config';
import wagmiConfig from '@/lib/configs/wagmi-config';
import { PrivyProvider } from '@privy-io/react-auth';
import { WagmiProvider } from '@privy-io/wagmi';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import type { PropsWithChildren } from 'react';

const privyAppId = process.env.NEXT_PUBLIC_PRIVY_APP_ID!;
if (!privyAppId) throw new Error('NEXT_PUBLIC_PRIVY_APP_ID is not set');

const queryClient = new QueryClient();

export default function Providers({ children }: PropsWithChildren) {
  return (
    <PrivyProvider appId={privyAppId} config={privyConfig}>
      <QueryClientProvider client={queryClient}>
        <WagmiProvider config={wagmiConfig}>{children}</WagmiProvider>
      </QueryClientProvider>
    </PrivyProvider>
  );
}
