import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './states/account_setup_state.dart';
import './data/root_degrees.dart' as rd;
import './layout/styles.dart';

class DegreeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider.of<Degrees>(context);
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
    final instId = setupState.getInitialVal('Institution');
    final instDegs = rd.degrees[instId];

    if (instDegs != null) {
      return instDegs.keys.map((id) {
        final degInfo = instDegs[id];
        String degName = '';
        if (degInfo != null) {
          degName = degInfo['name'] ?? '';
        }
        return TextButton(
          child: Text(degName, style: _textStyle),
          onPressed: () {
            setupState.update(label: 'Degree', val: [id], listen: true);
            Navigator.pop(ctx);
          },
        );
      }).toList();
    }
    return <Widget>[];
  }
}
