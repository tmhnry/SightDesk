import 'package:flutter/material.dart';
import 'package:flutter_math_fork/flutter_math.dart';
import './styles.dart';

RegExp textFormatter = RegExp(r'''\textnormal|\textbold|\textitalic''');
enum RenderMode { math, textItalic, textNormal, textBold, normal }
const int maxIteration = 100;
const String bs = '\\';
const String begin = r'''{begin}''';
const String end = r'''{end}''';
const String block = r'''\block''';
const String textNormal = r'''\textnormal''';
const String textBold = r'''\textbold''';
const String textItalic = r'''\textitalic''';
const String texts = '$bs$textNormal|$bs$textBold|$bs$textItalic';

String getContent(String template) {
  int openingIndex = template.indexOf('{');
  int closingIndex = template.indexOf('}');
  if (openingIndex < 0 || closingIndex < 0) return '';
  return template.substring(openingIndex + 1, closingIndex);
}

int getEndOfTemplate(String text, {bool? isSection}) {
  int closingIndex = -1;
  int unmatched = 0;
  final textChars = text.split('');
  for (int i = 0; i < textChars.length; i++) {
    if (textChars[i] == '{') unmatched++;
    if (textChars[i] == '}') unmatched--;
    if (unmatched == 0 && textChars[i] == '}') {
      closingIndex = i;
      break;
    }
  }
  return closingIndex;
}

class Renderer extends StatelessWidget {
  final String content;
  final String? fontFamily;
  final double width;
  Renderer({
    required this.content,
    required this.width,
    this.fontFamily,
  });

  InlineSpan renderMath({required String text, required BuildContext context}) {
    final globalWidth = MediaQuery.of(context).size.width;
    return WidgetSpan(
      child: Math.tex(
        text,
        textStyle: TextStyle(fontSize: globalFontSize * width / globalWidth),
      ),
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
    );
  }

  InlineSpan renderText({
    required String text,
    required BuildContext context,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
  }) {
    final globalWidth = MediaQuery.of(context).size.width;
    if (text.contains(textBold)) fontWeight = FontWeight.w700;
    if (text.contains(textItalic)) fontStyle = FontStyle.italic;
    return TextSpan(
      text: getContent(text),
      style: TextStyle(
        color: Colors.black,
        fontFamily: fontFamily,
        fontSize: globalFontSize * width / globalWidth,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalWidth = MediaQuery.of(context).size.width;
    int count = 0;
    final widgets = <Widget>[];
    String content = this.content.trim();
    while (content.isNotEmpty && count < maxIteration) {
      content = content.trim();
      TextSpan customText = TextSpan(
        children: <InlineSpan>[],
        style: TextStyle(height: 1.8 * width / globalWidth),
      );
      final children = customText.children;
      String currentBlock = content.substring(
        content.indexOf('$block$begin') + 13,
        content.indexOf('$block$end'),
      );
      content = content.replaceFirst('$block$begin$currentBlock$block$end', '');
      currentBlock = currentBlock.trim();
      bool proceed = currentBlock.isNotEmpty && count < maxIteration;
      while (proceed && children != null) {
        String render = '';
        int stop = currentBlock.indexOf(RegExp(texts));
        if (stop == 0) {
          stop = getEndOfTemplate(currentBlock) + 1;
          if (stop == 0) {
            children.clear();
            break;
          }
          render = currentBlock.substring(0, stop);
          children.add(renderText(
            text: render,
            context: context,
            fontWeight: FontWeight.w600,
          ));
        } else {
          render = currentBlock.substring(
            0,
            stop < 0 ? currentBlock.length : stop,
          );
          children.add(renderMath(text: render, context: context));
        }
        currentBlock = currentBlock.replaceFirst(render, '');
        count++;
        proceed = currentBlock.isNotEmpty && count < maxIteration;
      }
      widgets.add(RichText(text: customText));
      count++;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widgets,
    );
  }
}
