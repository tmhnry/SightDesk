import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './layout/styles.dart';
import './states/account_setup_state.dart';

class SexSelector extends StatelessWidget {
  TextStyle get _textStyle {
    return TextStyle(
      color: Colors.white,
      fontFamily: 'Raleway',
      fontSize: 15,
      fontWeight: FontWeight.w700,
    );
  }

  List<Widget> _showOptions(BuildContext ctx) {
    final setupState = Provider.of<AccountSetupState>(ctx, listen: false);
    return ['Male', 'Female'].map((sex) {
      return TextButton(
        child: Text('Male', style: _textStyle),
        onPressed: () {
          setupState.update(label: 'Sex', val: [sex], listen: true);
          Navigator.pop(ctx);
        },
      );
    }).toList();
  }

  Container _bottomSheetBuilder(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [CustomColors.colorfulBlue, Colors.blue],
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _showOptions(ctx),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          context: context,
          builder: (ctx) {
            return _bottomSheetBuilder(ctx);
          },
        );
      },
      icon: Icon(Icons.arrow_drop_down),
    );
  }
}
