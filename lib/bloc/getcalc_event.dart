part of 'getcalc_bloc.dart';

@immutable
abstract class CalcEvent {}

class NumberEvent extends CalcEvent {
  final int value;
  NumberEvent(this.value);
}

class PlusOperationEvent extends CalcEvent {}

class MinusOperationEvent extends CalcEvent {}

class DivisionOperationEvent extends CalcEvent {}

class MultiOperationEvent extends CalcEvent {}

class PointOperationEvent extends CalcEvent {}

class PercentOperationEvent extends CalcEvent {}

class PlusMinusOperationEvent extends CalcEvent {}

class BackspaceOperationEvent extends CalcEvent {}

class ClearAllOperationEvent extends CalcEvent {}

class ResultOperationEvent extends CalcEvent {}
