# OnlyBees Event Booking Clone

**Repository:** [github.com/Shamimkhan1406/onlybees_clone](https://github.com/Shamimkhan1406/onlybees_clone)

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