import 'package:advanced_table/advanced_table.dart';
import 'package:flutter/material.dart';

/// Configuration data for a single column. The type of a value of an entry in
/// [AdvancedTable.data] must correspond to [T] of this definition. In addition to that
/// an entries key must correspond to [valueKey].
///
/// A [valueKey] and [title] must be provided.
///
/// The currently allowed types for [T] are:
/// * [String] and [num]
/// * [Enum] and [List]
///
/// Consider that these types can be nullable as well. See [NullValueStrategy] for options
/// what to display when a value is null.
///
/// NOTE: For enum values [Enum.name] is used. Also you can customize the displaying text for a [List] by using the [AdvancedTableConfig].
class ColumnDefinition<T> {
  /// The key to be used to extract the value of an entry in [AdvancedTable.data]
  final String valueKey;

  /// Alignment of each cell in this column
  final TextAlign valueAlignment;

  /// Text to be displayed in the first row of this column
  final Text title;

  /// Type of the definition [T] determining the transformation of the value
  final Type type;

  ColumnDefinition({
    required this.valueKey,
    required this.title,
    this.valueAlignment = TextAlign.start,
  }) : type = T;

  /// Return true if [T] is nullable
  bool get isNullable {
    try {
      null as T;
      return true;
    } catch(_) {
      return false;
    }
  }
}

