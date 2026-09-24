# Privacy Policy for Pitbox Wall

**Effective Date:** September 23, 2026  
**App Name:** Pitbox Wall  
**Package ID:** com.alurei97.pitboxwall  
**Developer:** alurei97  
**Contact:** alurei97@gmail.com

---

## 1. Introduction

Pitbox Wall ("the App") is a Formula 1 race companion application that provides race schedules, standings, results, driver information, and an AI-powered statistics assistant. This Privacy Policy explains how the App handles information when you use it.

**We do not collect, store, or transmit any personally identifiable information.** The App operates entirely on your device with no user accounts, no tracking, and no analytics.

---

## 2. Information We Do Not Collect

- **No personal data:** We do not collect names, email addresses, phone numbers, or any contact information
- **No account system:** The App has no login, registration, or user profiles
- **No analytics:** We do not use Firebase Analytics, Google Analytics, or any third-party tracking
- **No advertising:** The App contains no ads and no advertising identifiers are collected
- **No location data:** The App does not request or access device location
- **No contacts, camera, microphone:** The App does not access these permissions

---

## 3. Data Processing on Your Device

All data processing occurs locally on your device:

### 3.1 Formula 1 Data (Cached Locally)
The App fetches public Formula 1 data from the following free, open APIs:
- **Jolpica F1 API** (`https://api.jolpi.ca/ergast/f1/`) — race schedules, standings, results, driver/constructor metadata
- **OpenF1 API** (`https://api.openf1.org/v1/`) — optional session-level data (future use)
- **F1 Media CDN** (`https://media.formula1.com/`) — official driver and team images

This data is **publicly available Formula 1 information** — not your personal data. It is cached locally using **Drift (SQLite)** on your device for offline access and performance. Cache durations vary:
- Completed race results: cached indefinitely
- Current standings: cached for 1 hour
- Season schedule: cached for 24 hours
- Driver/team metadata: cached for 7 days

### 3.2 AI Assistant (Groq — Llama 3.3 70B)
The AI Assistant feature sends your **natural language questions** to Groq's Llama 3.3 70B model via the Groq API. The request includes:
- Your question text
- Current season F1 data (standings, recent results) as context — **this is public F1 data, not your personal data**

**No conversation history is stored on our servers.** Groq processes the request per their [Privacy Policy](https://groq.com/privacy-policy/). You can use the App without using the AI feature.

### 3.3 Network Requests
The App makes HTTPS requests only to the APIs listed above. Requests include:
- Standard HTTP headers (User-Agent, Accept)
- No authentication tokens, no device identifiers, no personal data

---

## 4. Local Storage

The App uses **Drift (SQLite)** to store cached API responses on your device. This database:
- Is stored in the App's private data directory (inaccessible to other apps)
- Contains only public Formula 1 data (schedules, standings, results, images URLs)
- Is cleared if you uninstall the App or clear App data in Android Settings

---

## 5. Permissions

The App requests only one permission:
- **Internet** — required to fetch Formula 1 data from public APIs and to use the AI Assistant

No other permissions are requested or used.

---

## 6. Third-Party Services

| Service | Purpose | Data Shared |
|---------|---------|-------------|
| Jolpica F1 API | Public F1 race data | None (public API, no auth) |
| OpenF1 API | Optional session data | None (public API, no auth) |
| F1 Media CDN | Driver/team images | None (public image URLs) |
| Groq API | AI Assistant responses | Your question + public F1 context |

**We do not use:** Firebase, Google Play Services, Crashlytics, AdMob, Facebook SDK, or any analytics/tracking libraries.

---

## 7. Children's Privacy

The App is not directed at children under 13. We do not knowingly collect personal information from children. Since we collect no personal information at all, this policy inherently protects children's privacy.

---

## 8. Data Retention

- **Cached F1 data:** Retained per cache TTL (see Section 3.1), cleared on App uninstall
- **AI conversation history:** Stored only in memory during your session, cleared when you close the App or use "Clear History"
- **No data is stored on our servers** — we have no servers

---

## 9. Your Rights

Since we collect no personal data, there is no personal data to access, correct, delete, or port. You can:
- Clear all local cache: Android Settings → Apps → Pitbox Wall → Storage → Clear Data
- Disable the AI Assistant: simply don't use the AI tab
- Uninstall the App: removes all local data

---

## 10. Changes to This Policy

We may update this Privacy Policy if the App's data practices change. Updates will be posted in the App and on the Play Store listing. Continued use after changes constitutes acceptance.

---

## 11. Contact

If you have questions about this Privacy Policy, contact:

**alurei97@gmail.com**

---

## 12. Compliance

This App complies with:
- Google Play Developer Policy Center requirements
- GDPR (no personal data processed)
- CCPA (no personal information sold or shared)
- ePrivacy Directive (no cookies, no tracking)

---

*Last updated: September 23, 2026*