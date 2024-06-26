import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/event.dart';
import '../core/basic_state_machine.dart';
import '../state_machines/task_state_machine.dart';
import '../blocs/task_state.dart';
import 'task_events.dart';

class TaskBloc extends Bloc<Event, TaskState> {
  BasicStateMachine? _stateMachine;

  TaskBloc(TaskState initialState) : super(initialState) {
    _stateMachine = TaskStateMachine(initialState.state().index);
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
