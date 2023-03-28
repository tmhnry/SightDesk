import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './problem_card.dart';
import '../../states/assessment_state.dart';
import '../../entities/problem.dart';

class ProblemWidget extends StatefulWidget {
  final Problem problem;
  ProblemWidget(this.problem);

  @override
  State<ProblemWidget> createState() => _ProblemWidgetState();
}

class _ProblemWidgetState extends State<ProblemWidget> {
  String? fromRadioButton;

  void initRadioButton() {
    if (widget.problem.type == Type.unique &&
        widget.problem.userAnswers.isNotEmpty) {
      fromRadioButton = widget.problem.userAnswers[0];
    }
  }

  void updateRadioButton(String? answer) {
    setState(() {
      fromRadioButton = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final assessmentState = Provider.of<AssessmentState>(
      context,
      listen: false,
    );
    final media = MediaQuery.of(context);
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(7)),
      ),
      margin: EdgeInsets.only(top: 5),
      child: Container(
        height: double.infinity,
        child: Stack(
          children: [
            ProblemCard(
              problem: widget.problem,
              index: assessmentState.index,
              width: media.size.width,
              readOnly: false,
              forNavigation: false,
              updateRadioButton: updateRadioButton,
            ),
            if (assessmentState.index > 0)
              Positioned(
                bottom: 30,
                left: 0,
                child: IconButton(
                  iconSize: 30,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    assessmentState.update(
                      index: assessmentState.index - 1,
                      listen: true,
                    );
                  },
                ),
              ),
            Positioned(
              bottom: 30,
              right: 0,
              child: assessmentState.index < assessmentState.problems.length - 1
                  ? IconButton(
                      iconSize: 30,
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        assessmentState.update(
                          index: assessmentState.index + 1,
                          listen: true,
                        );
                      },
                    )
                  : TextButton(
                      child: Text(
                        'Finish',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Raleway',
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () async {
                        final problemSet = assessmentState.problemSet;
                        final date = assessmentState.date;
                        if (problemSet != null && date != null) {
                          await problemSet.markCompleted(date);
                        }
                        Navigator.pop(context);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

//   Widget buildUserAnswerInput(AssessmentState assessmentState) {
//     if (widget.problem.type == Type.Unique) {
//       return buildUniqueInput();
//     }
//     if (widget.problem.type == Type.Enumeration) {
//       return EnumerationInput(
//         problem: widget.problem,
//         index: assessmentState.index,
//       );
//     }
//     return SizedBox();
//   }

//   Widget buildUniqueInput() {
//     final media = MediaQuery.of(context);
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: widget.problem.choices
//           .map(
//             (choice) => RichText(
//               text: TextSpan(children: [
//                 WidgetSpan(
//                   alignment: PlaceholderAlignment.middle,
//                   baseline: TextBaseline.alphabetic,
//                   child: Container(
//                     width: media.size.width / 20 * (40 / 20),
//                     height: media.size.width / 20 * (40 / 20),
//                     child: Transform.scale(
//                       scale: 1.5,
//                       child: Radio<String>(
//                         //  what happense if two values are the same
//                         value: choice['content'],
//                         groupValue: fromRadioButton,
//                         onChanged: (String? value) async {
//                           fromRadioButton = value;
//                           final userAnswer = fromRadioButton;
//                           if (userAnswer != null) {
//                             await widget.problem.update(
//                               userAnswers: [userAnswer],
//                               isTaken: true,
//                             );
//                           }
//                           setState(() => null);
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 WidgetSpan(
//                   alignment: PlaceholderAlignment.baseline,
//                   baseline: TextBaseline.alphabetic,
//                   child: SizedBox(width: media.size.width / (2 * 20)),
//                 ),
//                 WidgetSpan(
//                   alignment: PlaceholderAlignment.baseline,
//                   baseline: TextBaseline.alphabetic,
//                   child: Renderer(
//                       content: choice['content'] ?? '',
//                       width: media.size.width),
//                 ),
//                 WidgetSpan(
//                   alignment: PlaceholderAlignment.baseline,
//                   baseline: TextBaseline.alphabetic,
//                   child: SizedBox(width: media.size.width / (2 * 20)),
//                 ),
//                 WidgetSpan(
//                   alignment: PlaceholderAlignment.baseline,
//                   baseline: TextBaseline.alphabetic,
//                   child: Renderer(
//                       content: choice['choice_units'] ?? '',
//                       width: media.size.width),
//                 ),
//               ]),
//             ),
//           )
//           .toList(),
//     );
//   }
}
