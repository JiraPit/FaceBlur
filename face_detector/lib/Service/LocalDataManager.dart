import 'package:flutter/material.dart';

class LocalDataManager extends ChangeNotifier {
  bool isLoading = false;
  void setLoading({required bool set}) {
    isLoading = set;
    notifyListeners();
  }
}
