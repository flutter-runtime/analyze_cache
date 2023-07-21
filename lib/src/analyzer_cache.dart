import 'package:darty_json_safe/darty_json_safe.dart';

abstract class AnalyzerCache<T> {
  final T element;
  final Map map;
  final AnalyzerCache? parent;
  bool isEnable = true;

  AnalyzerCache(this.element, this.map, [this.parent]) {
    fromMap(map);
  }

  Map toJson() {
    addToMap();
    return map;
  }

  void addToMap() {
    this['isEnable'] = isEnable;
  }

  operator []=(String name, dynamic element) {
    Unwrap(element).map((e) => map[name] = e);
  }

  void fromMap(Map map) {
    isEnable = JSON(map)['isEnable'].bool ?? true;
  }
}

extension ListFirst<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    final index = indexWhere(test);
    return index == -1 ? null : this[index];
  }
}

extension StringPrivate on String {
  bool get isPrivate => startsWith('_');
}
