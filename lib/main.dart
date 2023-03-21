import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Name App',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favourites = <WordPair>[];

  void toogleFavourite() {
    if (favourites.contains(current)) {
      favourites.remove(current);
    } else {
      favourites.add(current);
    }
    print(favourites);
    notifyListeners();
  }

  void removeFavorite(int index) {
    favourites.removeAt(index);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  Widget page = GeneratorPage();

  @override
  Widget build(BuildContext context) {
    switch (selectedIndex) {
      case 0:
        {
          page = GeneratorPage();
        }
        break;
      case 1:
        {
          page = PlaceHolder();
        }
        break;
      case 2:
        {
          page = FormStudent();
        }
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return Scaffold(
      body: Row(
        children: [
          SafeArea(
              child: NavigationRail(
            extended: false,
            destinations: [
              NavigationRailDestination(
                  icon: Icon(Icons.home), label: Text('Home')),
              NavigationRailDestination(
                  icon: Icon(Icons.list_alt), label: Text('List')),
              NavigationRailDestination(
                  icon: Icon(Icons.person), label: Text('New Student'))
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          )),
          Expanded(
              child: Container(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: page,
          ))
        ],
      ),
    );
  }
}

class PlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favourites = appState.favourites;
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          // return Container(
          //   height: 50,
          //   color: Theme.of(context).primaryColor,
          //   child: Row(
          //     children: [
          //       Text('${favourites[index]}'),
          //       ElevatedButton.icon(
          //           onPressed: () {
          //             appState.removeFavorite(index);
          //           },
          //           icon: Icon(Icons.delete_outline),
          //           label: Text('Unfavorite'))
          //     ],
          //   ),
          // );
          return ListTile(
            leading: Icon(Icons.favorite),
            title: Text('${favourites[index]}'),
            trailing: ElevatedButton.icon(
                onPressed: () {
                  appState.removeFavorite(index);
                },
                icon: Icon(Icons.delete_outline),
                label: Text('Unfavorite')),
          );
        },
      ),
    );
  }
}

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    IconData icon;
    if (appState.favourites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border_outlined;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text('A random idea: '),
          BigCard(pair: pair),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () => appState.toogleFavourite(),
                icon: Icon(
                  icon,
                  color: Colors.green,
                ),
                label: Text('Like'),
              ),
              SizedBox(
                width: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  print('button pressed');
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!
        .copyWith(color: theme.colorScheme.onPrimary);
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asCamelCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
