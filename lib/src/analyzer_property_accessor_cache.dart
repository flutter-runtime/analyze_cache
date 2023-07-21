import 'package:darty_json_safe/darty_json_safe.dart';

import 'analyzer_cache.dart';

class AnalyzerPropertyAccessorCache<T> extends AnalyzerCache<T> {
  late String name;
  late bool isStatic;
  late bool isGetter;
  late bool isSetter;
  late bool isNamed;
  late bool hasDefaultValue;
  String? defaultValueCode;
  String? asName;
  AnalyzerPropertyAccessorCache(super.element, super.map, [super.parent]);

  @override
  void addToMap() {
    super.addToMap();
    this['isStatic'] = isStatic;
    this['name'] = name;
    this['isGetter'] = isGetter;
    this['isSetter'] = isSetter;
    this['isNamed'] = isNamed;
    this['hasDefaultValue'] = hasDefaultValue;
    this['defaultValueCode'] = defaultValueCode;
    this['asName'] = asName;
  }

  @override
  void fromMap(Map map) {
    super.fromMap(map);

    isStatic = JSON(element)['isStatic'].boolValue;
    name = JSON(element)['name'].stringValue;
    isGetter = JSON(element)['isGetter'].boolValue;
    isSetter = JSON(element)['isSetter'].boolValue;
    isNamed = JSON(element)['isNamed'].boolValue;
    hasDefaultValue = JSON(element)['hasDefaultValue'].boolValue;
    defaultValueCode = JSON(element)['defaultValueCode'].string;
    asName = JSON(element)['asName'].string;
  }
}
