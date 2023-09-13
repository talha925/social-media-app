import 'package:flutter/material.dart';

class FavouriteProider extends ChangeNotifier {
  bool _isLiked = false;

  bool get isLiked => _isLiked;

  void toggleLike() {
    _isLiked = !_isLiked;
    notifyListeners();
  }
}
