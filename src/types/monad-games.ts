export interface MonadGamesUser {
  id: number;
  username: string;
  walletAddress: string;
}

export interface UserResponse {
  hasUsername: boolean;
  user?: MonadGamesUser;
}
