// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:task_management/blocks/task_events.dart';
import 'package:task_management/core/basic_state_machine.dart';
import 'package:task_management/state_machines/task_state_machine.dart';
import 'package:task_management/blocks/task_state.dart';

void main() {
  test('TaskStateMachine', () {
    BasicStateMachine?
      stateMachine = TaskStateMachine(TaskState.state_(TaskStates.idle));
    expect(stateMachine.state(),  TaskState.state_(TaskStates.idle));
    stateMachine.dispatch(Run());
    expect(stateMachine.state(),  TaskState.state_(TaskStates.active));
    stateMachine.dispatch(Success());
    expect(stateMachine.state(),  TaskState.state_(TaskStates.idle));
    stateMachine.dispatch(Run());
    expect(stateMachine.state(),  TaskState.state_(TaskStates.active));
    stateMachine.dispatch(Cancel());
    expect(stateMachine.state(),  TaskState.state_(TaskStates.idle));
    stateMachine.dispatch(Run());
    expect(stateMachine.state(),  TaskState.state_(TaskStates.active));
    stateMachine.dispatch(Failed());
    expect(stateMachine.state(),  TaskState.state_(TaskStates.error));
    stateMachine.dispatch(Reset());
    expect(stateMachine.state(),  TaskState.state_(TaskStates.idle));
  });

}
