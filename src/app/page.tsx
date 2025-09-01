'use client';

import usePrivyAuth from '@/hooks/use-privy-auth';
import { GodotIframe } from '@/types/godot';
import { usePrivy } from '@privy-io/react-auth';
import { useEffect, useRef } from 'react';

const appUrl = process.env.NEXT_PUBLIC_APP_URL!;
const godotVersion = process.env.NEXT_PUBLIC_GODOT_VERSION!;

if (!appUrl) throw new Error('NEXT_PUBLIC_APP_URL is not set');
if (!godotVersion) throw new Error('NEXT_PUBLIC_GODOT_VERSION is not set');

export default function Home() {
  const godotRef = useRef<GodotIframe>(null);
  const { ready, login, logout } = usePrivy();
  const { accountAddress } = usePrivyAuth();

  useEffect(() => {
    const godotWindow = godotRef.current?.contentWindow;

    if (godotWindow) {
      godotWindow.appUrl = appUrl;
      godotWindow.accountAddress = accountAddress;
      godotWindow.login = login;
      godotWindow.logout = logout;
    }
  }, [accountAddress, login, logout]);

  if (!ready) {
    return (
      <div className="flex h-svh items-center justify-center">
        <p>Loading...</p>
      </div>
    );
  }

  return (
    <div className="h-svh">
      <iframe
        ref={godotRef}
        title="Space Anomaly"
        src={`/godot/${godotVersion}/index.html`}
        className="h-full w-full"
        sandbox="allow-scripts allow-same-origin allow-popups"
      />
    </div>
  );
}
