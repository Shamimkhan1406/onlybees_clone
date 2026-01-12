import 'package:flutter/material.dart';
import '../models/section_model.dart';

// =======================
// TICKET CARD UI
// =======================
// Displays one ticket section

class TicketCard extends StatelessWidget {
  final SectionModel section;
  final VoidCallback onAdd;
  final VoidCallback onRemove;

  const TicketCard({
    super.key,
    required this.section,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSoldOut = section.availableQuantity <= 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          // =======================
          // LEFT: Ticket Info
          // =======================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  section.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '₹${section.price}',
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  section.info.replaceAll('\\n', '\n'),
                  style: const TextStyle(color: Colors.grey, height: 1.5),
                ),
              ],
            ),
          ),

          // =======================
          // RIGHT: Quantity Control
          // =======================
          isSoldOut
              ? const Text(
                  'Sold Out',
                  style: TextStyle(color: Colors.redAccent),
                )
              : Row(
                  children: [
                    IconButton(
                      onPressed: onRemove,
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      section.selectedQuantity.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: onAdd,
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
