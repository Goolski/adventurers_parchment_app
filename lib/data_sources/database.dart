import 'dart:async';

class Database<T> {
  Database({List<T> initList = const []}) : _list = initList {
    _controller.onListen = () => _emitCurrentValue();
  }

  final StreamController<List<T>> _controller =
      StreamController<List<T>>.broadcast();
  List<T> _list;

  set list(List<T> newList) {
    _list = newList;
    _emitCurrentValue();
  }

  Stream<List<T>> get stream => _controller.stream;

  void dispose() {
    _controller.close();
  }

  void _emitCurrentValue() {
    _controller.sink.add(_list);
  }
}
