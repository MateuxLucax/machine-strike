enum Player {
  one,
  two;

  Player next() => this == Player.one ? Player.two : this;
}
