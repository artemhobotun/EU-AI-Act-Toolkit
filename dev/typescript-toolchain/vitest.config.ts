import path from 'path';
import { fileURLToPath } from 'url';
import { defineConfig } from 'vitest/config';

const toolchainDir = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(toolchainDir, '../..');

export default defineConfig({
  root: repoRoot,
  test: {
    environment: 'node',
    include: ['src/**/*.test.ts'],
  },
});
