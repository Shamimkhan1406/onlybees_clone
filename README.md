# OnlyBees Event Booking Clone



## Project Overview

This project is a 1:1 functional clone of an event booking page from OnlyBees, built as a frontend engineering assignment.

**What it demonstrates:**
- Pixel-accurate UI replication of a production event booking interface
- Complex state management for multi-tier ticket selection and checkout flows
- API integration with proper loading and error handling
- Clean architecture using Flutter Web and Provider pattern

## Tech Stack

- **Framework:** Flutter (Web)
- **State Management:** Provider
- **API:** Public/proxy API for ticket availability (no custom backend)
- **Development Tools:** Dart DevTools, Flutter Web tooling

## UI & Feature Implementation

**Event Page Layout**
- Responsive event header with image, title, date, and venue details
- Ticket tier cards with pricing, availability badges, and descriptions
- Sticky checkout summary panel

**Ticket Selection**
- Dynamic quantity selectors for multiple ticket tiers
- Real-time price calculation
- Availability constraints enforced at UI level
- Disable/enable logic based on stock

**Checkout Flow**
- Multi-step form with attendee details collection
- Payment method selection (UI only, no actual processing)
- Order summary with breakdown of fees and totals
- Confirmation screen with booking details

## State Management

**Provider Architecture**
- `TicketProvider` manages all ticket-related state (quantities, totals, selected tiers)
- `CheckoutProvider` handles form state, validation, and checkout progression
- `EventProvider` manages event data and API response caching

**State Handling**
- Ticket quantities stored in a `Map<String, int>` keyed by tier ID
- Total calculation computed on-the-fly via `notifyListeners()`
- Checkout state machine (selection → details → payment → confirmation)
- Form validation state synchronized with UI button enablement

## API Consumption

**Data Fetching**
- Ticket availability fetched via REST API on page load
- Event metadata retrieved from public endpoint
- Future-based async calls wrapped in `FutureBuilder` widgets

**Loading & Error States**
- Shimmer placeholders during initial load
- Retry mechanism on network failures
- User-friendly error messages for API timeouts or invalid responses
- Graceful degradation when optional data is unavailable

**No Backend Implementation**
- All data sourced from external APIs
- No server-side logic or database integration

## AI Assistance

AI tools were used strategically throughout the development process:

**UI Structure Planning**
- Generated widget hierarchy proposals for complex layouts
- Suggested Flutter-specific patterns for responsive design
- Provided alternatives for nested ScrollView configurations

**State Architecture Decisions**
- Reviewed Provider setup for separation of concerns
- Recommended state normalization strategies for nested ticket data
- Suggested optimal rebuild scopes to minimize widget re-renders

**Debugging Async/State Issues**
- Diagnosed race conditions in API calls during rapid UI interaction
- Identified unnecessary rebuilds via ChangeNotifier
- Resolved state loss issues during navigation

**Refining Checkout Logic**
- Optimized validation flow for multi-step forms
- Improved error propagation from API layer to UI
- Streamlined total calculation with edge case handling

## Project Structure

```
onlybees_clone/
├── lib/
│   ├── main.dart                      # App entry point, route setup
│   ├── models/
│   │   ├── event.dart                 # Event data model
│   │   ├── ticket_tier.dart           # Ticket tier model
│   │   └── booking.dart               # Booking/checkout model
│   ├── providers/
│   │   ├── ticket_provider.dart       # Ticket state management
│   │   ├── checkout_provider.dart     # Checkout flow state
│   │   └── event_provider.dart        # Event data provider
│   ├── services/
│   │   └── api_service.dart           # API calls and response handling
│   ├── screens/
│   │   ├── event_page.dart            # Main event booking page
│   │   ├── checkout_page.dart         # Multi-step checkout screen
│   │   └── confirmation_page.dart     # Booking confirmation screen
│   ├── widgets/
│   │   ├── event_header.dart          # Event details header
│   │   ├── ticket_card.dart           # Individual ticket tier card
│   │   ├── checkout_summary.dart      # Sticky summary panel
│   │   ├── quantity_selector.dart     # Increment/decrement control
│   │   └── shimmer_loader.dart        # Loading placeholder
│   └── utils/
│       ├── constants.dart             # API endpoints, colors, strings
│       └── validators.dart            # Form validation logic
├── assets/
│   └── images/                        # Placeholder images (if any)
├── pubspec.yaml                       # Dependencies and assets
└── README.md
```

## Local Setup Guide

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (bundled with Flutter)
- Chrome or any modern browser for web development
- Git

### Installation Steps

**1. Clone the Repository**

```bash
git clone https://github.com/Shamimkhan1406/onlybees_clone.git
cd onlybees_clone
```

**2. Install Dependencies**

```bash
flutter pub get
```

**3. Verify Flutter Web Support**

```bash
flutter config --enable-web
flutter devices
```

Ensure you see Chrome or a web server listed as an available device.

**4. Run the Application**

```bash
flutter run -d chrome
```

Or for a specific browser:

```bash
flutter run -d web-server --web-port=8080
```

**5. Build for Production (Optional)**

```bash
flutter build web --release
```

The output will be in `build/web/` and can be deployed to any static hosting service.

### Troubleshooting

**Issue: API calls failing**
- Check your internet connection
- Verify API endpoints in `lib/utils/constants.dart` are accessible
- Check browser console for CORS errors

**Issue: Hot reload not working**
- Restart the app with `r` in terminal or full restart with `R`
- Clear browser cache and reload

**Issue: Dependencies not resolving**
- Run `flutter clean` then `flutter pub get`
- Check Flutter version compatibility: `flutter doctor`

### Environment Variables (If Applicable)

If the project uses environment-specific configurations, create a `.env` file:

```
API_BASE_URL=https://api.example.com
```

Then load using a package like `flutter_dotenv`.

## Notes

**Assumptions & Simplifications**
- Payment processing is UI-only; no actual transactions occur
- User authentication not implemented (single-user flow assumed)
- Ticket inventory managed via API response, not client-side persistence

**Scope Boundaries**
- Frontend-focused implementation; backend out of scope
- Desktop/web experience prioritized; mobile responsive but not optimized
- API schema assumed stable; no versioning logic included

**Known Limitations**
- No persistent cart (state clears on refresh)
- Booking confirmation not sent to backend or email
- Accessibility features (screen reader support) not fully implemented