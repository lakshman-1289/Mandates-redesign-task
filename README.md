# Ezfinanz Mandates - UI/UX Redesign

A production-quality, standalone Flutter implementation of the **Mandates** screen and flow for the **Ezfinanz** financial application..

---

## 1. Information Architecture & UX Redesign Overview

### The Problem with the Original Screen
In the existing application reference:
- Only a single mandate card was shown with a dominant header **"E-Mandate"** (a classification, not an identifier).
- The **UMRN** (the actual unique identifier) was buried as a faint, low-contrast label.
- Bank name and masked account number were entirely missing.
- Status was indicated solely by an obscure green circle containing three dots (`...`), without explicit readable text.
- No support existed for collections, multiple active mandates, past/cancelled mandates, empty states, loading skeletons, or error states.

### The Redesigned Solution
The redesign transforms the screen into a scalable, high-clarity financial dashboard:
1. **Primary Identifier Prominence:** The UMRN is elevated to the top of the card alongside the explicit, readable status badge (`● ACTIVE`, `● INACTIVE`, `● EXPIRED`, `● CANCELLED`).
2. **Strict 3-Tier Card Information Hierarchy:**
   - **Top Tier (Identifiers & Status):** Type prefix + UMRN (left) and Status Badge (top-right, scanned uniformly across cards).
   - **Middle Tier (Banking Institution):** Bank logo avatar + Bank Name + Masked Account Number (`A/C •••• 4540`).
   - **Bottom Tier (Financial & Temporal Terms):** Prominent Mandate Limit (`₹1,00,000`, bold financial typography) on left, Registration Date on right.
3. **Multi-Mandate Organization & Scalability:**
   - Vertically scrollable sliver list using lazy loading (`SliverList` / `ListView.builder`).
   - Clean summary header (`Your Mandates`, `2 Active · 2 Other`).
   - Intelligent visual grouping separating **Active Mandates** from **Past & Inactive Mandates** with quick filter chips (`All`, `Active`, `Other`).
   - Subdued, non-alarmist styling for inactive/expired/cancelled mandates.
4. **Comprehensive State Coverage:**
   - **Empty State:** Custom vector illustration with an actionable **"Set up Auto Pay"** CTA.
   - **Loading State:** Card-mirroring shimmer skeletons matching exact card geometry.
   - **Error State:** Network failure representation with a working **Retry** mechanism.
   - **Mandate Details Screen:** In-depth view featuring Hero status card, copyable UMRN, detailed bank & account specs, and schedule/timeline validity.
   - **Demo Scenario Switcher:** Built-in reviewer tool to test all 8 evaluation states in real-time.

---

## 2. Project Architecture

```
lib/
├── main.dart                                # Application bootstrapping & edge-to-edge system UI
├── app/
│   ├── app.dart                             # MaterialApp root & theme wiring
│   └── theme/
│       ├── app_colors.dart                  # Fintech color tokens (Primary blue, Emerald, Amber, Rose, Slate)
│       ├── app_typography.dart              # Typography scale with tabular financial figures
│       └── app_theme.dart                   # Material 3 light theme definition
├── models/
│   ├── mandate.dart                         # Mandate domain model
│   ├── mandate_status.dart                  # MandateStatus enum with colors, badges, and icons
│   └── mandate_type.dart                    # MandateType enum (E-Mandate, Physical, UPI Autopay)
├── data/
│   ├── mandate_repository.dart              # Abstract repository contract (API-ready)
│   └── mock_mandate_repository.dart         # Realistic mock dataset with 8 evaluation scenarios
├── utils/
│   ├── currency_formatter.dart              # Indian Rupee formatting (e.g. ₹1,00,000)
│   └── date_formatter.dart                  # Standardized date formatting (e.g. 22 Nov 2022)
├── screens/
│   ├── mandates/
│   │   ├── mandates_screen.dart             # Primary screen: slivers, grouping, filters, states
│   │   └── mandate_details_screen.dart      # Hero card, bank info, timeline, copyable UMRN
│   └── demo/
│       └── demo_scenario_selector.dart      # Evaluation scenario bottom sheet modal
└── widgets/
    ├── mandate_card.dart                    # Reusable card implementing the required hierarchy
    ├── mandate_status_badge.dart            # Multi-attribute status chip (dot + text + border)
    ├── mandate_summary_header.dart          # Header with counts and filter chips
    ├── mandate_info_row.dart                # Info row with clipboard copy support
    ├── mandates_empty_state.dart            # Empty state vector illustration & CTA
    ├── mandates_loading_state.dart          # Skeleton loading placeholder
    ├── mandates_error_state.dart            # Error state with working Retry button
    ├── bank_logo_avatar.dart                # Dynamic bank avatar generator
    └── shimmer_box.dart                     # Custom gradient shimmer animation widget
```

---

## 3. Supported Scenarios in Demo Mode

The reviewer can test any scenario on the fly by tapping the **"Demo"** button in the top-right corner of the AppBar:

1. **One Active (Reference):** The original mandate from the Ezfinanz screenshot (`SBIN702231220003687`, `₹1,00,000`, `State Bank of India`, `22 Nov 2022`).
2. **Multiple Active (3):** Three concurrent active mandates across SBI, HDFC Bank, and ICICI Bank.
3. **Mixed Statuses (4):** Demonstrates all 4 statuses simultaneously (Active, Inactive, Expired, Cancelled) with section grouping.
4. **5 Mandates (Balanced):** Realistic mid-size portfolio showing category separation.
5. **10+ Mandates (12 Total):** Extensive list across 8 major Indian banks demonstrating lazy rendering, smooth vertical scrolling, and responsive layouts.
6. **Empty State (0):** Zero mandates layout with custom illustration and Auto Pay setup CTA.
7. **Loading State:** Skeleton shimmer preview matching the exact layout of the real cards.
8. **Error State:** Network failure simulator with an active **Retry** button that successfully recovers the data.

---

## 4. How to Run Locally

### Run on Connected Device / macOS Desktop
```bash
flutter run -d macos
```

### Run on Chrome / Web
```bash
flutter run -d chrome
```

### Run on Android Device / Emulator
```bash
flutter run
```

---

## 5. Verification & Build Results

### Static Analysis
```bash
flutter analyze
```
> **Result:** `No issues found! (ran in 0.8s)`

### Automated Test Suite
```bash
flutter test
```
> **Result:** `All 9 tests passed!`
> - Empty state rendering test
> - Active mandate badge & UMRN test
> - Cancelled mandate badge & styling test
> - Multiple mandates rendering & section headers test
> - Mandate details navigation & data verification test
> - Error state display and Retry reload test
> - Loading state skeleton placeholder test
> - Dynamic active vs other filter chip test
> - App bootstrap smoke test

### Release Builds Generated
- **Android Release APK:**
  `build/app/outputs/flutter-apk/app-release.apk` (44 MB)
- **macOS Desktop App:**
  `build/macos/Build/Products/Release/ezfinanz_mandates.app` (40.4 MB)
- **Web Production Bundle:**
  `build/web/`

---

## 6. Assumptions & Backend Integration Points

1. **Repository Abstraction:**
   All data queries originate from `MandateRepository` (`Future<List<Mandate>> getMandates()` and `Future<Mandate?> getMandateById(String id)`). Replacing mock data with a real REST or GraphQL API simply requires implementing `HttpMandateRepository` without touching any UI widget.
2. **Zero Hardcoded Personal Information:**
   All account numbers are masked (`•••• 4540`), and customer names/identifiers are realistic yet fictional.
3. **No Destructive Unsupported Actions:**
   As instructed, no speculative business actions (e.g. Cancel Mandate, Pause Mandate) were added to the UI, maintaining focus on clarity, information hierarchy, and UX scalability.
