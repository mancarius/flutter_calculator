import 'package:flutter/material.dart';
import 'package:calculator/calcolatrice.helper.dart';

class CalcolatriceService {
  // Singleton
  static final CalcolatriceService _calcolatriceService = CalcolatriceService._internal();
  factory CalcolatriceService() => _calcolatriceService;
  CalcolatriceService._internal();

  TextEditingController controller = TextEditingController(text: '0');

  List<String> operators = ['+', '-', 'x', '÷', '()', '%'];

  // Metodi
  void clear() {
    controller.text = '0';
  }

  void addText(String text) {
    if (!CalcolatriceHelper.isNumber(text)) {
      if (CalcolatriceHelper.isOperator(controller.text[controller.text.length - 1])) return;
      if (text == '(') return;
      if (text == ',') return;
    }
    controller.text = controller.text == '0' ? text : controller.text + text;
  }

  void toggleBracket() {
    String text = controller.text;
    if(text.split('').last == '(') return;
    if (_hasNotClosedBracket(text)) {
      controller.text = '$text)';
    } else {
      controller.text = text == '0' ? '(' : '$text(';
    }
  }

  void addComma() {
    String text = controller.text;
    if (isOperator(text[text.length - 1])) {
      controller.text = text;
      return;
    }
    // seleziona l'ultimo numero dello stringa (es. 1+2,3 => 2,3)
    String lastNumber = text.split(RegExp(r'[+\-x÷()]')).last;
    if (lastNumber.contains(',')){
      controller.text = text;
      return;
    }
    controller.text = '$text,';
  }

  bool isOperator(String text) {
    return operators.contains(text);
  }

  void deleteLastChar() {
    String text = controller.text;
    if (text.length > 1) {
      controller.text = text.substring(0, text.length - 1);
    } else {
      controller.text = '0';
    }
  }

  void calcola() {
    String text = controller.text;
    if (_hasNotClosedBracket(text)) {
      return;
    }
    // rimuove eventuali virgole
    text = text.replaceAll(',', '.');
    List<String> elements = [];
    int start = 0;
    while (start < text.length) {
      if (!CalcolatriceHelper.isNumber(text[start]) && text[start] != '.') {
        elements.add(text[start]);
        start++;
      } else {
        int end = start + 1;
        while (end < text.length && (CalcolatriceHelper.isNumber(text[end]) || text[end] == '.')) {
          end++;
        }
        elements.add(text.substring(start, end));
        start = end;
      }
    }
    String result = _calculate(elements).toString();
    result = removeDecimalsIfZero(result);
    result = replaceDotsWithCommas(result);
    controller.text = result;
  }

  String removeDecimalsIfZero(String text) {
    if (text.contains('.')) {
      List<String> elements = text.split('.');
      if (elements[1] == '0') {
        return elements[0];
      }
    }
    return text;
  }

  String replaceDotsWithCommas(String text) {
    return text.replaceAll('.', ',');
  }

  bool _hasNotClosedBracket(String text) {
    num openedBracketCount = text.split('').where((element) => element == '(').length;
    num closedBracketCount = text.split('').where((element) => element == ')').length;
    return openedBracketCount > closedBracketCount;
  }

  double _calculate(List<String> elements) {
    elements = _calcolaParentesi(elements);
    elements = _calcolaMoltiplicazioniEDivisioni(elements);
    elements = _calcolaSommeESottrazioni(elements);
    return double.parse(elements[0] ?? '0');
  }

  List<String> _calcolaMoltiplicazioniEDivisioni(List<String> elements) {
    while (elements.contains('x') || elements.contains('÷')) {
      int index = elements.contains('x') ? elements.indexOf('x') : elements.indexOf('÷');
      double a = double.parse(elements[index - 1]);
      double b = double.parse(elements[index + 1]);
      double result = elements[index] == 'x'
          ? CalcolatriceHelper.moltiplicazione(a, b)
          : CalcolatriceHelper.divisione(a, b);
      elements = elements.sublist(0, index - 1)
        ..add(result.toString())
        ..addAll(elements.sublist(index + 2));
    }
    return elements;
  }

  List<String> _calcolaSommeESottrazioni(List<String> elements) {
    while (elements.contains('+') || elements.contains('-')) {
      int index = elements.contains('+') ? elements.indexOf('+') : elements.indexOf('-');
      double a = double.parse(elements[index - 1]);
      double b = double.parse(elements[index + 1]);
      double result = elements[index] == '+'
          ? CalcolatriceHelper.somma(a, b)
          : CalcolatriceHelper.sottrazione(a, b);
      elements = elements.sublist(0, index - 1)
        ..add(result.toString())
        ..addAll(elements.sublist(index + 2));
    }
    return elements;
  }

  List<String> _calcolaParentesi(List<String> elements) {
    while (elements.contains('(')) {
      int start = elements.lastIndexOf('(');
      int end = elements.indexOf(')', start);
      String result = _calculate(elements.sublist(start + 1, end)).toString();
      elements = elements.sublist(0, start)
        ..add(result)
        ..addAll(elements.sublist(end + 1));
    }
    return elements;
  }
}