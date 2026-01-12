import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // =======================
  // FORM CONTROLLERS
  // =======================
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  // =======================
  // COUNTDOWN TIMER (7:30)
  // =======================
  late Timer _timer;
  int _secondsLeft = 7 * 60 + 30;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
        Navigator.pop(context); // ⏪ go back when time ends
      } else {
        setState(() {
          _secondsLeft--;
        });
      }
    });
  }

  String get formattedTime {
    final minutes = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TicketProvider>();

    // =======================
    // GST CALCULATION (18%)
    // =======================
    final gst = (provider.totalPrice * 0.18).round();
    const bookingFee = 118;
    final grandTotal = provider.totalPrice + gst + bookingFee;

    return Scaffold(
      backgroundColor: Colors.black,

      body: Column(
        children: [
          // =======================
          // SCROLLABLE CONTENT
          // =======================
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 36),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // =======================
                  // LEFT COLUMN – FORM
                  // =======================
                  Expanded(
                    flex: 2,
                    child: _leftForm(),
                  ),

                  const SizedBox(width: 60),

                  // =======================
                  // RIGHT COLUMN – SUMMARY
                  // =======================
                  Expanded(
                    flex: 1,
                    child: _orderSummary(provider, gst, bookingFee, grandTotal),
                  ),
                ],
              ),
            ),
          ),

          // =======================
          // FIXED BOTTOM BAR
          // =======================
          _bottomCheckoutBar(grandTotal, provider),
        ],
      ),
    );
  }

  // ============================================================
  // LEFT COLUMN – CHECKOUT FORM
  // ============================================================
  Widget _leftForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CHECKOUT',
          style: const TextStyle(
            color: Color(0xFF4CFF78),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(
          'Time left: $formattedTime',
          style: const TextStyle(color: Colors.white70),
        ),

        const SizedBox(height: 52),

        _inputField(label: 'Name', controller: nameController),
        const SizedBox(height: 30),

        _inputField(
          label: 'Email',
          hint: 'you@example.com',
          controller: emailController,
        ),

        const SizedBox(height: 10),
        const Text(
          "Note: You'll receive a copy of the tickets here",
          style: TextStyle(
            color: Color(0xFF4CFF78),
            fontSize: 12,
          ),
        ),

        const SizedBox(height: 30),

        _inputField(
          label: 'Phone',
          prefix: '🇮🇳  +91 ',
          controller: phoneController,
        ),

        const SizedBox(height: 44),

        const Text(
          'By purchasing you’ll receive an account and agree to our '
          'Terms of use, Privacy Policy and the Ticket Purchase Terms.',
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }

  // ============================================================
  // INPUT FIELD
  // ============================================================
  Widget _inputField({
    required String label,
    required TextEditingController controller,
    String? hint,
    String? prefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label :', style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            prefixText: prefix,
            prefixStyle: const TextStyle(color: Colors.white),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white24),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // RIGHT COLUMN – ORDER SUMMARY
  // ============================================================
  Widget _orderSummary(
    TicketProvider provider,
    int gst,
    int bookingFee,
    int grandTotal,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/mohombi.jpg', height: 220),

        const SizedBox(height: 18),

        const Text(
          'Mohombi Live in Shillong',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 6),
        const Text(
          'Larit, Mawdiangdiang\nSat, Oct 25, 2025\nShillong',
          style: TextStyle(color: Colors.white70),
        ),

        const SizedBox(height: 34),

        const Text(
          'Order Summary',
          style: TextStyle(
            color: Color(0xFF4CFF78),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 18),

        ...provider.sections
            .where((s) => s.selectedQuantity > 0)
            .map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${s.name}  x${s.selectedQuantity}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      '₹${s.price * s.selectedQuantity}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

        const SizedBox(height: 14),
        _summaryRow('GST (18%)', '₹$gst'),
        _summaryRow('Booking Fees', '₹$bookingFee'),

        const Divider(color: Colors.white24, height: 36),

        _summaryRow('Total', '₹$grandTotal', bold: true),
      ],
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // BOTTOM BAR – PRINT DATA ON CHECKOUT
  // ============================================================
  Widget _bottomCheckoutBar(int total, TicketProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
      decoration: const BoxDecoration(
        color: Color(0xFF1C1C1C),
        border: Border(top: BorderSide(color: Colors.white24)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total: ₹$total',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CFF78),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              // =======================
              // PRINT DATA TO TERMINAL
              // =======================
              print('--- CHECKOUT DATA ---');
              print('Name: ${nameController.text}');
              print('Email: ${emailController.text}');
              print('Phone: ${phoneController.text}');
              print('Tickets:');

              for (final s in provider.sections) {
                if (s.selectedQuantity > 0) {
                  print(
                    '${s.name} x${s.selectedQuantity} = ₹${s.price * s.selectedQuantity}',
                  );
                }
              }

              print('Total Amount: ₹$total');
              print('----------------------');
            },
            child: const Text('Checkout'),
          ),
        ],
      ),
    );
  }
}
