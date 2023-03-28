import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../entities/problems_provider.dart';
import '../../entities/problem.dart';
import '../../states/assessment_state.dart';

class DailyInfoPage extends StatelessWidget {
  final int pageNumber;
  const DailyInfoPage(this.pageNumber);
  Row _buildTopNavigation(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pop(ctx);
          },
          child: Icon(Icons.arrow_back, size: 30.0, color: Colors.white),
        ),
        Icon(Icons.library_books, size: 30.0, color: Colors.white),
      ],
    );
  }

  Container _buildDescription() {
    return Container(
      height: 400.0,
      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: 30.0,
              right: 30.0,
              top: 40.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'All to know...',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10.0),
                Text(
                  'This is hard',
                  style: TextStyle(color: Colors.black87, fontSize: 16.0),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Details',
                  style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Please be mentally prepared before proceeding.',
                  style: TextStyle(fontSize: 16.0, color: Colors.black87),
                ),
                Text(
                  'You have 5 minutes before timer ends.',
                  style: TextStyle(fontSize: 16.0, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dailyState = Provider.of<AssessmentState>(context, listen: false);
    final daily = Provider.of<Daily>(context, listen: false);
    final topicInfo = daily.current.values.toList()[pageNumber];
    var probs = topicInfo['probs'] as List<Problem>?;
    probs = probs ?? <Problem>[];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
                  height: 520.0,
                  color: Color(0xff453658),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      _buildTopNavigation(context),
                      Text(
                        daily.current.values.toList()[pageNumber]['name'] ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        daily.current.values.toList()[pageNumber]['name'] ?? '',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Text(
                        'Number of Problems',
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '${probs.length}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40.0),
                      Text(
                        'Difficulty',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        'Difficult',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 40.0),
                      RawMaterialButton(
                        padding: EdgeInsets.all(20.0),
                        shape: CircleBorder(),
                        elevation: 2.0,
                        fillColor: Colors.black,
                        child: Icon(Icons.arrow_forward,
                            color: Colors.white, size: 35.0),
                        onPressed: () {
                          dailyState.update(start: true, listen: true);
                        },
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   right: 20.0,
                //   bottom: 30.0,
                //   child: Hero(
                //     tag: widget.subjectModel.imageUrl,
                //     child: Image(
                //       height: 280.0,
                //       width: 280.0,
                //       image: AssetImage(widget.subjectModel.imageUrl),
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
                _buildDescription(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
