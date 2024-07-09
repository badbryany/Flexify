import 'package:flexify/data/globalVariables.dart' as global;

String dateString(DateTime date) {
  return '${date.day.toString()} ${global.months[date.month - 1]} ${date.year.toString()}';
}