import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sightdesk_new/home/pages/daily_info_page.dart';
import '../widgets/assessment_desk.dart';
import '../widgets/problem_card.dart';
import '../../states/assessment_state.dart';
import '../../entities/problem.dart';

class AssessmentScreen extends StatelessWidget {
  static const String routeName = 'assessment';

  Positioned _buildisTakenSymb(Problem prob) {
    return Positioned(
      top: 10,
      right: 10,
      child: prob.isTaken
          ? Icon(Icons.mark_chat_read, color: Colors.green)
          : SizedBox(),
    );
  }

  GestureDetector _buildMiniPage({
    required BuildContext ctx,
    required double drawerWidth,
    required int index,
    required Problem prob,
  }) {
    final assessmentState = Provider.of<AssessmentState>(ctx, listen: false);
    final padding = 40.0;
    final border = 1.5;
    final cardWidth = drawerWidth - 2 * padding - 2 * border;
    return GestureDetector(
      onTap: () {
        Navigator.of(ctx).pop();
        assessmentState.update(index: index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: padding,
          vertical: 10,
        ),
        color: Color.fromRGBO(0, 0, 0, 0.667),
        child: Container(
          height: cardWidth * (11 / 8.5),
          decoration: BoxDecoration(
            border: assessmentState.index == index
                ? Border.all(width: border, color: Colors.orange)
                : null,
            color: Color.fromRGBO(255, 255, 255, 0.95),
          ),
          child: Stack(
            children: [
              ProblemCard(
                problem: prob,
                index: index,
                width: cardWidth,
                readOnly: true,
                forNavigation: true,
                updateRadioButton: (String? _) => null,
              ),
              _buildisTakenSymb(prob),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final assessmentState = Provider.of<AssessmentState>(context);
    final drawerWidth = media.size.width / 1.3;
    //  comment out padding and uncomment below when using column
    // final margin = 40.0;
    return Scaffold(
      body: assessmentState.start ? AssessmentDesk() : Center(),
      drawer: Container(
        padding: EdgeInsets.only(top: media.padding.top),
        //  using ListView.builder, the format changes without specifying drawer width
        width: drawerWidth,
        child: Drawer(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _buildMiniPage(
                drawerWidth: drawerWidth,
                index: index,
                prob: assessmentState.problems[index],
                ctx: context,
              );
            },
            itemCount: assessmentState.problems.length,
          ),
        ),
        // child: SingleChildScrollView(
        //   child: Column(children: buildProblemCards(context)),
        // ),
      ),
    );
  }

  // List<Widget> buildProblemCards(BuildContext context) {
  //   final assessmentState = Provider.of<AssessmentState>(context);
  //   final media = MediaQuery.of(context);
  //   final cards = <Widget>[];
  //   final problems = assessmentState.problems;
  //   final margin = 40.0;
  //   final border = 2.0;
  //   final width = media.size.width / 1.3 - 2 * margin - 2 * border;
  //   if (problems != null && problems.isNotEmpty) {
  //     for (int i = 0; i < problems.length; i++) {
  //       cards.add(
  //         GestureDetector(
  //           onTap: () {
  //             Navigator.of(context).pop();
  //             assessmentState.index = i;
  //           },
  //           child: Container(
  //             // margin: EdgeInsets.symmetric(horizontal: margin, vertical: 5),
  //             margin: EdgeInsets.symmetric(vertical: 5),
  //             width: width,
  //             height: width * (11 / 8.5),
  //             decoration: BoxDecoration(
  //               color: Colors.orange,
  //               border: assessmentState.index == i
  //                   ? Border.all(width: border, color: Colors.blue)
  //                   : null,
  //             ),
  //             child: Stack(
  //               children: [
  //                 ProblemCard(
  //                   problem: problems[i],
  //                   index: i,
  //                   width: width,
  //                   readOnly: true,
  //                   forNavigation: true,
  //                   updateRadioButton: (String? _) => null,
  //                 ),
  //                 Positioned(
  //                   top: 10,
  //                   right: 10,
  //                   child: problems[i].isTaken
  //                       ? Icon(Icons.mark_chat_read, color: Colors.green)
  //                       : SizedBox(),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  //   return cards;
  // }
}
