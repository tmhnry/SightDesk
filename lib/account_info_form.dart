import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './entities/typedef.dart';
import './sex_selector.dart';
import './states/account_setup_state.dart';

class AccountInfoForm extends StatefulWidget {
  const AccountInfoForm({Key? key}) : super(key: key);

  @override
  _AccountInfoFormState createState() => _AccountInfoFormState();
}

class _AccountInfoFormState extends State<AccountInfoForm> {
  final double _hmargin = 15;
  final double _htfmargin = 5;

  InputDecoration _buildTextDec(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Color.fromRGBO(0, 0, 0, 0.5)),
      border: InputBorder.none,
      prefix: SizedBox(width: 10),
    );
  }

  InputDecoration get _sexDec {
    return InputDecoration(
      labelText: '   Sex',
      labelStyle: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 0.5),
      ),
      border: InputBorder.none,
      prefix: SizedBox(width: 10),
      suffixIcon: SexSelector(),
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
              (width - 2 * _hmargin - labels.length * _htfmargin) /
              3,
          margin: margin,
          decoration: decoration,
          child: TextFormField(
            initialValue: setupState.getInitialVal(label.trim()),
            readOnly: label.trim() == 'Sex',
            onChanged: (val) {
              setupState.update(label: label.trim(), val: [val]);
            },
            textAlignVertical: TextAlignVertical.center,
            style: _textStyle,
            decoration: label.trim() == 'Sex'
                ? _sexDec
                : _buildTextDec(labels[count - 1]),
          ),
        );
      }).toList(),
    );
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    Provider.of<AccountSetupState>(context);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildRow(
              media.size.width,
              [1.7, 1.3],
              ['   First Name', '   Middle Name'],
            ),
            _buildRow(
              media.size.width,
              [1.3, 1.7],
              ['   Last Name', '   Email Address'],
            ),
            _buildRow(
              media.size.width,
              [2.0, 1.0],
              ['   Contact Number', '   Sex'],
            ),
            _buildRow(media.size.width, [3.0], ['   Address']),
          ],
        ),
      ),
    );
  }
}
