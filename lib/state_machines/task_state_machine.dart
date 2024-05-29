import 'dart:async';
import '../core/basic_state_machine.dart';
import '../core/state.dart';
import '../core/trans.dart';
import '../core/event.dart';
import '../blocks/task_state.dart';
import '../blocks/task_events.dart';
import 'trans_methods.dart';

class TaskStateMachine extends BasicStateMachine {
  TaskStateMachine(super.currentState);

  @override
  void create() {
    states_ [TaskState.state_(TaskStates.idle)]   = State([ Trans(Run(),      TaskState.state_(TaskStates.active),  OnRun     (this))]);
    states_ [TaskState.state_(TaskStates.active)] = State([ Trans(Success(),  TaskState.state_(TaskStates.idle),    OnSuccess (this)),
                                                            Trans(Cancel(),   TaskState.state_(TaskStates.idle),    OnCancel  (this)),
                                                            Trans(Failed(),   TaskState.state_(TaskStates.error),   OnFailed  (this)),
                                                          ]);
    states_ [TaskState.state_(TaskStates.error)]  = State([ Trans(Reset(),    TaskState.state_(TaskStates.idle),    OnReset (this))]);

  }

  @override
  String? getEventName(int event) {
    // TODO: implement getEventName
    throw UnimplementedError();
  }

  @override
  String? getStateName(int state) {
    return TaskStates.values[state].name;
  }

  @override
  void publishEvent(Event event) {
    print ("publishEvent->$event");
  }

  @override
  void publishState(int state) {
    // TODO: implement publishState
  }



}
