# Secretary Feature Module (Receptionist)

This folder contains the complete logical and UI flow for the **Secretary** role within Hamrah Physio.

## Target Audience & Role
- **Clinic Secretary**: Manages reception workflows, registers new patients, arranges appointment books, tracks bills, and coordinates operator schedules.

## Proposed Clean Architecture Sub-Structure
```text
lib/features/secretary/
├── data/            # Local caching, Remote databases, Models, Repositories
├── domain/          # Entities, Scheduling Rules, Validation Rules
└── presentation/    # Calendar widgets, Patient registration forms, Riverpod states
```

## Core Responsibility Points
1. **Front-Desk Dashboard**: Calendar view of all active therapy rooms.
2. **Registration Desk**: Onboarding new patients, collecting national IDs and contact details.
3. **Queue Manager**: Managing drop-ins, room assignment flags, and operator handoffs.
4. **Billing Suite**: Processing invoices, tracking insurance coverage, issuing digital receipts.