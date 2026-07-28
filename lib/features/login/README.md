# Login & Authentication Feature Module

This folder handles authorization, multi-role dispatch, token validation, and secure onboarding.

## Proposed Clean Architecture Sub-Structure
```text
lib/features/login/
├── data/            # Auth API client, Token persistence handlers, JWT parsers
├── domain/          # Auth Credentials entity, Validation Use Cases, Password Encrypters
└── presentation/    # Multi-role Login Form, PIN Lock screen, Riverpod controllers
```

## Core Responsibility Points
1. **Multi-Role Credentials Form**: Single secure entry gateway directing users to their designated dashboards (Doctor, Secretary, Operator, or Patient).
2. **Offline PIN Lock**: Securing the device fast for operators and doctors changing cabins.
3. **Session Watcher**: Guarding unauthorized deep-link access via routing rules.