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
  int update = 0;

  @override
  void initState() {
    super.initState();
    update = 0;
    jogador = Colors.green;
  }

  List<List<Offset>> linhas = [];
  List<Offset> pontos = [];
  List<double> col = [];
  List<double> row = [];
  List<Color> colors = [];

  Color jogador = Colors.green;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    pontos.clear();
    col.clear();
    row.clear();
    for (double p = 50; p <= 350;) {
      for (double i = 50; i <= 530;) {
        pontos.add(Offset(p, i));
        col.add(i);
        i = i + 60;
      }

      row.add(p);
      p = p + 60;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: CustomPaint(
            painter: FaceOutlinePainter(
                linhas: linhas, pontos: pontos, col: col, row: row,colors: colors),
            child: GestureDetector(
              onTapDown: (TapDownDetails details) {
                double dy = details.localPosition.dy;
                double dx = details.localPosition.dx;

                if (isVertical(details.localPosition)) {
                  setVertivcal(dx, dy);
                } else {
                  setHorizontal(dx, dy);
                }

                colors.add(jogador);
                Color newJogador = jogador == Colors.green ?Colors.red:Colors.green;
                setState(() {
                  jogador = newJogador;
                  update++;
                });
              },
            )));
  }

  bool isVertical(Offset position) {
    double dx = position.dx;

    return row.where((e) {
      double prev = e - 15;
      double next = e + 15;
      if (prev <= dx && next >= dx) {
        return true;
      }
      return false;
    }).isNotEmpty;
  }

  void setHorizontal(double dx1, double dy) {
    if (dx1 <= 50 || dx1 <= 110) {
      dx1 = 50;
    }

    if (dx1 >= 110 && dx1 <= 170) {
      dx1 = 110;
    }

    if (dx1 >= 170 && dx1 <= 230) {
      dx1 = 170;
    }

    if (dx1 >= 230 && dx1 <= 290) {
      dx1 = 230;
    }

    if (dx1 >= 290 && dx1 <= 350) {
      dx1 = 290;
    }

    if (dx1 >= 350) {
      dx1 = 290;
    }

    if (dy <= 50 || dy <= 110) {
      dy = 50;
    }

    if (dy >= 110 && dy <= 170) {
      dy = 110;
    }

    if (dy >= 170 && dy <= 230) {
      dy = 170;
    }

    if (dy >= 230 && dy <= 290) {
      dy = 230;
    }

    if (dy >= 290 && dy <= 350) {
      dy = 290;
    }

    if (dy >= 350 && dy <= 410) {
      dy = 350;
    }

    if (dy >= 410 && dy <= 470) {
      dy = 410;
    }

    if (dy >= 470 && dy <= 530) {
      dy = 470;
    }

    if (dy >= 530 && dy <= 590) {
      dy = 530;
    }

    if (dy > 530) {
      dy = 530;
    }

    double dx2 = dx1 + 60;

    linhas.add([Offset(dx1, dy), Offset(dx2, dy)]);
  }

  void setVertivcal(double dx, double dy1) {
    if (dx <= 50 || dx <= 110) {
      dx = 50;
    }

    if (dx >= 110 && dx <= 170) {
      dx = 110;
    }

    if (dx >= 170 && dx <= 230) {
      dx = 170;
    }

    if (dx >= 230 && dx <= 290) {
      dx = 230;
    }

    if (dx >= 290 && dx <= 350) {
      dx = 290;
    }

    if (dx >= 350 && dx <= 410) {
      dx = 350;
    }

    if (dx >= 410) {
      dx = 410;
    }

    if (dy1 <= 50 || dy1 <= 110) {
      dy1 = 50;
    }

    if (dy1 >= 110 && dy1 <= 170) {
      dy1 = 110;
    }

    if (dy1 >= 170 && dy1 <= 230) {
      dy1 = 170;
    }

    if (dy1 >= 230 && dy1 <= 290) {
      dy1 = 230;
    }

    if (dy1 >= 290 && dy1 <= 350) {
      dy1 = 290;
    }

    if (dy1 >= 350 && dy1 <= 410) {
      dy1 = 350;
    }

    if (dy1 >= 410 && dy1 <= 470) {
      dy1 = 410;
    }

    if (dy1 >= 470 && dy1 <= 530) {
      dy1 = 470;
    }

    if (dy1 >= 470) {
      dy1 = 470;
    }

    double dy2 = dy1 + 60;

    linhas.add([Offset(dx, dy1), Offset(dx, dy2)]);
  }
}

class FaceOutlinePainter extends CustomPainter {
  FaceOutlinePainter(
      {required this.linhas,
      required this.pontos,
      required this.row,
      required this.col, required this.colors,})
      : super();

  final List<List<Offset>> linhas;
  final List<Offset> pontos;
  final List<double> row;
  final List<double> col;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.grey;

    var paint2 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0
      ..color = Colors.black;

    var paint3 = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.grey;

    for (Offset ponto in pontos) {
      for (double c in col) {
        canvas.drawLine(ponto, Offset(ponto.dx, c), paint3);
      }

      for (double r in row) {
        canvas.drawLine(ponto, Offset(r, ponto.dy), paint3);
      }
    }

    for (Offset ponto in pontos) {
      canvas.drawCircle(ponto, 10, paint2);
    }

    for (int l = 0;  l < linhas.length; l++) {
      paint.color = colors[l];
      canvas.drawLine(linhas[l].first, linhas[l].last, paint);
    }
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => true;
}
