import 'package:curved_drawer_fork/curved_drawer_fork.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/src/widgets/basic.dart';
import '../../../../assets/theme_provider.dart';
import '../../data/data_source/aliskanlik_datasource/alishkanlik_datasource.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController = TextEditingController();


    void createNewHabit() {
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              content: TextField(
                controller: textController,
                decoration: const InputDecoration(hintText: "add new habit"),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {
                    // Yangi odat qushish
                    String newHabitName = textController.text;

                    // Databazaga saqlash
                    context.read<HabitDatabase>().addHabit(newHabitName);

                    // Orqagq
                    Navigator.pop(context);

                    // Clear text controller
                    textController.clear();
                  },
                  child: const Text("Save"),
                ),
                MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                    textController.clear();
                  },
                  child: const Text("Cansel"),
                ),
              ],
            ),
      );
    }
    void toggleTheme() {
      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
    }

    return CurvedDrawer(
      index: 1,
      color: Colors.deepOrange,
      width: 70,
      items: <DrawerItem>[

        DrawerItem(icon: Icon(Icons.add_circle)),
        DrawerItem(icon: Icon(Icons.back_hand_rounded,),label: "hello"),
        DrawerItem(icon: Icon(Icons.light_mode_outlined)),
      ],
      onTap: (index) {
        if (index == 0) {
          createNewHabit();
        } else if (index == 2) {

          toggleTheme();
        }
        // ... handle other indices
      },
    );
  }
}
//     return Drawer(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: 40),
//           Row(
//             children: [
//               SizedBox(width: 10),
//               Text(
//                 "theme mods",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontFamily: GoogleFonts.abel().fontFamily,
//                 ),
//               ),
//               SizedBox(width: 10),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20),
//                   color: Colors.deepOrangeAccent,
//                 ),
//                 child: CupertinoSwitch(
//                   value: Provider.of<ThemeProvider>(context).isDarkMode,
//                   onChanged: (value) =>
//                       Provider.of<ThemeProvider>(context, listen: false)
//                           .toggleTheme(),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           Row(
//             children: [
//               SizedBox(width: 10),
//               Text(
//                 "add habit",
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontFamily: GoogleFonts.abel().fontFamily,
//                 ),
//               ),
//               SizedBox(width: 13),
//               GestureDetector(
//                 onTap:  createNewHabit,
//                 child: Container(
//                   width: 58,
//                   height: 38,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(18),
//                     color: Colors.deepOrangeAccent,
//                   ),
//                   child: Icon(Icons.add),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
