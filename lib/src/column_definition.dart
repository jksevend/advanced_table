import 'package:flutter/cupertino.dart';

///
class ColumnDefinition<T> {
  ///
  final String valueKey;

  ///
  final TextAlign valueAlignment;

  ///
  final Text title;

  ///
  final Type type;

  ColumnDefinition({
    required this.valueKey,
    required this.title,
    this.valueAlignment = TextAlign.start,
  }) : type = T;
}
