import 'package:flutter_bloc/flutter_bloc.dart';

import '../events/event.dart';
import '../events/task_events.dart';
import '../state_machines/basic_state_machine.dart';
import '../state_machines/task_state_machine.dart';
import '../states/task_state.dart';

class TaskBloc extends Bloc<Event, TaskState> {
  BasicStateMachine? _stateMachine;

  TaskBloc(super.state) {
    _stateMachine = TaskStateMachine(TaskState.state_(TaskStates.idle));
    on<Reset>((event, emit) {
      done(event, emit);
    });
    on<Run>((event, emit) {
      done(event, emit);
    });
    on<Success>((event, emit) {
      done(event, emit);
    });
    on<Failed>((event, emit) {
      done(event, emit);
    });
    on<Cancel>((event, emit) {
      done(event, emit);
    });
  }

  void done(Event event, Emitter<TaskState> emit) {
    int newState = _stateMachine!.dispatch(event);
    if (newState >= 0) {
      TaskState nextState = TaskState(TaskStates.values[newState]);
      nextState.setData(event.getData());
      emit(nextState);
    }
  }
}
