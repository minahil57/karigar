# All About Karigar

## Overview

Karigar is an AI-powered local services marketplace designed to connect customers with skilled professionals through intelligent matching, workflow automation, and premium mobile-first experiences.

The platform focuses on:

* AI-driven service discovery
* AI-powered provider recommendations
* Workflow automation
* Booking management
* Smart service request handling
* Provider analytics and earnings tracking

---

# Brand Identity

## Product Name

**Karigar**

## Product Vision

Create a premium AI-native marketplace experience where service providers receive highly relevant jobs automatically and customers get instant trusted matches.

## Design Philosophy

* Ultra-modern startup aesthetic
* Apple-inspired spacing and depth
* Minimal UI clutter
* Premium glassmorphism cards
* Clean typography hierarchy
* AI-first interactions
* Edge-to-edge layouts
* Functional white space

---

# Typography

## Primary Font

### Poppins

Used across the entire application.

### Font Weights

| Usage       | Weight |
| ----------- | ------ |
| Headings    | 700    |
| Subheadings | 600    |
| Body        | 400    |
| Captions    | 300    |
| Buttons     | 500    |

---

# Color System

## Primary Colors

| Name               | Hex     |
| ------------------ | ------- |
| Deep Charcoal Blue | #1E293B |
| Slate Blue         | #334155 |
| Indigo Black       | #0F172A |

## Accent Colors

| Name               | Hex     |
| ------------------ | ------- |
| Teal Green         | #5FB3B3 |
| Light Teal Surface | #DDF4F4 |

## Background Colors

| Name           | Hex     |
| -------------- | ------- |
| Soft Off White | #F8FAFC |
| Light Surface  | #F1F5F9 |
| White          | #FFFFFF |

## Border Colors

| Name          | Hex     |
| ------------- | ------- |
| Subtle Border | #E2E8F0 |
| Light Border  | #CBD5E1 |

## Text Colors

| Name           | Hex     |
| -------------- | ------- |
| Main Heading   | #0F172A |
| Dark Text      | #1E293B |
| Secondary Text | #64748B |
| Light Text     | #94A3B8 |

## Status Colors

| Name    | Hex     |
| ------- | ------- |
| Success | #5FB3B3 |
| Error   | #DC2626 |

---

# Tech Stack

## Frontend

### Flutter

Cross-platform mobile application development.

### State Management

* GetX

### Architecture

* MVC Architecture
* Layered Architecture

### Local Storage

* Shared Preferences

### Notifications

* Firebase Cloud Messaging (FCM)

### Maps & Location

* Flutter Geolocator Package
* Latitude & Longitude based location detection

---

## Backend

### Node.js APIs

Used for:

* Authentication
* AI workflows
* Booking systems
* Service matching
* Booking management
* Notifications
* Provider management

### Framework

* Express.js

### Authentication

* JWT Authentication
* Refresh Tokens
* OTP Verification

### Database

* MongoDB

### File Storage

* Cloudinary / AWS S3

### Real-Time Services

* REST APIs

---

## AI Layer

Used for:

* Intent extraction
* Provider ranking
* Smart matching
* Automated workflow generation
* AI recommendations

---

# Application Structure

## User Roles

### Customer

* Search services
* Create requests
* Track workflow
* Chat with providers
* Manage bookings
* Payments

### Service Provider

* Accept/reject jobs
* View AI recommendations
* Manage earnings
* Booking management
* Work history
* Profile management

---

# Designed Screens

# Common Screens

## 1. Splash Screen

### Purpose

Initial application loading experience.

### Features

* Karigar branding logo
* Smooth logo animation
* AI startup style intro
* Premium dark/light transition
* App initialization

### UI Style

* Minimal
* Premium gradients
* Soft motion animation
* Centered branding

---

## 2. Onboarding Screen

### Purpose

Introduce users to Karigar platform features.

### Features

* AI-powered booking introduction
* Smart provider matching explanation
* Community showcase
* Multi-language support explanation
* Smooth onboarding carousel

### UI Components

* Large illustrations
* Modern cards
* Floating elements
* Continue CTA buttons

---

## 3. Login Screen

### Purpose

Role-based authentication.

### Login Inputs

* Email
* Password

### Features

* Role-based login
* Forgot password
* Clean email/password authentication
* Language toggle
* Clean authentication UI

### Roles

* User
* Provider

---

## 4. Signup Screen

### Purpose

Create new account.

### Features

* Role-based signup
* Email registration
* Password creation
* User type selection
* Language selection

### User Flow

* Normal User → Home Screen
* Provider → Complete Profile Screen

---

# User Screens

## 1. User Home Screen

### Purpose

AI-native booking and communication hub.

### Features

* AI chat interface
* Booking through chat
* Roman Urdu support
* Urdu support
* English support
* Smart AI recommendations
* AI generated booking flow
* Natural conversation interface

### Core Experience

Users interact directly with AI assistant instead of traditional forms.

### UI Style

* Chat-first layout
* Minimal interface
* AI typing animations
* Smart suggestion chips
* Premium messaging UI

---

## 2. Community Page

### Purpose

Discover nearby registered providers.

### Features

* Area-based provider discovery
* Provider listing cards
* Ratings display
* Skills preview
* AI recommended providers
* Search and filters

### Provider Cards

* Profile image
* Profession
* Area name
* Ratings
* Skills tags

---

## 3. Community Detail Page

### Purpose

Detailed provider profile view.

### Features

* Provider full details
* Skills list
* Area information
* Ratings and reviews
* Experience details
* Book Now CTA

### Smart Booking Flow

When user clicks Book Now:

1. AI automatically generates booking message
2. User redirected to AI Home Chat
3. Chat starts with prefilled booking request

---

## 4. User Profile Screen

### Purpose

Manage user details and preferences.

### Features

* User personal details
* Language settings
* Urdu/English switching
* Account settings
* Notification settings
* Logout

### Multi-language Support

* English
* Urdu
* Roman Urdu conversational support

---

# Provider Screens

## 1. Provider Home Screen

### Purpose

Main provider dashboard.

### Features

* Upcoming work requests
* AI matched jobs
* Current bookings
* Earnings overview
* Active bookings
* Workflow timeline
* Accept/reject actions
* AI booking insights

### Dashboard Cards

* Jobs completed
* Total earnings
* Active booking

---

## 2. Work History Screen

### Purpose

Track previous and current work.

### Features

* Current bookings
* Completed work
* Cancelled work
* Ratings received
* Earnings history
* Booking details
* Load more pagination

---

## 3. Provider Profile Screen

### Purpose

Provider profile management.

### Features

* Profile image
* Profession details
* Skills
* Experience
* Languages
* Service areas
* Ratings
* Profile settings
* Documents verification
* Notification settings
* Logout

---

## 4. Complete Profile Screen

### Purpose

Mandatory provider onboarding after signup.

### Features

* Upload profile image
* Profession selection
* Skills selection
* Experience input
* Service area selection
* Languages selection
* CNIC verification
* Basic work details setup
* Portfolio/work uploads
* Bio/About section

### User Flow

Signup → Complete Profile → Provider Dashboard

---

# Navigation System

## Navigation Philosophy

No traditional bottom navigation bar.

### Navigation Components

* Floating profile button
* Floating history button
* AI quick action button

### Animation Style

* Smooth slide transitions
* Fade animations
* Glass blur overlays
* Soft micro-interactions

---

# UI Components

## Cards

### Style

* White backgrounds
* Soft shadows
* Rounded corners
* Ultra-subtle borders
* Glassmorphism accents

### Border Radius

24px

### Elevation

Very soft premium shadows.

---

## Buttons

### Primary Button

* Background: #1E293B
* Text: White
* Rounded corners

### Secondary Button

* Ghost style
* Border only
* Transparent background

### AI Buttons

* Teal accents
* Soft glow

---

## Inputs

### Search Fields

* Rounded search bars
* AI icons
* Minimal outlines
* Soft shadows

---

# Workflow Timeline System

## AI Timeline Steps

1. Intent Extracted
2. Provider Ranked
3. Slot Reserved
4. Awaiting Response
5. Booking Confirmed

### Timeline UI

* Connected progress indicators
* Teal active states
* Real-time updates

---

# Design Rules

## Spacing System

| Type | Value |
| ---- | ----- |
| XS   | 4     |
| SM   | 8     |
| MD   | 16    |
| LG   | 24    |
| XL   | 32    |
| XXL  | 48    |

---

## Corner Radius

| Component     | Radius |
| ------------- | ------ |
| Cards         | 24     |
| Buttons       | 18     |
| Inputs        | 20     |
| Bottom Sheets | 32     |

---

## Shadows

Use extremely soft shadows with low opacity for premium feel.

Example:

* Blur Radius: 20
* Opacity: 0.06
* Offset Y: 6

---

# Future Features

## Planned Features

* In-app chat
* AI voice assistant
* Customer reviews
* AI chat improvements
* Enhanced provider profiles
* Better workflow automation

---

# Recommended APIs

## Essential APIs

* Google Maps API
* Firebase Cloud Messaging
* OpenAI APIs
* Twilio OTP APIs
* Cloudinary Upload APIs

---

# Performance Goals

## Application Goals

* 60 FPS animations
* Fast onboarding
* Under 2 second load time
* Optimized API requests
* Smooth transitions
* Lightweight UI rendering

---

# Security

## Security Features

* JWT authentication
* OTP verification
* Secure API encryption
* Role-based access
* Secure payments
* Session handling

---

# Folder Structure Recommendation

## Flutter Structure

```bash
lib/
 ├── core/
    ├── theme/ 
    ├── constants/ 
    ├── helpers/ 
    ├── localizations/
    ├── storage/ 
    ├── functions/ 
    └── utils/ 
    
 └── modules/
    ├── splash/
    ├── onboarding/
    ├── login/
    ├── signup/
    ├── user/
    └── provider/
 └── services/
    ├── api_providers/
    ├── dio_interceptors/
    ├── endpoints/
    └── dio_helper.dart    
 └── widgets/
 └── main.dart
 └── app.dart
 └── routes.dart   

```

---

# Final Product Feel

Karigar should feel:

* Premium
* Intelligent
* AI-native
* Fast
* Minimal
* Trustworthy
* Startup-grade
* Modern
* Clean
* Highly scalable
