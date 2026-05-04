/**
 * EU AI Act Toolkit - Readiness Quiz Scoring Engine
 *
 * Typed TypeScript implementation of the AI governance readiness quiz logic.
 * This mirrors the vanilla JavaScript quiz in docs/assets/site.js.
 *
 * The quiz evaluates an organisation's readiness for EU AI Act compliance
 * across key dimensions: AI tool use, vendor procurement, data handling,
 * human oversight, and governance maturity.
 */

/**
 * Result level thresholds and recommendations
 */
export enum ReadinessLevel {
  Low = 'low-readiness-attention',
  Moderate = 'moderate-readiness-attention',
  High = 'high-readiness-or-escalation',
}

/**
 * A single answer option in the quiz
 */
export interface QuizOption {
  label: string;
  value: string;
  score: number;
}

/**
 * A single question in the quiz
 */
export interface QuizQuestion {
  id: string;
  category: string;
  text: string;
  weight: number;
  options: QuizOption[];
}

/**
 * User answer: question index and selected option index
 */
export interface UserAnswer {
  questionIndex: number;
  selectedOptionIndex: number;
}

/**
 * Result recommendation with next steps
 */
export interface Recommendation {
  text: string;
  href: string;
  label: string;
}

/**
 * Quiz result with level, description, and recommendations
 */
export interface QuizResult {
  level: ReadinessLevel;
  score: number;
  maxScore: number;
  percentage: number;
  description: string;
  recommendations: Recommendation[];
}

/**
 * Calculate raw score from answers
 */
export function calculateScore(
  questions: QuizQuestion[],
  answers: (number | null)[]
): number {
  let score = 0;
  answers.forEach((answerIndex, questionIndex) => {
    if (answerIndex !== null && answerIndex >= 0) {
      const question = questions[questionIndex];
      const option = question.options[answerIndex];
      if (option) {
        score += option.score;
      }
    }
  });
  return score;
}

/**
 * Calculate maximum possible score
 */
export function calculateMaxScore(questions: QuizQuestion[]): number {
  return questions.reduce((max, q) => {
    const maxOption = Math.max(...q.options.map((o) => o.score));
    return max + maxOption;
  }, 0);
}

/**
 * Determine readiness level from score percentage
 */
export function getReadinessLevel(percentage: number): ReadinessLevel {
  if (percentage <= 33) {
    return ReadinessLevel.Low;
  } else if (percentage <= 66) {
    return ReadinessLevel.Moderate;
  } else {
    return ReadinessLevel.High;
  }
}

/**
 * Get recommendations based on readiness level
 */
export function getRecommendations(level: ReadinessLevel): Recommendation[] {
  const baseUrl = '/EU-AI-Act-Toolkit/';

  const recommendations: Record<ReadinessLevel, Recommendation[]> = {
    [ReadinessLevel.Low]: [
      {
        text: 'Create a basic AI tool inventory to track what you use',
        label: 'Starter Pack',
        href: baseUrl + 'packs.html',
      },
      {
        text: 'Review the Starter Pack for low-overhead governance templates',
        label: 'Starter Pack',
        href: baseUrl + 'packs.html',
      },
      {
        text: 'Bookmark the decision tree for future tool reviews',
        label: 'Decision Tree',
        href: '../docs/19-sme-decision-tree.md',
      },
      {
        text: 'Check official EU sources to understand the broader regulatory context',
        label: 'Official EU Sources',
        href: baseUrl + 'official-sources.html',
      },
    ],
    [ReadinessLevel.Moderate]: [
      {
        text: 'Start an AI inventory using the provided CSV template',
        label: 'AI Inventory Template',
        href: '../toolkit/templates/ai-system-inventory.csv',
      },
      {
        text: 'Run a risk screening on your key AI tools',
        label: 'Risk Screening Form',
        href: '../toolkit/templates/ai-risk-screening-form.md',
      },
      {
        text: 'Review vendor agreements — use the Vendor Assessment Pack',
        label: 'Vendor Pack',
        href: baseUrl + 'packs.html',
      },
      {
        text: 'Consider a documented AI usage policy for staff',
        label: 'AI Usage Policy',
        href: baseUrl + 'packs.html',
      },
    ],
    [ReadinessLevel.High]: [
      {
        text: 'Prioritise building an AI tool inventory and risk register',
        label: 'Inventory Template',
        href: '../toolkit/templates/ai-system-inventory.csv',
      },
      {
        text: 'Review vendor AI terms for all active tools — use the Vendor Pack',
        label: 'Vendor Pack',
        href: baseUrl + 'packs.html',
      },
      {
        text: 'Establish or formalise human review for high-output decisions',
        label: 'Governance Guide',
        href: baseUrl + 'packs.html',
      },
      {
        text: 'Consult the escalation guide to identify cases requiring legal review',
        label: 'Escalation Guide',
        href: '../docs/16-what-to-escalate-for-legal-review.md',
      },
    ],
  };

  return recommendations[level];
}

/**
 * Calculate full quiz result
 */
export function calculateReadinessScore(
  questions: QuizQuestion[],
  answers: (number | null)[]
): QuizResult {
  const score = calculateScore(questions, answers);
  const maxScore = calculateMaxScore(questions);
  const percentage = maxScore > 0 ? (score / maxScore) * 100 : 0;
  const level = getReadinessLevel(percentage);
  const recommendations = getRecommendations(level);

  const descriptions: Record<ReadinessLevel, string> = {
    [ReadinessLevel.Low]:
      'You\'re just getting started. Focus on understanding your current AI inventory and initial risk screening.',
    [ReadinessLevel.Moderate]:
      'You\'ve made good progress. Now assess your vendors and deepen your governance practices.',
    [ReadinessLevel.High]:
      'You\'re well-prepared. Consider sharing your practices and supporting others.',
  };

  return {
    level,
    score,
    maxScore,
    percentage: Math.round(percentage),
    description: descriptions[level],
    recommendations,
  };
}

/**
 * Example quiz questions matching the static Pages implementation
 */
export const QUIZ_QUESTIONS: QuizQuestion[] = [
  {
    id: 'q1-ai-tool-use',
    category: 'AI Tool Use',
    text: 'Does your organisation use any AI-powered tools? (e.g. ChatGPT, Microsoft Copilot, AI-enabled SaaS, automated decision systems)',
    weight: 1,
    options: [
      { label: 'Yes — we regularly use AI tools', value: 'yes', score: 1 },
      { label: 'Sometimes — occasional or informal use', value: 'sometimes', score: 1 },
      { label: 'No / not sure', value: 'no', score: 0 },
    ],
  },
  {
    id: 'q2-vendor-procurement',
    category: 'Vendor Procurement',
    text: 'Do you procure, evaluate, or manage AI-enabled SaaS tools from third-party vendors?',
    weight: 1,
    options: [
      { label: 'Yes — we regularly buy or renew AI-enabled tools', value: 'yes', score: 1 },
      { label: 'Occasionally', value: 'occ', score: 1 },
      { label: 'No', value: 'no', score: 0 },
    ],
  },
  {
    id: 'q3-impact-on-people',
    category: 'Impact on People',
    text: 'Does any AI system affect decisions about employees, job applicants, or customers?',
    weight: 2,
    options: [
      { label: 'Yes — AI informs HR, hiring, or customer decisions', value: 'yes', score: 2 },
      { label: 'Possibly — some indirect influence', value: 'poss', score: 1 },
      { label: 'No', value: 'no', score: 0 },
    ],
  },
  {
    id: 'q4-personal-data',
    category: 'Personal Data',
    text: 'Is personal data processed by any AI tool in your organisation? (names, behaviour, location, profiling data, etc.)',
    weight: 2,
    options: [
      { label: 'Yes — personal data is processed', value: 'yes', score: 2 },
      { label: 'Possibly — we are not fully certain', value: 'poss', score: 1 },
      { label: 'No', value: 'no', score: 0 },
    ],
  },
  {
    id: 'q5-human-oversight',
    category: 'Human Oversight',
    text: 'Is there a formal human review process before acting on AI-generated outputs in key decisions?',
    weight: 2,
    options: [
      { label: 'No — outputs are used directly without formal review', value: 'no', score: 2 },
      { label: 'Partial — some review, but not consistently applied', value: 'part', score: 1 },
      { label: 'Yes — all material outputs are reviewed by humans', value: 'yes', score: 0 },
    ],
  },
  {
    id: 'q6-governance-documentation',
    category: 'Governance Documentation',
    text: 'Does your organisation have a documented AI tool inventory or register?',
    weight: 1,
    options: [
      { label: 'No — there is no formal inventory', value: 'no', score: 1 },
      { label: 'Partial — some tools are listed informally', value: 'part', score: 1 },
      { label: 'Yes — we maintain a structured inventory', value: 'yes', score: 0 },
    ],
  },
  {
    id: 'q7-vendor-documentation',
    category: 'Vendor Documentation',
    text: 'Are AI vendor data agreements (DPA, terms of service, AI usage terms) reviewed before procurement?',
    weight: 2,
    options: [
      { label: 'No — we rarely or never review vendor AI terms', value: 'no', score: 2 },
      { label: 'Partially — only for some vendors or contracts', value: 'part', score: 1 },
      { label: 'Yes — we have a structured vendor review process', value: 'yes', score: 0 },
    ],
  },
  {
    id: 'q8-ai-literacy-policy',
    category: 'AI Literacy & Policy',
    text: 'Does your organisation have a staff AI usage policy or AI literacy training in place?',
    weight: 1,
    options: [
      { label: 'No — nothing formal is in place', value: 'no', score: 1 },
      { label: 'In progress — something is being developed', value: 'prog', score: 1 },
      { label: 'Yes — policy and/or training exists and is used', value: 'yes', score: 0 },
    ],
  },
  {
    id: 'q9-scoring-profiling',
    category: 'Scoring & Profiling',
    text: 'Does any AI tool score, rank, profile, or make recommendations about individual people?',
    weight: 3,
    options: [
      {
        label: 'Yes — AI scores or ranks individuals (leads, candidates, customers, etc.)',
        value: 'yes',
        score: 3,
      },
      { label: 'Possibly — used in targeting or segmentation', value: 'poss', score: 2 },
      { label: 'No', value: 'no', score: 0 },
    ],
  },
  {
    id: 'q10-risk-domain',
    category: 'Risk Domain',
    text: 'Does your AI use touch any higher-sensitivity domains? (healthcare-adjacent, legal decisions, financial assessment, public services, children or vulnerable groups)',
    weight: 3,
    options: [
      { label: 'Yes — one or more of these apply to our AI use', value: 'yes', score: 3 },
      { label: 'Possibly — borderline or adjacent cases', value: 'poss', score: 2 },
      {
        label: 'No — our AI use is in general internal or marketing contexts',
        value: 'no',
        score: 0,
      },
    ],
  },
];
