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
            ColumnDefinition<Gender>(
                valueKey: 'gender', title: const Text('Gender')),
            ColumnDefinition<List<String>>(
                valueKey: 'favouriteFood', title: const Text('Favourite Food')),
          ],
          data: <Person>[
            Person(
                age: 17,
                firstName: 'Hallo',
                lastName: 'Welt',
                gender: Gender.male,
                favouriteFood: ['This', 'That']),
            Person(
                age: 17,
                firstName: 'Hallo',
                lastName: 'Welt',
                gender: Gender.male,
                favouriteFood: ['This', 'That']),
            Person(
                age: 17,
                firstName: 'Hallo',
                lastName: 'Welt',
                gender: Gender.male,
                favouriteFood: ['This', 'That']),
            Person(
                age: 17,
                firstName: 'Hallo',
                lastName: 'Welt',
                gender: Gender.male,
                favouriteFood: ['This', 'That'])
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
  Gender gender;
  List<String> favouriteFood;

  Person({
    required this.age,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.favouriteFood,
  });

  Map<String, dynamic> toJson() => {
        'age': age,
        'firstName': firstName,
        'lastName': lastName,
        'gender': gender,
        'favouriteFood': favouriteFood,
      };
}

enum Gender {
  male,
  female,
  diverse,
}
