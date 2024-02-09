import 'package:isar/isar.dart';

part 'habit.g.dart';

@Collection()
class Habit{
  //habit id
  Id id = Isar.autoIncrement;
  //habit name
  late String name;
  //completed days
  List<DateTime> completeDays = [
    //DataTime(year,month,day),
    //DataTime(2024,1,1),
    //DataTime(2024,2,2).
  ];
 }