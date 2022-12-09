import 'package:advanced_table/advanced_table.dart';
import 'package:flutter/material.dart';

/// Creates an advanced table wrapper widget around [Table].
///
/// [T] should be a custom object with a [toJson] method.
///
/// [columnDefinitions] and [data] must be provided.
class AdvancedTable<T> extends StatefulWidget {
  /// Configuration info for each individual column
  final List<ColumnDefinition> columnDefinitions;

  /// Data to be displayed.
  final List<T> data;

  final List<Widget>? actions;

  /// Separator for a [ColumnDefinition<List>].
  ///
  /// Default is [ListSeparator.comma]
  final ListSeparator listSeparator;

  /// Bracket characters around the list e.g. `(1, 2, 3)`.
  ///
  /// Default is [ListBrackets.square]
  final ListBrackets listBrackets;

  /// Strategy to be applied to null values.
  ///
  /// Default is [NullValueStrategy.hyphen]
  final NullValueStrategy nullValue;

  /// Border to be created
  final TableBorder? border = TableBorder.all();

  /// Contains the parsed JSON representation of each [T] in [data]
  final List<Map<String, dynamic>> _parsedData = [];

  AdvancedTable({
    super.key,
    required this.columnDefinitions,
    required this.data,
    this.actions,
    this.listSeparator = ListSeparator.comma,
    this.listBrackets = ListBrackets.square,
    this.nullValue = NullValueStrategy.hyphen,
    TableBorder? border,
  }) {
    // Parsing objects to maps
    for (dynamic value in data) {
      try {
        final Map<String, dynamic> jsonMap = value.toJson();
        _parsedData.add(jsonMap);
      } on NoSuchMethodError catch (_) {
        throw NoSuchMethodError.withInvocation(value, value.toJson());
      }
    }
    // Check if the keys' length of each map entry matches the length of
    // defined column definitions
    final int columnCount = columnDefinitions.length;
    for (var dataEntry in _parsedData) {
      if (dataEntry.keys.length != columnCount) {
        throw StateError(
            'Count of columns $columnCount does not match data entry key count ${dataEntry.keys.length}: ${dataEntry.keys}');
      }
    }
  }

  @override
  State<AdvancedTable> createState() => _AdvancedTableState();
}

class _AdvancedTableState extends State<AdvancedTable> {
  @override
  Widget build(BuildContext context) {
    return widget.actions != null
        ? Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(width: 1),
                      top: BorderSide(width: 1),
                      right: BorderSide(width: 1)),
                ),
                child: Row(
                  children: widget.actions!,
                ),
              ),
              advancedTableCore,
            ],
          )
        : advancedTableCore;
  }

  _AdvancedTableCore get advancedTableCore => _AdvancedTableCore(
        columnDefinitions: widget.columnDefinitions,
        data: widget._parsedData,
        listBrackets: widget.listBrackets,
        listSeparator: widget.listSeparator,
        nullValue: widget.nullValue,
        border: widget.border,
      );
}

class _AdvancedTableCore extends StatelessWidget {
  final List<ColumnDefinition> columnDefinitions;
  final List<Map<String, dynamic>> data;
  final TableBorder? border;
  final ListSeparator listSeparator;
  final ListBrackets listBrackets;
  final NullValueStrategy nullValue;

  const _AdvancedTableCore({
    Key? key,
    required this.columnDefinitions,
    required this.data,
    required this.listBrackets,
    required this.listSeparator,
    required this.nullValue,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: border,
      children: <TableRow>[
        /// Header row
        TableRow(
          children: columnDefinitions
              .map(
                (columnDefinition) => TableCell(
                  child: Text(
                    columnDefinition.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
              .toList(),
        ),

        /// Data rows
        ...data.map((jsonMap) => TableRow(
            children: jsonMap.entries.map((mapEntry) => _buildDataCell(mapEntry)).toList()))
      ],
    );
  }

  /// Returns a [TableCell] widget using a [MapEntry] obtained
  /// from parsing [AdvancedTable.data]
  Widget _buildDataCell(final MapEntry<String, dynamic> entry) {
    // Find applicable column
    final ColumnDefinition columnDefinition = columnDefinitions.firstWhere(
      (element) => element.valueKey == entry.key,
      orElse: () => throw StateError('No column definition found for ${entry.key}'),
    );

    final dynamic value = entry.value;

    // Check if types match
    final Type columnDefinitionType = columnDefinition.type;
    final Type valueType = value.runtimeType;
    if (!columnDefinition.isNullable && columnDefinitionType != valueType) {
      throw StateError(
          'Provided type $valueType of value $value does not match column definition type $columnDefinitionType');
    }

    dynamic textValue;
    // Check type and transform value
    if (value is String) {
      textValue = value;
    } else if (value is num) {
      textValue = value.toString();
    } else if (value is Enum) {
      textValue = value.name;
    } else if (value == null) {
      textValue = nullValue.value;
    } else if (value is List) {
      final String joined = value.join('${listSeparator.value} ');
      textValue = listBrackets.left + joined + listBrackets.right;
    } else {
      throw StateError('Type $valueType not supported');
    }

    return TableCell(
      child: Text(
        textValue,
        textAlign: columnDefinition.valueAlignment,
      ),
    );
  }
}

/// Define the brackets used when displaying a [List] in a cell.
///
/// Supported bracket types are:
/// * parentheses: ()
/// * curly: {}
/// * square: []
enum ListBrackets {
  /// Use parentheses
  parentheses('(', ')'),

  /// Use curly brackets
  curly('{', '}'),

  /// Use square brackets
  square('[', ']');

  /// The left side of a bracket
  final String left;

  /// The right side of a bracket
  final String right;

  const ListBrackets(this.left, this.right);
}

/// Define the value to be displayed for [null]
enum NullValueStrategy {
  /// Display en empty String
  empty(''),

  /// Display an hyphen
  hyphen('-');

  final String value;

  const NullValueStrategy(this.value);
}

/// Define the separator between items when displaying a
/// [List] in a Table
enum ListSeparator {
  /// Use commas
  comma(','),

  /// Use semicolons
  semicolon(';');

  final String value;

  const ListSeparator(this.value);
}
