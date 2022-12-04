import 'package:advanced_table/advanced_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('$AdvancedTable error tests', () {
    test('$AdvancedTable count of definitions does not match count of keys of map entry', () {
      final List<ColumnDefinition> definitions = [
        ColumnDefinition<String>(valueKey: 'value1', title: const Text('Value 1')),
        ColumnDefinition<String>(valueKey: 'value2', title: const Text('Value 2')),
      ];

      final List<Map<String, dynamic>> data = [
        {'value1': 'Hello', 'value2': 'World'},
        {'value1': 'Hallo'},
      ];

      expect(() => AdvancedTable(columnDefinitions: definitions, data: data), throwsA(isA<StateError>()));
    });
  });
}
