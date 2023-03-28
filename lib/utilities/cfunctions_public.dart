import '../entities/cid.dart';

enum Position {
  Start,
  Between,
  End,
}

Position cFuncGetItemPosition({
  required dynamic item,
  required List<dynamic> parentList,
}) {
  if (parentList.isEmpty)
    throw Exception('cFuncGetItemPosition: parentList is empty');
  if (!(parentList.contains(item)))
    throw Exception('cFuncGetItemPosition: item not found in parentList');
  if (parentList.indexOf(item) == 0) return Position.Start;
  if (parentList.indexOf(item) == parentList.length - 1) return Position.End;
  return Position.Between;
}

List<String> cFuncGetCIDStrings(List<CID> cids) {
  return cids.map((cid) => cid.id).toList();
}

Map cFuncMapDeepSearch({
  required Map m,
  required List l,
}) {
  for (var v in l) {
    if (m.containsKey(v)) {
      if (m[v] is Map)
        m = m[v];
      else
        throw Exception('cFuncMapInsert: \'${m[v].runtimeType}\' is not a map');
    } else {
      throw Exception(
        'cFuncMapInsert: key $v of type ${v.runtimeType} not found',
      );
    }
  }
  return m;
}

Map cFuncMapInsert({
  required Map m,
  required List l,
}) {
  if (l.length == 2) return m.putIfAbsent(l[0], () => l[1]);
  m = cFuncMapDeepSearch(m: m, l: l.sublist(0, l.length - 2));
  return m.putIfAbsent(l[l.length - 2], () => l[l.length - 1]);
}

List cFuncMapQuery({
  required Map m,
  required List l,
  bool getKeys = false,
}) =>
    getKeys
        ? cFuncMapDeepSearch(m: m, l: l).keys.toList()
        : cFuncMapDeepSearch(m: m, l: l).values.toList();

String cFuncGenerateUniqueCIDString({
  int? len,
  required List<String> cidStrings,
}) {
  String cidString = '';
  if (len != null)
    cidString = CIDRoutines.generateCIDString(len);
  else {
    assert(cidStrings.length > 0);
    len = cidStrings.elementAt(0).length;
    cidString = CIDRoutines.generateCIDString(len);
    while (cidStrings.contains(cidString))
      cidString = CIDRoutines.generateCIDString(len);
  }
  return cidString;
}
