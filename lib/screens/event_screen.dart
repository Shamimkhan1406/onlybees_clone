import 'package:flutter/material.dart';
import 'package:onlybees_clone/screens/tickets_screen.dart';
import 'package:onlybees_clone/utils/responsive.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // =======================
      // TOP HEADER (ONLYBEES)
      // =======================
      body: Column(
        children: [
          _header(), // ONLYBEES text + white divider
          // =======================
          // MAIN PAGE CONTENT
          // =======================
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                // This centers the PAGE, not the text
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: Responsive.clampWidth(context, 950),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.clampWidth(context, 20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // =======================
                                // LEFT SIDE (TEXT CONTENT)
                                // =======================
                                Expanded(flex: 2, child: _leftSection(context)),

                                SizedBox(
                                  width: Responsive.clampWidth(context, 24),
                                ),

                                // =======================
                                // RIGHT SIDE (POSTER + PRICE)
                                // =======================
                                Expanded(
                                  flex: 2,
                                  child: _rightSection(context),
                                ),
                              ],
                            ),

                            SizedBox(
                              height: Responsive.clampWidth(context, 40),
                            ),
                            Text(
                              'Event Guide',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            _eventGuide(),
                            const SizedBox(height: 16),
                            // ARTIST TITLE
                            // =======================
                            const Text(
                              'Artist',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // =======================
                            const SizedBox(height: 16),
                            // ARTIST CARD
                            _artistCard(),
                          ],
                        ),
                      ),
                      //const Divider(color: Colors.white24, thickness: 1),
                      SizedBox(height: Responsive.clampWidth(context, 60)),
                      _footer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =======================
  // HEADER WIDGET
  // =======================
  Widget _header() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'ONLYBEES.',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 16),
          Divider(color: Colors.white, thickness: 2),
        ],
      ),
    );
  }

  // =======================
  // LEFT SECTION (EVENT INFO)
  // =======================
  Widget _leftSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end, // IMPORTANT
      children: [
        // Location row (top small text)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(Icons.location_on, size: 14, color: Colors.white),
            SizedBox(width: 6),
            Text('Larit, Mawdangdiang', style: TextStyle(color: Colors.white)),
          ],
        ),

        const SizedBox(height: 16),

        // Event title
        const Text(
          'Mohombi Live in\nShillong',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 50,
            fontWeight: FontWeight.bold,
            height: 1.2,
            //color: Color(0xFF00FF38),
          ),
        ),

        const SizedBox(height: 10),

        // Date & time
        const Text(
          'Sat, Oct 25, 2025, 3:00 PM GMT +5:30',
          style: TextStyle(color: Color(0xFF00FF38), fontSize: 16),
        ),

        const SizedBox(height: 4),

        const Text(
          'Shillong',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),

        const SizedBox(height: 32),

        // Tabs placeholder (About | Venue | T&C | FAQ)
        SizedBox(
          width: Responsive.clampWidth(context, 500),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: const [
                _TabItem(title: 'About', active: true),
                _TabItem(title: 'Venue Layout'),
                _TabItem(title: 'Terms and Conditions'),
                _TabItem(title: 'FAQ'),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // About card
        Container(
          height: Responsive.clampWidth(context, 270),
          width: Responsive.clampWidth(context, 500),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1C),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SingleChildScrollView(
            child: const Text(
              'Get ready for a high-energy night with global pop & Afro-Latin star Mohombi — '
              'the Congolese-Swedish hitmaker behind chart-toppers like '
              '"Bumpy Ride", "Coconut Tree" and "mi amor". Expect a power-packed set '
              'blending pop, dancehall, reggaeton, and Afrobeats with a full live band and dancers.\n\n'
              'Highlights:\n'
              '• International hits and exclusive live edits\n'
              '• State-of-the-art sound & lighting\n'
              '• Limited VIP zones with premium viewing'
              'Come early, clear security fast, and secure your spot up front.'
              'This is one for the books!',
              style: TextStyle(height: 1.6),
            ),
          ),
        ),
      ],
    );
  }

  // =======================
  // RIGHT SECTION (POSTER + PRICE)
  // =======================
  Widget _rightSection(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset('assets/images/mohombi.jpg', fit: BoxFit.cover),
        ),

        const SizedBox(height: 20),

        Container(
          //height: Responsive.clampWidth(context, 140),
          padding: EdgeInsets.all(Responsive.clampWidth(context, 20)),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1C),
            borderRadius: BorderRadius.circular(18),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isTight = constraints.maxWidth < 360; // you can adjust 360

              if (!isTight) {
                // ✅ Normal layout (Row)
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          'STARTING',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹799',
                          style: TextStyle(
                            fontSize: Responsive.clampFont(context, 38),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00FF38),
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.clampWidth(context, 48),
                          vertical: Responsive.clampWidth(context, 24),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TicketsScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Book Now ▶',
                        style: TextStyle(
                          fontSize: Responsive.clampFont(context, 14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                );
              }

              // ✅ Small width layout (Button goes below)
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'STARTING',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹799',
                        style: TextStyle(
                          fontSize: Responsive.clampFont(context, 38),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.clampWidth(context, 12)),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00FF38),
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.clampWidth(context, 48),
                          vertical: Responsive.clampWidth(context, 24),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TicketsScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Book Now ▶',
                        style: TextStyle(
                          fontSize: Responsive.clampFont(context, 14),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

// =======================
// TAB ITEM WIDGET
// =======================
class _TabItem extends StatelessWidget {
  final String title;
  final bool active;

  const _TabItem({required this.title, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: active ? Colors.white : Colors.grey),
          ),
          const SizedBox(height: 6),
          if (active)
            Container(height: 2, width: 40, color: Colors.greenAccent),
        ],
      ),
    );
  }
}

// =======================
// EVENT GUIDE ITEM
// =======================
class _GuideItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _GuideItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF00FF38), size: 20),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

Widget _artistCard() {
  return // =======================
  // ARTIST CARD
  // =======================
  Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/artist.jpg', // add this image
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(width: 26),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 12),
          Text(
            'Mohombi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 2),
          Text(
            'Musician, Singer, Composer and Dancer',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    ],
  );
}

Widget _eventGuide() {
  return // =======================
  // EVENT GUIDE CARD
  // =======================
  LayoutBuilder(
    builder: (context, constraints) {
      final isWide = constraints.maxWidth > 600;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(14),
        ),
        child:
            isWide
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    SizedBox(width: 8),
                    _GuideItem(
                      icon: Icons.translate,
                      label: 'Language',
                      value: 'English',
                    ),
                    SizedBox(width: 38),
                    _GuideItem(
                      icon: Icons.schedule,
                      label: 'Duration',
                      value: 'TBI',
                    ),
                    SizedBox(width: 38),
                    _GuideItem(
                      icon: Icons.airplane_ticket,
                      label: 'Entry Allowed',
                      value: '14 yrs & above',
                    ),
                    SizedBox(width: 38),
                  ],
                )
                : Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 16,
                  runSpacing: 16,
                  children: const [
                    _GuideItem(
                      icon: Icons.translate,
                      label: 'Language',
                      value: 'English',
                    ),
                    _GuideItem(
                      icon: Icons.schedule,
                      label: 'Duration',
                      value: 'TBI',
                    ),
                    _GuideItem(
                      icon: Icons.airplane_ticket,
                      label: 'Entry Allowed',
                      value: '14 yrs & above',
                    ),
                  ],
                ),
      );
    },
  );
}

// =======================
// FOOTER
// =======================
Widget _footer() {
  return Column(
    children: [
      const Divider(color: Colors.white, thickness: 2),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                'ONLYBEES.',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Explore',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  SizedBox(height: 12),
                  Text('About'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Support',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                  SizedBox(height: 12),
                  Text('Contact us'),
                  SizedBox(height: 8),
                  Text('Refund'),
                ],
              ),
            ),
          ],
        ),
      ),

      const Divider(color: Colors.white, thickness: 2),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Copyright © Onlybees 2025, KL & Sons - ONLYBEES',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                'Privacy Policy     Terms and Conditions',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
