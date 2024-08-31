import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String expression = "";

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "CLEAR") {
        expression = "";
        output = "0";
      } else if (buttonText == "=") {
        try {
          output = _evaluateExpression(expression).toString();
          expression = output;
        } catch (e) {
          output = "Miss u :v";
        }
      } else {
        if (expression == "0" && buttonText != ".") {
          expression = buttonText;
        } else {
          expression += buttonText;
        }
        output = expression;
      }
    });
  }

  double _evaluateExpression(String expression) {
    // Simple expression evaluation using the Dart's expression evaluator
    // This approach assumes the input is valid and does not handle errors robustly.
    // You can use the "expressions" package or implement a custom parser for more complex cases.
    double result = 0.0;
    List<String> tokens = expression.split(RegExp(r"([+\-*/])")).map((e) => e.trim()).toList();
    result = double.parse(tokens[0]);

    for (int i = 1; i < tokens.length; i += 2) {
      String operator = tokens[i];
      double value = double.parse(tokens[i + 1]);

      switch (operator) {
        case "+":
          result += value;
          break;
        case "-":
          result -= value;
          break;
        case "*":
          result *= value;
          break;
        case "/":
          result /= value;
          break;
        default:
          throw Exception("Unknown operator $operator");
      }
    }

    return result;
  }

  Widget buildButton(String buttonText) {
    return Expanded(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.orange,
          padding: EdgeInsets.all(4.0),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(

          ),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
        onPressed: () => buttonPressed(buttonText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TomDev"),
      ),
      body: Column(
        children: <Widget>[
          Container(

            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(

              vertical: 54.0,
              horizontal: 12.0,
            ),

            child: Text(
              output,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Padding(

                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                child: Row(
                  children: [
                    buildButton("7"),
                    SizedBox(width: 10,),
                    buildButton("8"),
                    SizedBox(width: 10,),
                    buildButton("9"),
                    SizedBox(width: 10,),
                    buildButton("/"),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  buildButton("4"),
                  SizedBox(width: 10,),
                  buildButton("5"),
                  SizedBox(width: 10,),
                  buildButton("6"),
                  SizedBox(width: 10,),
                  buildButton("*"),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  buildButton("1"),
                  SizedBox(width: 10,),
                  buildButton("2"),
                  SizedBox(width: 10,),
                  buildButton("3"),
                  SizedBox(width: 10,),
                  buildButton("-"),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  buildButton("."),
                  SizedBox(width: 10,),
                  buildButton("0"),
                  SizedBox(width: 10,),
                  buildButton("00"),
                  SizedBox(width: 10,),
                  buildButton("+"),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  buildButton("CLEAR"),
                  buildButton("="),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
