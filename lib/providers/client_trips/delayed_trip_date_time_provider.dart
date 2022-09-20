import 'package:flutter/material.dart';

import '../../common/style/colors.dart';

class DelayedTripDateTimeProvider extends ChangeNotifier {
  String _selectedDateTime = "";
  DateTime? _selectedDateAndTime;

  String get getSelectedDateTime => _selectedDateTime;
  DateTime? get selectedDateAndTime => _selectedDateAndTime;

  Future<DateTime?> openDateTimePicker(BuildContext context) async {
    var date = await showDatePicker(
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Palette.primaryColor,
              onPrimary: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Palette.primaryColor,
              ),
            ),
          ),
          child: child!,
        );
      },
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      currentDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    var time = date == null
        ? null
        : await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Palette.primaryColor,
                    onPrimary: Colors.black,
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      primary: Palette.primaryColor,
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );

    if (date != null && time != null) {
      DateTime? dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      _selectedDateAndTime = dateTime;
      _selectedDateTime = dateTime.toString();
    }
    notifyListeners();
    return _selectedDateAndTime;
  }

  void clearSelectedDateAndTime() {
    _selectedDateTime = "";
    _selectedDateAndTime = null;
  }
}
