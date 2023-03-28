import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './enumeration_input.dart';
import '../../layout/renderer.dart';
import '../../entities/problem.dart';
import '../../states/assessment_state.dart';

class ProblemCard extends StatelessWidget {
  final Problem problem;
  final void Function(String? answer) updateRadioButton;
  final int index;
  final double width;
  final bool forNavigation;
  final bool readOnly;
  const ProblemCard({
    required this.problem,
    required this.updateRadioButton,
    required this.index,
    required this.width,
    required this.forNavigation,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    final globalWidth = MediaQuery.of(context).size.width;
    return Container(
      height: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 20 * width / globalWidth,
        horizontal: 15 * width / globalWidth,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Renderer(
              content: problem.question,
              width: width,
              fontFamily: 'Raleway',
            ),
            SizedBox(height: 100 * width / globalWidth),
            buildUserAnswerInput(context),
          ],
        ),
      ),
    );
  }

  Widget buildUserAnswerInput(BuildContext context) {
    if (problem.type == Type.unique) {
      return buildUniqueInput(context);
    }
    if (problem.type == Type.enumeration) {
      return EnumerationInput(
        problem: problem,
        index: index,
        width: width,
        readOnly: readOnly,
        forNavigation: forNavigation,
      );
    }
    return SizedBox();
  }

  Widget buildUniqueInput(BuildContext context) {
    final globalWidth = MediaQuery.of(context).size.width;
    final assessmentState = Provider.of<AssessmentState>(
      context,
      listen: false,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: problem.choices
          .map(
            (choice) => RichText(
              text: TextSpan(children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  baseline: TextBaseline.alphabetic,
                  child: Container(
                    height: 40 * width / globalWidth,
                    width: 40 * width / globalWidth,
                    child: Transform.scale(
                      scale: width / globalWidth,
                      child: Radio<String>(
                        splashRadius: 10,
                        //  what happens if two values are the same
                        value: choice['content'],
                        groupValue: problem.userAnswers.isEmpty
                            ? null
                            : problem.userAnswers[0],
                        onChanged: readOnly
                            ? (_) => null
                            : (String? value) async {
                                updateRadioButton(value);
                                final problems = assessmentState.problems;
                                if (problems != null && value != null) {
                                  await problems[assessmentState.index].update(
                                    userAnswers: [value],
                                    isTaken: true,
                                  );
                                }
                              },
                      ),
                    ),
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: Renderer(
                    content: choice['content'] ?? '',
                    width: width,
                  ),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: SizedBox(width: 10 * width / globalWidth),
                ),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: Renderer(
                    content: choice['choice_units'] ?? '',
                    width: width,
                  ),
                ),
              ]),
            ),
          )
          .toList(),
    );
  }
}
