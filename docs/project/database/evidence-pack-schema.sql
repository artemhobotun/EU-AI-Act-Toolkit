/**
 * EU AI Act Toolkit — Optional Evidence Pack Schema
 *
 * DISCLAIMER: This schema is an optional internal documentation aid for SMEs
 * who want to store AI governance evidence in a structured local database.
 * This schema is not legal advice and does not guarantee compliance.
 *
 * Use cases:
 * - Track AI tools in use across the organisation
 * - Document risk screening results and decisions
 * - Record vendor assessments and procurement decisions
 * - Log incidents or governance reviews
 * - Maintain evidence of readiness practices
 *
 * This is SQLite-compatible and intended for local, internal use only.
 * Do not store sensitive personal data or confidential information here
 * without appropriate security controls.
 */

-- AI Systems: Track every AI tool in use
CREATE TABLE IF NOT EXISTS ai_systems (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  vendor TEXT,
  description TEXT,
  category TEXT,
  -- Category options: internal_genai, customer_chatbot, hr_recruitment, marketing, vendor_saas, document_review, crm_scoring, other
  data_processed TEXT,
  -- Brief description of data types
  owner TEXT,
  -- Person/team responsible for this tool
  created_date TEXT DEFAULT CURRENT_TIMESTAMP,
  last_reviewed_date TEXT,
  review_status TEXT DEFAULT 'pending',
  -- pending, in_progress, completed, escalated
  notes TEXT
);

-- Risk Screening: Results of readiness screening for each AI tool
CREATE TABLE IF NOT EXISTS risk_screenings (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ai_system_id INTEGER NOT NULL,
  screening_date TEXT NOT NULL,
  -- Key screening dimensions
  data_risk TEXT,
  -- low, moderate, high
  oversight_risk TEXT,
  vendor_clarity TEXT,
  escalation_recommended INTEGER DEFAULT 0,
  -- 1 = yes, 0 = no
  escalation_reason TEXT,
  reviewer TEXT,
  notes TEXT,
  FOREIGN KEY (ai_system_id) REFERENCES ai_systems(id)
);

-- Vendors: Track third-party vendors providing AI-enabled services
CREATE TABLE IF NOT EXISTS vendors (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL UNIQUE,
  product_name TEXT,
  ai_features_description TEXT,
  contract_signed_date TEXT,
  renewal_date TEXT,
  dpa_in_place INTEGER DEFAULT 0,
  -- 1 = yes, 0 = no
  data_processing_terms TEXT,
  -- Brief summary of how the vendor uses data
  support_contact TEXT,
  review_status TEXT DEFAULT 'pending',
  -- pending, reviewed, approved_with_conditions, rejected
  last_assessment_date TEXT,
  notes TEXT
);

-- Vendor Reviews: Detailed assessment of vendor AI practices
CREATE TABLE IF NOT EXISTS vendor_reviews (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  vendor_id INTEGER NOT NULL,
  review_date TEXT NOT NULL,
  -- Assessment dimensions
  ai_transparency TEXT,
  -- low, moderate, high
  model_traceability TEXT,
  -- Whether vendor can explain model behavior
  training_data_clarity TEXT,
  -- Whether vendor discloses training data sources
  bias_mitigation TEXT,
  -- Whether vendor addresses bias concerns
  human_override_capability INTEGER DEFAULT 1,
  -- 1 = yes, 0 = no / unclear
  escalation_required INTEGER DEFAULT 0,
  -- 1 = yes, 0 = no
  reviewer TEXT,
  decision_record_link TEXT,
  -- Reference to decision record in toolkit
  notes TEXT,
  FOREIGN KEY (vendor_id) REFERENCES vendors(id)
);

-- Incidents: Log any incidents, concerns, or escalations related to AI use
CREATE TABLE IF NOT EXISTS incidents (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  ai_system_id INTEGER,
  incident_date TEXT NOT NULL,
  description TEXT NOT NULL,
  severity TEXT,
  -- low, moderate, high
  category TEXT,
  -- data_breach, bias_alert, accuracy_issue, escalation, other
  actions_taken TEXT,
  resolved_date TEXT,
  reported_by TEXT,
  notes TEXT,
  FOREIGN KEY (ai_system_id) REFERENCES ai_systems(id)
);

-- AI Literacy: Track staff training and AI literacy initiatives
CREATE TABLE IF NOT EXISTS ai_literacy_records (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  staff_member_identifier TEXT,
  -- Anonymous identifier or role (avoid storing PII)
  training_type TEXT,
  -- policy_briefing, literacy_session, vendor_training, other
  training_date TEXT NOT NULL,
  trainer TEXT,
  completion_status TEXT DEFAULT 'pending',
  -- pending, in_progress, completed
  notes TEXT
);

-- Maintenance Reviews: Track periodic reviews and maintenance of AI governance
CREATE TABLE IF NOT EXISTS maintenance_reviews (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  review_date TEXT NOT NULL,
  review_type TEXT,
  -- quarterly_review, incident_debrief, policy_update, vendor_recheck
  ai_systems_count INTEGER,
  -- How many tools reviewed this period
  changes_made TEXT,
  escalations_identified INTEGER DEFAULT 0,
  next_review_date TEXT,
  reviewer TEXT,
  notes TEXT
);

-- Source Updates: Track when toolkit materials or official sources are reviewed
CREATE TABLE IF NOT EXISTS source_updates (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  source_title TEXT NOT NULL,
  source_type TEXT,
  -- regulation, policy, guidance, template
  last_checked_date TEXT NOT NULL,
  url TEXT,
  status TEXT DEFAULT 'current',
  -- current, outdated, superseded, archived
  notes TEXT
);

-- Index for common queries
CREATE INDEX IF NOT EXISTS idx_ai_systems_owner ON ai_systems(owner);
CREATE INDEX IF NOT EXISTS idx_ai_systems_review_status ON ai_systems(review_status);
CREATE INDEX IF NOT EXISTS idx_vendors_review_status ON vendors(review_status);
CREATE INDEX IF NOT EXISTS idx_incidents_severity ON incidents(severity);
CREATE INDEX IF NOT EXISTS idx_incidents_resolved ON incidents(resolved_date);
