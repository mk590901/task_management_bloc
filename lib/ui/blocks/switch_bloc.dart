import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/basic_state_machine.dart';
import '../../core/event.dart';
import '../events/switch_events.dart';
import '../state_machines/switch_state_machine.dart';
import '../states/switch_state.dart';

class SwitchBloc extends Bloc<Event, SwitchState> {
  BasicStateMachine? _stateMachine;

  SwitchBloc(super.state) {
    _stateMachine = SwitchStateMachine(SwitchState.state_(SwitchStates.off));
    on<Reset>((event, emit) {
      done(event, emit);
    });
    on<Click>((event, emit) {
      done(event, emit);
    });
    on<Enable>((event, emit) {
      done(event, emit);
    });
    on<Disable>((event, emit) {
      done(event, emit);
    });
  }

  void done(Event event, Emitter<SwitchState> emit) {
    int newState = _stateMachine!.dispatch(event);
    if (newState >= 0) {
      SwitchState nextState = SwitchState(SwitchStates.values[newState]);
      nextState.setData(event.getData());
      emit(nextState);
    }
  }
}
