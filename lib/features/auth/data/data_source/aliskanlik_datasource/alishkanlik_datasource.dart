import 'package:flutter/cupertino.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:up31/features/auth/data/models/habit.dart';

import '../../models/app_settings.dart';
class HabitDatabase extends ChangeNotifier{
  static late Isar isar;

  //initialize database // data bazani boshlatish//
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  //hozirgi vaqtni dataga saqlash//
  Future<void> saveFirstLaunchData() async{
    final existingSettings = await isar.appSettings.where().findFirst();
    if(existingSettings == null){
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
 }


  //dastur statusini hozirgi vaqtini olish//
  Future<DateTime?> getFirstLaunchData()async{
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  //aliskanlik listi
  final List<Habit> currentHabits = [];

  // C R E A T E - yangi aliskanlik yaratish
  Future<void> addHabit(String habitName)async{
    //create new habit
    final newHabit = Habit()..name = habitName;

    //save to database
    await isar.writeTxn(() => isar.habits.put(newHabit));

    //read from database
    readHabits();
  }

  //R E A D - read saved habit from database
  Future<void> readHabits()async{
    //fatch all habits from database
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    //give to current habits
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    //update Ui;
    notifyListeners();
  }

  //UPDATE - check habit on and off
  Future<void> updateHabitComplation(int id,bool isComplated)async{
    final habit = await isar.habits.get(id);

    //update completion status
    if(habit != null){
      await isar.writeTxn(()async{
        if(isComplated && !habit.completeDays.contains(DateTime.now())){
          //bugun
          final today = DateTime.now();
          //add the current date if it's not already on list
          habit.completeDays.add(
            DateTime(
              today.year,
              today.month,
              today.day,
            ),
          );
        }else{
          habit.completeDays.removeWhere((date) =>
          date.year == DateTime.now().year &&
          date.month == DateTime.now().month &&
          date.day == DateTime.now().day,

          );
        }
        //save the update habits back to the database
        await isar.habits.put(habit);
      });
    }

    //re-read from database
    readHabits();
  }

  //UPDATE - EDIT HABIT NAME
  Future<void> updateHabitName(int id,String newName)async{
    //fine spacific habit
    final habit = await isar.habits.get(id);

    //update habit name
    if(habit != null){
      await isar.writeTxn(()async{
        habit.name = newName;
        //save updatehabit back to database
        await isar.habits.put(habit);
      });
    }
    readHabits();
  }

  //DELETE HABIT
  Future<void>deleteHabit(int id)async{
    await isar.writeTxn(()async{
      await isar.habits.delete(id);
    });
    readHabits();
  }

}