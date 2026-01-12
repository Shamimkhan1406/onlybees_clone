import 'package:flutter/material.dart';
import 'package:onlybees_clone/screens/checkout_screen.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';
import '../widgets/ticket_card.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

// =======================
// STATE CLASS (IMPORTANT)
// =======================
class _TicketsScreenState extends State<TicketsScreen> {
  // 🔹 STEP 2: initState GOES HERE
  @override
  void initState() {
    super.initState();

    // Call API when ticket screen opens
    Future.microtask(() {
      context.read<TicketProvider>().loadSections();
    });
  }

  // 🔹 UI BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: Column(
        children: [
          // top right corner close button
          Padding(
            padding: const EdgeInsets.only(top: 40, right: 40, bottom: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: // =======================
              // TOP RIGHT CLOSE BUTTON
              // =======================
              Positioned(
                top: 24,
                right: 24,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.all(12),
                    shape: const CircleBorder(),
                  ),
                  child: const Icon(Icons.close, color: Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),
          ),
          // =======================
          // MAIN CONTENT
          // =======================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 270),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =======================
                  // LEFT: TICKETS LIST
                  // =======================
                  Expanded(flex: 1, child: _ticketsList()),

                  const SizedBox(width: 32),

                  // =======================
                  // RIGHT: VENUE LAYOUT IMAGE
                  // =======================
                  Expanded(flex: 1, child: _venueLayout()),
                ],
              ),
            ),
          ),

          // =======================
          // BOTTOM CHECKOUT BAR
          // =======================
          _checkoutBar(),
        ],
      ),
    );
  }
}

// =======================
// TICKETS LIST (LEFT COLUMN)
// =======================
Widget _ticketsList() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tickets',
          style: TextStyle(
            fontSize: 36,
            color: Color( 0xFF00FF38),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),

        Expanded(
          child: Consumer<TicketProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView(
                children:
                    provider.sections.map((section) {
                      return TicketCard(
                        section: section,
                        onAdd: () => provider.increment(section),
                        onRemove: () => provider.decrement(section),
                      );
                    }).toList(),
              );
            },
          ),
        ),
      ],
    ),
  );
}

// =======================
// VENUE LAYOUT (RIGHT COLUMN)
// =======================
Widget _venueLayout() {
  return Column(
    children: [
      const SizedBox(height: 58),
      Image.asset('assets/images/venue_layout.png', fit: BoxFit.contain),
    ],
  );
}

// =======================
// BOTTOM CHECKOUT BAR
// =======================
Widget _checkoutBar() {
  return Consumer<TicketProvider>(
    builder: (context, provider, _) {
      return Container(
        height: 120,
        padding: const EdgeInsets.symmetric(horizontal: 320, vertical: 20),
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1C),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ₹${provider.totalPrice}',
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color( 0xFF00FF38),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 52,
                  vertical: 26,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed:
                  provider.totalTickets > 0
                      ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const CheckoutScreen(),
                          ),
                        );
                      }
                      : null,
              child: const Text('Proceed'),
            ),
          ],
        ),
      );
    },
  );
}
