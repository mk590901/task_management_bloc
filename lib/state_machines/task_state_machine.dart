import '../core/basic_state_machine.dart';
import '../core/state.dart';
import '../core/trans.dart';
import '../core/event.dart';
import '../blocs/task_state.dart';
import '../blocs/task_events.dart';
import 'trans_methods.dart';

class TaskStateMachine extends BasicStateMachine {
  TaskStateMachine(super.currentState);

  @override
  void create() {
    states_ [TaskState.state_(TaskStates.idle)]   = State([ Trans(Run(),      TaskState.state_(TaskStates.active),  OnRun     ())]);
    states_ [TaskState.state_(TaskStates.active)] = State([ Trans(Success(),  TaskState.state_(TaskStates.idle),    OnSuccess ()),
                                                            Trans(Cancel(),   TaskState.state_(TaskStates.idle),    OnCancel  ()),
                                                            Trans(Failed(),   TaskState.state_(TaskStates.error),   OnFailed  ()),
                                                          ]);
    states_ [TaskState.state_(TaskStates.error)]  = State([ Trans(Reset(),    TaskState.state_(TaskStates.idle),    OnReset   ())]);

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
