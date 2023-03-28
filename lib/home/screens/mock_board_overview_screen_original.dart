import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../entities/problems_provider.dart';
import '../../entities/problem_set.dart';
import '../../entities/problem.dart';
import '../../states/assessment_state.dart';
import '../../main_screen.dart';
import '../widgets/custom_timer.dart';
import './assessment_screen.dart';

class MockBoardOverviewScreen extends StatefulWidget {
  static const String routeName = 'mockboard_overview';
  @override
  _MockBoardOverviewScreenState createState() =>
      _MockBoardOverviewScreenState();
}

class _MockBoardOverviewScreenState extends State<MockBoardOverviewScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  final _problemSets = <ProblemSet>[];
  int _selectedPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 1);
  }

  Widget _subjectSelector(int index) {
    final assessmentState =
        Provider.of<AssessmentState>(context, listen: false);
    final dateBody = _problemSets[index].problems[assessmentState.date];
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget? widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          _pageController.page == null
              ? null
              : value = _pageController.page! - index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 1.0);
          // print(_pageController.page);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 450.0,
            // height: value * 500.0,
            width: Curves.easeInOut.transform(value) * 400.0,
            // width: value * 400.0,
            child: widget,
          ),
        );
      },
      child: GestureDetector(
        onTap: () {
          if (dateBody != null) {
            assessmentState.update(
              problems: <Problem>[],
              problemSet: _problemSets[index],
            );
            Navigator.pushReplacementNamed(context, AssessmentScreen.routeName);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xff453658),
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 30.0),
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: index,
                      child: Text('aw'),
                    ),
                  ),
                  Positioned(
                    top: 30.0,
                    right: 30.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'PROBLEMS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        Text(
                          dateBody != null ? '${dateBody.length}' : '0',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 30.0,
                    bottom: 30.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          // subjects[index].category.toUpperCase(),
                          _problemSets[index].name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          // subjects[index].name,
                          '',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 4.0,
              child: RawMaterialButton(
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
                elevation: 2.0,
                fillColor: Colors.black,
                child: Icon(
                  Icons.library_books,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () => print(''),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mockBoard = Provider.of<MockBoard>(context, listen: false);
    final mockBoardState = Provider.of<AssessmentState>(context, listen: false);
    final mockBoardDuration = Duration(days: mockBoard.duration);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 30.0,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        MainScreen.routeName,
                      );
                    },
                  ),
                  Icon(
                    Icons.lightbulb,
                    size: 30.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.only(left: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Pick a Category',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CustomTimer(
                    width: 80,
                    height: 80,
                    duration: mockBoardDuration,
                    value: mockBoardState.getTimerValue(
                      Duration(days: mockBoard.duration),
                    ),
                    noStroke: false,
                    noButton: true,
                  ),
                ],
              ),
            ),
            Container(
              height: 500.0,
              width: double.infinity,
              child: PageView.builder(
                controller: _pageController,
                // onPageChanged: (int index) {
                //   setState(() {
                //     _selectedPage = index;
                //   });
                // },
                itemCount: _problemSets.length,
                itemBuilder: (BuildContext context, int index) {
                  return _subjectSelector(index);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    // subjects[_selectedPage].description,
                    '',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
