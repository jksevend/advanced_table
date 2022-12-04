import 'package:advanced_table/src/column_definition.dart';
import 'package:flutter/material.dart';

///
class AdvancedTable extends StatefulWidget {
  ///
  final List<ColumnDefinition> columnDefinitions;

  ///
  final List<Map<String, dynamic>> data;

  ///
  final TableBorder? border;

  AdvancedTable({
    super.key,
    required this.columnDefinitions,
    required this.data,
    this.border,
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
              .map((columnDefinition) => TableCell(child: columnDefinition.title))
              .toList(),
        ),
        ...widget.data.map((jsonMap) => TableRow(
            children: jsonMap.entries
                .map((mapEntry) => _buildDataCell(mapEntry.key, mapEntry.value))
                .toList()))
      ],
    );
  }

  Widget _buildDataCell(final String valueKey, final dynamic value) {
    // Find applicable column
    final ColumnDefinition columnDefinition = widget.columnDefinitions.firstWhere(
      (element) => element.valueKey == valueKey,
      orElse: () => throw StateError('No column definition found for $valueKey'),
    );

    // Check if types match
    final Type type = columnDefinition.type;
    if (value.runtimeType != type) {
      throw StateError(
          'Provided type $type of value does not match column definition type ${columnDefinition.type}');
    }

    if (value is String) {
      return Text(value);
    } else if (value is num) {
      return Text(value.toString());
    } else if (value is Enum) {
      return Text(value.name);
    } else if (value is List) {
      final String joined = value.join(', ');
      return Text(joined);
    } else {
      throw StateError('Type ${value.runtimeType} not supported');
    }
  }
}
