import 'package:analyzer/src/dart/ast/ast.dart';
import 'package:darty_json_safe/darty_json_safe.dart';

import 'analyzer_cache.dart';
import 'analyzer_file_cache.dart';
import 'analyzer_namespace_cache.dart';

class AnalyzerImportCache<T> extends AnalyzerCache<T> {
  String? uriContent;
  String? asName;
  List<String> shownNames = [];
  List<String> hideNames = [];
  AnalyzerNameSpaceCache? namespace;
  int index = 0;
  AnalyzerImportCache(super.element, super.map, [super.parent]);

  @override
  void addToMap() {
    super.addToMap();
    this['uriContent'] = uriContent;
    this['asName'] = asName;
    this['shownNames'] = shownNames;
    this['hideNames'] = hideNames;
    this['namespace'] = namespace;
    this['index'] = index;
  }

  List<String> hideNamesFromFileCache(AnalyzerFileCache fileCache) {
    final hideNames2 = [...hideNames];
    final exportNames = namespace?.exportNames ?? [];
    for (final e in fileCache.exportNames) {
      if (exportNames.contains(e)) {
        hideNames2.add(e);
      }
    }
    return hideNames2;
  }

  @override
  void fromMap(Map map) {
    super.fromMap(map);
    uriContent = JSON(element)['uriContent'].string;
    asName = JSON(element)['asName'].string;
    shownNames = JSON(element)['shownNames']
        .listValue
        .map((e) => JSON(e).stringValue)
        .toList();
    hideNames = JSON(element)['hideNames']
        .listValue
        .map((e) => JSON(e).stringValue)
        .toList();
    namespace = Unwrap(JSON(element)['namespace'].rawValue)
        .map((e) => AnalyzerNameSpaceCache(e as Map, e, this))
        .value;
    index = JSON(element)['index'].intValue;
  }

  String get name => uriContent ?? '';
}
