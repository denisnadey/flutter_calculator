import 'dart:async';
import 'package:cloudtech_calculator/extension.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'getcalc_event.dart';
part 'getcalc_state.dart';

class CalcEventBloc extends Bloc<CalcEvent, CalcEventState> {
  CalcEventBloc() : super(const EmptyState());

  @override
  Stream<CalcEventState> mapEventToState(
    CalcEvent event,
  ) async* {
    num a;
    num b;
    final lastState = state;
    if (event is NumberEvent) {
      if (lastState is EmptyState) {
        yield FirstState(a: event.value);
      } else if (lastState is FirstState) {
        a = lastState.a.concat(pointer: false, value: event.value);
        yield FirstState(a: a);
      } else if (lastState is OperatorState &&
          lastState.pointStatus == true &&
          lastState.operator == Operator.point &&
          lastState.b == null) {
        a = lastState.a.concat(pointer: true, value: event.value);
        yield FirstState(a: a);
      } else if (lastState is OperatorState &&
          lastState.operator != Operator.point &&
          lastState.b == null) {
        yield SecondState(
            a: lastState.a, b: event.value, operator: lastState.operator);
      } else if (lastState is SecondState && lastState.b != null) {
        b = lastState.b.concat(pointer: false, value: event.value);
        yield SecondState(a: lastState.a, b: b, operator: lastState.operator);
      } else if (lastState is OperatorState && lastState.b != null) {
        b = lastState.b.concat(pointer: true, value: event.value);
        yield SecondState(a: lastState.a, b: b, operator: lastState.operator);
      }
    } else if (event is PlusOperationEvent) {
      yield OperatorState(a: (state as FirstState).a, operator: Operator.plus);
    } else if (event is MinusOperationEvent) {
      yield OperatorState(a: (state as FirstState).a, operator: Operator.minus);
    } else if (event is DivisionOperationEvent) {
      yield OperatorState(a: (state as FirstState).a, operator: Operator.div);
    } else if (event is MultiOperationEvent) {
      yield OperatorState(a: (state as FirstState).a, operator: Operator.multi);
    } else if (event is PointOperationEvent) {
      if (lastState is FirstState) {
        yield OperatorState(
            a: lastState.a, operator: Operator.point, pointStatus: true);
      } else if (lastState is SecondState) {
        yield OperatorState(
            a: lastState.a,
            b: lastState.b,
            operator: lastState.operator,
            pointStatus: true);
      }
    } else if (event is PercentOperationEvent) {
      if (lastState is FirstState) {
        a = lastState.a / 100;
        yield FirstState(a: a);
      } else if (lastState is SecondState) {
        b = lastState.b / 100;
        yield SecondState(a: lastState.a, b: b, operator: lastState.operator);
      }
    } else if (event is PlusMinusOperationEvent) {
      if (lastState is FirstState) {
        a = lastState.a * (-1);
        yield FirstState(a: a);
      } else if (lastState is SecondState) {
        b = lastState.b * (-1);
        yield SecondState(a: lastState.a, b: b, operator: lastState.operator);
      }
    } else if (event is BackspaceOperationEvent) {
      if (lastState is FirstState) {
        a = lastState.a.backspace();
        yield FirstState(a: a);
      } else if (lastState is SecondState) {
        b = lastState.b.backspace();
        yield SecondState(a: lastState.a, b: b, operator: lastState.operator);
      }
    } else if (event is ClearAllOperationEvent) {
      yield const EmptyState();
    } else if (event is ResultOperationEvent) {
      if (lastState is SecondState) {
        yield FirstState(
            a: operationEvent(lastState.a, lastState.b, lastState.operator));
      }
    }
  }
}
