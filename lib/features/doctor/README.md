# Doctor Feature Module (Physiotherapist Specialist)

This folder contains the complete logical and UI flow for the **Physiotherapist Specialist (Doctor)** role within Hamrah Physio.

## Target Audience & Role
- **Physiotherapist (Doctor)**: Refers patients, designs, edits, and monitors clinical treatment plans, tracks clinical logs, and performs physiotherapeutic diagnostics.

## Proposed Clean Architecture Sub-Structure
Please organize this folder into these three clean layers during development:

```text
lib/features/doctor/
├── data/            # API Data sources, Subabase Clients, Repository Implementations, Models
├── domain/          # Pure Business Logic, Entities, Use Case Interfaces
└── presentation/    # Riverpod States, Controllers, Screens, Custom Visual Widgets
```

## Core Responsibility Points
1. **Clinic Dashboard**: Today's scheduled patients, clinical summary statistics.
2. **Patient Charts**: Deep medical history, chronic condition sheets.
3. **Treatment Creator**: Assigning laser therapy, electrotherapy, or dry needling regimens.
4. **Diagnostic Metrics**: Tracking ROM (Range of Motion) and pain indices (VAS scale).