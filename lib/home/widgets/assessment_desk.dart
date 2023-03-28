import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './problem_widget.dart';
import './assessment_progress_indicator.dart';
import '../../states/assessment_state.dart';
import '../../entities/problem.dart';

class AssessmentDesk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final assessmentState = Provider.of<AssessmentState>(
      context,
      listen: false,
    );
    return Container(
      height: double.infinity,
      color: Color.fromRGBO(0, 0, 0, 1 / 24),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: mediaQuery.padding.top,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buildTopNavigation(
                context: context,
                problems: assessmentState.problems,
              ),
            ),
          ),
          Expanded(
            child: ProblemWidget(
              assessmentState.problems[assessmentState.index],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildTopNavigation({
    required BuildContext context,
    required List<Problem> problems,
  }) {
    final assessmentState = Provider.of<AssessmentState>(
      context,
      listen: false,
    );
    return [
      GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(Icons.arrow_back, size: 25),
      ),
      Container(child: AssessmentProgressIndicator(problems)),
      GestureDetector(
          onTap: assessmentState.category == Category.daily
              ? () {
                  assessmentState.restart();
                }
              : null,
          child: Icon(Icons.restart_alt, size: 25)),
      GestureDetector(
        onTap: () => Scaffold.of(context).openDrawer(),
        child: Icon(Icons.widgets_outlined, size: 25),
      ),
    ];
  }
}
