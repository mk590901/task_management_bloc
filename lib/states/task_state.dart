enum TaskStates { idle, active, error }

class TaskState<T> {

  static int state_(TaskStates state) {
    return state.index;
  }

  final TaskStates _state;
  T? _data;

  TaskState(this._state) {
    _data = null;
  }

  TaskStates state() {
    return _state;
  }
  
  void setData(T? data) {
    _data = data;
  }

  T? data() {
    return _data;
  }
}
