import 'dart:async';

class Database<T> {
  Database({List<T> initList = const []}) : _list = initList {
    _controller.onListen = () => emitCurrentValue();
  }

  final StreamController<List<T>> _controller =
      StreamController<List<T>>.broadcast();
  List<T> _list;

  set list(List<T> newList) {
    _list = newList;
    emitCurrentValue();
  }

  Stream<List<T>> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }

  void emitCurrentValue() {
    _controller.sink.add(_list);
  }
}
