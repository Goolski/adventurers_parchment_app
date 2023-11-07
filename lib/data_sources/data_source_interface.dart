abstract class ICrudDataSource<T> {
  Stream<T> get({required String id});
  Stream<Iterable<T>> getAll();
  Future<void> add({required T item});
  Future<void> update({required T item});
  Future<void> delete({required T item});
}
