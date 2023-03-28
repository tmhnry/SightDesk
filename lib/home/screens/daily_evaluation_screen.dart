import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sightdesk_new/home/pages/daily_info_page.dart';
import '../../states/assessment_state.dart';
import '../../entities/problems_provider.dart';

class DailyEvaluationScreen extends StatefulWidget {
  static const String routeName = 'daily_evaluation';
  const DailyEvaluationScreen({Key? key}) : super(key: key);

  @override
  _DailyEvaluationScreenState createState() => _DailyEvaluationScreenState();
}

class _DailyEvaluationScreenState extends State<DailyEvaluationScreen> {
  bool _isLoading = false;
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );
  final DateTime dateToday = DateTime.now();
  //  although dateOfRecentDaily can never be null, unlike dateOfRecentMockBoard
  late final DateTime? dateOfRecentDaily;

  @override
  void didChangeDependencies() {
    refresh();
    super.didChangeDependencies();
  }

  Future<void> refresh() async {
    final daily = Provider.of<Daily>(context, listen: false);
    setState(() => _isLoading = true);
    await daily.make(dateToday);
    await Future.delayed(
      (Duration(seconds: 1)),
      () => setState(() => _isLoading = false),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dailyState = Provider.of<AssessmentState>(context, listen: false);
    dailyState.update(category: Category.daily);
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : PageView.builder(
            controller: _pageController,
            itemBuilder: (ctx, index) {
              return DailyInfoPage(index);
            },
          );
  }
}
