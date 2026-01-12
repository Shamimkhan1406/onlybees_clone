import 'package:flutter/material.dart';
import '../models/section_model.dart';
import '../services/api_service.dart';

// =======================
// TICKET PROVIDER
// =======================

class TicketProvider extends ChangeNotifier {
  List<SectionModel> _sections = [];
  bool isLoading = true;

  List<SectionModel> get sections => _sections;

  // -----------------------
  // Load tickets from API
  // -----------------------
  Future<void> loadSections() async {
    isLoading = true;
    notifyListeners();

    try {
      _sections = await ApiService.fetchSections();
    } catch (e) {
      debugPrint('API ERROR: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  // -----------------------
  // Increase ticket quantity
  // -----------------------
  void increment(SectionModel section) {
    if (section.selectedQuantity < section.availableQuantity) {
      section.selectedQuantity++;
      notifyListeners();
    }
  }

  // -----------------------
  // Decrease ticket quantity
  // -----------------------
  void decrement(SectionModel section) {
    if (section.selectedQuantity > 0) {
      section.selectedQuantity--;
      notifyListeners();
    }
  }

  // -----------------------
  // Total price
  // -----------------------
  int get totalPrice {
    int total = 0;
    for (final s in _sections) {
      total += s.selectedQuantity * s.price;
    }
    return total;
  }

  // -----------------------
  // Total tickets
  // -----------------------
  int get totalTickets {
    int total = 0;
    for (final s in _sections) {
      total += s.selectedQuantity;
    }
    return total;
  }
}
