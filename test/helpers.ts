export async function mustThrow(asyncFn: () => Promise<any>, msg?: string) {
  try {
    await asyncFn();
    throw new Error(msg ?? 'Expected function to throw, but it did not');
  } catch (e) {
    // If a specific message was provided, ensure it matches when possible
    if (msg && e && (e as Error).message !== msg) {
      throw e;
    }
    return e;
  }
}

export function delay(ms: number) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
