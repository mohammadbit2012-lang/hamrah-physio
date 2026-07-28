# Operator Feature Module (Device Operator)

This folder contains the complete logical and UI flow for the **Device Operator** role within Hamrah Physio.

## Target Audience & Role
- **Operator**: Sets up physical equipment (TENS, ultrasound, lasers, heat pads) on patients, logs treatment completion, and notes patient tolerances.

## Proposed Clean Architecture Sub-Structure
```text
lib/features/operator/
├── data/            # Device logs database integration, Status trackers
├── domain/          # Entities representing sessions, devices, parameters
└── presentation/    # Active Session monitor, Stopwatches, Logs forms
```

## Core Responsibility Points
1. **Active Terminal**: Real-time list of patients currently in therapy cabins.
2. **Device Presets**: Viewing doctor-prescribed equipment settings (e.g. "Laser 10 mins, 50Hz").
3. **Timer & Monitor**: Multi-room countdown timers tracking treatment cycles.
4. **Session Log**: Documenting skin reaction, pain levels, or hardware errors.