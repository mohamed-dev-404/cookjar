enum FavoriteMeal { breakfast, lunch, dinner, dessert }

extension FavoriteMealX on FavoriteMeal {
  String get label {
    switch (this) {
      case FavoriteMeal.breakfast:
        return 'Breakfast';
      case FavoriteMeal.lunch:
        return 'Lunch';
      case FavoriteMeal.dinner:
        return 'Dinner';
      case FavoriteMeal.dessert:
        return 'Dessert';
    }
  }
}
