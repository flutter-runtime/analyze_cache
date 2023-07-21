import 'package:darty_json_safe/darty_json_safe.dart';
import 'analyzer_cache.dart';

class AnalyzerNameSpaceCache<T> extends AnalyzerCache<T> {
  List<String> exportNames = [];
  AnalyzerNameSpaceCache(super.element, super.map, [super.parent]);

  @override
  void addToMap() {
    super.addToMap();
    this['exportNames'] = exportNames;
  }

  @override
  void fromMap(Map map) {
    super.fromMap(map);
    exportNames = JSON(element)['exportNames']
        .listValue
        .map((e) => JSON(e).stringValue)
        .toList();
  }
}
