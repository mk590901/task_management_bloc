import 'dart:ui';
import '../blocs/task_bloc.dart';
import '../core/interfaces/i_transition_method.dart';

class OnRun implements ITransitionMethod {
  OnRun();
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
  OnSuccess();
  @override
  void execute([var hashMap]) {
    print("@OnSuccess $hashMap");
  }
}

class OnCancel implements ITransitionMethod {
  OnCancel();
  @override
  void execute([var hashMap]) {
    print("@OnCancel $hashMap");
  }
}

class OnFailed implements ITransitionMethod {
  OnFailed();
  @override
  void execute([var hashMap]) {
    print("@OnFailed $hashMap");
  }
}

class OnReset implements ITransitionMethod {
  OnReset();
  @override
  void execute([var hashMap]) {
    print("@OnReset $hashMap");
  }
}
