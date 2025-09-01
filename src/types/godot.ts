import type { Address } from 'viem';

export type GodotIframe = HTMLIFrameElement & {
  contentWindow?: GodotWindow | null;
};

export type GodotWindow = Window & {
  appUrl: string;
  accountAddress: Address | null;
  login: () => void;
  logout: () => void;
};
