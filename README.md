# Advanced table
[![Tests](https://github.com/jksevend/advanced_table/actions/workflows/tests.yaml/badge.svg)](https://github.com/jksevend/advanced_table/actions/workflows/tests.yaml)
[![Analyze](https://github.com/jksevend/advanced_table/actions/workflows/analyze.yaml/badge.svg)](https://github.com/jksevend/advanced_table/actions/workflows/analyze.yaml)
> **NOTE**: 🚧 Under active development. 🚧

A table widget providing advanced functionality and easier use by allowing the generic display of objects 
in their JSON representation.

## Table of contents
* [Getting started](#getting-started)
* [Showcase](#showcase)
* [Usage](#usage)
    * [Actions](#actions)
    * [Links](#links)
    * [Null values](#null-values)
    * [Ignore values](#ignore-values)
    * [List display text](#list-display-text)
* [Limitations](#limitations)
* [Future Updates](#future-updates)
* [Bugs](#bugs-errors-etc)

## Getting started
First add the dependency into your ```pubspec.yaml```:
```
dependencies:
    advanced_table: ^1.1.0
```

**OR**
Add the dependency via terminal:
```
flutter pub add advanced_table
```

When making use of the package:
```
import 'package:advanced_table/advanced_table.dart';
```

## Showcase
<a href="https://ibb.co/SXjKtz1"><img src="https://i.ibb.co/bg0rsky/Screenshot-2022-12-10-123809.png" alt="Screenshot-2022-12-10-123809" border="0"></a>
## Usage
Since the table works by providing generic data, create a simple data class. Make sure you provide a ``toJson`` method or otherwise the table won't work due to limitation with reflection in Flutter:
```
class Person {
  int age;
  String firstName;
  String lastName;
  List<String> favouriteFood;
  
  Person({
    required this.age,
    required this.firstName,
    required this.lastName,
    required this.favouriteFood,
  });

  Map<String, dynamic> toJson() => {
        'age': age,
        'firstName': firstName,
        'lastName': lastName,
        'favouriteFood': favouriteFood,
      };
}
```

Once you created a data class you can go on with ``AdvancedTable``. The idea here is that obviously somehow you want to 
pass a list of your objects. However, in addition to that you provide a ``ColumnDefinition`` for each field in the
``Person`` class. Make sure that the ``valueKey`` property matches the key of an entry in ``Person#toJson``.
```
return MaterialApp(
      title: 'Example',
      home: Scaffold(
        body: AdvancedTable<Person>(
          columnDefinitions: [
            ColumnDefinition<int>(valueKey: 'age', title: const Text('Age')),
            ColumnDefinition<String>(
                valueKey: 'firstName', title: const Text('First name')),
            ColumnDefinition<String>(
                valueKey: 'lastName', title: const Text('Last name')),
            ColumnDefinition<List<String>>(
                valueKey: 'favouriteFood', title: const Text('Favourite Food')),
          ],
          data: <Person>[
            Person(
                age: 17,
                firstName: 'John',
                lastName: 'Smith',
                favouriteFood: ['Burger', 'Pizza']),
            Person(
                age: 17,
                firstName: 'Helena',
                lastName: 'Morgan',
                favouriteFood: ['Sushi', 'Pizza']),
          ],
        ),
      ),
    );
```

### Actions
Space above the header row of an ``AdvancedTable`` where utility widgets can be placed:

```
AdvancedTable<Person>(
          columnDefinitions: ...,
          data: ...,
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.sort)),
          ]
        ),
```

### Links
The possibility exists to make cell values clickable by passing ``isLink`` to a 
``ColumnDefinition``. You may also want to define a ``linkValueClicked`` to respond to the link being 
clicked. This is default behaviour for ``Uri`` types.

Example:
```
ColumnDefinition<String>(
            valueKey: 'id',
            title: 'User ID',
            isLink: true,
            linkValueClicked: (value) {
                print('I was clicked');
              },
          ),
```


### Null Values
The ``AdvancedTable`` can display ``null`` values too. Just make sure to make your type nullable for a ``ColumnDefinition``:
```
ColumnDefinition<List<String>?>(
    valueKey: 'favouriteFood', title: const Text('Favourite Food')),
```
You can also configure a ``NullValueStrategy`` to customize the text displayed when a value is null.
By default ``NullValueStrategy.hyphen`` is used.

### Ignore values
You have the possibility to ignore entries of the ``Person#toJson`` map. Just be sure to provide **NO** ``ColumnDefinition``
for this field and add it's key to ``ignoringKeys`` when creating a table:

```
AdvancedTable<Person>(
          /// ! Make sure to not provide a definition !
          columnDefinitions: ...,
          data: ...,
          ignoringKeys: const <String>['firstName'],
        ),
```

### List Display Text
When defining a ``ColumnDefinition<List>`` you can configure the way the displayed text in a cell looks.
Right now the ``listSeparator`` and the ``listBrackets`` can be customized. By default ``ListSeparator.comma`` and
``ListBrackets.square`` are used.

Just pass your desired values when creating an ``AdvancedTable``:
```
AdvancedTable<Person>(
          columnDefinitions: ...,
          data: ...,
          listSeparator: ListSeparator.semicolon,
          listBrackets: ListBrackets.curly,
        ),
```


## Limitations
For now only ``String``, ``num``, ``Enum``, ``DateTime``, ``Uri`` and ``List`` types are available for a ``ColumnDefinition``.

Up to this point ([v1.1.0](https://github.com/jksevend/advanced_table/releases/tag/advanced_table-v1.1.0)) 
no searching/editing/sorting/filtering of data is possible but will follow in future updates.
## Future Updates
The plan right now is to add support to:
* Search, filter and order data
* Make data editable
* Move the order of columns
* Styling customizations
* Render conditional ``Icon`` or ``Widget`` inside cell

To stay updated on the progress visit the [Advanced Table Project Board](https://github.com/users/jksevend/projects/11)


## Bugs, Errors, etc
If you find any weird behaviour, bugs or errors please let me know by opening an [issue](https://github.com/jksevend/advanced_table/issues).
Also, an image or a gif will help a lot if the UI behaves differently.