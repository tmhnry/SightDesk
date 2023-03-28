import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './main_screen.dart';
import './layout/styles.dart';
import 'degree_selector.dart';
import './states/account_setup_state.dart';
import './entities/typedef.dart';

class SelectDegreePage extends StatelessWidget {
  Text get _headerText {
    return Text(
      'SightDesk PH Degree Selection',
      style:
          TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 40),
    );
  }

  Text get _pageDetail {
    return Text(
      'Every institution offers a set of different disciplines or degrees that are dependent on knowledge branches specific to the institution. This is true for SightDesk PH as well. Please choose from the following the degree that you want to take: ',
      style:
          TextStyle(color: Colors.white, fontFamily: 'Raleway', fontSize: 20),
      textAlign: TextAlign.justify,
    );
  }

  Positioned _buildPosButton(
    AccountSetupState setupState,
    BuildContext? ctx,
    List<double?> pos,
  ) {
    return Positioned(
      top: pos[0],
      bottom: pos[1],
      right: pos[3],
      left: pos[4],
      child: IconButton(
        iconSize: 40,
        onPressed: () async {
          if (pos[3] == 0.0 && ctx != null) {
            await setupState.complete();
            Navigator.pushReplacementNamed(ctx, MainScreen.routeName);
          } else {
            setupState.update(
              index: setupState.index - 1,
              listen: true,
            );
          }
        },
        icon: Icon(
          pos[3] == 0.0 ? Icons.flag : Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final setupState = Provider.of<AccountSetupState>(context, listen: false);
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            CustomColors.colorfulBlue,
            Colors.blue,
          ],
        ),
      ),
      padding: EdgeInsets.only(top: media.padding.top),
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                _headerText,
                SizedBox(height: 20),
                _pageDetail,
                DegreeForm(),
              ],
            ),
          ),
          _buildPosButton(setupState, null, [null, 30.0, null, 0.0]),
          _buildPosButton(setupState, context, [null, 30.0, 0.0, null]),
        ],
      ),
    );
  }
}

class DegreeForm extends StatefulWidget {
  const DegreeForm({Key? key}) : super(key: key);

  @override
  _DegreeFormState createState() => _DegreeFormState();
}

class _DegreeFormState extends State<DegreeForm> {
  final _formKey = GlobalKey<FormState>();

  final double _hmargin = 15;
  final double _htfmargin = 5;

  InputDecoration _buildTextDec(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
      border: InputBorder.none,
      prefix: SizedBox(width: 10),
      suffixIcon: DegreeSelector(),
    );
  }

  TextStyle get _textStyle {
    return TextStyle(
      color: Color.fromRGBO(255, 255, 255, 1),
      fontFamily: 'Raleway',
    );
  }

  Row _buildRow(double width, Doubles spaces, Strings labels) {
    final setupState = Provider.of<AccountSetupState>(context, listen: false);
    final margin = EdgeInsets.only(
      top: 20,
      left: _htfmargin,
      right: _htfmargin,
      bottom: 10,
    );
    final decoration = BoxDecoration(
      border: Border.all(color: Colors.white, width: 0.2),
      borderRadius: BorderRadius.circular(10),
      color: Color.fromRGBO(0, 0, 0, 0.1),
    );

    int count = 0;

    return Row(
      children: labels.map((label) {
        count++;
        return Container(
          width: spaces[count - 1] *
              (width - 2 * _hmargin - 2 * labels.length * _htfmargin) /
              3,
          margin: margin,
          decoration: decoration,
          child: TextFormField(
            initialValue: setupState.getInitialVal(label.trim()),
            readOnly: true,
            textAlignVertical: TextAlignVertical.center,
            style: _textStyle,
            decoration: _buildTextDec(labels[count - 1]),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    Provider.of<AccountSetupState>(context);
    return Form(
      key: _formKey,
      child: _buildRow(media.size.width, [3.0], ['   Degree']),
    );
  }
}
