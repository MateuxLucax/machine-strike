class Stack<E> {
  final int limit;

  final _list = <E>[];

  Stack(this.limit);

  void push(E value) {
    if (_list.length > limit) pop();
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
