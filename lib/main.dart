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
  }

  int gren = 0;
  int red = 0;
  List<List<Offset>> linhas = [];
  List<Offset> pontos = [];
  List<double> col = [];
  List<double> row = [];
  List<Color> colors = [];
  List<Quadrado> quadrados = [];
  Color jogador = Colors.green;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    pontos.clear();
    col.clear();
    row.clear();
    for (double p = 50; p <= 350;) {
      for (double i = 170; i <= 650;) {
        pontos.add(Offset(p, i));
        col.add(i);
        i = i + 60;
      }

      row.add(p);
      p = p + 60;
    }

    final List<Widget> icones = [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                gren = 0;
                red = 0;
                linhas.clear();
                pontos.clear();
                col.clear();
                row.clear();
                colors.clear();
                quadrados.clear();
                jogador = Colors.green;
                setState(() {
                  update++;
                });
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
                size: 30,
              ))
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.square,
            size: 40,
            color: Colors.green,
          ),
          Text(' $gren - $red ',
              style: const TextStyle(color: Colors.black, fontSize: 30)),
          const Icon(
            Icons.square,
            size: 40,
            color: Colors.red,
          ),
        ],
      ),
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: CustomPaint(
            painter: FaceOutlinePainter(
                linhas: linhas,
                pontos: pontos,
                col: col,
                row: row,
                colors: colors,
                quadrados: quadrados),
            child: GestureDetector(
              onTapDown: (TapDownDetails details) {
                double dy = details.localPosition.dy;
                double dx = details.localPosition.dx;

                if (isVertical(details.localPosition)) {
                  setVertivcal(dx, dy);
                } else {
                  setHorizontal(dx, dy);
                }
              },
              child: CustomScrollView(slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return icones[index];
                  }, childCount: icones.length),
                )
              ]),
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

    if (dy <= 170 && dy <= 230) {
      dy = 170;
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

    if (dy >= 590 && dy <= 650) {
      dy = 590;
    }

    if (dy > 650) {
      dy = 650;
    }

    double dx2 = dx1 + 60;

    setJogada(Offset(dx1, dy), Offset(dx2, dy));
  }

  void setJogada(Offset first, Offset last) {
    if (linhas
        .where((element) => element.first == first && element.last == last)
        .isEmpty) {
      int count = quadrados.length;
      colors.add(jogador);
      linhas.add([first, last]);
      setQuadrado(first, last);
      if (count == quadrados.length) {
        jogador = jogador == Colors.green ? Colors.red : Colors.green;
      }
      setState(() {
        update++;
      });
    }
  }

  void setQuadrado(Offset first, Offset last) {
    setQuadradoDown(first, last);
    setQuadradoUp(first, last);
    setQuadradoLeft(first, last);
    setQuadradoRight(first, last);
  }

  void setQuadradoRight(Offset first, Offset last) {
    Offset pontoFirstRightLinha = Offset(first.dx - 60, first.dy);
    Offset pontoLastRightLinha = Offset(last.dx - 60, last.dy);

    Iterable<List<Offset>> quadrado = linhas.where((l) {
      bool l1 = l.first == pontoFirstRightLinha && l.last == first;
      bool l2 =
          l.first == pontoFirstRightLinha && l.last == pontoLastRightLinha;
      bool l3 = l.first == pontoLastRightLinha && l.last == last;
      return l1 || l2 || l3;
    });
    if (quadrado.length == 3) {
      setPontos();
      quadrados.add(Quadrado(color: jogador, ponto1: pontoFirstRightLinha));
    }
  }

  void setPontos() {
    if (jogador == Colors.green) {
      gren++;
    } else {
      red++;
    }
  }

  void setQuadradoLeft(Offset first, Offset last) {
    Offset pontoFirstLeftLinha = Offset(first.dx + 60, first.dy);
    Offset pontoLastLeftLinha = Offset(last.dx + 60, last.dy);

    Iterable<List<Offset>> quadrado = linhas.where((l) {
      bool l1 = l.first == first && l.last == pontoFirstLeftLinha;
      bool l2 = l.first == pontoFirstLeftLinha && l.last == pontoLastLeftLinha;
      bool l3 = l.first == last && l.last == pontoLastLeftLinha;
      return l1 || l2 || l3;
    });

    if (quadrado.length == 3) {
      setPontos();
      quadrados.add(Quadrado(color: jogador, ponto1: first));
    }
  }

  void setQuadradoUp(Offset first, Offset last) {
    Offset pontoFirstUpLinha = Offset(first.dx, first.dy - 60);
    Offset pontoLastUpLinha = Offset(last.dx, last.dy - 60);

    Iterable<List<Offset>> quadrado = linhas.where((l) {
      bool l1 = l.first == pontoFirstUpLinha && l.last == first;
      bool l2 = l.first == pontoFirstUpLinha && l.last == pontoLastUpLinha;
      bool l3 = l.first == pontoLastUpLinha && l.last == last;
      return l1 || l2 || l3;
    });

    if (quadrado.length == 3) {
      setPontos();
      quadrados.add(Quadrado(color: jogador, ponto1: pontoFirstUpLinha));
    }
  }

  void setQuadradoDown(Offset first, Offset last) {
    Offset pontoFirstDownLinha = Offset(first.dx, first.dy + 60);
    Offset pontoLastDownLinha = Offset(last.dx, last.dy + 60);

    Iterable<List<Offset>> quadrado = linhas.where((l) {
      bool l1 = l.first == first && l.last == pontoFirstDownLinha;
      bool l2 = l.first == pontoFirstDownLinha && l.last == pontoLastDownLinha;
      bool l3 = l.first == last && l.last == pontoLastDownLinha;
      return l1 || l2 || l3;
    });

    if (quadrado.length == 3) {
      setPontos();
      quadrados.add(Quadrado(color: jogador, ponto1: first));
    }
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

    if (dy1 <= 170 && dy1 <= 230) {
      dy1 = 170;
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

    if (dy1 >= 530 && dy1 <= 590) {
      dy1 = 530;
    }

    if (dy1 >= 590 && dy1 <= 650) {
      dy1 = 590;
    }

    if (dy1 >= 650) {
      dy1 = 590;
    }

    double dy2 = dy1 + 60;

    setJogada(Offset(dx, dy1), Offset(dx, dy2));
  }
}

class FaceOutlinePainter extends CustomPainter {
  FaceOutlinePainter({
    required this.linhas,
    required this.pontos,
    required this.row,
    required this.col,
    required this.colors,
    required this.quadrados,
  }) : super();

  final List<List<Offset>> linhas;
  final List<Offset> pontos;
  final List<double> row;
  final List<double> col;
  final List<Color> colors;
  final List<Quadrado> quadrados;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..color = Colors.grey;

    var paint4 = Paint()
      ..style = PaintingStyle.fill
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

    for (int l = 0; l < linhas.length; l++) {
      paint.color = colors[l];
      canvas.drawLine(linhas[l].first, linhas[l].last, paint);
    }

    for (int q = 0; q < quadrados.length; q++) {
      paint4.color = quadrados[q].color;
      canvas.drawRect(quadrados[q].ponto1 & const Size(60, 60), paint4);
    }
  }

  @override
  bool shouldRepaint(FaceOutlinePainter oldDelegate) => true;
}

class Quadrado {
  const Quadrado({required this.color, required this.ponto1}) : super();

  final Offset ponto1;
  final Color color;
}
