import 'package:flutter/material.dart';
import './layout/renderer.dart';
import './home/screens/home_screen.dart';
import './home/widgets/custom_timer.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = 'main screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildScreen(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(width: 0.01),
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(
                Icons.home_outlined,
                color:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              ),
            ),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(width: 0.01),
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(
                Icons.public_outlined,
                color:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              ),
            ),
            icon: Icon(Icons.public_outlined),
            label: 'Online',
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(width: 0.01),
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(
                Icons.account_circle_outlined,
                color:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              ),
            ),
            icon: Icon(Icons.account_circle_outlined),
            label: 'My Account',
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
          BottomNavigationBarItem(
            activeIcon: Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(width: 0.01),
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).colorScheme.primary,
              ),
              child: Icon(
                Icons.settings_outlined,
                color:
                    Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              ),
            ),
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
            backgroundColor:
                Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        currentIndex: currentIndex,
      ),
    );
  }

  Widget buildScreen() {
    switch (currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return Scaffold(
            body: CustomTimer(
          noStroke: false,
          noButton: false,
          duration: Duration(seconds: 100),
        ));
      case 2:
        return Center();
      default:
        return Scaffold(
          body: Center(
            child: Renderer(
              content: r'''\block{begin}
              \textnormal{ddddddddaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa Every time I try to fly I fall without my wings I feel so small guess I need you }\lim{2}\sqrt{\int_{0}^{1}}\textbold{ asdasdasd ugh ugh ugh baby}\textitalic{ hoolahoop }\textbold{reallyasdasdasd?}asdasdasdasdasdasdasdasdqweasd
              \block{end}
              \block{begin}\sqrt{2}
              \textnormal{working}
              \block{end}
            ''',
              width: MediaQuery.of(context).size.width,
              // fontSize: 20,
            ),
          ),
        );
    }
  }
}
