import 'package:flutter/material.dart';
import '../../entities/problem.dart';

class AssessmentProgressIndicator extends StatefulWidget {
  final List<Problem> problemList;
  AssessmentProgressIndicator(this.problemList);

  @override
  _AssessmentProgressIndicatorState createState() =>
      _AssessmentProgressIndicatorState();
}

class _AssessmentProgressIndicatorState
    extends State<AssessmentProgressIndicator> {
  int get numberOfProblemsTaken {
    int numberOfProblemsTaken = 0;
    widget.problemList.forEach((problem) {
      if (problem.isTaken) numberOfProblemsTaken++;
    });
    return numberOfProblemsTaken;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: buildRowChildren(mediaQuery),
    );
  }

  List<Widget> buildRowChildren(MediaQueryData mediaQuery) {
    List<Widget> takenProblemsProgress = [];
    for (int i = 0; i < numberOfProblemsTaken; i++) {
      takenProblemsProgress.add(buildIndividualIndicator(
        indicatorValue: true,
        mediaQuery: mediaQuery,
        indicatorIndex: i,
      ));
    }
    for (int i = 0;
        i < widget.problemList.length - numberOfProblemsTaken;
        i++) {
      takenProblemsProgress.add(buildIndividualIndicator(
        indicatorValue: false,
        mediaQuery: mediaQuery,
        indicatorIndex: numberOfProblemsTaken + i,
      ));
    }
    return takenProblemsProgress;
  }

  Widget buildIndividualIndicator({
    required int indicatorIndex,
    required bool indicatorValue,
    required MediaQueryData mediaQuery,
  }) =>
      Container(
        height: 14,
        width: mediaQuery.size.width / (2 * widget.problemList.length),
        decoration: BoxDecoration(
          color: indicatorValue
              ? Colors.yellow
              : Color.fromRGBO(
                  0,
                  0,
                  0,
                  0.667,
                ),
          borderRadius: buildBorderRadius(indicatorIndex),
        ),
      );

  BorderRadiusGeometry? buildBorderRadius(int indicatorIndex) {
    if (indicatorIndex == 0)
      return BorderRadius.horizontal(left: Radius.circular(5));
    if (indicatorIndex == widget.problemList.length - 1)
      return BorderRadius.horizontal(right: Radius.circular(5));
    return null;
  }
}
