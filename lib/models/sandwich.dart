enum BreadType { white, wheat, wholemeal }

enum SandwichType {
  veggieDelight,
  chickenTeriyaki,
  tunaMelt,
  meatballMarinara,
}

class Sandwich {
  final String id;
  final SandwichType type;
  final bool isFootlong;
  final BreadType breadType;
  final String description;
  final bool available;

  Sandwich({
    required this.id,
    required this.type,
    required this.isFootlong,
    required this.breadType,
    required this.description,
    required this.available,
  });

  /// Factory constructor to create a Sandwich from JSON data.
  factory Sandwich.fromJson(Map<String, dynamic> json) {
    return Sandwich(
      id: json['id'] as String? ?? '',
      type: _sandwichTypeFromString(json['type'] as String? ?? 'veggieDelight'),
      isFootlong: json['isFootlong'] as bool? ?? true,
      breadType: _breadTypeFromString(json['breadType'] as String? ?? 'white'),
      description: json['description'] as String? ?? '',
      available: json['available'] as bool? ?? true,
    );
  }

  String get name {
    switch (type) {
      case SandwichType.veggieDelight:
        return 'Veggie Delight';
      case SandwichType.chickenTeriyaki:
        return 'Chicken Teriyaki';
      case SandwichType.tunaMelt:
        return 'Tuna Melt';
      case SandwichType.meatballMarinara:
        return 'Meatball Marinara';
    }
  }

  String get image {
    String typeString = type.name;
    String sizeString = '';
    if (isFootlong) {
      sizeString = 'footlong';
    } else {
      sizeString = 'six_inch';
    }
    return 'assets/images/${typeString}_$sizeString.png';
  }
}

/// Helper function to convert a string to SandwichType enum.
SandwichType _sandwichTypeFromString(String value) {
  switch (value.toLowerCase()) {
    case 'veggiedelight':
      return SandwichType.veggieDelight;
    case 'chickenteriyaki':
      return SandwichType.chickenTeriyaki;
    case 'tunamelt':
      return SandwichType.tunaMelt;
    case 'meatballmarinara':
      return SandwichType.meatballMarinara;
    default:
      return SandwichType.veggieDelight;
  }
}

/// Helper function to convert a string to BreadType enum.
BreadType _breadTypeFromString(String value) {
  switch (value.toLowerCase()) {
    case 'white':
      return BreadType.white;
    case 'wheat':
      return BreadType.wheat;
    case 'wholemeal':
      return BreadType.wholemeal;
    default:
      return BreadType.white;
  }
}
