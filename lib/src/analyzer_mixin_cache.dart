// ignore_for_file: implementation_imports

import 'package:darty_json_safe/darty_json_safe.dart';
import 'analyzer_cache.dart';
import 'analyzer_method_cache.dart';
import 'analyzer_property_accessor_cache.dart';

class AnalyzerMixinCache<T> extends AnalyzerCache<T> {
  List<AnalyzerPropertyAccessorCache> fields = [];
  List<AnalyzerMethodCache> methods = [];
  List<AnalyzerMethodCache> constructors = [];
  late String name;
  AnalyzerMixinCache(super.element, super.map, [super.parent]);

  @override
  void addToMap() {
    super.addToMap();
    this['fields'] = fields.map((e) => e.toJson()).toList();
    this['methods'] = methods.map((e) => e.toJson()).toList();
    this['constructors'] = constructors.map((e) => e.toJson()).toList();
    this['name'] = name;
  }

  @override
  void fromMap(Map map) {
    super.fromMap(map);
    fields = JSON(element)['fields']
        .listValue
        .map((e) => AnalyzerPropertyAccessorCache(e, e, this))
        .toList();
    methods = JSON(element)['methods']
        .listValue
        .map((e) => AnalyzerMethodCache(e, e, this))
        .toList();
    constructors = JSON(element)['constructors']
        .listValue
        .map((e) => AnalyzerMethodCache(e, e, this))
        .toList();

    name = JSON(element)['name'].stringValue;
  }
}