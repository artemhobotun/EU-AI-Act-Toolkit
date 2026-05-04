import path from 'path';
import { fileURLToPath } from 'url';
import { defineConfig } from 'vitest/config';

const toolchainDir = path.dirname(fileURLToPath(import.meta.url));
export default defineConfig({
  root: toolchainDir,
  test: {
    environment: 'node',
    include: ['./**/*.test.ts'],
  },
});
