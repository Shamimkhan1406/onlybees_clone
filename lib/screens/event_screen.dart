import 'package:flutter/material.dart';

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
                  constraints: const BoxConstraints(maxWidth: 1200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // =======================
                      // LEFT SIDE (TEXT CONTENT)
                      // =======================
                      Expanded(
                        flex: 2,
                        child: _leftSection(),
                      ),

                      const SizedBox(width: 32),

                      // =======================
                      // RIGHT SIDE (POSTER + PRICE)
                      // =======================
                      Expanded(
                        flex: 1,
                        child: _rightSection(),
                      ),
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
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 16),
          Divider(color: Colors.white24, thickness: 1),
        ],
      ),
    );
  }

  // =======================
  // LEFT SECTION (EVENT INFO)
  // =======================
  Widget _leftSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // IMPORTANT
      children: [
        // Location row (top small text)
        Row(
          children: const [
            Icon(Icons.location_on, size: 14, color: Colors.grey),
            SizedBox(width: 6),
            Text(
              'Larit, Mawdangdiang',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Event title
        const Text(
          'Mohombi Live in Shillong',
          style: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 12),

        // Date & time
        const Text(
          'Sat, Oct 25, 2025, 3:00 PM GMT +5:30',
          style: TextStyle(
            color: Colors.greenAccent,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 6),

        const Text(
          'Shillong',
          style: TextStyle(color: Colors.grey),
        ),

        const SizedBox(height: 32),

        // Tabs placeholder (About | Venue | T&C | FAQ)
        Row(
          children: const [
            _TabItem(title: 'About', active: true),
            _TabItem(title: 'Venue Layout'),
            _TabItem(title: 'Terms and Conditions'),
            _TabItem(title: 'FAQ'),
          ],
        ),

        const SizedBox(height: 24),

        // About card
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1C),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            'Get ready for a high-energy night with global pop & Afro-Latin star Mohombi — '
            'the Congolese-Swedish hitmaker behind chart-toppers like '
            '"Bumpy Ride", "Coconut Tree" and "mi amor". Expect a power-packed set '
            'blending pop, dancehall, reggaeton, and Afrobeats with a full live band and dancers.\n\n'
            'Highlights:\n'
            '• International hits and exclusive live edits\n'
            '• State-of-the-art sound & lighting\n'
            '• Limited VIP zones with premium viewing',
            style: TextStyle(height: 1.6),
          ),
        ),
      ],
    );
  }

  // =======================
  // RIGHT SECTION (POSTER + PRICE)
  // =======================
  Widget _rightSection() {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/images/mohombi.jpg',
            fit: BoxFit.cover,
          ),
        ),

        const SizedBox(height: 20),

        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1C1C1C),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'STARTING',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹799',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {},
                child: const Text('Book Now ▶'),
              ),
            ],
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

  const _TabItem({
    required this.title,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: active ? Colors.white : Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          if (active)
            Container(
              height: 2,
              width: 40,
              color: Colors.greenAccent,
            ),
        ],
      ),
    );
  }
}
