import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyCustomForm extends ConsumerStatefulWidget {
  const MyCustomForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyCustomFormState();
}

//TODO: Maybe use a provider to achieve this?
class _MyCustomFormState extends ConsumerState<MyCustomForm> {
  final myController = TextEditingController();
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.blueGrey[100],
          padding: const EdgeInsets.all(50.0),
          margin: const EdgeInsets.all(40.0),
          height: 200.0,
          width: 500,
          child: Text(myController.text),
          // alignment: Alignment.center,
        ),
        TextField(
          controller: myController,
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                text = myController.text;
              });
            },
            child: const Text("Submit")),
      ],
    );
  }

  @override
  void dispoose() {
    myController.dispose();
    super.dispose();
  }
}

// provider that returns a string value
final helloWorldProvider = Provider<String>((ref) {
  return "Hello World";
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final testStr = ref.watch(helloWorldProvider);

    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green,
              title: const Text('My First App'),
            ),
            body: const Center(
              child: Padding(
                padding: EdgeInsets.all(100.0),
                child: Column(
                  children: [MyCustomForm()],
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  label: 'School',
                ),
              ],
            ),
            drawer: AboutDialog(
              applicationName: 'My First App',
              applicationVersion: '1.0.0',
              applicationIcon: const Icon(Icons.ac_unit),
              children: [
                Text(testStr),
              ],
            )));
  }
}
