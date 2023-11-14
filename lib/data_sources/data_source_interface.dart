abstract class ICrudDataSource<T> {
  Stream<T> get({required String id});
  Stream<Iterable<T>> getAll();
  Future<void> add({required T item});
  Future<void> update({required T item});
  Future<void> delete({required T item});
}

class ItemAlreadyExistsException implements Exception {
  ItemAlreadyExistsException({this.item});
  final Object? item;

  @override
  String toString() {
    final str = item == null ? "" : ": ${item.toString()}";
    return "Item already exist in Data Source$str";
  }
}

class ItemDoesntExistException implements Exception {
  ItemDoesntExistException({this.id});
  final String? id;

  @override
  String toString() {
    final str = id == null ? "" : ": ${id.toString()}";
    return "Item with given Id doesn't exist in database: Id: $str";
  }
}

class ItemDeletedException implements Exception {
  ItemDeletedException({this.id});
  final String? id;

  @override
  String toString() {
    final str = id == null ? "" : ": ${id.toString()}";
    return "Item with given Id was deleted: Id: $str";
  }
}
