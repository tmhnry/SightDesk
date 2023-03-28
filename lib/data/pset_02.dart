import './helpers.dart';

//  using const instead of final makes it immutable
final pset_02 = <String, Map<String, dynamic>>{
  'A02BA': {
    question: r'''
    \block{begin}
      \textnormal{What temperature at which water freezes using the Kelvin scale?}
    \block{end}
    ''',
    solution: '',
    choices: [
      {
        content: r'''
        \block{begin}
          373
        \block{end}
        ''',
        choice_units: r'''
        ''',
        value: 0,
      },
      {
        content: r'''
        \block{begin}
          273
        \block{end}
        ''',
        choice_units: r'''
        ''',
        value: 1,
      },
      {
        content: r'''
        \block{begin}
          278
        \block{end}
        ''',
        choice_units: r'''
        ''',
        value: 0,
      },
      {
        content: r'''
        \block{begin}
          406
        \block{end}
        ''',
        choice_units: r'''
        ''',
        value: 0,
      },
    ],
  },
  'A02BB': {
    question: r'''
    \block{begin}
      \textnormal{What is the standard temperature in the US?}
    \block{end}
    ''',
    solution: r'''
    ''',
    choices: [
      {
        content: r'''
        \block{begin}
          \textnormal{Fahrenheit}
        \block{end}
        ''',
        choice_units: r'''
        ''',
        value: 1,
      },
      {
        content: r'''
        \block{begin}
          \textnormal{Rankine}
        \block{end}
        ''',
        choice_units: r'''
        ''',
        value: 0,
      },
      {
        content: r'''
        \block{begin}
          \textnormal{Celsius}
        \block{end}
        ''',
        choice_units: r'''
        ''',
        value: 0,
      },
      {
        content: r'''
        \block{begin}
          \textnormal{Kelvin}
        \block{end}
        ''',
        choice_units: r'''
        ''',
        value: 0,
      },
    ],
  },
};
