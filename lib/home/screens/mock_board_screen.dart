import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './mock_board_overview_screen.dart';
import '../widgets/timer_string.dart';
import '../../entities/problems_provider.dart';
import '../../states/assessment_state.dart';

class MockBoardExamScreen extends StatefulWidget {
  static const String routeName = 'mock_board_exam';
  const MockBoardExamScreen({Key? key}) : super(key: key);

  @override
  _MockBoardExamScreenState createState() => _MockBoardExamScreenState();
}

class _MockBoardExamScreenState extends State<MockBoardExamScreen> {
  late DateTime dateToday;
  Duration? availableIn;
  DateTime? recent;
  bool isLoading = false;

  void initState() {
    refresh();
    super.initState();
  }

  Future<void> refresh() async {
    final mockBoard = Provider.of<MockBoard>(context);
    setState(() => isLoading = true);
    dateToday = DateTime.now();
    availableIn = await mockBoard.make(dateToday);
    recent = mockBoard.recent;
    await Future.delayed((Duration(seconds: 1)), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final mockBoardState = Provider.of<AssessmentState>(context);
    mockBoardState.update(category: Category.mockBoard);
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Container(
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  leading: IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: Image.asset(
                      'assets/icons/drawer_00.png',
                      width: 24,
                      height: 24,
                      color: Theme.of(context).primaryIconTheme.color,
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  floating: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Container(
                              child: Image.asset(
                                'assets/icons/mbe_00.png',
                                width: media.size.width / 1.5,
                                height: media.size.width / 1.5,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Mock Board Exam',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w800,
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              'Take part in this emulated Board Examination experience to gauge your knowledge about your particular program. The assessment takes about 4 hours to complete.',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500,
                                fontSize: 18,
                              ),
                            ),
                            GestureDetector(
                              onTap: availableIn != null
                                  ? () {
                                      refresh();
                                    }
                                  : () {
                                      mockBoardState.date = recent;
                                      Navigator.pushReplacementNamed(
                                        context,
                                        MockBoardOverviewScreen.routeName,
                                      );
                                    },
                              child: Container(
                                margin: EdgeInsets.only(top: 20, bottom: 10),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: double.infinity,
                                child: Center(
                                  child: availableIn != null
                                      ? TimerString(availableIn!)
                                      : Text(
                                          'Start Exam',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                              255,
                                              255,
                                              255,
                                              0.667,
                                            ),
                                            fontSize: 18,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Reminder: Although you can choose to skip harder problems and take breaks, there is no option for pausing the timer.',
                              style: TextStyle(
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // : Padding(
            //     padding: EdgeInsets.only(top: media.padding.top),
            //     child: Padding(
            //       padding:
            //           const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            //       child: Column(
            //         children: [
            //           Expanded(
            //             child: Align(
            //               alignment: FractionalOffset.center,
            //               child: AspectRatio(
            //                 aspectRatio: 1,
            //                 child: Container(
            //                   child: Image.asset(
            //                     'assets/icons/mbe_00.png',
            //                     width: media.size.width / 1.5,
            //                     height: media.size.width / 1.5,
            //                     fit: BoxFit.cover,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           Column(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               Text(
            //                 'Mock Board Exam',
            //                 style: TextStyle(
            //                   fontFamily: 'Raleway',
            //                   fontWeight: FontWeight.w800,
            //                   fontSize: 40,
            //                 ),
            //               ),
            //               SizedBox(height: 15),
            //               Text(
            //                 'Take part in this emulated Board Examination experience to gauge your knowledge about your particular program. The assessment takes about 4 hours to complete.',
            //                 style: TextStyle(
            //                   fontFamily: 'Raleway',
            //                   fontWeight: FontWeight.w500,
            //                   fontSize: 18,
            //                 ),
            //               ),
            //               GestureDetector(
            //                 onTap: availableIn != null
            //                     ? () {
            //                         refresh();
            //                       }
            //                     : () {
            //                         final date = recent;
            //                         mockBoardState.reset();
            //                         if (date != null) {
            //                           mockBoardState.date = date;
            //                         }
            //                         Navigator.pushReplacementNamed(
            //                           context,
            //                           MockBoardOverviewScreen.routeName,
            //                         );
            //                       },
            //                 child: Container(
            //                   margin: EdgeInsets.only(top: 20, bottom: 10),
            //                   padding: EdgeInsets.symmetric(vertical: 15),
            //                   decoration: BoxDecoration(
            //                     color: Colors.blueGrey,
            //                     borderRadius: BorderRadius.circular(8),
            //                   ),
            //                   width: double.infinity,
            //                   child: Center(
            //                     child: availableIn != null
            //                         ? TimerString(availableIn!)
            //                         : Text(
            //                             'Start Exam',
            //                             style: TextStyle(
            //                               color: Color.fromRGBO(
            //                                 255,
            //                                 255,
            //                                 255,
            //                                 0.667,
            //                               ),
            //                               fontSize: 18,
            //                             ),
            //                           ),
            //                   ),
            //                 ),
            //               ),
            //               SizedBox(height: 12),
            //               Text(
            //                 'Reminder: Although you can choose to skip harder problems and take breaks, there is no option for pausing the timer.',
            //                 style: TextStyle(
            //                   fontFamily: 'Raleway',
            //                   fontWeight: FontWeight.w500,
            //                   fontSize: 15,
            //                 ),
            //                 textAlign: TextAlign.justify,
            //               ),
            //               SizedBox(height: 15),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
          );
  }
}
