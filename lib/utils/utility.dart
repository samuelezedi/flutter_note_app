
import 'package:time_formatter/time_formatter.dart';

class Utility {

  static getHumanTime( timestamp ) {
    return formatTime(timestamp.seconds * 1000);
  }
}