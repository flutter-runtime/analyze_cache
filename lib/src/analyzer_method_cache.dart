// ignore_for_file: implementation_imports

import 'package:darty_json_safe/darty_json_safe.dart';
import 'analyzer_cache.dart';
import 'analyzer_property_accessor_cache.dart';

class AnalyzerMethodCache<T> extends AnalyzerCache<T> {
  late String name;
  List<AnalyzerPropertyAccessorCache> parameters = [];
  late bool isStatic;
  AnalyzerMethodCache(super.element, super.map, [super.parent]);

  @override
  void addToMap() {
    super.addToMap();
    this['isStatic'] = isStatic;
    this['name'] = name;
    this['parameters'] = parameters.map((e) => e.toJson()).toList();
  }

  @override
  void fromMap(Map map) {
    super.fromMap(map);
    parameters = JSON(element)['parameters']
        .listValue
        .map((e) => AnalyzerPropertyAccessorCache(e, e, this))
        .toList();
    isStatic = JSON(element)['isStatic'].boolValue;
    name = JSON(element)['name'].stringValue;
  }
}
