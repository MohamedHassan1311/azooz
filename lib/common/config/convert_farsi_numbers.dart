String? convertArabicToEng(
  String? number,
) {
  if (number != null && number.isNotEmpty) {
    var persianNumbers = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
    var arabicNumbers = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    var enNumbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "."];

    for (var i = 0; i < 10; i++) {
      number = number!
          .replaceAll(RegExp(persianNumbers[i]), enNumbers[i])
          .replaceAll(RegExp(arabicNumbers[i]), enNumbers[i]);
    }
    return number;
  }
  print("Converted Data:: $number ##");
  return number;
}
