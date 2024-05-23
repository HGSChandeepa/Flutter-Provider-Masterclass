import 'package:flutter/material.dart';

class FavoritesProvider extends ChangeNotifier {
  final Map<String, bool> _favorites = {};

  Map<String, bool> get favorites => _favorites;

  void toggleFavorite(String productId) {
    if (_favorites.containsKey(productId)) {
      _favorites[productId] = !_favorites[productId]!;
    } else {
      _favorites[productId] = true;
    }
    notifyListeners();
  }

  bool isFavorite(String productId) {
    return _favorites[productId] ?? false;
  }
}
