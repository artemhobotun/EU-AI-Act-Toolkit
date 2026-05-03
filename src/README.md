# TypeScript Quiz Engine

This directory contains the typed scoring logic for the EU AI Act Toolkit's AI governance readiness self-check quiz.

## Purpose

The `quiz-engine.ts` module provides a reusable, type-safe implementation of the readiness quiz scoring logic. It can be used to:

- Validate quiz question definitions
- Calculate readiness scores
- Determine result levels and recommendations
- Support future quiz applications or integrations

## How It Maps to the Static Pages Quiz

The vanilla JavaScript quiz (`docs/assets/site.js`) implements the same logic as defined here:

- **Question definitions** match the 10-question structure in `QUIZ_QUESTIONS`
- **Scoring** uses the same weighted calculation: options have scores, questions have weights
- **Result levels** match: low (≤33%), moderate (34-66%), high (67%+)
- **Recommendations** follow the same three tiers of guidance

The TypeScript version is the canonical definition; the JavaScript is the runtime implementation.

## Future Uses

This TypeScript engine can support:

1. **Quiz Configuration Generation** — export `QUIZ_QUESTIONS` to JSON/YAML for validation or versioning
2. **Validation** — check new quiz question definitions against the `QuizQuestion` type
3. **API Endpoints** — run scoring server-side if a backend is added
4. **Testing** — unit tests can validate scoring logic independently of the Pages UI
5. **Audit Trail** — log scores and recommendations for organisations tracking readiness over time

## Key Exports

- `ReadinessLevel` — enum of three result tiers
- `QuizQuestion`, `QuizOption` — types for questions and answers
- `calculateScore()` — compute raw score from answers
- `getReadinessLevel()` — determine tier from percentage
- `getRecommendations()` — fetch next-step suggestions for a tier
- `calculateReadinessScore()` — full pipeline: answer array → `QuizResult`
- `QUIZ_QUESTIONS` — the 10-question set used in the static quiz

## Important Note

This scoring engine is a practical readiness aid. It does not constitute legal advice and does not determine compliance. Legal determinations require qualified professional review.
