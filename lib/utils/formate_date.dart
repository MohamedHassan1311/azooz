import 'package:intl/intl.dart' as intl;

const String dateFormat = 'dd/MMMM/yyyy';
const String adsDateFormat = 'yyyy-MM-dd';

// String formatsTime(DateTime? dateTime) {
//   if (dateTime != null) {
//     return intl.DateFormat('$dateFormat - hh:mm a').format(dateTime);
//   } else {
//     return intl.DateFormat('$dateFormat - hh:mm a').format(DateTime.now());
//   }
// }

String formatsTime(DateTime? dateTime) {
  if (dateTime != null) {
    return intl.DateFormat('dd/MM/yyyy - hh:mm a').format(dateTime);
  } else {
    return intl.DateFormat('dd/MM/yyyy - hh:mm a').format(DateTime.now());
  }
}

String getMinuteString(double decimalValue) {
  var data = (decimalValue * 60).toString().padLeft(2, '0');
  return data.substring(0, 3);
}

String formatDate(String date) {
  return intl.DateFormat(dateFormat).format(DateTime.parse(date));
}

String adsFormatDate(String date) {
  return intl.DateFormat(adsDateFormat).format(DateTime.parse(date));
}
