import 'dart:math';
import '../utilities/cfunctions_private.dart';
import '../utilities/cfunctions_public.dart';

class CID<T> {
  late final String id;

  @override
  int get hashCode {
    int result = 17;
    result = 37 * result + id.hashCode;
    return result;
  }

  // You should generally implement operator == if you
  // override hashCode.
  @override
  bool operator ==(dynamic other) {
    return other is CID<T> && other.id == id;
  }

  CID({
    int? len,
    required List<String> cidStrings,
  }) {
    this.id = cFuncGenerateUniqueCIDString(len: len, cidStrings: cidStrings);
  }

  CID.custom({
    required String id,
  }) : this.id = id;
}

class CIDRoutines {
  static final String _cidChars = '0123456789ABCDEF';

  static String get cidChar {
    Random _generator = Random();
    return _cidChars[_generator.nextInt(_cidChars.length)];
  }

  static String generateCIDString(int len) => cFuncGenerateString(
        n: len,
        g: ({
          required String s,
          int? n,
        }) =>
            s,
        f: () => cidChar,
      );
}
