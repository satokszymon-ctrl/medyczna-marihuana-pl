// lib/models/strain.dart
// Data model for medical marijuana strain information.

class Terpene {
  final String name;
  final String percentage;
  final String effect;

  const Terpene({
    required this.name,
    required this.percentage,
    required this.effect,
  });

  factory Terpene.fromJson(Map<String, dynamic> json) {
    return Terpene(
      name: json['name'] as String,
      percentage: json['percentage'] as String,
      effect: json['effect'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'percentage': percentage,
        'effect': effect,
      };
}

class Strain {
  final String id;
  final String brand;
  final String strainName;
  final String thcContent;
  final String cbdContent;
  final String type;
  final List<String> medicalUse;
  final List<Terpene> terpenes;
  final List<String> effects;
  final List<String> sideEffects;
  final List<String> flavorProfile;
  final String origin;
  final String form;
  final String packaging;
  final String prescriptionName;
  final String description;
  final String imageColor;

  const Strain({
    required this.id,
    required this.brand,
    required this.strainName,
    required this.thcContent,
    required this.cbdContent,
    required this.type,
    required this.medicalUse,
    required this.terpenes,
    required this.effects,
    required this.sideEffects,
    required this.flavorProfile,
    required this.origin,
    required this.form,
    this.packaging = '',
    this.prescriptionName = '',
    required this.description,
    required this.imageColor,
  });

  factory Strain.fromJson(Map<String, dynamic> json) {
    return Strain(
      id: json['id'] as String,
      brand: json['brand'] as String,
      strainName: json['strainName'] as String,
      thcContent: json['thcContent'] as String,
      cbdContent: json['cbdContent'] as String,
      type: json['type'] as String,
      medicalUse: List<String>.from(json['medicalUse'] as List),
      terpenes: (json['terpenes'] as List)
          .map((t) => Terpene.fromJson(t as Map<String, dynamic>))
          .toList(),
      effects: List<String>.from(json['effects'] as List),
      sideEffects: List<String>.from(json['sideEffects'] as List),
      flavorProfile: List<String>.from(json['flavorProfile'] as List),
      origin: json['origin'] as String,
      form: json['form'] as String,
      packaging: (json['packaging'] as String?) ?? '',
      prescriptionName: (json['prescriptionName'] as String?) ?? '',
      description: json['description'] as String,
      imageColor: json['imageColor'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'brand': brand,
        'strainName': strainName,
        'thcContent': thcContent,
        'cbdContent': cbdContent,
        'type': type,
        'medicalUse': medicalUse,
        'terpenes': terpenes.map((t) => t.toJson()).toList(),
        'effects': effects,
        'sideEffects': sideEffects,
        'flavorProfile': flavorProfile,
        'origin': origin,
        'form': form,
        'packaging': packaging,
        'prescriptionName': prescriptionName,
        'description': description,
        'imageColor': imageColor,
      };

  /// Get the type icon string representation
  String get typeEmoji {
    switch (type) {
      case 'Sativa':
        return '☀️';
      case 'Indica':
        return '🌙';
      case 'Hybrid':
        return '⚖️';
      default:
        return '🌿';
    }
  }

  /// Parse the hex color string to a Color-compatible int
  int get colorValue {
    final hex = imageColor.replaceAll('#', '');
    return int.parse('FF$hex', radix: 16);
  }
}

class EducationalSection {
  final String heading;
  final String content;

  const EducationalSection({
    required this.heading,
    required this.content,
  });

  factory EducationalSection.fromJson(Map<String, dynamic> json) {
    return EducationalSection(
      heading: json['heading'] as String,
      content: json['content'] as String,
    );
  }
}

class EducationalContent {
  final String title;
  final String lastUpdated;
  final List<EducationalSection> sections;

  const EducationalContent({
    required this.title,
    required this.lastUpdated,
    required this.sections,
  });

  factory EducationalContent.fromJson(Map<String, dynamic> json) {
    return EducationalContent(
      title: json['title'] as String,
      lastUpdated: json['lastUpdated'] as String,
      sections: (json['sections'] as List)
          .map((s) => EducationalSection.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }
}
