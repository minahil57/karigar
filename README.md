# Karigar AI 🔧

> **Book local home services, instantly, in any language.**  
> Smart AI matching for Pakistan's informal service economy.

![Google Antigravity](https://img.shields.io/badge/Built%20with-Google%20Antigravity-4285F4?style=flat&logo=google)
![Gemini](https://img.shields.io/badge/Powered%20by-Gemini%203.1%20Flash%20Lite-8E24AA?style=flat&logo=google)
![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter)
![Node.js](https://img.shields.io/badge/Node.js-≥20.x-339933?style=flat&logo=nodedotjs)
![Neon](https://img.shields.io/badge/Database-Neon%20Serverless%20PostgreSQL-00E5BF?style=flat)
![Firebase](https://img.shields.io/badge/Firebase-FCM%20%2B%20Storage%20%2B%20Tasks-FFCA28?style=flat&logo=firebase)
![LangChain](https://img.shields.io/badge/LangGraph-ReAct%20Agent-1C3C3C?style=flat)
![Drizzle](https://img.shields.io/badge/ORM-Drizzle-C5F74F?style=flat)

**Hackathon:** Google Antigravity Hackathon, Challenge 2: AI Service Orchestrator for Informal Economy

---

## The Problem

Pakistan's informal service economy, AC technicians, plumbers, electricians, painters, carpenters and many more, operates entirely through WhatsApp messages, phone calls, and word-of-mouth referrals.

- No reliable way to find trusted, vetted providers quickly
- No real-time availability tracking or scheduling logic
- No automated booking, confirmation, or follow-up infrastructure
- A fragmented, high-friction experience for both users and service providers

---

## The Solution

Karigar AI is a two-sided agentic platform. Users interact with a LangGraph AI agent in natural language, **English, Urdu, or Roman Urdu** to find and book local service providers. Providers manage their profiles, services, availability schedules, and incoming bookings through the same app.

The agent handles the full lifecycle autonomously: from extracting the user's intent to writing the confirmed booking to the database and scheduling an FCM push notification reminder.

> Built entirely inside **Google Antigravity**, all agent workflows, reasoning steps, and implementation plans were authored and tracked here.

---

## Demo

> 🎬 **Demo video:** _Coming soon, link to be added after recording_

**Sample interaction (Roman Urdu):**
```
User:  Mujhe kal 2 baje G-13 mein AC technician chahiye

Agent: [Analyzing service intent, location context, and scheduling timeframes...]
       [Querying database for verified local service professionals...]
       [Evaluating provider coordinates, response rates, and availability schedules...]
       [Executing booking transaction and securing reservation slot...]
       [Configuring reminder triggers with background scheduler...]

       Maine aapki request ke mutabiq 3 providers dhoond liye hain.

       ┌─ Booking Confirmed ──────────────────────────┐
       │ Provider:  Ali AC Services                   │
       │ Service:   AC Repair                         │
       │ Location:  G-13, Islamabad                   │
       │ Time:      Friday at 2:00 PM                 │
       │ Status:    ✓ Confirmed                       │
       └──────────────────────────────────────────────┘
```

FCM push notification fires automatically 1 hour before the appointment via Firebase Cloud Functions Task Queue.

---

## 🌐 Google Ecosystem Usage

This section is first because Google tooling is the backbone of every layer.

| Google Product | Role in Karigar AI |
|---|---|
| **Google Antigravity** | Core development platform. All agent architecture, implementation plans, tool design, and reasoning traces were built and tracked here. Antigravity artifacts (`implementation_plan.md`, task logs) are included in the submission. |
| **Gemini 3.1 Flash Lite** | Primary LLM powering all agent reasoning, intent classification, multilingual detection, and structured tool calling via `@langchain/google-genai` (`ChatGoogleGenerativeAI`, `temperature: 0.2`). |
| **Firebase Cloud Messaging** | Push notifications for immediate booking confirmations and delayed appointment reminders. Sent via Firebase Admin SDK from Node.js. |
| **Firebase Cloud Functions (Task Queues)** | `sendReminder` is a `onTaskDispatched` v2 Cloud Function. The booking tool enqueues a delayed task (1 min in demo, 1 hour in production). The function sends the FCM push when the task fires, serverless, retry-safe, no polling. |
| **Firebase Storage** | Avatar image storage for users and providers. Uploaded via `firebase-admin` on the Node.js backend through the `/api/upload/avatar` route. |
| **Google Maps Geocoding API** | Reverse geocoding of user and provider GPS coordinates (`lat`/`lng`) to human-readable area names in `src/services/maps.service.ts`. |

---

## Tech Stack

### Backend

| Layer | Technology | Version |
|---|---|---|
| Runtime | Node.js + TypeScript | ≥ 20.x |
| Framework | Express | ^4.21.1 |
| Real-time | Socket.IO | ^4.8.3 |
| Authentication | Better Auth (email/password, bearer tokens, two roles) | ^1.6.11 |
| ORM | Drizzle ORM | ^0.45.2 |
| Database | Neon Serverless PostgreSQL (US East Virginia) | ^1.1.0 |
| Caching | Upstash Redis via Drizzle `$withCache()` | ^1.38.0 |
| File Upload | Multer | ^2.1.1 |
| Notifications | Firebase Admin SDK (FCM + Storage + Functions) | ^13.10.0 |
| Notifications (scheduled) | Firebase Cloud Functions Task Queues | v2 |
| API Docs | Scalar (`@scalar/express-api-reference`) | ^0.9.16 |
| Security | Helmet, express-rate-limit, CORS | — |

### AI / Agent

| Component | Technology |
|---|---|
| Agent framework | LangGraph (`@langchain/langgraph` ^1.3.0) + LangChain.js (`langchain` ^1.4.0) |
| LLM | Gemini 3.1 Flash Lite via `@langchain/google-genai` ^2.1.30 |
| Agent pattern | LangGraph `createAgent` ReAct loop |
| Tools | 5 custom LangChain tools (see Agent Architecture) |
| Structured output | Zod schema (`AgentResponseSchema`) enforced on every agent response |
| Recursion guard | `recursionLimit: 10` |

### Mobile

| Layer | Technology |
|---|---|
| Framework | Flutter |
| State management | GetX |
| Layout | ScreenUtil |
| Auth | Custom (Better Auth bearer tokens) |
| Real-time | Socket.IO client |
| Notifications | Firebase Cloud Messaging |

---

## Agent Architecture

The intelligence layer is a **LangGraph ReAct agent** (`createAgent`) that autonomously decides which tools to invoke based on the conversation history and user intent.

```
User message (English / Urdu / Roman Urdu)
        │
        ▼
┌─────────────────────────────────────────────────────────┐
│  ORCHESTRATOR  (src/agents/orchestrator.ts)             │
│                                                         │
│  1. detectLanguage()  → English | Urdu | Roman Urdu     │
│  2. Fetch user profile lat/lng from DB                  │
│  3. Build system prompt (PKT datetime injected)         │
│  4. createAgent (LangGraph ReAct loop)                  │
│                                                         │
│  ┌──────────────────────────────────────────────────┐   │
│  │              5-TOOL PIPELINE                     │   │
│  │                                                  │   │
│  │  filter_extraction  → understand intent + time   │   │
│  │         │                                        │   │
│  │  provider_query     → Drizzle ORM, PostGIS       │   │
│  │         │                                        │   │
│  │  ranking            → availability + score       │   │
│  │         │                                        │   │
│  │  booking            → DB write + FCM Task Queue  │   │
│  │         │                                        │   │
│  │  follow_up          → UX confirmation + log      │   │
│  └──────────────────────────────────────────────────┘   │
│                                                         │
│  5. stream() with streamMode:'updates'                  │
│     → onStep() → Socket.IO → Flutter step cards        │
│     → onThought() → Socket.IO → collapsible traces     │
└─────────────────────────────────────────────────────────┘
        │
        ▼
  AgentResponseSchema { message, widget?, metadata? }
        │
        ├── widget: "providers"           → Flutter provider list card
        ├── widget: "services"            → Flutter service picker
        └── widget: "booking_confirmation"→ Flutter booking card
```

### Tool Details

#### 1. `filter_extraction`
- Accepts raw user message in English, Urdu, or Roman Urdu
- Uses Gemini directly (`.invoke()`) to classify intent: `BOOKING | DISCOVERY | HYBRID | GENERAL`
- Extracts: `service_name`, `location`, `min_rating`, `price_range`, `sort_by`, `limit`
- **Time resolution:** Converts relative expressions to exact PKT day + 24h time
  - `"kal subah"` → `friday, 09:00` | `"kal 2 baje"` → `friday, 14:00` | `"aaj shaam"` → `today, 17:00`
- Returns raw JSON string consumed by `provider_query`

#### 2. `provider_query`
- Parses the JSON from `filter_extraction`
- Builds **type-safe Drizzle ORM queries** — no raw SQL ever generated
- PostGIS `ST_DWithin` geo-fence: finds providers within 10 km radius
- Haversine distance calculation in JS for ranking input
- Falls back to global search (ignoring geo-fence) if no results found in area
- Returns providers with their `providerServices` + `provider_skills` joined

#### 3. `ranking`
- **BOOKING / HYBRID:** Hard-filters providers by JSONB weekly availability schedule at requested `day` + `HH:MM` time. Providers closed on the requested day/time get `score = 0`
- **DISCOVERY:** Ranks by rating and response time only (no time constraint)
- Weighted scoring formula:
  ```
  BOOKING:    40% distance  +  35% rating  +  25% response_time
  DISCOVERY:  70% rating    +  30% response_time
  ```
- Returns `{ ranked: Provider[], topProvider: Provider | null }`

#### 4. `booking`
- Validates the provider's availability one final time before writing
- Inserts a confirmed booking row into the `bookings` table (Neon PostgreSQL)
- Calculates `reminderTime` = exactly 1 hour before the booking in PKT
- Fires an **immediate** FCM booking confirmation notification (fire-and-forget)
- Enqueues a **delayed** FCM reminder via Firebase Cloud Functions Task Queue (`sendReminder`)
- Writes an `agent_logs` entry (step 4) for Antigravity traceability

#### 5. `follow_up`
- UX-only step: returns a friendly "Reminder set ✓" message for the agent to relay
- Writes a final `agent_logs` entry (step 5) to complete the 5-step trace chain

### Language Detection

A pre-processor in the orchestrator classifies the user's message before the agent runs:

```
Urdu script (U+0600–U+06FF)  → "Urdu"
Roman Urdu keywords present  → "Roman Urdu"
Otherwise                    → "English"
```

The detected language is injected into the system prompt and the agent's `REAL-TIME THINKING FORCE RULE` — every thought and response must be in that language.

### Human-in-the-Loop

The agent does **not** call `booking` autonomously, it presents the top provider and waits. Flutter then emits a `provider:selected` event, which the backend handles directly (bypassing the agent entirely) via `handleProviderSelected()` in `socketService.ts`. This is a zero-latency direct `bookingTool.invoke()` call, no Gemini, no LangGraph re-run.

---

## Notification Architecture

Karigar AI uses **two-tier notifications** for reliability:

```
Booking created
      │
      ├─ 1. IMMEDIATE ─────────────────────────────────────────────────
      │      sendPushNotification() fire-and-forget
      │      FCM: "Booking Confirmed — Your service is booked for X"
      │
      └─ 2. DELAYED REMINDER ──────────────────────────────────────────
             functions.taskQueue('sendReminder').enqueue(payload, { scheduleTime })
             Firebase Cloud Functions Task Queue → onTaskDispatched()
             Retries: max 3 attempts, 60s min backoff
             FCM: "⏰ Karigar Reminder — Your appointment is coming up soon!"
```

**`sendReminder` Cloud Function** (`functions/src/index.ts`):
- `onTaskDispatched` v2 with `maxConcurrentDispatches: 6`, `maxAttempts: 3`
- Sends FCM with `android.priority: "high"` and APNS sound
- Throws on failure → Cloud Tasks retries automatically

---

## Database Schema

**Better Auth auto-generated tables:** `user`, `session`, `account`, `verification`

**Custom Karigar tables (Drizzle ORM + Neon PostgreSQL):**

| Table | Description |
|---|---|
| `profiles` | Customer profile linked 1-to-1 with Better Auth `user`. Stores avatar (Firebase Storage URL), GPS `lat`/`lng`, PostGIS `geography` column, and Google Places JSONB `address`. |
| `providers` | Provider business profile. Stores `businessName`, GPS coordinates, PostGIS `geography`, JSONB `availability` (weekly schedule), `rating`, `responseTime`, `priceRange`, `isOnboarded`. |
| `provider_skills` | Free-text skill tags linked to a provider (e.g. "Inverter AC", "Split Unit"). |
| `services` | Master seed list of 13 canonical service names (e.g. `AC Repair`, `Plumbing Repair`, `Interior Painting`). The `filter_extraction` tool matches against these exact names. |
| `provider_services` | Junction: which services a provider offers, with `price` (PKR), `priceType` (`fixed` / `starting_from` / `on_inspection`), and `durationMinutes`. |
| `bookings` | Confirmed appointment linking user → provider_service. Stores `requestedDay`, `requestedTime` (24h), `scheduledTime` (human-readable), `reminderTime` (used by Firebase Task Queue), `fcmToken`, `status`. |
| `reviews` | Post-booking rating (1.0–5.0) + comment. Triggers provider `rating` recalculation. One review per booking. |
| `agent_logs` | Every LangGraph tool invocation — step index, tool name, JSONB `input`/`output`, `durationMs`, `status`. Antigravity hackathon traceability artifact. |
| `fcm_tokens` | Latest FCM device token per user. Upserted on every app open. Read by `bookingTool` to attach the token to the booking row. |
| `preferences` | User notification settings. Auto-created on signup via `databaseHooks`. |

**PostGIS indexes:** Both `profiles` and `providers` have GiST indexes on their `geography` column for fast `ST_DWithin` geo-queries.

---

## Caching Strategy

Provider discovery queries are cached via **Upstash Redis** using Drizzle's built-in `$withCache()`:

| Query | Cache TTL | Tag |
|---|---|---|
| Services master list | 24 hours | `services_master` + service name |
| Provider discovery results | 5 minutes | per search combination |
| Single provider profile | 10 minutes | per user tag |
| Bookings, reviews, FCM tokens | **Never cached** | always fresh |

---

## Two Roles

### User (role: `"user"`)
- Signs up → `databaseHooks` auto-creates `profiles` + `preferences` rows
- Interacts with the AI agent to find and book services (English, Urdu, Roman Urdu)
- Views booking history and submits post-booking reviews
- Device FCM token upserted on every login

### Provider (role: `"provider"`)
- Signs up → `databaseHooks` auto-creates `providers` + `preferences` rows
- Completes onboarding: business name, area, GPS coordinates, weekly availability schedule, services offered with pricing
- Uploads avatar via Firebase Storage (`/api/upload/avatar`)
- Manages incoming bookings (confirm / complete / cancel)

Role validation is enforced by Better Auth's `additionalFields` configuration. Only `"user"` and `"provider"` are accepted at signup.

---

## Socket Events

### Flutter → Server

| Event | Payload | Description |
|---|---|---|
| `message` | `{ message, token }` | Natural language user message — triggers full agent pipeline |
| `provider:selected` | `{ providerServiceId?, providerId?, serviceName?, scheduledTime?, requestedDay?, requestedTime?, location?, token }` | Provider or service tapped in Flutter UI |
| `service:selected` | `{ serviceName, token }` | Service tapped from SERVICE_LIST widget |
| `cancel` | _(none)_ | Aborts the active agent execution via `AbortController` |

### Server → Flutter

| Event | Payload | Description |
|---|---|---|
| `agent:loading` | `{ message }` | Agent is starting ("Thinking...") |
| `agent:step` | `{ agent, message, status, timestamp }` | Tool start / finish — displayed as animated step cards |
| `agent:thought` | `{ text }` | Agent reasoning before tool call — displayed as collapsible trace |
| `agent:response` | `{ message, timestamp }` | Streamed word-by-word response chunks |
| `agent:done` | `{ message }` | Response stream complete |
| `booking:confirmed` | Full booking row with `providerService → service + provider` joins | Triggers Flutter booking confirmation UI |
| `agent:error` | `{ message }` | Error message for user display |

---

## Getting Started

### Prerequisites

- Node.js ≥ 20
- A [Neon](https://neon.tech) PostgreSQL database (US East Virginia recommended for latency)
- A Firebase project (FCM + Storage + Functions enabled)
- A Google AI Studio API key (Gemini)
- An [Upstash](https://upstash.com) Redis database

### 1. Clone & install

```bash
git clone https://github.com/your-org/karigar-backend.git
cd karigar-backend
npm install
```

### 2. Configure environment

```bash
cp .env.example .env
```

Fill in `.env`:

```env
# Server
PORT=3000
NODE_ENV=development
ALLOWED_ORIGINS=http://localhost:3000

# Database (Neon)
DATABASE_URL=postgresql://user:pass@ep-xxx.us-east-1.aws.neon.tech/karigar?sslmode=require

# Better Auth
BETTER_AUTH_SECRET=your_random_32_char_secret_here
BETTER_AUTH_URL=http://localhost:3000

# Gemini LLM
GOOGLE_API_KEY=your_gemini_api_key

# Firebase (Storage + FCM + Task Queues)
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_PRIVATE_KEY=your_private_key_with_newlines_as_\n
FIREBASE_CLIENT_EMAIL=firebase-adminsdk-xxxxx@your_project.iam.gserviceaccount.com
FIREBASE_STORAGE_BUCKET=your_project.firebasestorage.app
```

### 3. Push schema & seed

```bash
npm run db:push      # Push Drizzle schema to Neon
npm run db:seed      # Seed the services master table (13 canonical services)
```

### 4. Deploy Firebase Cloud Functions

```bash
cd functions
npm install
cd ..
firebase deploy --only functions
```

### 5. Run

```bash
npm run dev          # tsx watch + auto-generates Scalar API docs
```

The server starts on `http://localhost:3000`.  
API docs available at `http://localhost:3000/api/docs` (Scalar UI).

---

## Project Structure

```
karigar-backend/
├── src/
│   ├── agents/
│   │   ├── orchestrator.ts          # LangGraph ReAct agent + language detection
│   │   └── tools/
│   │       ├── filterExtractionTool.ts  # Intent + filter extraction (Gemini direct)
│   │       ├── providerQueryTool.ts     # Drizzle ORM query builder + PostGIS
│   │       ├── rankingTool.ts           # Availability validation + scoring
│   │       ├── bookingTool.ts           # DB write + FCM Task Queue enqueue
│   │       └── followUpTool.ts          # UX confirmation + agent_logs step 5
│   ├── config/
│   │   ├── auth.ts                  # Better Auth (email/password, bearer, hooks)
│   │   ├── firebase.ts              # Firebase Admin SDK (Storage + FCM + Functions)
│   │   ├── gemini.ts                # ChatGoogleGenerativeAI (gemini-3.1-flash-lite)
│   │   └── socket.ts                # Socket.IO server config
│   ├── db/
│   │   ├── schema.ts                # Full Drizzle schema (10 tables + PostGIS)
│   │   ├── index.ts                 # Neon + Drizzle + Upstash Redis cache init
│   │   └── seed.ts                  # Seeds 13 canonical services
│   ├── services/
│   │   ├── socketService.ts         # Socket event handlers (message, provider:selected)
│   │   ├── notificationService.ts   # sendPushNotification() wrapper
│   │   └── maps.service.ts          # Google Maps reverse geocoding
│   ├── app.ts                       # Express app (middleware, routes, Scalar docs)
│   └── index.ts                     # HTTP + Socket.IO server entry point
├── functions/
│   └── src/
│       └── index.ts                 # Firebase Cloud Function: sendReminder (Task Queue)
├── .env.example
├── drizzle.config.ts
└── package.json
```

---

## Team

| Person | Role |
|---|---|
| **Arjun** | Backend Engineering — Node.js, LangGraph agent, Drizzle ORM, Socket.IO, Firebase Task Queues |
| **[Member 2]** | Mobile Engineering — Flutter UI, GetX, Socket.IO client, FCM, booking flow |
| **[Member 3]** | Product & QA — Demo recording, documentation, mock data generation, Antigravity artifacts |

---

## License

MIT — see [LICENSE](LICENSE) for details.
