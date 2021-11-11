enum Operator {
  plus,
  minus,
  div,
  multi,
  percent,
  plusminus,
  backspace,
  clearall,
  point,
  result
}

extension OperationExtension on Operator {
  String getString() {
    switch (this) {
      case Operator.plus:
        return " + ";
      case Operator.minus:
        return " - ";
      case Operator.multi:
        return " x ";
      case Operator.div:
        return " ÷ ";
      case Operator.point:
        return ".";
      case Operator.result:
        return " = ";
      default:
        throw UnimplementedError();
    }
  }
}

extension NumbersExtension on num {
  num backspace() {
    String pull = "$this";
    pull = pull.substring(0, pull.length - 1);
    if (pull.isNotEmpty && pull.split('').last.contains('.')) {
      pull = pull.substring(0, pull.length - 1);
    }
    return num.parse(pull, (pull) => 0);
  }

  num concat({bool pointer, int value}) {
    if (pointer == true) {
      final String pull = "${this}." + "$value";
      return num.parse(pull);
    } else {
      final String pull = "$this" + "$value";
      return num.parse(pull);
    }
  }
}

num operationEvent(num x, num y, Operator op) {
  num result = 0;
  switch (op) {
    case Operator.plus:
      result = x + y;
      break;
    case Operator.minus:
      result = x - y;
      break;
    case Operator.multi:
      result = x * y;
      break;
    case Operator.div:
      result = x / y;
      break;
    default:
      result = 0;
      break;
  }

  if (result % 1 == 0) {
    return result.toInt();
  } else {
    return result;
  }
}
