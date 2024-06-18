import 'package:flutter/foundation.dart';

class SelectedDatesProvider with ChangeNotifier {
  List<DateTime> _selectedDates = [];

  List<DateTime> get selectedDates => _selectedDates;

  void setSelectedDates(List<DateTime> dates) {
    _selectedDates = dates;
    notifyListeners();
  }

  void clearSelectedDates() {
    _selectedDates.clear();
    notifyListeners();
  }
}
