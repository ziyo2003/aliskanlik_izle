import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/data_source/aliskanlik_datasource/alishkanlik_datasource.dart';
import '../../data/models/habit.dart';
import '../util/habit_util.dart';
import '../widgets/my_drower.dart';
import '../widgets/my_habit_tile.dart';
import '../widgets/my_heat_map.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    Provider.of<HabitDatabase>(context, listen: false).readHabits();
    super.initState();
  }



  final TextEditingController textController = TextEditingController();

  void createNewHabit(){
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
            decoration: const InputDecoration(hintText: "Yangi odat qushing"),
          ),
          actions: [
            MaterialButton(
                onPressed:(){
                  //yangi odat qushish
                  String newHabitName = textController.text;

                  //databazaga saqlash
                  context.read<HabitDatabase>().addHabit(newHabitName);

                  //orqagq
                  Navigator.pop(context);

                  //clear textcontroller
                  textController.clear();
                },
                child: const Text("Saqlash"),
            ),

            MaterialButton(
                onPressed: (){
                  Navigator.pop(context);

                  textController.clear();
                },
              child: const Text("Bekorqilish"),

            ),
          ],
        ),
    );
  }

  //check habit on && off
  void checkHabitOnOff(bool? value, Habit habit){
    if(value != null){
      context.read<HabitDatabase>().updateHabitComplation(habit.id, value);
    }
  }
  //edit habit box
  void editHabitBox(Habit habit){
    textController.text = habit.name;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              onPressed:(){
                //yangi odat qushish
                String newHabitName = textController.text;

                //databazaga saqlash
                context.read<HabitDatabase>().updateHabitName(habit.id,newHabitName);

                //orqagq
                Navigator.pop(context);

                //clear textcontroller
                textController.clear();
              },
              child: const Text("Saqlash"),
            ),

            MaterialButton(
              onPressed: (){
                Navigator.pop(context);

                textController.clear();
              },
              child: const Text("Bekorqilish"),

            ),
          ],
        ),
    );
  }
  //dalete habit box
  void daleteHabitBox(Habit habit){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("O'chirishni hoxlaysizmi?"),
        actions: [
          MaterialButton(
            onPressed:(){


              //databazaga saqlash
              context
                  .read<HabitDatabase>()
                  .deleteHabit(habit.id);

              //orqagq
              Navigator.pop(context);

            },
            child: const Text("O'chirish"),
          ),

          MaterialButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text("Bekorqilish"),

          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.tertiary,
      ),
      drawer: MyDrawer(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white24,
                ),
                child: _buildHeatMap(),
              ),
            ),
            _buildHabitList(),
          ],
        ),
      ),
    );
  }


  Widget _buildHeatMap(){
    final habitDatabase = context.watch<HabitDatabase>();

    List<Habit> currentHabits = habitDatabase.currentHabits;

    return FutureBuilder<DateTime?>(
        future: habitDatabase.getFirstLaunchData(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return MyHeatMap(
              startDate: snapshot.data!,
              datasets: prepHeatMapDataset(currentHabits),
            );
          }else{
            return Container();
          }
        }
    );
}


  Widget _buildHabitList(){
    //habit databazasi
    final habitDatabase = context.watch<HabitDatabase>();

    //curent habits
    List<Habit> currentHabits = habitDatabase.currentHabits;

    return ListView.builder(
      itemCount: currentHabits.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder:(context, index){
        final habit = currentHabits[index];

        bool isCompletedToday = isHabitCompletedToday(habit.completeDays);

        return MyHabitTile(
            text: habit.name,
            isComplated: isCompletedToday,
            onChanged: (value) => checkHabitOnOff(value,habit),
            editHabit: (context) => editHabitBox(habit),
            daleteHabit: (context) => daleteHabitBox(habit),
        );
     },
    );


  }
}
