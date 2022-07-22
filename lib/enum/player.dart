enum Player {
  one,
  two;

  Player next() => this == Player.one ? Player.two : this;

  @override
  String toString() {
    return 'Player ${this == Player.one ? '1' : '2'}';
  }
}
