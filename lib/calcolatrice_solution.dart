import 'package:flutter/material.dart';
import 'package:calculator/button.dart';
import 'package:calculator/calcolatrice.service.dart';

class ButtonLabel {
  static const String ac = 'AC';
  static const String bracket = '()';
  static const String percent = '%';
  static const Icon plus = Icon(Icons.add);
  static const Icon minus = Icon(Icons.remove);
  static const Icon multiply = Icon(Icons.close);
  static const String divide = '÷';
  static const String comma = ',';
  static const Icon backspace = Icon(Icons.backspace);
  static const String equal = '=';
}

class ButtonColors {
  static const Color special = Colors.deepPurple;
  static const Color operator = Color.fromARGB(255, 211, 130, 9);
  static const Color number = Colors.grey;
  static const Color equal = Colors.green;
  static const Color comma = Colors.grey;
  static const Color backspace = Colors.red;
}

class ButtonConfig {
  final label;
  final Color bgColor;
  final Function(String) onPressed;

  const ButtonConfig({
    required this.label,
    required this.bgColor,
    required this.onPressed,
  });
}

class CalcolatriceSolution extends StatelessWidget {
  final String title;

  CalcolatriceSolution({
    super.key,
    required this.title,
  });

  CalcolatriceService service = CalcolatriceService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Expanded(
        child: Column(
          children: [
            Expanded(
                child: TextField(
              textAlign: TextAlign.right,
              textAlignVertical: TextAlignVertical.bottom,
              readOnly: true,
              controller: service.controller,
              style: const TextStyle(fontSize: 70),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 93)),
            )),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: buttonsWidgetSizedBox(context)
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buttonsWidgetSizedBox(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CalcolatriceButton(
                label: ButtonLabel.ac,
                bgColor: ButtonColors.special,
                onPressed: service.clear,
              ),
              CalcolatriceButton(
                label: ButtonLabel.bracket,
                bgColor: ButtonColors.operator,
                onPressed: service.toggleBracket,
              ),
              CalcolatriceButton(
                label: ButtonLabel.percent,
                bgColor: ButtonColors.operator,
                onPressed: () => service.addText('%'),
              ),
              CalcolatriceButton(
                label: ButtonLabel.divide,
                bgColor: ButtonColors.operator,
                onPressed: () => service.addText('÷'),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CalcolatriceButton(
              label: '7',
              bgColor: ButtonColors.number,
              onPressed: () => service.addText('7'),
            ),
            CalcolatriceButton(
              label: '8',
              bgColor: ButtonColors.number,
              onPressed: () => service.addText('8'),
            ),
            CalcolatriceButton(
              label: '9',
              bgColor: ButtonColors.number,
              onPressed: () => service.addText('9'),
            ),
            CalcolatriceButton(
              label: ButtonLabel.multiply,
              bgColor: ButtonColors.operator,
              onPressed: () => service.addText('x'),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              CalcolatriceButton(
                label: '4',
                bgColor: ButtonColors.number,
                onPressed: () => service.addText('4'),
              ),
              CalcolatriceButton(
                label: '5',
                bgColor: ButtonColors.number,
                onPressed: () => service.addText('5'),
              ),
              CalcolatriceButton(
                label: '6',
                bgColor: ButtonColors.number,
                onPressed: () => service.addText('6'),
              ),
              CalcolatriceButton(
                label: ButtonLabel.minus,
                bgColor: ButtonColors.operator,
                onPressed: () => service.addText('-'),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CalcolatriceButton(
              label: '1',
              bgColor: ButtonColors.number,
              onPressed: () => service.addText('1'),
            ),
            CalcolatriceButton(
              label: '2',
              bgColor: ButtonColors.number,
              onPressed: () => service.addText('2'),
            ),
            CalcolatriceButton(
              label: '3',
              bgColor: ButtonColors.number,
              onPressed: () => service.addText('3'),
            ),
            CalcolatriceButton(
              label: ButtonLabel.plus,
              bgColor: ButtonColors.operator,
              onPressed: () => service.addText('+'),
            ),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            CalcolatriceButton(
              label: '0',
              bgColor: ButtonColors.number,
              onPressed: () => service.addText('0'),
            ),
            CalcolatriceButton(
              label: ButtonLabel.comma,
              bgColor: ButtonColors.comma,
              onPressed: service.addComma,
            ),
            CalcolatriceButton(
              label: ButtonLabel.backspace,
              bgColor: ButtonColors.backspace,
              onPressed: service.deleteLastChar,
            ),
            CalcolatriceButton(
              label: ButtonLabel.equal,
              bgColor: ButtonColors.equal,
              onPressed: service.calcola,
            ),
          ])
        ],
    );
  }
}
