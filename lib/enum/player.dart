enum Player {
  playerOne,
  playerTwo;

  Player next() => this == Player.playerOne ? Player.playerTwo : this;
}
