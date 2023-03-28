import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './home/screens/assessment_screen.dart';
import './home/screens/daily_evaluation_screen.dart';
import './home/screens/mock_board_screen.dart';
import './layout/styles.dart';
import './account_setup_screen.dart';
import './login_screen.dart';
import './main_screen.dart';
import './home/screens/mock_board_overview_screen.dart';
import './states/assessment_state.dart';
import './entities/problems_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MockBoard()),
        ChangeNotifierProvider(create: (context) => Daily()),
        ChangeNotifierProvider(create: (context) => AssessmentState()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //  for custom timer
          // canvasColor: Colors.blueGrey,
          // iconTheme: IconThemeData(
          //   color: Colors.white,
          // ),
          // accentColor: Colors.pinkAccent,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: CustomColors.colorfulWhite,
            selectedItemColor: CustomColors.colorfulBlue,
            selectedLabelStyle: TextStyle(
              color: CustomColors.colorfulBlue,
            ),
            unselectedItemColor: CustomColors.colorfulBlue,
          ),
          tabBarTheme:
              TabBarTheme(indicator: BoxDecoration(color: Colors.pink)),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              color: CustomColors.colorfulBlue,
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w900,
            ),
          ),
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: CustomColors.colorfulBlue,
            secondary: CustomColors.colorfulOrange,
            background: CustomColors.colorfulWhite,
            surface: Colors.black,
            onSurface: Colors.black,
            onBackground: CustomColors.customGray,
            primaryVariant: CustomColors.colorfulBlue,
            onPrimary: CustomColors.colorfulBlue,
            secondaryVariant: CustomColors.colorfulOrange,
            onSecondary: CustomColors.colorfulOrange,
            onError: Colors.red,
            error: Colors.red,
          ),
          primaryTextTheme: TextTheme(
            headline1: TextStyle(color: CustomColors.colorfulBlue),
          ),
          primaryIconTheme: IconThemeData(color: CustomColors.colorfulBlue),
        ),
        home: LoginScreen(),
        routes: {
          MainScreen.routeName: (context) => MainScreen(),
          DailyEvaluationScreen.routeName: (context) => DailyEvaluationScreen(),
          MockBoardExamScreen.routeName: (context) => MockBoardExamScreen(),
          AccountSetupScreen.routeName: (context) => AccountSetupScreen(),
          MockBoardOverviewScreen.routeName: (context) =>
              MockBoardOverviewScreen(),
          AssessmentScreen.routeName: (context) => AssessmentScreen(),
        },
      ),
    );
  }
}
