import 'package:flutter/cupertino.dart';

///
class ColumnDefinition<T> {
  ///
  final String valueKey;

  ///
  final Text title;

  ///
  final Type type;

  ColumnDefinition({required this.valueKey, required this.title}) : type = T;
}
