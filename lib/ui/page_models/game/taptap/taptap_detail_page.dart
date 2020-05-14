import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learn_english/core/models/vocabulary.dart';
import 'package:learn_english/ui/page_models/game/taptap/end_game_page.dart';
import 'package:learn_english/ui/page_models/game/taptap/state/level_state.dart';
import 'package:provider/provider.dart';

class TapTapDetailPage extends StatelessWidget {
  List<Vocabulary> vocabList;
  TapTapDetailPage({this.vocabList});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LevelState(vocabList: vocabList),
        ),
      ],
      child: TapTapDetail(),
    );
  }
}

class TapTapDetail extends StatefulWidget {
  TapTapDetailState createState() => TapTapDetailState();
}

class TapTapDetailState extends State<TapTapDetail>
    with TickerProviderStateMixin {
  AnimationController animationController;

  String get timerString {
    Duration duration =
        animationController.duration * animationController.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 150));
    startTime();
  }

  void startTime() {
    if (!animationController.isAnimating) {
      animationController.reverse(
          from: animationController.value == 0.0
              ? 1.0
              : animationController.value);
    }
  }

  void stopTime() {
    if (animationController.isAnimating) {
      animationController.stop();
    }
  }

  Future<bool> onWillPop() {
    Fluttertoast.showToast(msg: "Press 'Close' button to quit");
    return Future.value(false);
  }

  @override
  Widget build(BuildContext context) {
    LevelState levelState = Provider.of<LevelState>(context);

    if (levelState.getIsFinish || animationController.value == 0.00)
      return EndGamePage();
    if (levelState.getIsFalse)
      stopTime();
    else
      startTime();

    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.green[100],
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset('assets/bg.jpg').image,
                    fit: BoxFit.cover),
              ),
            ),
            SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  'Close',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height: 140,
                                width: MediaQuery.of(context).size.width,
                                child: Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Align(
                                          alignment: FractionalOffset.center,
                                          child: AspectRatio(
                                            aspectRatio: 1.0,
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned.fill(
                                                  child: AnimatedBuilder(
                                                    animation:
                                                        animationController,
                                                    builder:
                                                        (BuildContext context,
                                                            Widget child) {
                                                      return CustomPaint(
                                                        painter: TimerPainter(
                                                          animation:
                                                              animationController,
                                                          backgroundColor:
                                                              Colors.white,
                                                          // color: Theme.of(context).accentColor),
                                                          color:
                                                              Colors.orange[700],
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      FractionalOffset.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      AnimatedBuilder(
                                                          animation:
                                                              animationController,
                                                          builder: (_,
                                                              Widget child) {
                                                            return Text(
                                                              timerString,
                                                              style: TextStyle(
                                                                  color: (animationController.value == 0.00)
                                                                      ? Colors
                                                                          .orange[700]
                                                                      : Colors
                                                                          .white,
                                                                  fontSize: 35,
                                                                  ),
                                                            );
                                                          })
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Level: ${levelState.getCurrentLevel}',
                                style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Arial'),
                              ),
                            ),
                            levelState.getCurWidget
                          ],
                        ),
                      ],
                    ),
                  ),
                  (levelState.getIsFalse)
                      ? AlertDialog(
                          content: Container(
                            height: 200,
                            alignment: Alignment.center,
                            child: Column(children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: Image.asset('assets/oh_no.jpg')
                                            .image),
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                    style: GoogleFonts.handlee(
                                        textStyle: TextStyle(
                                            color: Colors.blue, fontSize: 18)),
                                    children: <TextSpan>[
                                      TextSpan(text: 'Do you want to trade '),
                                      TextSpan(
                                        text: '${100} ',
                                        style: TextStyle(
                                            color: Colors.orange[300],
                                            fontSize: 25),
                                      ),
                                      TextSpan(
                                        text: 'EXP ',
                                        style: TextStyle(
                                            color: Colors.green[300],
                                            fontSize: 25),
                                      ),
                                      TextSpan(text: 'to continue?'),
                                    ]),
                              ),
                            ]),
                          ),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                levelState.backToPreState();
                              },
                              child: Text('Yes'),
                            ),
                            FlatButton(
                              onPressed: () {},
                              child: Text('No'),
                            ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerPainter extends CustomPainter {
  final Animation<double> animation;
  final Color backgroundColor;
  final Color color;

  TimerPainter({this.animation, this.backgroundColor, this.color})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * pi;
    canvas.drawArc(Offset.zero & size, pi * 1.5, -progress, false, paint);
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
