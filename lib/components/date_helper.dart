import 'package:intl/intl.dart';

String dateHelper(DateTime date){
  DateFormat dateFormat = DateFormat('dd/MMM/yyy');
  String result = dateFormat.format(date);
  return result;
}