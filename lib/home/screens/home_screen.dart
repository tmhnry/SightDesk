import 'package:flutter/material.dart';
import 'mock_board_screen.dart';
import './my_activity_screen.dart';
import './daily_evaluation_screen.dart';
import '../widgets/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String homeDrawerCategory;

  void initState() {
    homeDrawerCategory = 'My Activity';
    super.initState();
  }

  void selectHomeDrawerCategory(String homeDrawerCategory) {
    setState(() => this.homeDrawerCategory = homeDrawerCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeDrawer(
        selectHomeDrawerCategory: selectHomeDrawerCategory,
        selectedHomeDrawerCategory: homeDrawerCategory,
        homeDrawerCategories: homeDrawerCategories,
      ),
      body: buildBody(homeDrawerCategory),
    );
  }

  List<String> homeDrawerCategories = [
    'My Activity',
    'Daily Evaluation',
    'Coursework',
    'Mock Board Exam',
    'Problem Sets',
    'Notes and Reviewers',
  ];

  Widget buildBody(String homeDrawerCategory) {
    switch (homeDrawerCategory) {
      case 'My Activity':
        return MyActivityScreen();
      case 'Daily Evaluation':
        return DailyEvaluationScreen();
      case 'Coursework':
        return Center();
      case 'Mock Board Exam':
        return MockBoardExamScreen();
      case 'Problem Sets':
        return Center();
      case 'Notes and Reviewers':
        return Center();
      default:
        return MyActivityScreen();
    }
  }
}
