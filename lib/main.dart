import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ffi.dart' if (dart.library.html) 'ffi_web.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: CalculatorMainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class CalculatorMainPage extends StatefulWidget {
  const CalculatorMainPage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<CalculatorMainPage> createState() => _CalculatorMainPageState();
}

class _CalculatorMainPageState extends State<CalculatorMainPage> {
  // These futures belong to the state and are only initialized once,
  // in the initState method.
  late Expr expr;
  late String result;
  late bool isResult;
  late ScrollController exprController;
  late ScrollController resultController;
  late PageController inputPadController;
  late List<(Expr, String)> history;
  @override
  void initState() {
    super.initState();
    inputPadController = PageController(initialPage: 1);
    expr = Expr(exprList: [], lBracketCount: 0, rBracketCount: 0);
    result = "";
    resultController = ScrollController();
    exprController = ScrollController();
    isResult = false;
    getTemporaryDirectory().then((value) {
      print(value.path);
      return api.getHistroy(path: value.path);
    }).then((value) async {
      history = value.historyExpr;
      expr = value.currentExpr;
      result = await expr.calculate();
      print(history);
      print(expr.toExpression());
    }).catchError((err) {
      history = [];
      expr = Expr(exprList: [], lBracketCount: 0, rBracketCount: 0);
      print("Error!!!: $err");
    }).whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    exprController.dispose();
    resultController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    Size size = MediaQuery.of(context).size;
    if (size.height / size.width < 1.6) {
      size = Size(size.height / 1.6, size.height);
    }
    Color color;
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      color = const Color.fromARGB(255, 10, 10, 10);
    } else {
      color = const Color.fromARGB(255, 255, 255, 255);
    }
    return Scaffold(
      backgroundColor: color,
      body: Stack(children: [
        InputWidget(
          expr: expr,
          size: size,
          exprController: exprController,
          resultController: resultController,
          result: result,
        ),
        InputPad(
          inputPadController: inputPadController,
          key: UniqueKey(),
          expr: expr,
          size: size,
          result: result,
          calculate: () {
            expr.calculate().then((value) async {
              if (value != "") {
                isResult = true;
                history.add((expr, value));
                expr.allClear();
                var dir = await getTemporaryDirectory();
                await api.storeHistory(
                    path: dir.path,
                    history:
                        DataStruct(currentExpr: expr, historyExpr: history));
                expr.pushNumber(value);
                result = "";
                setState(() {});
              }
            }).catchError((_) {
              result = "Error";
              setState(() {});
            });
          },
          typeSymbols: (fn) {
            setState(() {
              fn();
              getTemporaryDirectory().then((dir) {
                return api.storeHistory(
                    path: dir.path,
                    history:
                        DataStruct(currentExpr: expr, historyExpr: history));
              });
              isResult = false;
              expr.calculate().then((value) {
                result = value;
              }).catchError((onError) {
                result = "Error";
              });
            });
            Future.delayed(const Duration(milliseconds: 1), () {
              if (exprController.hasClients && resultController.hasClients) {
                exprController.jumpTo(exprController.position.maxScrollExtent);
                resultController
                    .jumpTo(resultController.position.maxScrollExtent);
              }
            });
          },
          isResult: isResult,
        )
      ]),
    );
  }
}

class InputWidget extends StatelessWidget {
  const InputWidget(
      {super.key,
      required this.expr,
      required this.size,
      required this.exprController,
      required this.resultController,
      required this.result});

  final Expr expr;
  final Size size;
  final ScrollController exprController;
  final ScrollController resultController;
  final String result;
  @override
  Widget build(BuildContext context) {
    Color exprColor;
    Color resultColor;
    if (MediaQuery.of(context).platformBrightness == Brightness.light) {
      exprColor = const Color.fromARGB(255, 0, 0, 0);
      resultColor = const Color.fromARGB(170, 0, 0, 0);
    } else {
      exprColor = const Color.fromARGB(255, 220, 219, 219);
      resultColor = const Color.fromARGB(175, 255, 255, 255);
    }
    return Align(
        alignment: const Alignment(1, -1),
        child: SizedBox(
          width: size.width,
          height: size.height - size.width * 1.25,
          child: Stack(children: [
            Positioned(
                width: size.width,
                bottom: size.width / 8,
                child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(
                        scrollbars: false,
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                        physics: const BouncingScrollPhysics()),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: SingleChildScrollView(
                            controller: exprController,
                            scrollDirection: Axis.horizontal,
                            child: RichText(
                                text: TextSpan(
                                    text: expr.toExpression(),
                                    style: TextStyle(
                                        color: exprColor,
                                        fontSize: size.width / 8))))))),
            Positioned(
                width: size.width,
                bottom: size.width / 40,
                right: 0,
                child: ScrollConfiguration(
                    behavior: const ScrollBehavior().copyWith(
                        scrollbars: false,
                        dragDevices: {
                          PointerDeviceKind.touch,
                          PointerDeviceKind.mouse,
                        },
                        physics: const BouncingScrollPhysics()),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: SingleChildScrollView(
                        controller: resultController,
                        scrollDirection: Axis.horizontal,
                        child: RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(text: result.isNotEmpty ? "= " : ""),
                                TextSpan(text: result)
                              ],
                              style: TextStyle(
                                  color: resultColor,
                                  fontSize: size.width / 12.5)),
                        ),
                      ),
                    )))
          ]),
        ));
  }
}

class InputPad extends StatelessWidget {
  final Expr expr;
  final Size size;
  final bool isResult;
  final String result;
  final PageController inputPadController;
  final void Function() calculate;
  final void Function(void Function()) typeSymbols;
  const InputPad(
      {super.key,
      required this.expr,
      required this.size,
      required this.calculate,
      required this.typeSymbols,
      required this.result,
      required this.isResult,
      required this.inputPadController});

  @override
  Widget build(BuildContext context) {
    double widthFactor = 4;
    double heightFactor = 4.8;
    var spaceWidth = size.width / 25;
    var sizeStyle = Size(size.width / widthFactor - spaceWidth,
        size.width / heightFactor - spaceWidth);
    var buttonStyle = TextButton.styleFrom(
        minimumSize: const Size(10, 10),
        fixedSize: sizeStyle,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(size.width / 25))));
    TextStyle textStyle = TextStyle(
        fontSize: size.width / 14,
        color: const Color.fromARGB(170, 28, 28, 28));
    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      buttonStyle = buttonStyle.copyWith(
          backgroundColor: const MaterialStatePropertyAll(Color(0xFF131313)));
      textStyle =
          textStyle.copyWith(color: const Color.fromARGB(255, 213, 213, 213));
    }
    return Align(
      alignment: Alignment.bottomRight,
      child: SizedBox(
          width: size.width,
          height: size.width * 1.25,
          child: PageView(children: [
            NumPad(
                buttonStyle: buttonStyle,
                size: size,
                typeSymbols: typeSymbols,
                expr: expr,
                textStyle: textStyle,
                widthFactor: widthFactor,
                spaceWidth: spaceWidth,
                heightFactor: heightFactor,
                isResult: isResult,
                calculate: calculate)
          ])),
    );
  }
}

class NumPad extends StatelessWidget {
  const NumPad({
    super.key,
    required this.buttonStyle,
    required this.size,
    required this.typeSymbols,
    required this.expr,
    required this.textStyle,
    required this.widthFactor,
    required this.spaceWidth,
    required this.heightFactor,
    required this.isResult,
    required this.calculate,
  });

  final ButtonStyle buttonStyle;
  final Size size;
  final void Function(void Function() p1) typeSymbols;
  final Expr expr;
  final TextStyle textStyle;
  final double widthFactor;
  final double spaceWidth;
  final double heightFactor;
  final bool isResult;
  final void Function() calculate;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button(
              style: buttonStyle,
              size: size,
              onPressed: () {
                typeSymbols(() => expr.pushLeftBracket());
              },
              child: Text(
                "(",
                style: textStyle,
              )),
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() => expr.pushRightBracket());
              },
              style: buttonStyle,
              child: Text(
                ")",
                style: textStyle,
              )),
          Button(
            size: size,
            onPressed: () {
              typeSymbols(() => expr.removeLast());
            },
            style: buttonStyle.copyWith(
                fixedSize: MaterialStatePropertyAll(Size(
                    size.width / (widthFactor / 2) - spaceWidth,
                    size.width / heightFactor - spaceWidth))),
            child: Text(
              "del",
              style: textStyle,
            ),
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Button(
                  size: size,
                  onPressed: () {
                    typeSymbols(() => expr.allClear());
                  },
                  style: buttonStyle,
                  child: Text(
                    "AC",
                    style: textStyle,
                  )),
              Button(
                  size: size,
                  onPressed: () {
                    typeSymbols(() {
                      if (isResult) expr.allClear();
                      expr.pushNumber("7");
                    });
                  },
                  style: buttonStyle,
                  child: Text(
                    "7",
                    style: textStyle,
                  ))
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Button(
                  size: size,
                  onPressed: () {
                    typeSymbols(() => expr.pushMulDiv(false));
                  },
                  style: buttonStyle,
                  child: Text(
                    "÷",
                    style: textStyle,
                  )),
              Button(
                  size: size,
                  onPressed: () {
                    typeSymbols(() {
                      if (isResult) expr.allClear();
                      expr.pushNumber("8");
                    });
                  },
                  style: buttonStyle,
                  child: Text(
                    "8",
                    style: textStyle,
                  ))
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Button(
                  size: size,
                  onPressed: () {
                    typeSymbols(() => expr.pushMulDiv(true));
                  },
                  style: buttonStyle,
                  child: Text(
                    "×",
                    style: textStyle,
                  )),
              Button(
                  size: size,
                  onPressed: () {
                    typeSymbols(() {
                      if (isResult) expr.allClear();
                      expr.pushNumber("9");
                    });
                  },
                  style: buttonStyle,
                  child: Text(
                    "9",
                    style: textStyle,
                  ))
            ],
          ),
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() => expr.pushAddSub(true));
              },
              style: buttonStyle.copyWith(
                  fixedSize: MaterialStatePropertyAll(Size(
                      size.width / widthFactor - spaceWidth,
                      size.width / (heightFactor / 2) - spaceWidth))),
              child: Text(
                "+",
                style: textStyle,
              ))
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() {
                  if (isResult) expr.allClear();
                  expr.pushNumber("4");
                });
              },
              style: buttonStyle,
              child: Text(
                "4",
                style: textStyle,
              )),
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() {
                  if (isResult) expr.allClear();
                  expr.pushNumber("5");
                });
              },
              style: buttonStyle,
              child: Text(
                "5",
                style: textStyle,
              )),
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() {
                  if (isResult) expr.allClear();
                  expr.pushNumber("6");
                });
              },
              style: buttonStyle,
              child: Text(
                "6",
                style: textStyle,
              )),
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() => expr.pushAddSub(false));
              },
              style: buttonStyle,
              child: Text(
                "-",
                style: textStyle,
              ))
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() {
                  if (isResult) expr.allClear();
                  expr.pushNumber("1");
                });
              },
              style: buttonStyle,
              child: Text(
                "1",
                style: textStyle,
              )),
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() {
                  if (isResult) expr.allClear();
                  expr.pushNumber("2");
                });
              },
              style: buttonStyle,
              child: Text(
                "2",
                style: textStyle,
              )),
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() {
                  if (isResult) expr.allClear();
                  expr.pushNumber("3");
                });
              },
              style: buttonStyle,
              child: Text(
                "3",
                style: textStyle,
              )),
          Button(
              size: size,
              onPressed: calculate,
              style: buttonStyle,
              child: Text(
                "=",
                style: textStyle,
              ))
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() {
                  if (isResult) expr.allClear();
                  expr.pushNumber("0");
                });
              },
              style: buttonStyle.copyWith(
                  fixedSize: MaterialStatePropertyAll(Size(
                      size.width / (widthFactor / 2) - spaceWidth,
                      size.width / heightFactor - spaceWidth))),
              child: Text("0", style: textStyle)),
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() {
                  if (isResult) expr.allClear();
                  expr.pushNumber(".");
                });
              },
              style: buttonStyle,
              child: Text(
                ".",
                style: textStyle,
              )),
          Button(
              size: size,
              onPressed: () {
                typeSymbols(() => expr.pushRegularSymbol("%"));
              },
              style: buttonStyle,
              child: Text(
                "%",
                style: textStyle,
              ))
        ],
      )
    ]);
  }
}

class HistoryPad extends StatelessWidget {
  final Size size;
  final Expr expr;
  final List<(Expr, String)> history;
  final void Function(void Function() p1) typeSymbols;
  final void Function() calculate;

  const HistoryPad({
    super.key,
    required this.size,
    required this.expr,
    required this.history,
    required this.typeSymbols,
    required this.calculate,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(children: historyChildren,);
  }

  get historyChildren {
    List<RichText> list = [];
    for (var i in history) {
      list.add(RichText(text: TextSpan(children: [TextSpan(text: i.$1.toExpression()), const TextSpan(text: " = "), TextSpan(text: i.$2)]),));
    }
    return list;
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.style,
    required this.onPressed,
    required this.child,
    required this.size,
  });
  final ButtonStyle style;
  final Widget child;
  final void Function() onPressed;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(size.width / 50),
        child: TextButton(onPressed: onPressed, style: style, child: child));
  }
}

extension on Expr {
  void removeLast() {
    if (exprList.isEmpty) return;
    if (exprList.last.$2.length <= 1) {
      if (exprList.last.$1 == ExprType.LeftBracket) lBracketCount -= 1;
      if (exprList.last.$1 == ExprType.RightBracket) rBracketCount -= 1;
      exprList.removeLast();
      return;
    }
    if (exprList.last.$2.length > 1) {
      var last = exprList.removeLast();
      exprList.add((last.$1, last.$2.substring(0, last.$2.length - 1)));
      return;
    }
  }

  void allClear() {
    exprList.clear();
    lBracketCount = 0;
    rBracketCount = 0;
  }

  void pushAddSub(bool boolOp) {
    String op = boolOp ? "+" : "-";
    const type = ExprType.AddSub;
    if (exprList.isEmpty) {
      exprList.add((type, op));
      return;
    }
    if (exprList.last.$1 == ExprType.AddSub ||
        exprList.last.$1 == ExprType.MulDiv) {
      exprList.removeLast();
      exprList.add((type, op));
      return;
    }
    exprList.add((type, op));
  }

  void pushMulDiv(bool boolOp) {
    String op = boolOp ? "*" : "/";
    const type = ExprType.MulDiv;
    if (exprList.isEmpty) return;
    if (exprList.last.$1 == ExprType.AddSub ||
        exprList.last.$1 == ExprType.MulDiv) {
      exprList.removeLast();
      exprList.add((type, op));
      return;
    }
    exprList.add((type, op));
  }

  void pushNumber(String number) {
    const type = ExprType.Number;
    if (exprList.isEmpty) {
      exprList.add((type, number));
      return;
    }
    if ((number.contains(".") &&
        exprList.last.$1 == type &&
        !exprList.last.$2.contains("."))) {
      var last = exprList.removeLast();
      exprList.add((type, last.$2 + number));
      return;
    } else if (number.contains(".") &&
        exprList.last.$1 == type &&
        exprList.last.$2.contains(".")) {
      return;
    }
    if (exprList.last == (type, "0")) {
      exprList.removeLast();
      exprList.add((type, number));
      return;
    }
    if (exprList.last.$1 == type) {
      var last = exprList.removeLast();
      exprList.add((type, last.$2 + number));
      return;
    }
    if (exprList.last.$1 != type) {
      exprList.add((type, number));
    }
  }

  void pushLeftBracket() {
    exprList.add((ExprType.LeftBracket, "("));
    lBracketCount += 1;
  }

  void pushRightBracket() {
    exprList.add((ExprType.RightBracket, ")"));
    rBracketCount += 1;
  }

  String toExpression() {
    String str = "";
    for (int i = 0; i < exprList.length; i++) {
      str += exprList[i].$2;
    }
    str = str.replaceAll("/", "÷");
    str = str.replaceAll("*", "×");
    return str;
  }

  void pushRegularSymbol(String symbol) {
    exprList.add((ExprType.RegularSymbol, symbol));
  }

  Future<String> calculate() async {
    var str = "";

    for (int i = 0; i < exprList.length; i++) {
      str += exprList[i].$2;
    }
    for (int i = 0; i < str.length; i++) {
      if ('+-*/'.contains(str[str.length - 1])) {
        str = str.substring(0, str.length - 1);
      }
    }
    if (lBracketCount > rBracketCount) {
      for (int i = 0; i < lBracketCount - rBracketCount; i++) {
        str += ")";
      }
    }
    Future<String> res = Future.value("");
    if (str.isNotEmpty) {
      try {
        res = Future.value(api.dartCalculate(input: str));
      } catch (e) {
        res = Future.error(e);
      }
    }
    return res;
  }
}
