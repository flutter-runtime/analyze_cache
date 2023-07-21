import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/src/dart/element/element.dart';
import 'package:darty_json_safe/darty_json_safe.dart';
import 'analyzer_cache.dart';
import 'analyzer_property_accessor_cache.dart';
import 'analyzer_method_cache.dart';

class AnalyzerExtensionCache<T> extends AnalyzerCache<T> {
  List<AnalyzerPropertyAccessorCache> fields = [];
  List<AnalyzerMethodCache> methods = [];
  late String name;

  /// 扩展名称
  String? extensionName;
  AnalyzerExtensionCache(super.element, super.map, [super.parent]);

  @override
  void addToMap() {
    super.addToMap();
    this['fields'] = fields.map((e) => e.toJson()).toList();
    this['methods'] = methods.map((e) => e.toJson()).toList();
    this['name'] = name;
    this['extensionName'] = extensionName;
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
    extensionName = JSON(element)['extensionName'].stringValue;
    name = JSON(element)['name'].stringValue;
  }
}
