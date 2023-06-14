import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studied/hive/hive_favorite.dart';
import 'package:studied/models/EnglishWord.dart';
import 'package:studied/packages/quote.dart';
import 'package:studied/pages/landing_page.dart';
import 'package:studied/styles/AppStyles.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Quotes().getAll();
  // initHive();
  await Hive.initFlutter();
  Hive.registerAdapter(EnglishWordAdapter());
  await Hive.openBox<EnglishWord>("favorite");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Colors.lightBlue
      ),
      home: const LandingPage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), onPressed: () {  },
        ),
        title: const Text("Studied Flutter"),
      ),
      body: Container(
        child: Wrap(
          direction: Axis.vertical,
          children: [
            Expanded(
              child: Container(
                color: Colors.lightBlue,
                child: Text("nguyên là nhất", style: TextStyle(color: Colors.red, fontSize: 20),),
              ),
            ),
            Container(
              width: 200,
              height: 100,
              color: Colors.red,
            ),
            Container(
              child: Text("nguyên là nhất", style: TextStyle(color: Colors.red, fontSize: 20),),
            ),
          ],
        ),
      ),
    );

  }

}



class MyHomePage1 extends StatefulWidget {
  const MyHomePage1({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage1> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage1> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: AppStyles.h3.copyWith(color: Colors.blue),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
