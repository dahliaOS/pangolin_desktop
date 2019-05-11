import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'dart:math' as math;

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Calculator',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Colors.green[600],
        ),
        home: CalculatorHome(),
    );
  }
}

class _CalculatorHomeState extends State<CalculatorHome> {
  TextSelection _currentSelection = TextSelection(baseOffset: 0, extentOffset: 0);
  TextEditingController _controller = TextEditingController(text: '');
  final GlobalKey _textFieldKey = GlobalKey();
  final textFieldPadding = EdgeInsets.only(right: 8.0);
  static TextStyle textFieldTextStyle = TextStyle(fontSize: 80.0, fontWeight: FontWeight.w300);
  Color _numColor = Color.fromRGBO(48, 47, 63, .94);
  Color _opColor = Color.fromRGBO(22, 21, 29, .93);
  double _fontSize = textFieldTextStyle.fontSize;
  final _pageController = PageController(initialPage: 0);
  bool _useRadians = false;
  bool _invertedMode = false;
  bool _toggled = false;


  void _onTextChanged() {
    final inputWidth = _textFieldKey.currentContext.size.width - textFieldPadding.horizontal;

    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: _controller.text,
        style: textFieldTextStyle,
      ),
    );
    textPainter.layout();

    var textWidth = textPainter.width;
    var fontSize = textFieldTextStyle.fontSize;

    while (textWidth > inputWidth && fontSize > 40.0) {
      fontSize -= 0.5;
      textPainter.text = TextSpan(
        text: _controller.text,
        style: textFieldTextStyle.copyWith(fontSize: fontSize),
      );
      textPainter.layout();
      textWidth = textPainter.width;
    }

    setState(() {
      _fontSize = fontSize;
    });
  }

  void _append(String character) {
    setState(() {
      if (_controller.selection.baseOffset >= 0) {
        _currentSelection = TextSelection(
            baseOffset: _controller.selection.baseOffset + 1,
            extentOffset: _controller.selection.extentOffset + 1,
        );
        _controller.text = _controller.text.substring(0, _controller.selection.baseOffset) +
            character + _controller.text.substring(_controller.selection.baseOffset, _controller.text.length);
        _controller.selection = _currentSelection;
      } else {
        _controller.text += character;
      }
    });
    _onTextChanged();
  }

  void _clear([bool longPress = false]) {
    setState(() {
      if (longPress) {
        _controller.text = '';
      } else {
        if (_controller.selection.baseOffset >= 0) {
          _currentSelection = TextSelection(
              baseOffset: _controller.selection.baseOffset - 1,
              extentOffset: _controller.selection.extentOffset - 1);
          _controller.text = _controller.text
              .substring(0, _controller.selection.baseOffset - 1) +
              _controller.text.substring(
                  _controller.selection.baseOffset, _controller.text.length);
          _controller.selection = _currentSelection;
        } else {
          _controller.text =
              _controller.text.substring(0, _controller.text.length - 1);
        }
      }
    });
    _onTextChanged();
  }

  void _equals() {
    setState(() {
      try {
        var diff = "(".allMatches(_controller.text).length - ")".allMatches(_controller.text).length;
        if (diff>0) {_controller.text += ')'*diff;}
        String expText = _controller.text
            .replaceAll('e+', 'e')
            .replaceAll('e', '*10^')
            .replaceAll('÷', '/')
            .replaceAll('×', '*')
            .replaceAll('%', '/100')
            .replaceAll('sin(', _useRadians ? 'sin(' : 'sin(π/180.0 *')
            .replaceAll('cos(', _useRadians ? 'cos(' : 'cos(π/180.0 *')
            .replaceAll('tan(', _useRadians ? 'tan(' : 'tan(π/180.0 *')
            .replaceAll('sin⁻¹', _useRadians? 'asin' : '180/π*asin')
            .replaceAll('cos⁻¹', _useRadians? 'acos' : '180/π*acos')
            .replaceAll('tan⁻¹', _useRadians? 'atan' : '180/π*atan')
            .replaceAll('π', 'PI')
            .replaceAll('℮', 'E')
            .replaceAllMapped(RegExp(r'(\d+)\!'), (Match m) => "fact(${m.group(1)})")
            .replaceAllMapped(RegExp(r'(?:\(([^)]+)\)|([0-9A-Za-z]+(?:\.\d+)?))\^(?:\(([^)]+)\)|([0-9A-Za-z]+(?:\.\d+)?))'), (Match m) => "pow(${m.group(1) ?? ''}${m.group(2) ?? ''},${m.group(3)??''}${m.group(4)??''})")
            .replaceAll('√(', 'sqrt(');
        print(expText);
        Expression exp = Expression.parse(expText);
        var context = {
          "PI": math.pi,
          "E": math.e,
          "asin": math.asin,
          "acos": math.acos,
          "atan": math.atan,
          "sin": math.sin,
          "cos": math.cos,
          "tan": math.tan,
          "ln": math.log,
          "log": log10,
          "pow": math.pow,
          "sqrt": math.sqrt,
          "fact": factorial,
        };
        final evaluator = const ExpressionEvaluator();
        num outcome = evaluator.eval(exp, context);
        _controller.text = outcome
            .toStringAsPrecision(13)
            .replaceAll(RegExp(r'0+$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      } catch (e) {
        _controller.text = 'Error';
      }
    });
    _onTextChanged();
  }

  double log10(num x) {
    return math.log(x)/math.log(10);
  }

  int factorial(int number) {
    int factorialRange(int bottom, int top) {
      if (top == bottom) {
        return bottom;
      }

      return top * factorialRange(bottom, top - 1);
    }

    return factorialRange(1, number);
  }

  Widget _buildButton(String label, [Function() func]) {
    if (func==null) func =  (){_append(label);};
    return Expanded(
        child: InkResponse(
          onTap: func,
          onLongPress: (label == 'C') ? () => _clear(true) : null,
          child: Center(
              child: Text(
                label,
                style: TextStyle(
                    fontSize: (MediaQuery.of(context).orientation == Orientation.portrait) ? 32.0 : 20.0,//24
                    fontWeight: FontWeight.w300,
                    color: Colors.white
                ),
              )
          ),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0.0,
          title: Text(_toggled?(_useRadians?'RAD':'DEG'):'', style: TextStyle(color: Colors.grey)),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: TextField(
                key: _textFieldKey,
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: textFieldPadding,
                ),
                textAlign: TextAlign.right,
                style: textFieldTextStyle.copyWith(fontSize: _fontSize),
                focusNode: AlwaysDisabledFocusNode(),
              ),
            ),
            Expanded(
              flex: 5,
               child: Material(color: _opColor,
                child: PageView(
                controller: _pageController,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildButton('C', _clear),
                                  _buildButton('('),
                                  _buildButton(')'),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Material(
                                  color: _numColor,
                                  child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildButton('7'),
                                        _buildButton('8'),
                                        _buildButton('9'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildButton('4'),
                                        _buildButton('5'),
                                        _buildButton('6'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildButton('1'),
                                        _buildButton('2'),
                                        _buildButton('3'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildButton('%'),
                                        _buildButton('0'),
                                        _buildButton('.'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            _buildButton('÷'),
                            _buildButton('×'),
                            _buildButton('-'),
                            _buildButton('+'),
                            _buildButton('=', _equals),
                          ],
                        )
                        ),
                      InkWell(
                          child: Container(
                            color: Theme.of(context).accentColor,
                            child: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () => _pageController.animateToPage(
                            1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease,
                          ),
                        ),
                    ],
                  ),
                  Material(
                    color: Theme.of(context).accentColor,
                    child:
                  Column(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton(_invertedMode ? 'sin⁻¹' : 'sin', () => _invertedMode ? _append('sin⁻¹(') : _append('sin(')),
                            _buildButton(_invertedMode ? 'cos⁻¹' : 'cos', () => _invertedMode ? _append('cos⁻¹(') : _append('cos(')),
                            _buildButton(_invertedMode ? 'tan⁻¹' : 'tan', () => _invertedMode ? _append('tan⁻¹(') : _append('tan(')),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton(_invertedMode ? 'eˣ' : 'ln', () => _invertedMode ? _append('℮^(') : _append('ln(')),
                            _buildButton(_invertedMode ? '10ˣ' : 'log', () => _invertedMode ? _append('10^(') : _append('log(')),
                            _buildButton(_invertedMode ? 'x²' : '√', () => _invertedMode ? _append('^2') : _append('√(')),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton('π'),
                            _buildButton('e', () => _append('℮')),
                            _buildButton('^'),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildButton(_invertedMode ? '𝗜𝗡𝗩' : 'INV', () {setState(() {_invertedMode = !_invertedMode;});}),
                            _buildButton(_useRadians ? 'RAD' : 'DEG', () {setState(() {_useRadians = !_useRadians; _toggled = true;});}),
                            _buildButton('!'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  )
                ],
              ),
              ),
            ),
          ],
        ),
      );
  }
}

class CalculatorHome extends StatefulWidget {
  @override
  _CalculatorHomeState createState() => _CalculatorHomeState();
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}