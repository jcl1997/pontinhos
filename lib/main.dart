import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pontinhos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Pontinhos'),
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GestureDetector(
            onVerticalDragStart: (DragStartDetails details) {
              print('VERTICAL');
              print('dx:: ${details.globalPosition.dx}');
              print('dy:: ${details.globalPosition.dy}');
              print('direction:: ${details.globalPosition.direction}');
              print('distance:: ${details.globalPosition.distance}');
            },
            onHorizontalDragStart: (DragStartDetails details) {
              print('HORIZONTAL');
              print('dx:: ${details.globalPosition.dx}');
              print('dy:: ${details.globalPosition.dy}');
              print('direction:: ${details.globalPosition.direction}');
              print('distance:: ${details.globalPosition.distance}');
            },
            child: CustomPaint(
                painter: FaceOutlinePainter(),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 30,
                    mainAxisExtent: 30,
                    mainAxisSpacing: 30.0,
                    crossAxisSpacing: 30.0,
                  ),
                  itemCount: (size.width / 8).ceil() + 4,
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  itemBuilder: (BuildContext context, int index) {
                    return const Icon(Icons.circle, size: 10);
                  },
                ))));
  }
}

class FaceOutlinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.grey;
    canvas.drawLine(Offset(20.2, 20.2), Offset(50.5, 20.2), paint);
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => false;
}
