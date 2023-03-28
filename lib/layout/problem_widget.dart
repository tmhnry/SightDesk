import 'dart:math';
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

Widget buildWidget(String content) {
  const String inlineText = r'''\texti''';
  const String blockText = r'''\textb''';
  const String inlineMath = r'''\mathi''';
  const String blockMath = r'''\mathb''';
  final displayComponents = <Widget>[];
  while (content.contains(inlineText) ||
      content.contains(blockText) ||
      content.contains(inlineMath) ||
      content.contains(blockMath)) {
    print('start');
    final _content = content.substring(
      content.indexOf(RegExp(r'''(\\texti|\\textb|\\mathi|\\mathb)''')),
      content.indexOf('}') + 1,
    );
    content = content.replaceFirst(_content, '');
    if (_content.contains(inlineText))
      displayComponents.add(
        Text(
          _content.replaceFirst(inlineText + '{', '').replaceFirst('}', ''),
          // textAlign: TextAlign.justify,
          textWidthBasis: TextWidthBasis.longestLine,
          style: TextStyle(
            backgroundColor: Colors.yellow,
            color: Colors.black,
            fontFamily: 'Raleway',
            fontSize: 20,
          ),
        ),
      );
    if (_content.contains(blockText))
      displayComponents.add(Container(
        width: double.infinity,
        child: Text(
          _content.replaceFirst(blockText + '{', '').replaceFirst('}', ''),
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Raleway',
            fontSize: 20,
          ),
        ),
      ));
    if (_content.contains(inlineMath))
      displayComponents.add(Container(
        color: Colors.red,
        child: Math.tex(
          r'''\;''' +
              _content
                  .replaceFirst(inlineMath + '{', '')
                  .replaceFirst('}', '') +
              r'''\;''',
          textStyle: TextStyle(
            fontSize: 23,
          ),
        ),
      ));
    if (_content.contains(blockMath))
      displayComponents.add(Container(
        width: double.infinity,
        child: Math.tex(
          _content.replaceFirst(blockMath + '{', '').replaceFirst('}', ''),
          textStyle: TextStyle(
            fontSize: 25,
          ),
        ),
      ));
  }
  return Wrap(
    crossAxisAlignment: WrapCrossAlignment.center,
    children: displayComponents,
  );
}

List<Widget> buildRowStack({
  required String content,
  required BuildContext context,
}) {
  final maxChars = (1.2 * MediaQuery.of(context).size.width) ~/ globalFontSize;
  final rowStack = <Widget>[];
  late RenderMode mode;
  Row currentRow = new Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: <Widget>[],
  );
  int allowableChars = 0;
  int currentChars = 0;
  int remainingChars = 0;
  String blockContent = (content = content.trim()).substring(
    content.indexOf('$block$begin') + 13,
    content.indexOf('$block$end'),
  );
  String currentString = '';
  int currentIteration = 0;
  while ((currentString.isNotEmpty || blockContent.isNotEmpty) &&
      currentIteration < maxIteration) {
    if (currentChars == maxChars) {
      rowStack.add(currentRow);
      currentRow = new Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[],
      );
      currentChars = 0;
    }
    if (remainingChars == 0) {
      blockContent = blockContent.trim();
      final backSlashIndex = blockContent.indexOf('\\');
      if (backSlashIndex < 0) {
        mode = RenderMode.normal;
        currentString = blockContent;
        remainingChars = currentString.length;
        blockContent = blockContent.replaceFirst(currentString, '');
      }
      if (backSlashIndex == 0) {
        final containsFormatter = blockContent
                .replaceFirst(
                  '\\',
                  '',
                )
                .indexOf(
                  RegExp(r'''\S'''),
                ) ==
            0;
        if (containsFormatter) {
          final end = getEndOfTemplate(blockContent) + 1;
          if (end == 0) return <Widget>[];
          final template = blockContent.substring(0, end);
          currentString = getContent(template);
          remainingChars = currentString.length;
          if (template.contains(textNormal)) {
            mode = RenderMode.textNormal;
          } else if (template.contains(textBold)) {
            mode = RenderMode.textBold;
          } else if (template.contains(textItalic)) {
            mode = RenderMode.textItalic;
          } else {
            mode = RenderMode.math;
          }
          blockContent = blockContent.replaceFirst(template, '');
        } else {
          mode = RenderMode.normal;
          currentString = '\\';
          remainingChars = currentString.length;
          blockContent = blockContent.replaceFirst(currentString, '');
        }
      }
      if (backSlashIndex > 0) {
        mode = RenderMode.normal;
        currentString = blockContent.substring(0, backSlashIndex);
        remainingChars = currentString.length;
        blockContent = blockContent.replaceFirst(currentString, '');
      }
    }
    allowableChars = min(remainingChars, maxChars - currentChars);
    remainingChars = remainingChars - allowableChars;
    currentChars += allowableChars;
    final widgetText = currentString.substring(
      0,
      allowableChars,
    );
    currentString = currentString.replaceFirst(widgetText, '');
    if (mode == RenderMode.normal || mode == RenderMode.math) {
      currentRow.children.add(
        Math.tex(
          widgetText,
          textStyle: TextStyle(fontSize: globalFontSize),
        ),
      );
    }
    if (mode == RenderMode.textNormal) {
      currentRow.children.add(
        Text(
          widgetText,
          style: TextStyle(fontSize: globalFontSize),
        ),
      );
    }
    if (mode == RenderMode.textBold) {
      currentRow.children.add(
        Text(
          widgetText,
          style:
              TextStyle(fontWeight: FontWeight.w700, fontSize: globalFontSize),
        ),
      );
    }
    if (mode == textItalic) {
      currentRow.children.add(
        Text(
          widgetText,
          style:
              TextStyle(fontStyle: FontStyle.italic, fontSize: globalFontSize),
        ),
      );
    }
    currentIteration++;
  }
  rowStack.add(currentRow);
  return rowStack;
}
