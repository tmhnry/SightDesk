import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../pages/mock_board_info_page.dart';
import '../../entities/user.dart';
import '../../entities/problems_provider.dart';

class MockBoardOverviewScreen extends StatefulWidget {
  static const String routeName = 'mock_board_overview';
  const MockBoardOverviewScreen({Key? key}) : super(key: key);

  @override
  _MockBoardOverviewScreenState createState() =>
      _MockBoardOverviewScreenState();
}

class _MockBoardOverviewScreenState extends State<MockBoardOverviewScreen>
    with TickerProviderStateMixin {
  late final TabController _controller;
  void initState() {
    super.initState();
    _controller = TabController(
      length: User.activeDeg.psets.length,
      vsync: this,
    );
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> get tabBarChildren {
    final mockBoard = Provider.of<MockBoard>(context, listen: false);
    return mockBoard.current.keys
        .map((psetId) => MockBoardInfoPage(psetId))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: media.padding.top),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              child: TabBarView(
                controller: _controller,
                children: tabBarChildren,
              ),
            ),
            TabPageSelector(controller: _controller, indicatorSize: 10),
          ],
        ),
      ),
    );
  }
}
