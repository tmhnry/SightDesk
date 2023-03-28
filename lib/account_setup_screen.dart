import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './states/account_setup_state.dart';
import './account_info_page.dart';
import './select_institution_page.dart';
import './select_degree_page.dart';
import './data/ids.dart' as ids;
import './layout/styles.dart';

class AccountSetupScreen extends StatefulWidget {
  static const String routeName = 'account_setup_screen';

  @override
  _AccountSetupScreenState createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  bool _isLoading = false;
  final _pageController = PageController(initialPage: 0, viewportFraction: 1);
  void initState() {
    createDummyUser();
    _init();
    super.initState();
  }

  void createDummyUser() {
    final setupState = Provider.of<AccountSetupState>(context, listen: false);
    setupState.update(label: 'First Name', val: ['Mark Lemuel']);
    setupState.update(label: 'Middle Name', val: ['Calotes']);
    setupState.update(label: 'Last Name', val: ['Genita']);
    setupState.update(label: 'Email Address', val: ['gmarklemuel@gmail.com']);
    setupState.update(label: 'Contact Number', val: ['09321330760']);
    setupState.update(label: 'Address', val: ['Panadtaran, Tubigon, Bohol']);
  }

  void _init() {
    setState(() {
      _isLoading = false;
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    return Scaffold(
      body: _isLoading
          ? _showLoading(media)
          : PageView.builder(
              controller: _pageController,
              itemCount: 3,
              itemBuilder: (BuildContext ctx, int index) {
                return _buildPage(index);
              },
            ),
    );
  }

  Widget _showLoading(MediaQueryData media) => Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [CustomColors.colorfulBlue, Colors.blue],
          ),
        ),
        padding: EdgeInsets.only(top: media.padding.top),
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      );

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return AccountInfoPage();
      case 1:
        return SelectInstitutionPage();
      default:
        return SelectDegreePage();
    }
  }
}
