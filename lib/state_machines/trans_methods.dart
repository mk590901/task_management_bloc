import 'package:task_management/state_machines/basic_state_machine.dart';

import '../interfaces/i_transition_method.dart';

class OnRun implements ITransitionMethod {
  BasicStateMachine? _stateMachine;
  OnRun(this._stateMachine);
  @override
  void execute([var hashMap]) {
    print("@OnRun $hashMap");
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
