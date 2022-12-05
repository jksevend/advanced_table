import 'package:advanced_table/advanced_table.dart';
import 'package:flutter/material.dart';

/// Creates an advanced table wrapper widget around `Table`.
///
/// `columnDefinitions` and `data` must be provided.
class AdvancedTable extends StatefulWidget {
  /// Configuration info for each individual column
  final List<ColumnDefinition> columnDefinitions;

  /// Data to be displayed
  final List<Map<String, dynamic>> data;

  /// Configuration info for this widget
  final AdvancedTableConfig config;

  /// Border to be created
  final TableBorder? border = TableBorder.all();

  AdvancedTable({
    super.key,
    required this.columnDefinitions,
    required this.data,
    this.config = const AdvancedTableConfig(),
    TableBorder? border,
  }) {
    final int columnCount = columnDefinitions.length;
    for (var dataEntry in data) {
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
    return Table(
      border: widget.border,
      children: <TableRow>[
        TableRow(
          children: widget.columnDefinitions
              .map((columnDefinition) => TableCell(
                    child: columnDefinition.title,
                  ))
              .toList(),
        ),
        ...widget.data.map((jsonMap) => TableRow(
            children: jsonMap.entries
                .map((mapEntry) => _buildDataCell(mapEntry))
                .toList()))
      ],
    );
  }

  /// Returns a `TableCell` widget using a `MapEntry` obtained
  /// from [AdvancedTable.data]
  Widget _buildDataCell(final MapEntry<String, dynamic> entry) {
    // Find applicable column
    final ColumnDefinition columnDefinition =
        widget.columnDefinitions.firstWhere(
      (element) => element.valueKey == entry.key,
      orElse: () =>
          throw StateError('No column definition found for ${entry.key}'),
    );

    final dynamic value = entry.value;

    // Check if types match
    final Type columnDefinitionType = columnDefinition.type;
    final Type valueType = value.runtimeType;
    if (columnDefinitionType != valueType) {
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
    } else if (value is List) {
      final String joined = value.join('${widget.config.listSeparator} ');
      textValue = widget.config.listWrapper.left +
          joined +
          widget.config.listWrapper.right;
    } else {
      throw StateError('Type ${value.runtimeType} not supported');
    }

    return TableCell(
      child: Text(
        textValue,
        textAlign: columnDefinition.valueAlignment,
      ),
    );
  }
}
