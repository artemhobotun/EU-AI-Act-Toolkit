import { readFileSync } from 'fs';
import { dirname, resolve } from 'path';
import { fileURLToPath } from 'url';
import { describe, expect, it } from 'vitest';

const __dirname = dirname(fileURLToPath(import.meta.url));

/** Site quiz thresholds must stay aligned with .github/tools/quiz-engine/quiz-engine.ts (getReadinessLevel). */
describe('docs/assets/site.js quiz thresholds', () => {
  const siteJsPath = resolve(__dirname, '../../docs/assets/site.js');
  const src = readFileSync(siteJsPath, 'utf8');

  it('uses inclusive 33% and 66% boundaries like the TypeScript engine', () => {
    expect(src).toContain('if (percentage <= 33)');
    expect(src).toContain('} else if (percentage <= 66)');
    expect(src).not.toMatch(/percentage < 33/);
    expect(src).not.toMatch(/percentage < 66/);
  });
});
