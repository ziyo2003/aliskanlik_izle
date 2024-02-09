import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up31/features/auth/presintation/pages/para_page.dart';
import 'assets/theme_provider.dart';
import 'features/auth/data/data_source/aliskanlik_datasource/alishkanlik_datasource.dart';
import 'features/auth/presintation/pages/home_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchData();
  
  runApp(
    MultiProvider(providers: [
      //habit provide
      ChangeNotifierProvider(create: (context) =>HabitDatabase()),
      //theme provider
      ChangeNotifierProvider(create: (contexrt) => ThemeProvider()),
    ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Theme.of(context).colorScheme.secondary,
          color: Colors.white24,
          animationDuration: Duration(milliseconds: 300),
          items: [
            Icon(Icons.timeline, color: Colors.grey),
            Icon(Icons.money,color: Colors.grey,),
          ],
          onTap: (index) {
            setState(() {
              _pageIndex = index;
            });
          },
        ),
        body: _getPage(_pageIndex),
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }

  Widget _getPage(int pageIndex) {
    switch (pageIndex) {
      case 0:
        return HomePage();
      case 1:
        return ParaPage(); // Ensure ParaPage is a valid widget
      default:
        return Scaffold(body: Center(child: Text('No page selected')));
    }
  }
}

