import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../states/assessment_state.dart';
import '../../entities/problem.dart';

class DailyTopicProblems extends StatelessWidget {
  final DateTime dateToday;
  const DailyTopicProblems(this.dateToday, {Key? key}) : super(key: key);

  IconButton _drawerButton(BuildContext ctx) {
    return IconButton(
      onPressed: () => Scaffold.of(ctx).openDrawer(),
      icon: Image.asset(
        'assets/icons/drawer_00.png',
        width: 24,
        height: 24,
        color: Theme.of(ctx).primaryIconTheme.color,
      ),
    );
  }

  TextStyle get _textStyle {
    return TextStyle(
      color: Color.fromRGBO(0, 0, 0, 0.667),
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );
  }

  Row get _headerTexts {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('Daily', style: _textStyle),
        Text(DateFormat.MEd().format(dateToday), style: _textStyle),
      ],
    );
  }

  List<Widget> _buildCards(BuildContext ctx) {
    //  setting listen: true will also trigger build()
    final dailyState = Provider.of<AssessmentState>(ctx, listen: false);
    return dailyState.problems.map((prob) => ProblemCard(prob)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: ClampingScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          leading: _drawerButton(context),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          floating: true,
        ),
        SizedBox(height: 20),
        SliverToBoxAdapter(child: _headerTexts),
        // SliverGrid.count(
        //   crossAxisCount: 3,
        //   crossAxisSpacing: 10,
        //   childAspectRatio: 0.8,
        //   children: buildSliverGridChildren(),
        // ),
        SliverList(
          delegate: SliverChildListDelegate.fixed(
            _buildCards(context),
          ),
        ),
      ],
    );
  }
}

class ProblemCard extends StatelessWidget {
  final Problem problem;
  const ProblemCard(this.problem);

  List<BoxShadow> get _boxShadow {
    return <BoxShadow>[
      BoxShadow(
        color: Color.fromRGBO(0, 0, 0, 0.333),
        blurRadius: 7,
        spreadRadius: 0.2,
        offset: Offset.fromDirection(3.1416 / 2, 3.5),
      ),
    ];
  }

  BoxDecoration get _decoration {
    return BoxDecoration(
      boxShadow: _boxShadow,
      borderRadius: BorderRadius.circular(5),
      color: Color.fromRGBO(255, 255, 255, 0.95),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 200,
        height: 170,
        decoration: _decoration,
        child: Text(problem.question),
      ),
    );
  }
}
