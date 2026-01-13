import 'dart:async';
import 'package:flutter/material.dart';
import 'package:onlybees_clone/widgets/coupon_code_widget.dart';
import 'package:provider/provider.dart';
import '../providers/ticket_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  // =======================
  // FORM KEY
  // =======================
  final _formKey = GlobalKey<FormState>();

  // =======================
  // TEXT CONTROLLERS
  // =======================
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final couponController = TextEditingController();

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
    couponController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft == 0) {
        timer.cancel();
        Navigator.pop(context);
      } else {
        setState(() => _secondsLeft--);
      }
    });
  }

  String get formattedTime {
    final m = (_secondsLeft ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsLeft % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TicketProvider>();

    // =======================
    // PRICE CALCULATIONS
    // =======================
    final gst = (provider.totalPrice * 0.18).round();
    const bookingFee = 118;
    final total = provider.totalPrice + gst + bookingFee;

    final w = MediaQuery.of(context).size.width;

    // ✅ Responsive page padding (removes constant big margins)
    final horizontalPadding = w < 350
        ? 12.0
        : w < 600
            ? 16.0
            : w < 900
                ? 40.0
                : 248.0;

    return Scaffold(
      backgroundColor: Colors.black,

      // ✅ Sticky bottom bar
      bottomNavigationBar: _bottomCheckoutBar(provider, total),

      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // =======================
                // SCROLLABLE CONTENT ONLY
                // =======================
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: w < 600 ? 20 : 36,
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isSmall = constraints.maxWidth < 700;

                        // ✅ Small screen: summary below form
                        if (isSmall) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Poster at the top
                              Image.asset('assets/images/mohombi.jpg', height: 220),
                              const SizedBox(height: 14),
                              // Event description below poster
                              const Text(
                                'Mohombi Live in\nShillong',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Larit, Mawdiangdiang',
                                style: TextStyle(color: Colors.white),
                              ),
                              const Text(
                                'Sat, Oct 25, 2025',
                                style: TextStyle(color: Colors.greenAccent),
                              ),
                              const Text('Shillong', style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 30),
                              // Input fields below event info
                              _leftForm(),
                              const SizedBox(height: 30),
                              _orderSummary(provider, gst, bookingFee, total, skipEventInfo: true),
                              const SizedBox(height: 30),
                            ],
                          );
                        }

                        // ✅ Desktop: keep same UI (2 columns)
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 1, child: _leftForm()),
                            const SizedBox(width: 90),
                            Expanded(
                              flex: 1,
                              child: _orderSummary(
                                provider,
                                gst,
                                bookingFee,
                                total,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),

            // =======================
            // TOP RIGHT CLOSE BUTTON (FIXED)
            // =======================
            Positioned(
              top: 8,
              right: 8,
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
          ],
        ),
      ),
    );
  }

  // ============================================================
  // LEFT FORM
  // ============================================================
  Widget _leftForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CHECKOUT',
            style: TextStyle(
              color: Color(0xFF4CFF78),
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),

          Row(
            children: [
              const Text('Time left: ', style: TextStyle(color: Colors.white)),
              Text(
                formattedTime,
                style: const TextStyle(color: Colors.green),
              ),
            ],
          ),

          // ✅ Instead of fixed 142px (causes overflow on small screen)
          SizedBox(height: MediaQuery.of(context).size.width < 600 ? 40 : 142),

          _inputField(
            label: 'Name',
            controller: nameController,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return 'Name is required';
              if (v.trim().length < 3) return 'Name must be at least 3 characters';
              return null;
            },
          ),

          const SizedBox(height: 12),

          _inputField(
            label: 'Email',
            hint: 'you@example.com',
            controller: emailController,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Email is required';
              final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
              if (!regex.hasMatch(v)) return 'Enter a valid email';
              return null;
            },
          ),

          const SizedBox(height: 10),
          const Text(
            "Note: You'll receive a copy of the tickets here",
            style: TextStyle(color: Color(0xFF4CFF78), fontSize: 12),
          ),

          const SizedBox(height: 30),

          _inputField(
            label: 'Phone',
            prefix: '🇮🇳  +91 ',
            controller: phoneController,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Phone number is required';
              if (!RegExp(r'^\d{10}$').hasMatch(v)) {
                return 'Enter a valid 10-digit number';
              }
              return null;
            },
          ),

          const SizedBox(height: 44),

          const Text(
            'By purchasing you’ll receive an account and agree to our '
            'Terms of use, Privacy Policy and the Ticket Purchase Terms.',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
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
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label :', style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
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
            errorStyle: const TextStyle(color: Colors.redAccent),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // ORDER SUMMARY
  // ============================================================
  Widget _orderSummary(
    TicketProvider provider,
    int gst,
    int bookingFee,
    int total, {
    bool skipEventInfo = false,
  }) {
    final w = MediaQuery.of(context).size.width;
    final isSmall = w < 900;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!skipEventInfo)
          isSmall
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/mohombi.jpg', height: 220),
                    const SizedBox(height: 14),
                    const Text(
                      'Mohombi Live in\nShillong',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Larit, Mawdiangdiang',
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      'Sat, Oct 25, 2025',
                      style: TextStyle(color: Colors.greenAccent),
                    ),
                    const Text('Shillong', style: TextStyle(color: Colors.white)),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 0,
                      child: Image.asset('assets/images/mohombi.jpg', height: 220),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Mohombi Live in\nShillong',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 6),
                            Text(
                              'Larit, Mawdiangdiang',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Sat, Oct 25, 2025',
                              style: TextStyle(color: Colors.greenAccent),
                            ),
                            Text('Shillong', style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
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
                  children: [
                    Expanded(
                      child: Text(
                        '${s.name} x${s.selectedQuantity}',
                        style: const TextStyle(color: Colors.white70),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '₹${s.price * s.selectedQuantity}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

        const SizedBox(height: 14),
        _summaryRow('GST (excl.)', '₹$gst'),
        _summaryRow('Booking Fees', '₹$bookingFee'),

        const Divider(color: Colors.white24, height: 36),

        _summaryRow('Total', '₹$total', bold: true),

        const SizedBox(height: 28),

        CouponCodeWidget(
          controller: couponController,
          onApply: () {
            print('Coupon Applied: ${couponController.text}');
          },
        ),
      ],
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
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
  // BOTTOM BAR (STICKY + RESPONSIVE)
  // ============================================================
  Widget _bottomCheckoutBar(TicketProvider provider, int total) {
    final w = MediaQuery.of(context).size.width;

    final horizontalPad = w < 350
        ? 12.0
        : w < 600
            ? 16.0
            : w < 900
                ? 40.0
                : 236.0;

    return SafeArea(
      top: false,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPad,
          vertical: w < 600 ? 12 : 18,
        ),
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1C),
          border: Border(top: BorderSide(color: Colors.white24)),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTight = constraints.maxWidth < 420;

            if (isTight) {
              // ✅ stack in tight mode
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total: ₹$total',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4CFF38),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) return;

                        print('--- CHECKOUT DATA ---');
                        print('Name: ${nameController.text}');
                        print('Email: ${emailController.text}');
                        print('Phone: ${phoneController.text}');

                        for (final s in provider.sections) {
                          if (s.selectedQuantity > 0) {
                            print(
                              '${s.name} x${s.selectedQuantity} = ₹${s.price * s.selectedQuantity}',
                            );
                          }
                        }

                        print('Total: ₹$total');
                        print('----------------------');
                      },
                      child: const Text(
                        'Proceed',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            // ✅ desktop same row UI
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Total: ₹$total',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CFF38),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 52,
                      vertical: 26,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    print('--- CHECKOUT DATA ---');
                    print('Name: ${nameController.text}');
                    print('Email: ${emailController.text}');
                    print('Phone: ${phoneController.text}');

                    for (final s in provider.sections) {
                      if (s.selectedQuantity > 0) {
                        print(
                          '${s.name} x${s.selectedQuantity} = ₹${s.price * s.selectedQuantity}',
                        );
                      }
                    }

                    print('Total: ₹$total');
                    print('----------------------');
                  },
                  child: const Text(
                    'Proceed',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
