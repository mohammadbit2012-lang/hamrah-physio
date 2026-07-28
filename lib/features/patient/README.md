# Patient Feature Module (Patient Portal)

This folder contains the complete logical and UI flow for the **Patient** role within Hamrah Physio.

## Target Audience & Role
- **Patient**: Views their progress, checks assigned appointment slots, practices home exercise prescriptions (HEP), and communicates with the clinic.

## Proposed Clean Architecture Sub-Structure
```text
lib/features/patient/
├── data/            # Local SQLite caches, Server synchronizers
├── domain/          # Home exercises entities, Pain tracker rules
└── presentation/    # Exercise videos player, Calendar checkers, Feedback sheets
```

## Core Responsibility Points
1. **My Journey**: Timeline tracking recovery status and completed sessions.
2. **Appointment Book**: View of upcoming sessions, with cancel/reschedule request links.
3. **Home Rehab Guide**: Video guides and check-lists for prescribed home physical therapy.
4. **Pain Diary**: Dynamic symptom tracker helping doctor calibrate laser and therapy intensities.