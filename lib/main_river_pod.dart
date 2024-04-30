import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class WordGenerator extends Notifier<String> {
  @override
  build() {
    return 'abcd';
  }

  void refresh() {
    state = WordPair.random().asCamelCase;
  }
}

// notifier generates stuff and holds the state, provider is an instance of notifier (because notifier is a class), the consumer consumes notifier
final WordProvider = NotifierProvider<WordGenerator, String>(WordGenerator.new);

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final word = ref.watch(WordProvider);
    return MaterialApp(
      title: "My RiverPod App",
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
          useMaterial3: true),
      home: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.favorite),
                  label: Text('Favorites'),
                ),
              ],
              selectedIndex: 0,
            ),
            VerticalDivider(thickness: 1, width: 1),
            Expanded(
              child: Center(
                child: Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        // color: Theme.of(context).colorScheme.primary,
                        color: Theme.of(context).primaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(100.0),
                          child: Text(
                            word,
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                              label: Text('like'),
                              onPressed: () {},
                              icon: Icon(Icons.favorite)),
                          ElevatedButton.icon(
                            // Both works, what's the difference here?
                            // onPressed: () =>ref.read(WordProvider.notifier).refresh(),
                            onPressed: ref.read(WordProvider.notifier).refresh,
                            icon: Icon(Icons.refresh),
                            label: Text("refresh"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
