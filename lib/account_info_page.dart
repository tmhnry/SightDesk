import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../states/account_setup_state.dart';
import './account_info_form.dart';
import './layout/styles.dart';
import './entities/user.dart';

class AccountInfoPage extends StatelessWidget {
  Text get _headerText {
    return Text(
      'Account Setup',
      style:
          TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 40),
    );
  }

  Text get _pageDetail {
    return Text(
      'We need to know more about you so that we can further improve our services during feedback. Please fill up the following: ',
      style:
          TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 20),
      textAlign: TextAlign.justify,
    );
  }

  @override
  Widget build(BuildContext context) {
    final setupState = Provider.of<AccountSetupState>(context, listen: false);
    final media = MediaQuery.of(context);
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [CustomColors.colorfulBlue, Colors.blue],
        ),
      ),
      padding: EdgeInsets.only(top: media.padding.top),
      child: Stack(
        children: [
          _buildMainContent(),
          _buildPosButton(setupState),
        ],
      ),
    );
  }

  SingleChildScrollView _buildMainContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          _headerText,
          SizedBox(height: 20),
          _pageDetail,
          AccountInfoForm(),
        ],
      ),
    );
  }

  Positioned _buildPosButton(AccountSetupState setupState) {
    return Positioned(
      bottom: 30,
      right: 0,
      child: IconButton(
        iconSize: 40,
        onPressed: () {
          setupState.update(index: setupState.index + 1, listen: true);
        },
        icon: Icon(Icons.arrow_forward, color: Colors.white),
      ),
    );
  }
}
