import 'package:flutter/material.dart';
import 'package:onlybees_clone/screens/checkout_screen.dart';
import 'package:onlybees_clone/utils/responsive.dart';
import 'package:provider/provider.dart';

import '../providers/ticket_provider.dart';
import '../widgets/ticket_card.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TicketProvider>().loadSections();
    });
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final horizontalPadding = w < 350
        ? 12.0
        : w < 500
            ? 16.0
            : w < 900
                ? 40.0
                : 270.0;

    return Scaffold(
      backgroundColor: Colors.black,

      // ✅ Sticky checkout bar at bottom
      bottomNavigationBar: _checkoutBar(),

      body: SafeArea(
        child: Column(
          children: [
            // ============================
            // TOP CLOSE BUTTON (FIXED)
            // ============================
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20, bottom: 10),
              child: Align(
                alignment: Alignment.topRight,
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

            // ============================
            // SCROLLABLE MAIN CONTENT ONLY
            // ============================
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final isSmall = constraints.maxWidth < 500;

                    if (isSmall) {
                      // ✅ Venue above, tickets below (small width)
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _venueLayout(),
                          SizedBox(height: Responsive.clampWidth(context, 16)),
                          _ticketsList(context, shrinkWrap: true),
                          const SizedBox(height: 30),
                        ],
                      );
                    }

                    // ✅ Desktop layout unchanged
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: _ticketsList(context, shrinkWrap: true),
                        ),
                        SizedBox(width: Responsive.clampWidth(context, 32)),
                        Expanded(
                          flex: 1,
                          child: _venueLayout(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =======================
// TICKETS LIST
// =======================
Widget _ticketsList(BuildContext context, {bool shrinkWrap = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer<TicketProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tickets',
              style: TextStyle(
                fontSize: 36,
                color: Color(0xFF00FF38),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            // ✅ ListView inside scroll must be shrinkWrap + never scrollable
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: provider.sections.length,
              itemBuilder: (context, index) {
                final section = provider.sections[index];
                return TicketCard(
                  section: section,
                  onAdd: () => provider.increment(section),
                  onRemove: () => provider.decrement(section),
                );
              },
            ),
          ],
        );
      },
    ),
  );
}

// =======================
// VENUE LAYOUT
// =======================
Widget _venueLayout() {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 58),
      Image.asset(
        'assets/images/venue_layout.png',
        fit: BoxFit.contain,
      ),
    ],
  );
}

// =======================
// CHECKOUT BAR (STICKY)
// =======================
Widget _checkoutBar() {
  return Consumer<TicketProvider>(
    builder: (context, provider, _) {
      final w = MediaQuery.of(context).size.width;

      final horizontalPad = w < 350
          ? 12.0
          : w < 600
              ? 16.0
              : Responsive.clampWidth(context, 320);

      return SafeArea(
        top: false,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPad,
            vertical: w < 350 ? 10 : Responsive.clampWidth(context, 16),
          ),
          decoration: const BoxDecoration(
            color: Color(0xFF1C1C1C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isTight = constraints.maxWidth < 420;

              if (isTight) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total: ₹${provider.totalPrice}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Responsive.clampFont(context, 20),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00FF38),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: provider.totalTickets > 0
                            ? () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CheckoutScreen(),
                                  ),
                                );
                              }
                            : null,
                        child: const Text(
                          'Proceed',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Total: ₹${provider.totalPrice}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: Responsive.clampFont(context, 32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FF38),
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.clampWidth(context, 52),
                        vertical: Responsive.clampWidth(context, 26),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: provider.totalTickets > 0
                        ? () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const CheckoutScreen(),
                              ),
                            );
                          }
                        : null,
                    child: const Text(
                      'Proceed',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    },
  );
}
