import 'package:advanced_table/src/advanced_table.dart';
import 'package:advanced_table/src/column_definition.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      home: Scaffold(
        body: AdvancedTable(
          columnDefinitions: [
            ColumnDefinition<int>(valueKey: 'age', title: const Text('Age')),
            ColumnDefinition<String>(
                valueKey: 'firstName', title: const Text('First name')),
            ColumnDefinition<String>(
                valueKey: 'lastName', title: const Text('Last name')),
          ],
          data: <Person>[
            Person(age: 17, firstName: 'Hallo', lastName: 'Welt'),
            Person(age: 17, firstName: 'Hallo', lastName: 'Welt'),
            Person(age: 17, firstName: 'Hallo', lastName: 'Welt'),
            Person(age: 17, firstName: 'Hallo', lastName: 'Welt')
          ].map((person) => person.toJson()).toList(),
        ),
      ),
    );
  }
}

class Person {
  int age;
  String firstName;
  String lastName;

  Person({
    required this.age,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() =>
      {'age': age, 'firstName': firstName, 'lastName': lastName};
}
