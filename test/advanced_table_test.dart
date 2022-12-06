import 'package:advanced_table/advanced_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data.dart';

void main() {
  group('$AdvancedTable - Error tests', () {
    test(
        '$AdvancedTable - Count of definitions does not match count of keys of map entry',
        () {
      // GIVEN
      final List<ColumnDefinition> definitions = [
        ColumnDefinition<String>(
            valueKey: 'valueOne', title: const Text('Value 1')),
        ColumnDefinition<String>(
            valueKey: 'valueTwo', title: const Text('Value 2')),
        ColumnDefinition<String>(valueKey: 'nan', title: const Text('Nan'))
      ];

      final List<TestData> testData = [
        TestData(valueOne: 'Hello', valueTwo: 'World'),
      ];

      // WHEN - THEN
      expect(
          () => AdvancedTable<TestData>(
              columnDefinitions: definitions, data: testData),
          throwsA(isA<StateError>()));
    });

    test('$AdvancedTable - Generic type does not have toJson method', () {
      // GIVEN
      final List<ColumnDefinition> definitions = [
        ColumnDefinition<String>(
            valueKey: 'valueOne', title: const Text('Value 1')),
        ColumnDefinition<String>(
            valueKey: 'valueTwo', title: const Text('Value 2')),
        ColumnDefinition<String>(valueKey: 'nan', title: const Text('Nan'))
      ];

      final List<TestDataNoToJson> testData = [
        TestDataNoToJson(valueOne: 'Hello', valueTwo: 'World'),
      ];

      // WHEN - THEN
      expect(
          () => AdvancedTable<TestDataNoToJson>(
              columnDefinitions: definitions, data: testData),
          throwsA(isA<NoSuchMethodError>()));
    });

    testWidgets('$AdvancedTable - Column definition not found',
        (widgetTester) async {
      // GIVEN
      final List<ColumnDefinition> definitions = [
        ColumnDefinition<String>(
            valueKey: 'valueOne', title: const Text('Value 1')),
        ColumnDefinition<String>(
            valueKey: 'value32', title: const Text('Value 1')),
      ];

      final List<TestData> testData = [
        TestData(valueOne: 'Hello', valueTwo: 'World'),
      ];

      final AdvancedTable table =
          AdvancedTable(columnDefinitions: definitions, data: testData);

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
            valueKey: 'valueOne', title: const Text('Value 1')),
        ColumnDefinition<int>(
            valueKey: 'valueTwo', title: const Text('Value 1')),
      ];

      final List<TestData> testData = [
        TestData(valueOne: 'Hello', valueTwo: 'World'),
      ];

      final AdvancedTable table =
          AdvancedTable(columnDefinitions: definitions, data: testData);

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
            valueKey: 'valueOne', title: const Text('Value 1')),
        ColumnDefinition<Map>(
            valueKey: 'valueTwo', title: const Text('Value 1')),
      ];

      final List<TestData> testData = [
        TestData(valueOne: 'Hello', valueTwo: 'World'),
      ];

      final AdvancedTable table =
          AdvancedTable(columnDefinitions: definitions, data: testData);

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
            valueKey: 'valueOne', title: const Text('Value 1')),
        ColumnDefinition<String>(
            valueKey: 'valueTwo', title: const Text('Value 1')),
      ];

      final List<TestData> testData = [
        TestData(valueOne: 'Hello', valueTwo: 'World'),
        TestData(valueOne: 'Hello', valueTwo: 'World'),
      ];

      final AdvancedTable table =
          AdvancedTable(columnDefinitions: definitions, data: testData);

      final int expectedCells =
          definitions.length * testData.length + definitions.length;

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
