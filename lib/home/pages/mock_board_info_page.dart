import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/painting.dart';
import '../../states/assessment_state.dart';

class MockBoardInfoPage extends StatelessWidget {
  final String psetId;
  const MockBoardInfoPage(this.psetId);
  @override
  Widget build(BuildContext context) {
    final mockBoardState = Provider.of<AssessmentState>(context, listen: false);
    final media = MediaQuery.of(context);
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Container(
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: mockBoardState.getPsetGrads(psetId),
            ),
          ),
        ),
        Positioned(
          top: 130,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                height: 150,
                child: Image.asset(mockBoardState.getPsetFig(psetId)),
              ),
              mockBoardState.isCompleted
                  ? Container(
                      margin: const EdgeInsets.only(top: 33),
                      child: Text(
                        'Your Score:',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          fontFamily: 'Raleway',
                        ),
                      ),
                    )
                  : SizedBox(),
              mockBoardState.isCompleted
                  ? Container(child: buildScore(mockBoardState))
                  : SizedBox(),
            ],
          ),
        ),
        // Positioned(
        //   width: media.size.width,
        //   top: 0,
        //   left: 0,
        //   child: Container(
        //     margin: EdgeInsets.only(
        //       top: media.padding.top + 5,
        //       left: 15,
        //       right: 15,
        //     ),
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             GestureDetector(
        //               onTap: () => Navigator.pop(context),
        //               child: Icon(
        //                 Icons.arrow_back_ios_new,
        //                 color: Theme.of(context).colorScheme.background,
        //                 size: 25,
        //               ),
        //             ),
        //             Container(
        //               width: media.size.width / 2,
        //               child: Text(
        //                 problemSet != null ? problemSet.name : '',
        //                 style: TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 25,
        //                   fontFamily: 'Raleway',
        //                   fontStyle: FontStyle.italic,
        //                   fontWeight: FontWeight.w700,
        //                 ),
        //                 textAlign: TextAlign.center,
        //               ),
        //             ),
        //             SizedBox(width: 25)
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                // assessmentState.update(start: true, listen: true);
              },
              child: Container(
                width: media.size.width / 2,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromRGBO(77, 30, 225, 1),
                ),
                child: Center(
                  child: Text(
                    mockBoardState.isCompleted
                        ? 'REVIEW'
                        : mockBoardState.resume
                            ? 'CONTINUE'
                            : 'START',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.background,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: media.size.height / 2,
              margin: EdgeInsets.only(
                top: 20,
                right: 15,
                left: 15,
              ),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: mockBoardState.topics
                      .map(
                        (topic) => Text(
                          topic.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 30,
                            fontFamily: 'Raleway',
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Widget buildScore(AssessmentState assessmentState) {
  return Text(
    assessmentState.score,
    style: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w600,
      color: Color.fromRGBO(255, 255, 255, 0.95),
      fontFamily: 'Raleway',
    ),
  );
}
