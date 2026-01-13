import 'package:flutter/material.dart';
import 'package:onlybees_clone/screens/tickets_screen.dart';
import 'package:onlybees_clone/utils/responsive.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // Dynamic page padding (so it shrinks properly)
    final pageHorizontalPadding = w < 350
        ? 12.0
        : w < 500
            ? 16.0
            : w < 900
                ? 24.0
                : 24.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _header(),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: w < 1000 ? w : 950,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: pageHorizontalPadding,
                    vertical: 32,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: w < 500 ? 0 : Responsive.clampWidth(context, 20),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final isSmall = constraints.maxWidth < 850;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // ✅ Desktop: Row | Mobile: Column
                                if (!isSmall)
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(flex: 2, child: _leftSection(context, isSmall: false)),
                                      SizedBox(width: Responsive.clampWidth(context, 24)),
                                      Expanded(flex: 2, child: _rightSection(context)),
                                    ],
                                  )
                                else
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _rightSection(context),
                                      SizedBox(height: Responsive.clampWidth(context, 24)),
                                      _leftSection(context, isSmall: true),
                                    ],
                                  ),

                                SizedBox(height: Responsive.clampWidth(context, 40)),

                                const Text(
                                  'Event Guide',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                _eventGuide(),

                                const SizedBox(height: 16),

                                const Text(
                                  'Artist',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 16),

                                _artistCard(),
                              ],
                            );
                          },
                        ),
                      ),

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
  // HEADER
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
  // LEFT SECTION
  // =======================
  Widget _leftSection(BuildContext context, {required bool isSmall}) {
    final w = MediaQuery.of(context).size.width;

    final titleFont = w < 500 ? 34.0 : w < 850 ? 42.0 : 50.0;

    return Column(
      crossAxisAlignment: isSmall ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: isSmall ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: const [
            Icon(Icons.location_on, size: 14, color: Colors.white),
            SizedBox(width: 6),
            Text('Larit, Mawdangdiang', style: TextStyle(color: Colors.white)),
          ],
        ),

        const SizedBox(height: 16),

        Text(
          'Mohombi Live in\nShillong',
          textAlign: isSmall ? TextAlign.left : TextAlign.right,
          style: TextStyle(
            fontSize: titleFont,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 10),

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

        // Tabs horizontal scroll (no overflow)
        SizedBox(
          width: double.infinity,
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

        // About card width always fits screen
        Container(
          height: w < 500 ? 290 : 370,
          width: double.infinity,
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
              '• Limited VIP zones with premium viewing\n'
              'Come early, clear security fast, and secure your spot up front.\n'
              'This is one for the books!',
              style: TextStyle(height: 1.6),
            ),
          ),
        ),
      ],
    );
  }

  // =======================
  // RIGHT SECTION
  // =======================
  Widget _rightSection(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: Image.asset(
              'assets/images/mohombi.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),

        const SizedBox(height: 20),

        Container(
          padding: EdgeInsets.all(Responsive.clampWidth(context, 20)),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1C),
            borderRadius: BorderRadius.circular(18),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isTight = constraints.maxWidth < 360;

              if (!isTight) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _priceBlock(context),
                    _bookButton(context),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _priceBlock(context),
                  SizedBox(height: Responsive.clampWidth(context, 12)),
                  SizedBox(width: double.infinity, child: _bookButton(context)),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _priceBlock(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        const Text(
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
    );
  }

  Widget _bookButton(BuildContext context) {
    return ElevatedButton(
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
          MaterialPageRoute(builder: (context) => const TicketsScreen()),
        );
      },
      child: Text(
        'Book Now ▶',
        style: TextStyle(
          fontSize: Responsive.clampFont(context, 14),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// =======================
// TAB ITEM
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
// GUIDE ITEM
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xFF00FF38), size: 20),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }
}

Widget _artistCard() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/artist.jpg',
          width: 120,
          height: 120,
          fit: BoxFit.cover,
        ),
      ),
      const SizedBox(height: 12),
      const Text(
        'Mohombi',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 2),
      const Text(
        'Musician, Singer, Composer and Dancer',
        style: TextStyle(color: Colors.grey),
      ),
    ],
  );
}

Widget _eventGuide() {
  return LayoutBuilder(
    builder: (context, constraints) {
      final isWide = constraints.maxWidth > 600;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1C1C1C),
          borderRadius: BorderRadius.circular(14),
        ),
        child: isWide
            ? Row(
                children: const [
                  _GuideItem(icon: Icons.translate, label: 'Language', value: 'English'),
                  SizedBox(width: 38),
                  _GuideItem(icon: Icons.schedule, label: 'Duration', value: 'TBI'),
                  SizedBox(width: 38),
                  _GuideItem(icon: Icons.airplane_ticket, label: 'Entry Allowed', value: '14 yrs & above'),
                ],
              )
            : Wrap(
                spacing: 16,
                runSpacing: 16,
                children: const [
                  _GuideItem(icon: Icons.translate, label: 'Language', value: 'English'),
                  _GuideItem(icon: Icons.schedule, label: 'Duration', value: 'TBI'),
                  _GuideItem(icon: Icons.airplane_ticket, label: 'Entry Allowed', value: '14 yrs & above'),
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isSmall = constraints.maxWidth < 500;

            if (isSmall) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('ONLYBEES.', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Text('Explore', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                  SizedBox(height: 12),
                  Text('About'),
                  SizedBox(height: 20),
                  Text('Support', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                  SizedBox(height: 12),
                  Text('Contact us'),
                  SizedBox(height: 8),
                  Text('Refund'),
                ],
              );
            }

            return Row(
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
                      Text('Explore', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                      SizedBox(height: 12),
                      Text('About'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Support', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19)),
                      SizedBox(height: 12),
                      Text('Contact us'),
                      SizedBox(height: 8),
                      Text('Refund'),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),

      const Divider(color: Colors.white, thickness: 2),

      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              Text(
                'Copyright © Onlybees 2025, KL & Sons - ONLYBEES',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(width: 20),
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
