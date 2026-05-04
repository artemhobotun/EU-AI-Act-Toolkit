import { describe, expect, it } from 'vitest';
import {
  calculateMaxScore,
  calculateReadinessScore,
  calculateScore,
  getReadinessLevel,
  type QuizQuestion,
  QUIZ_QUESTIONS,
  ReadinessLevel,
} from './quiz-engine';

function optionIndexWithMaxScore(question: QuizQuestion): number {
  let idx = 0;
  let best = question.options[0]?.score ?? 0;
  question.options.forEach((opt, i) => {
    if (opt.score > best) {
      best = opt.score;
      idx = i;
    }
  });
  return idx;
}

function optionIndexWithMinScore(question: QuizQuestion): number {
  let idx = 0;
  let best = question.options[0]?.score ?? 0;
  question.options.forEach((opt, i) => {
    if (opt.score < best) {
      best = opt.score;
      idx = i;
    }
  });
  return idx;
}

describe('getReadinessLevel', () => {
  it('uses inclusive 33% as low tier boundary', () => {
    expect(getReadinessLevel(33)).toBe(ReadinessLevel.Low);
    expect(getReadinessLevel(34)).toBe(ReadinessLevel.Moderate);
  });

  it('uses inclusive 66% as moderate tier boundary', () => {
    expect(getReadinessLevel(66)).toBe(ReadinessLevel.Moderate);
    expect(getReadinessLevel(67)).toBe(ReadinessLevel.High);
  });
});

describe('QUIZ_QUESTIONS invariants', () => {
  it('has ten questions and a positive max score', () => {
    expect(QUIZ_QUESTIONS).toHaveLength(10);
    expect(calculateMaxScore(QUIZ_QUESTIONS)).toBeGreaterThan(0);
  });
});

describe('calculateReadinessScore', () => {
  it('returns Low when every answer picks the lowest-risk option', () => {
    const answers = QUIZ_QUESTIONS.map((q) => optionIndexWithMinScore(q));
    const result = calculateReadinessScore(QUIZ_QUESTIONS, answers);
    expect(result.level).toBe(ReadinessLevel.Low);
    expect(result.score).toBe(0);
    expect(result.percentage).toBe(0);
  });

  it('returns High when every answer picks the highest-risk option', () => {
    const answers = QUIZ_QUESTIONS.map((q) => optionIndexWithMaxScore(q));
    const result = calculateReadinessScore(QUIZ_QUESTIONS, answers);
    expect(result.level).toBe(ReadinessLevel.High);
    expect(result.score).toBe(calculateMaxScore(QUIZ_QUESTIONS));
    expect(result.percentage).toBe(100);
  });

  it('can return Moderate for a mixed response pattern', () => {
    const maxAnswers = QUIZ_QUESTIONS.map((q) => optionIndexWithMaxScore(q));
    const minAnswers = QUIZ_QUESTIONS.map((q) => optionIndexWithMinScore(q));
    const blended = maxAnswers.map((v, i) => (i % 2 === 0 ? v : minAnswers[i]));
    const result = calculateReadinessScore(QUIZ_QUESTIONS, blended);
    expect(result.level).toBe(ReadinessLevel.Moderate);
    expect(result.percentage).toBeGreaterThan(33);
    expect(result.percentage).toBeLessThan(67);
  });
});

describe('calculateScore', () => {
  it('ignores out-of-range option indices', () => {
    const answers = QUIZ_QUESTIONS.map(() => 999);
    expect(calculateScore(QUIZ_QUESTIONS, answers)).toBe(0);
  });
});
