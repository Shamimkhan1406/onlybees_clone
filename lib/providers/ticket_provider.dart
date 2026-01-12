import 'package:flutter/material.dart';
import '../models/section_model.dart';
import '../services/api_service.dart';

// =======================
// TICKET PROVIDER
// =======================
// Holds ticket list + selection logic

class TicketProvider extends ChangeNotifier {
  List<SectionModel> _sections = [];
  bool isLoading = true;

  List<SectionModel> get sections => _sections;

  // Fetch tickets from API
  Future<void> loadSections() async {
    print('loadSections() called'); // 👈 DEBUG
    isLoading = true;
    notifyListeners();
    try {
      _sections = await ApiService.fetchSections();
      print('Tickets fetched: ${_sections.length}'); // 👈 DEBUG
    } catch (e) {
      print('API ERROR: $e'); // 👈 DEBUG
    }

    isLoading = false;
    notifyListeners();
  }

  // Increase ticket quantity
  void increment(SectionModel section) {
    if (section.selectedQuantity < section.availableQuantity) {
      section.selectedQuantity++;
      notifyListeners();
    }
  }

  // Decrease ticket quantity
  void decrement(SectionModel section) {
    if (section.selectedQuantity > 0) {
      section.selectedQuantity--;
      notifyListeners();
    }
  }

  // Calculate total price
  int get totalPrice {
    int total = 0;
    for (final s in _sections) {
      total += s.selectedQuantity * s.price;
    }
    return total;
  }

  // Calculate total tickets
  int get totalTickets {
    int total = 0;
    for (final s in _sections) {
      total += s.selectedQuantity;
    }
    return total;
  }
}
