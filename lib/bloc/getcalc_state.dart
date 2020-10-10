part of 'getcalc_bloc.dart';

@immutable
abstract class CalcEventState {
  const CalcEventState();
}

class EmptyState extends CalcEventState {
  const EmptyState();
}

class FirstState extends CalcEventState {
  final num a;
  const FirstState({this.a});
}

class OperatorState extends CalcEventState {
  final num a;
  final num b;
  final Operator operator;
  final bool pointStatus;
  const OperatorState({this.a, this.b, this.operator, this.pointStatus});
}

class SecondState extends CalcEventState {
  final num a, b;
  final Operator operator;
  const SecondState({this.a, this.b, this.operator});
}

class ResultState extends CalcEventState {
  final num a, b;
  final Operator operator;
  final num result;
  const ResultState({this.a, this.b, this.operator, this.result});
}