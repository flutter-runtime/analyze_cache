// ignore_for_file: implementation_imports

import 'package:darty_json_safe/darty_json_safe.dart';

import 'analyzer_cache.dart';
import 'analyzer_class_cache.dart';
import 'analyzer_extension_cache.dart';
import 'analyzer_import_cache.dart';
import 'analyzer_method_cache.dart';
import 'analyzer_enum_cache.dart';
import 'analyzer_mixin_cache.dart';
import 'analyzer_property_accessor_cache.dart';

class AnalyzerFileCache<T> extends AnalyzerCache<T> {
  List<AnalyzerClassCache> classs = [];
  List<AnalyzerExtensionCache> extensions = [];
  List<AnalyzerPropertyAccessorCache> topLevelVariables = [];
  List<AnalyzerMethodCache> functions = [];
  List<AnalyzerEnumCache> enums = [];
  List<AnalyzerMixinCache> mixins = [];
  List<AnalyzerImportCache> imports = [];
  AnalyzerFileCache(super.element, super.map);

  @override
  void addToMap() {
    super.addToMap();
    this['classs'] = classs.map((e) => e.toJson()).toList();
    this['extensions'] = extensions.map((e) => e.toJson()).toList();
    this['topLevelVariables'] =
        topLevelVariables.map((e) => e.toJson()).toList();
    this['functions'] = functions.map((e) => e.toJson()).toList();
    this['enums'] = enums.map((e) => e.toJson()).toList();
    this['mixins'] = mixins.map((e) => e.toJson()).toList();
    this['imports'] = imports.map((e) => e.toJson()).toList();
  }

  @override
  void fromMap(Map map) {
    classs = JSON(map)['classs']
        .listValue
        .map((e) => AnalyzerClassCache(e, e, this))
        .toList();

    enums = JSON(map)['enums']
        .listValue
        .map((e) => AnalyzerEnumCache(e, e, this))
        .toList();

    extensions = JSON(map)['extensions']
        .listValue
        .map((e) => AnalyzerExtensionCache(e, e, this))
        .toList();

    functions = JSON(map)['functions']
        .listValue
        .map((e) => AnalyzerMethodCache(e, e, this))
        .toList();

    mixins = JSON(map)['mixins']
        .listValue
        .map((e) => AnalyzerMixinCache(e, e, this))
        .toList();

    topLevelVariables = JSON(map)['topLevelVariables']
        .listValue
        .map((e) => AnalyzerPropertyAccessorCache(e, e, this))
        .toList();

    imports = JSON(map)['imports']
        .listValue
        .map((e) => AnalyzerImportCache(e, e, this))
        .toList();
  }

  List<String> get exportNames => [
        classs.map((e) => e.name),
        functions.map((e) => e.name),
        enums.map((e) => e.name),
        mixins.map((e) => e.name),
        extensions.map((e) => e.name),
        topLevelVariables.map((e) => e.name),
      ].expand((element) => element).toList();

  String? defaultValueCodeFromTopLevelVariable(String name) {
    return topLevelVariables
        .firstWhereOrNull((e) => e.name == name)
        ?.defaultValueCode;
  }
}
