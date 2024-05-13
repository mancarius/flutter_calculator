class CalcolatriceHelper {
  static double somma(double a, double b) {
    return a + b;
  }

  static double sottrazione(double a, double b) {
    return a - b;
  }

  static double moltiplicazione(double a, double b) {
    return a * b;
  }

  static double divisione(double a, double b) {
    return a / b;
  }

  static double percentuale(double a, double b) {
    return a * b / 100;
  }

  static bool isOperator(String text) {
    return ['+', '-', 'x', '÷', '%'].contains(text);
  }

  static bool isSpecial(String text) {
    return ['AC', '='].contains(text);
  }

  static bool isNumber(String text) {
    return text.contains(RegExp(r'[0-9]'));
  }
}