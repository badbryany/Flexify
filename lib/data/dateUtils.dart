import 'package:flexify/data/globalVariables.dart' as global;

String dateString(DateTime date) {
  return '${global.months[date.month]} ${date.day.toString()} ${date.year.toString()}';
}