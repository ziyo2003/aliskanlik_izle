import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final String text;
  final bool isComplated;
  final void Function (bool?)? onChanged;
  final void Function (BuildContext)? editHabit;
  final void Function (BuildContext)? daleteHabit;

  const MyHabitTile({
    super.key,
    required this.text,
    required this.isComplated,
    required this.onChanged,
    required this.editHabit,
    required this.daleteHabit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            //add
            SlidableAction(
                onPressed: editHabit,
                backgroundColor: Colors.grey.shade800,
                icon: Icons.settings,
                borderRadius: BorderRadius.circular(8),
            ),
            //delate
            SlidableAction(
              onPressed: daleteHabit,
              backgroundColor: Colors.red.shade800,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: (){
            if(onChanged != null){
              onChanged!(!isComplated);

            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: isComplated
                   ? Colors.deepOrange
                  : Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8)
            ),
            padding: EdgeInsets.all(12),
            // margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
            child: ListTile(
              title: Text(text,style:
                       TextStyle(
                            color: isComplated
                              ? Colors.white
                              : Theme.of(context)
                               .colorScheme.inversePrimary
                       ),
              ),
              leading: Checkbox(
                activeColor: Colors.deepOrange,
                value: isComplated,
                onChanged: onChanged,

              ),
            ),
          ),
        ),
      ),
    );
  }
}

