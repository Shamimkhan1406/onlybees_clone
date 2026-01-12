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
        color:
            isSoldOut
                ? const Color.fromARGB(255, 14, 13, 13)
                : const Color(0xFF1C1C1C),
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
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        isSoldOut
                            ? const Color.fromARGB(255, 112, 111, 111)
                            : Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      '₹${section.price}',
                      style: TextStyle(
                        color:
                            isSoldOut
                                ? Color.fromARGB(255, 69, 93, 75)
                                : Color(0xFF00FF38),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Exel. taxes',
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color:
                            isSoldOut
                                ? const Color.fromARGB(255, 112, 111, 111)
                                : Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Divider(color: Color.fromARGB(60, 61, 61, 61)),
                const SizedBox(height: 5),
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
              ? Container(
                height: 40,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color.fromARGB(255, 82, 81, 81)),
                ),
                child: const Text(
                  'Sold Out',
                  style: TextStyle(color: Color.fromARGB(255, 162, 72, 72), fontWeight: FontWeight.bold),
                ),
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
