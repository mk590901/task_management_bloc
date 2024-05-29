import '../core/event.dart';

//  Button events
class Reset<T> extends Event<T> {
  T? _data;
  Reset([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  Reset<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class Run<T> extends Event<T> {
  T? _data;
  Run([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  Run<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class Success<T> extends Event<T> {
  T? _data;
  Success([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  Success<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class Cancel<T> extends Event<T> {
  T? _data;
  Cancel([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  Cancel<T> setData([T? data]) {
    _data = data;
    return this;
  }
}

class Failed<T> extends Event<T> {
  T? _data;
  Failed([this._data]);
  @override
  T? getData() {
    return _data;
  }
  @override
  Failed<T> setData([T? data]) {
    _data = data;
    return this;
  }
}
