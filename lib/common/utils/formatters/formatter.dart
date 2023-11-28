import 'package:intl/intl.dart';

class TFormatter {


  static String formatDate(DateTime? date){
    date ??= DateTime.now();
    // return DateFormat('dd-MMM-yyyy').format(date);

    return '${DateFormat('yyyy년 MM월 dd일').format(date)} (${DateFormat('E', 'ko').format(date)})';
  }

  static String formatCurrency(double amount){
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber){
    if(phoneNumber.length == 10){
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} - ${phoneNumber.substring(6)}';
    }else if(phoneNumber.length == 11){
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 7)} - ${phoneNumber.substring(7)}';
    }

    return phoneNumber;
  }


}