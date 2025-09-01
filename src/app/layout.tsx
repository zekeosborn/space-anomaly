import Providers from '@/components/providers';
import type { Metadata } from 'next';
import { Geist } from 'next/font/google';
import type { PropsWithChildren } from 'react';
import './globals.css';

const geist = Geist({
  variable: '--font-geist',
  subsets: ['latin'],
});

export const metadata: Metadata = {
  title: 'Space Anomaly',
};

export default function RootLayout({ children }: PropsWithChildren) {
  return (
    <html lang="en">
      <body className={`${geist.variable} dark`}>
        <Providers>{children}</Providers>
      </body>
    </html>
  );
}
