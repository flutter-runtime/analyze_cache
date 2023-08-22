// ignore_for_file: implementation_imports

import 'package:analyzer/src/dart/element/element.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'analyzer_cache.dart';
import 'analyzer_property_accessor_cache.dart';
import 'analyzer_method_cache.dart';

class AnalyzerEnumCache<T> extends AnalyzerCache<T> {
  List<AnalyzerPropertyAccessorCache> fields = [];
  List<AnalyzerMethodCache> methods = [];
  late String name;
  AnalyzerEnumCache(super.element, super.map, [super.parent]);

  @override
  void addToMap() {
    super.addToMap();
    this['fields'] = fields.map((e) => e.toJson()).toList();
    this['methods'] = methods.map((e) => e.toJson()).toList();
    this['name'] = name;
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    super.fromMap(map);
    fields = JSON(element)['fields']
        .listValue
        .map((e) => AnalyzerPropertyAccessorCache(e, e, this))
        .toList();
    methods = JSON(element)['methods']
        .listValue
        .map((e) => AnalyzerMethodCache(e, e, this))
        .toList();
    name = JSON(element)['name'].stringValue;
  }
}
