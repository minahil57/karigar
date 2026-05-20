---
trigger: always_on
---

# Karigar AI — Project Overview

> **Karigar AI** is an Agentic AI system that automates the end-to-end lifecycle of a local service request in Pakistan — from natural language input to booking confirmation and follow-up reminders.

---

## The Problem

Pakistan's informal service economy (AC technicians, plumbers, electricians, beauticians) operates through unstructured WhatsApp messages, phone calls, and word-of-mouth referrals. This results in:

- No reliable way to find trusted, vetted providers quickly.
- No real-time availability tracking or scheduling logic.
- No automated booking, confirmation, or follow-up infrastructure.
- A fragmented, high-friction experience for both users and service providers.

---

## The Solution

Karigar AI lets a user describe their need in plain language — English, Urdu, or Roman Urdu — and handles the entire orchestration autonomously:

1. Extracts the exact service intent, location, and resolves natural language time (e.g., "kal subah" to a precise datetime).
2. Discovers nearby, onboarded providers from the database.
3. Ranks providers by distance, rating, and strict schedule availability.
4. Confirms the booking securely.
5. Schedules and triggers push-notification reminders before the appointment via Firebase Cloud Functions Task Queues.

---

## Hackathon Challenge

**Google Antigravity Hackathon — Challenge 2: AI Service Orchestrator for Informal Economy**

Built entirely inside **Google Antigravity** (agentic IDE powered by Gemini).

---

## Tech Stack

| Layer | Technology |
|---|---|
| **Mobile App** | Flutter (ScreenUtil, GetX) |
| **Backend** | Node.js + Express |
| **Database** | Neon Serverless PostgreSQL + Drizzle ORM |
| **Authentication** | Better Auth (Bearer Tokens, Role-Based Access) |
| **Agent Orchestration**| LangGraph + LangChain.js (ReAct Agent) |
| **LLM Engine** | Gemini 3.1 Flash Lite (`@langchain/google-genai`) |
| **File Storage** | Firebase Storage (via Firebase Admin) |
| **Real-time Comms** | Socket.IO (Event Streaming) |
| **Notifications** | Firebase Cloud Messaging (FCM) |
| **Task Scheduling** | Firebase Cloud Functions Task Queues (`onTaskDispatched` v2) |

---

## Agent Architecture

The intelligence layer is driven by a LangGraph Orchestrator that evaluates the user's conversation history and uses five distinct internal tools:

* **Filter Extraction Tool:** Classifies the user's intent (Booking, Discovery, Hybrid, or General). It parses the service name, location, and dynamically resolves conversational timeframes (like "tomorrow at 2 PM") against the current Pakistan Standard Time.
* **Provider Query Tool:** Acts as a safe query builder. It translates extracted filters into optimized Drizzle ORM queries against the Neon database to find matching, active providers offering the specific service.
* **Ranking Tool:** Evaluates the queried providers. It scores them based on distance, rating, and response time. Crucially, it validates the provider's weekly operating schedule to ensure they are actually open and available during the requested time slot.
* **Booking Tool:** Writes the finalized, user-approved appointment to the database. Fires an immediate FCM booking confirmation and enqueues a delayed reminder via Firebase Cloud Functions Task Queue.
* **Follow-up Tool:** Acknowledges the reminder is queued. The Firebase Cloud Function (`sendReminder`) delivers the FCM push notification when the task fires.

---

## Data & Relationship Model

The system utilizes a fully relational Postgres model managed by Drizzle:

* **Users & Roles:** Managed securely via Better Auth. Users are explicitly defined as either a `user` (customer) or a `provider` at sign-up.
* **Profiles & Providers:** Upon registration, the system automatically provisions either a Customer Profile or a Provider Business Profile based on the assigned role. Provider profiles contain business coordinates, weekly availability schedules, and dynamic ratings.
* **Service Catalog:** A master seed list of canonical services (e.g., AC Repair, Plumbing). Providers link themselves to these services, defining their specific pricing and duration.
* **Bookings & Reviews:** Centralizes the transaction, linking the user, the provider's specific service, the resolved time, and the user's device FCM token for notifications. Completed bookings unlock the review system.
* **Agent Logs:** Captures every thought, tool invocation, and duration of the LangGraph agent for Antigravity hackathon traceability.

---

## Full Request Flow

1. **Initialization:** User opens the Flutter app and authenticates. Their device registers an FCM token with the backend.
2. **Input:** User types: *"Mujhe kal subah G-13 mein AC technician chahiye"*
3. **Streaming:** The request hits the Node.js backend via Socket.IO.
4. **Extraction:** The Orchestrator fires the Intent Tool, streaming an "Understanding your request..." status to the UI. It extracts "AC Technician", "G-13", and resolves "kal subah" to the precise next-day morning timestamp.
5. **Discovery:** The Provider Query tool scans the Neon DB for matching technicians in G-13.
6. **Ranking:** The Ranking tool evaluates the technicians, filtering out anyone who is closed on the requested morning, and ranking the rest by rating and proximity.
7. **Confirmation:** The Booking tool finalizes the highest-ranked available technician and saves the record. Fires an immediate FCM booking confirmation. Enqueues a delayed Firebase Task for the reminder.
8. **Follow-up:** The Follow-up tool acknowledges the reminder is queued.
9. **Notification:** The Firebase Cloud Function `sendReminder` fires when the task executes and pushes an FCM alert to the user's device.

---

## Demo Scenario

**User Input (Roman Urdu):**
> Mujhe kal 2 baje G-13 mein AC technician chahiye

**Real-Time Agent Steps Displayed in Flutter UI:**
* Understanding your request...
* Resolving date/time: tomorrow at 2:00 PM
* Finding AC Technicians near G-13...
* Ranking providers based on availability and rating...
* Booking confirmed with Ali AC Services.
* Reminder scheduled.

**Booking Confirmation Card:**
* **Provider:** Ali AC Services
* **Service:** AC Technician
* **Location:** G-13, Islamabad
* **Time:** Friday, 2:00 PM
* **Status:** Confirmed

**FCM Notification (Triggered via Firebase Task Queue):**
* **Title:** ⏰ Karigar Reminder
* **Body:** Your service appointment is coming up soon! The technician is on their way.

---

## Deliverables

- [x] Flutter mobile app UI & real-time client
- [x] Node.js backend with LangGraph agent orchestration
- [x] Neon Serverless Postgres with Drizzle schema & mock data
- [x] Better Auth secure role-based login
- [x] Socket.IO real-time agent streaming
- [x] FCM push notifications via Firebase Cloud Functions Task Queues
- [x] Antigravity agent trace artifacts logged to database
- [ ] 3–5 min demo video
- [ ] README documentation
- [ ] Architecture diagram

---

## Team

| Person | Role |
|---|---|
| **Arjun** | Backend Engineering — Node.js, LangGraph/Agents, Neon DB, Drizzle ORM, Socket.IO, Firebase Task Queues |
| **Person 2** | Mobile Engineering — Flutter UI, GetX, Socket.IO client, FCM implementation |
| **Person 3** | Product & QA — Demo recording, Documentation, Mock data generation, Antigravity artifacts |