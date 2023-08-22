import 'package:darty_json_safe/darty_json_safe.dart';
import 'analyzer_property_accessor_cache.dart';
import 'analyzer_method_cache.dart';
import './analyzer_cache.dart';

class AnalyzerClassCache<T> extends AnalyzerCache<T> {
  AnalyzerClassCache(super.element, super.map, [super.parent]);
  List<AnalyzerPropertyAccessorCache> fields = [];
  List<AnalyzerMethodCache> methods = [];
  List<AnalyzerMethodCache> constructors = [];
  late String name;
  late bool isAbstract;

  @override
  void addToMap() {
    super.addToMap();
    this['isAbstract'] = isAbstract;
    this['name'] = name;
    this['fields'] = fields.map((e) => e.toJson()).toList();
    this['methods'] = methods.map((e) => e.toJson()).toList();
    this['constructors'] = constructors.map((e) => e.toJson()).toList();
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    super.fromMap(map);
    constructors = JSON(map)['constructors']
        .listValue
        .map((e) => AnalyzerMethodCache(e, e, this))
        .toList();
    fields = JSON(map)['fields']
        .listValue
        .map((e) => AnalyzerPropertyAccessorCache(e, e, this))
        .toList();
    methods = JSON(map)['methods']
        .listValue
        .map((e) => AnalyzerMethodCache(e, e, this))
        .toList();
    name = JSON(map)['name'].stringValue;
    isAbstract = JSON(map)['isAbstract'].boolValue;
  }

  String? defaultValueCodeFromClass(String name) {
    final field = fields.firstWhereOrNull((element) => element.name == name);
    if (field != null && field.isStatic) {
      if (field.name.isPrivate) {
        return '${this.name}.${field.defaultValueCode}';
      } else {
        return '${this.name}.${field.name}';
      }
    }
    return null;
  }
}
