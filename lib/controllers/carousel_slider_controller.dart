import 'package:flutter/material.dart';

class CarouselSliderController extends ChangeNotifier {

  int currentIndex = 0;

  onPageChange({required int index}) {
    currentIndex = index;
    notifyListeners();
  }
  
}