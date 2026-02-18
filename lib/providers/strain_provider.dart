// lib/providers/strain_provider.dart
// State management for strain data using Provider pattern.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/strain.dart';

class StrainProvider with ChangeNotifier {
  List<Strain> _allStrains = [];
  List<Strain> _filteredStrains = [];
  EducationalContent? _educationalContent;
  String _searchQuery = '';
  String _selectedBrand = 'Wszystkie';
  String _selectedType = 'Wszystkie';
  bool _isLoading = true;
  String? _error;

  // Getters
  List<Strain> get filteredStrains => _filteredStrains;
  List<Strain> get allStrains => _allStrains;
  EducationalContent? get educationalContent => _educationalContent;
  String get searchQuery => _searchQuery;
  String get selectedBrand => _selectedBrand;
  String get selectedType => _selectedType;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<String> get availableBrands {
    final brands = _allStrains.map((s) => s.brand).toSet().toList();
    brands.sort();
    return ['Wszystkie', ...brands];
  }

  List<String> get availableTypes =>
      ['Wszystkie', 'Sativa', 'Indica', 'Hybrid'];

  int get totalStrainCount => _allStrains.length;

  /// Load strain data from local JSON asset
  Future<void> loadStrains() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final String jsonString =
          await rootBundle.loadString('assets/data.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      _allStrains = (jsonData['strains'] as List)
          .map((s) => Strain.fromJson(s as Map<String, dynamic>))
          .toList();

      if (jsonData['educationalContent'] != null) {
        _educationalContent = EducationalContent.fromJson(
          jsonData['educationalContent'] as Map<String, dynamic>,
        );
      }

      _applyFilters();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = 'Błąd wczytywania danych: $e';
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  /// Update brand filter
  void setSelectedBrand(String brand) {
    _selectedBrand = brand;
    _applyFilters();
    notifyListeners();
  }

  /// Update type filter
  void setSelectedType(String type) {
    _selectedType = type;
    _applyFilters();
    notifyListeners();
  }

  /// Reset all filters
  void resetFilters() {
    _searchQuery = '';
    _selectedBrand = 'Wszystkie';
    _selectedType = 'Wszystkie';
    _applyFilters();
    notifyListeners();
  }

  /// Apply all active filters to the strain list
  void _applyFilters() {
    _filteredStrains = _allStrains.where((strain) {
      // Search query filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchesName =
            strain.strainName.toLowerCase().contains(query);
        final matchesBrand = strain.brand.toLowerCase().contains(query);
        final matchesMedical = strain.medicalUse
            .any((use) => use.toLowerCase().contains(query));
        final matchesEffects =
            strain.effects.any((e) => e.toLowerCase().contains(query));
        final matchesTerpenes = strain.terpenes
            .any((t) => t.name.toLowerCase().contains(query));

        if (!matchesName &&
            !matchesBrand &&
            !matchesMedical &&
            !matchesEffects &&
            !matchesTerpenes) {
          return false;
        }
      }

      // Brand filter
      if (_selectedBrand != 'Wszystkie' && strain.brand != _selectedBrand) {
        return false;
      }

      // Type filter
      if (_selectedType != 'Wszystkie' && strain.type != _selectedType) {
        return false;
      }

      return true;
    }).toList();
  }
}
