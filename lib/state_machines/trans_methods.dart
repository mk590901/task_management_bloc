import 'dart:ui';

// import 'package:task_management/blocks/task_bloc.dart';
// import 'package:task_management/state_machines/basic_state_machine.dart';

import '../blocks/task_bloc.dart';
import '../core/interfaces/i_transition_method.dart';
import '../core/basic_state_machine.dart';

class OnRun implements ITransitionMethod {
  BasicStateMachine? _stateMachine;
  OnRun(this._stateMachine);
  @override
  void execute([var variable]) {
    print("@OnRun $variable");
    if (variable is TaskBloc) {
      print("@OnRun -- parameter is TaskBloc");
    }
    if (variable is VoidCallback?) {
      print("@OnRun -- parameter is VoidCallback?");
      variable?.call();
    }

  }
}

class OnSuccess implements ITransitionMethod {
  BasicStateMachine? _stateMachine;
  OnSuccess(this._stateMachine);
  @override
  void execute([var hashMap]) {
    print("@OnSuccess $hashMap");
  }
}

class OnCancel implements ITransitionMethod {
  BasicStateMachine? _stateMachine;
  OnCancel(this._stateMachine);
  @override
  void execute([var hashMap]) {
    print("@OnCancel $hashMap");
  }
}

class OnFailed implements ITransitionMethod {
  BasicStateMachine? _stateMachine;
  OnFailed(this._stateMachine);
  @override
  void execute([var hashMap]) {
    print("@OnFailed $hashMap");
  }
}

class OnReset implements ITransitionMethod {
  BasicStateMachine? _stateMachine;
  OnReset(this._stateMachine);
  @override
  void execute([var hashMap]) {
    print("@OnReset $hashMap");
  }
}
