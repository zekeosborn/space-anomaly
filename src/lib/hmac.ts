import crypto from 'crypto';

const hmacSecretKey = process.env.HMAC_SECRET_KEY!;
if (!hmacSecretKey) throw new Error('HMAC_SECRET_KEY is not set');

const maxTimeDiff = 30 * 1000; // 30s

export function generateHmac(data: string, timestamp: string) {
  const hmac = crypto.createHmac('sha256', hmacSecretKey);
  hmac.update(data);
  hmac.update(timestamp);
  return hmac.digest('hex');
}

export function verifyHmac(data: string, timestamp: number, signature: string) {
  const expected = generateHmac(data, timestamp.toString());
  const isFresh = Math.abs(Date.now() - timestamp) <= maxTimeDiff;
  const isValid = signature === expected;
  return isFresh && isValid;
}
