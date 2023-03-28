import 'package:flutter/material.dart';
import '../../layout/renderer.dart';
import '../../layout/styles.dart';
import '../../entities/problem.dart';

class EnumerationInput extends StatefulWidget {
  final Problem problem;
  final int index;
  final double width;
  final bool? readOnly;
  final double? fontSize;
  final bool? forNavigation;
  const EnumerationInput({
    required this.index,
    required this.problem,
    required this.width,
    this.fontSize,
    this.readOnly,
    this.forNavigation,
  });

  @override
  _EnumerationInputState createState() => _EnumerationInputState();
}

class _EnumerationInputState extends State<EnumerationInput> {
  final _formKey = GlobalKey<FormState>();
  late List<String> _newAnswers;
  @override
  void initState() {
    _newAnswers = widget.problem.userAnswers.map((answer) => '').toList();
    super.initState();
  }

  void didUpdateWidget(EnumerationInput oldWidget) {
    _newAnswers = widget.problem.userAnswers.map((answer) => '').toList();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final globalWidth = MediaQuery.of(context).size.width;
    final fields = <Widget>[];
    final forNavigation = widget.forNavigation ?? false;
    final correctChoices = widget.problem.choices
        .where(
          (choiceInfo) => choiceInfo['value'] == 1,
        )
        .toList();
    for (int i = 0; i < widget.problem.userAnswers.length; i++) {
      TextSpan customText = TextSpan(
        children: <InlineSpan>[],
        style: TextStyle(height: 1.8 * widget.width / globalWidth),
      );
      final children = customText.children;
      if (children != null) {
        children.add(
          WidgetSpan(
            child: forNavigation
                ? Container(
                    width: widget.width / 2,
                    padding: EdgeInsets.symmetric(
                      vertical: 15 * widget.width / globalWidth,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 0.2 * widget.width / globalWidth,
                      ),
                      borderRadius: BorderRadius.circular(
                        10 * widget.width / globalWidth,
                      ),
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                    ),
                    child: Center(
                      child: Text(
                        widget.problem.userAnswers[i].isEmpty
                            ? 'Answer'
                            : widget.problem.userAnswers[i],
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: globalFontSize * widget.width / globalWidth,
                        ),
                      ),
                    ),
                  )
                : buildEnumerationField(
                    i,
                    initialValue: widget.problem.userAnswers[i],
                  ),
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
          ),
        );
        children.add(
          WidgetSpan(
            child: SizedBox(
              width: 10 * widget.width / globalWidth,
            ),
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
          ),
        );
        children.add(
          WidgetSpan(
            child: Renderer(
              content: correctChoices[i]['choice_units'] ?? '',
              width: widget.width,
            ),
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
          ),
        );
      }
      fields.add(RichText(text: customText));
    }
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: fields,
      ),
    );
  }

  Widget buildEnumerationField(int id, {String? initialValue}) {
    final globalWidth = MediaQuery.of(context).size.width;
    return Container(
      width: globalWidth / 2,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 0.2),
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(0, 0, 0, 0.1),
      ),
      child: TextFormField(
        readOnly: widget.readOnly ?? false,
        key: Key('$initialValue${widget.index}'),
        initialValue: initialValue,
        onChanged: (newAnswer) {
          _newAnswers[id] = newAnswer;
        },
        onEditingComplete: () async {
          await widget.problem.update(
            userAnswers: _newAnswers,
            isTaken: true,
          );
        },
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: Color.fromRGBO(0, 0, 0, 0.5),
          fontFamily: 'Raleway',
          fontSize: widget.fontSize ?? globalFontSize,
        ),
        decoration: InputDecoration(
          hintText: 'Answer',
          hintStyle: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.5),
            fontSize: widget.fontSize ?? globalFontSize,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
