import 'package:advanced_table/advanced_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$AdvancedTable - Error tests', () {
    test(
        '$AdvancedTable - Count of definitions does not match count of keys of map entry',
        () {
      // GIVEN
      final List<ColumnDefinition> definitions = [
        ColumnDefinition<String>(
            valueKey: 'value1', title: const Text('Value 1')),
        ColumnDefinition<String>(
            valueKey: 'value2', title: const Text('Value 2')),
      ];

      final List<Map<String, dynamic>> data = [
        {'value1': 'Hello', 'value2': 'World'},
        {'value1': 'Hallo'},
      ];

      // WHEN - THEN
      expect(() => AdvancedTable(columnDefinitions: definitions, data: data),
          throwsA(isA<StateError>()));
    });

    testWidgets('$AdvancedTable - Column definition not found',
        (widgetTester) async {
      // GIVEN
      final List<ColumnDefinition> definitions = [
        ColumnDefinition<String>(
            valueKey: 'value1', title: const Text('Value 1')),
        ColumnDefinition<String>(
            valueKey: 'value32', title: const Text('Value 1')),
      ];

      final List<Map<String, dynamic>> data = [
        {'value1': 'Hello', 'value2': 'World'},
        {'value1': 'Hallo', 'value2': 'World'},
      ];

      final AdvancedTable table =
          AdvancedTable(columnDefinitions: definitions, data: data);

      // WHEN
      await widgetTester.pumpWidget(table);

      // THEN
      expect(widgetTester.takeException(), isInstanceOf<StateError>());
    });

    testWidgets(
        '$AdvancedTable - Column definition type and value type does not match',
        (widgetTester) async {
      // GIVEN
      final List<ColumnDefinition> definitions = [
        ColumnDefinition<String>(
            valueKey: 'value1', title: const Text('Value 1')),
        ColumnDefinition<int>(valueKey: 'value2', title: const Text('Value 1')),
      ];

      final List<Map<String, dynamic>> data = [
        {'value1': 'Hello', 'value2': 'World'},
        {'value1': 'Hallo', 'value2': 'World'},
      ];

      final AdvancedTable table =
          AdvancedTable(columnDefinitions: definitions, data: data);

      // WHEN
      await widgetTester.pumpWidget(table);

      // THEN
      expect(widgetTester.takeException(), isInstanceOf<StateError>());
    });

    testWidgets('$AdvancedTable - Column definition type not supported',
        (widgetTester) async {
      // GIVEN
      final List<ColumnDefinition> definitions = [
        ColumnDefinition<String>(
            valueKey: 'value1', title: const Text('Value 1')),
        ColumnDefinition<Map>(valueKey: 'value2', title: const Text('Value 1')),
      ];

      final List<Map<String, dynamic>> data = [
        {
          'value1': 'Hello',
          'value2': {},
        },
        {
          'value1': 'Hallo',
          'value2': {},
        },
      ];

      final AdvancedTable table =
          AdvancedTable(columnDefinitions: definitions, data: data);

      // WHEN
      await widgetTester.pumpWidget(table);

      // THEN
      expect(widgetTester.takeException(), isInstanceOf<StateError>());
    });
  });

  group('$AdvancedTable - Structural tests', () {
    testWidgets('$AdvancedTable - Basic table structure is created',
        (widgetTester) async {
      // GIVEN
      final List<ColumnDefinition> definitions = [
        ColumnDefinition<String>(
            valueKey: 'value1', title: const Text('Value 1')),
        ColumnDefinition<String>(
            valueKey: 'value2', title: const Text('Value 1')),
      ];

      final List<Map<String, dynamic>> data = [
        {
          'value1': 'Hello',
          'value2': 'World',
        },
        {
          'value1': 'Hallo',
          'value2': 'World',
        },
      ];

      final AdvancedTable table =
          AdvancedTable(columnDefinitions: definitions, data: data);

      final int expectedCells =
          definitions.length * data.length + definitions.length;

      // WHEN
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: table,
          ),
        ),
      );

      await widgetTester.pumpAndSettle();

      // THEN
      expect(find.byType(Table), findsOneWidget);
      expect(find.byType(TableCell), findsNWidgets(expectedCells));

      final Table displayedTable = widgetTester.firstWidget(find.byType(Table));
      final TableBorder expectedBorder = TableBorder.all();
      expect(displayedTable.border, expectedBorder);
    });
  });
}
