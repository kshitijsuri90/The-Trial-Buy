import 'package:flutter_myntra_clone/utils/asset_constants.dart';

class HomeData {
  static List<String> getTopbarAssets() {
    return [
      offers, men, women, kids, festive, beauty, home, jewellery, gadgets, essentials,
    ];
  }

  static List<String> getBiggestOffers() {
    return [
      offer1, offer2, offer3, offer4, offer5, offer6, offer7, offer8, offer9, offer10,
    ];
  }

  static List<String> getDailyDeals() {
    return [
      daily_1, daily_2, daily_3, daily_4, daily_5, daily_6,
    ];
  }

  static List<String> getFeaturedBrands() {
    return [
      featured_1, featured_2, featured_3, featured_4, featured_5, featured_6, featured_7, featured_8,
    ];
  }
}
