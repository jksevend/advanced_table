import 'package:advanced_table/advanced_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('$ColumnDefinition - Type is nullable or not', () {
    // GIVEN
    final ColumnDefinition<int?> nullableDefinition = ColumnDefinition(
        valueKey: 'valueKey1', title: 'Value Key 1');
    final ColumnDefinition<int> notNullableDefinition = ColumnDefinition(
        valueKey: 'valueKey1', title: 'Value Key 1');

    // WHEN - THEN
    expect(nullableDefinition.isNullable, true);
    expect(notNullableDefinition.isNullable, false);
  });
}
