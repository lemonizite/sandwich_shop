class PricingRepository {
  // Prices in pounds
  static const double sixInchPrice = 7.0;
  static const double footlongPrice = 11.0;

  const PricingRepository();

  /// Returns the unit price for the selected sandwich size.
  double unitPrice({required bool isFootlong}) {
    return isFootlong ? footlongPrice : sixInchPrice;
  }

  /// Calculates the total price for [quantity] sandwiches of the given size.
  double totalPrice({required int quantity, required bool isFootlong}) {
    if (quantity <= 0) return 0.0;
    return unitPrice(isFootlong: isFootlong) * quantity;
  }
}
