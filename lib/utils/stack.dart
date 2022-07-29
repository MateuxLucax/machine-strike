class Stack<E> {
  final _list = <E>[];

  void push(E value) {
    _list.add(value);
  }

  E pop() => _list.removeLast();

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  void clear() => _list.clear();

  @override
  String toString() => _list.toString();
}
