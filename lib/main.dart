import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'DragDrop Test'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: GridView.count(
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              crossAxisCount: 3,
              children: List.generate(12, (index) => Case(key: GlobalKey())),
            ),
          ),
          Container(
            height: 150,
            child: BoxDrag(
              key: GlobalKey(),
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Case extends StatefulWidget {
  const Case({Key? key}) : super(key: key);

  @override
  State<Case> createState() => _CaseState();
}

class _CaseState extends State<Case> {
  Box? child;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Box>(
      builder: (context, List<Object?> candidateData, rejectedData) {
        if (child != null) {
          return child!;
        }
        return Container(
          color: Colors.yellow,
        );
      },
      onAccept: (box) {
        setState(() {
          child = box;
        });
      },
      onWillAccept: (box) => true,
    );
  }
}

class Box extends StatelessWidget {
  const Box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      color: Colors.blue,
    );
  }
}

class BoxDrag extends StatelessWidget {
  const BoxDrag({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Draggable(
        data: Box(),
        child: Box(),
        feedback: Box(),
        childWhenDragging: Box(),
      ),
    );
  }
}
