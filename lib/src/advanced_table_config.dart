/// Pass configuration parameters to `AdvancedTable`.
///
/// ```
/// final config = AdvancedTableConfig(listSeparator: ';', listWrapper: ListWrapper.curly);
/// ```
class AdvancedTableConfig {
  /// Separator for a `ColumnDefinition` with type `List`.
  ///
  /// Default is ','
  final String listSeparator;

  /// Wrapper characters around the list e.g. `(1, 2, 3)`.
  ///
  /// Default is [ListWrapper.square]
  final ListWrapper listWrapper;

  const AdvancedTableConfig({
    this.listSeparator = ',',
    this.listWrapper = ListWrapper.square,
  });
}

/// Define the brackets used when displaying a `List` in a cell
enum ListWrapper {
  parentheses,
  curly,
  square;

  /// Return the left (starting) character
  String get left {
    switch (this) {
      case ListWrapper.parentheses:
        return '(';
      case ListWrapper.curly:
        return '{';
      case ListWrapper.square:
        return '[';
    }
  }

  /// Return the right (ending) character
  String get right {
    switch (this) {
      case ListWrapper.parentheses:
        return ')';
      case ListWrapper.curly:
        return '}';
      case ListWrapper.square:
        return ']';
    }
  }
}
