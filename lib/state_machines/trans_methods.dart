import 'dart:ui';
import '../core/interfaces/i_transition_method.dart';

class OnRun implements ITransitionMethod {
  OnRun();
  @override
  void execute([var variable]) {
    print("@OnRun $variable");
    if (variable is VoidCallback?) {
      variable?.call();
    }
  }
}

class OnSuccess implements ITransitionMethod {
  OnSuccess();
  @override
  void execute([var variable]) {
    print("@OnSuccess $variable");
  }
}

class OnCancel implements ITransitionMethod {
  OnCancel();
  @override
  void execute([var variable]) {
    print("@OnCancel $variable");
  }
}

class OnFailed implements ITransitionMethod {
  OnFailed();
  @override
  void execute([var variable]) {
    print("@OnFailed $variable");
  }
}

class OnReset implements ITransitionMethod {
  OnReset();
  @override
  void execute([var variable]) {
    print("@OnReset $variable");
  }
}
