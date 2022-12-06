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
        body: AdvancedTable<Person>(columnDefinitions: [
          ColumnDefinition<int>(
              valueKey: 'age', title: const Text('Age'), valueAlignment: TextAlign.center),
          ColumnDefinition<String>(
              valueKey: 'firstName',
              title: const Text('First name'),
              valueAlignment: TextAlign.center),
          ColumnDefinition<String>(
              valueKey: 'lastName',
              title: const Text('Last name'),
              valueAlignment: TextAlign.center),
          ColumnDefinition<Gender>(
              valueKey: 'gender',
              title: const Text('Gender'),
              valueAlignment: TextAlign.center),
          ColumnDefinition<List<String>?>(
              valueKey: 'food',
              title: const Text('Favourite Food'),
              valueAlignment: TextAlign.center),
        ], data: <Person>[
          Person(age: 17, firstName: 'Hallo', lastName: 'Welt', gender: Gender.male, food: null),
          Person(
              age: 17,
              firstName: 'Hallo',
              lastName: 'Welt',
              gender: Gender.male,
              food: List.of(['this', 'that'])),
          Person(
              age: 17,
              firstName: 'Hallo',
              lastName: 'Welt',
              gender: Gender.male,
              food: List.of(['this', 'that'])),
          Person(
              age: 17,
              firstName: 'Hallo',
              lastName: 'Welt',
              gender: Gender.male,
              food: List.of(['this', 'that']))
        ]),
      ),
    );
  }
}

class Person {
  int age;
  String firstName;
  String lastName;
  Gender gender;
  List<String>? food;

  Person({
    required this.age,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.food,
  });

  Map<String, dynamic> toJson() => {
    'age': age,
    'firstName': firstName,
    'lastName': lastName,
    'gender': gender,
    'food': food,
  };
}

enum Gender { male, female, diverse, }
