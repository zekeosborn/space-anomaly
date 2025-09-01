'use client';

import {
  usePrivy,
  type CrossAppAccountWithMetadata,
} from '@privy-io/react-auth';
import { useEffect, useState } from 'react';
import { type Address } from 'viem';

const crossAppId = process.env.NEXT_PUBLIC_CROSS_APP_ID!;
if (!crossAppId) throw new Error('NEXT_PUBLIC_CROSS_APP_ID is not set');

export default function usePrivyAuth() {
  const { ready, authenticated, user } = usePrivy();
  const [accountAddress, setAccountAddress] = useState<Address | null>(null);

  useEffect(() => {
    // Check if privy is ready and user is authenticated
    if (ready && authenticated && user) {
      // Check if user has linkedAccounts
      if (user.linkedAccounts.length > 0) {
        // Get the cross app account created using Monad Games ID
        const crossAppAccount = user.linkedAccounts.filter(
          (account) =>
            account.type === 'cross_app' &&
            account.providerApp.id === crossAppId,
        )[0] as CrossAppAccountWithMetadata;

        // The first embedded wallet created using Monad Games ID, is the wallet address
        if (crossAppAccount && crossAppAccount.embeddedWallets.length > 0) {
          const address = crossAppAccount.embeddedWallets[0].address as Address;
          setAccountAddress(address);
        }
      }
    } else {
      // Clear address when not authenticated
      setAccountAddress(null);
    }
  }, [authenticated, ready, user]);

  return { accountAddress };
}
