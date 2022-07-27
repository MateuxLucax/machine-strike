enum Direction {
  north(0),
  east(45),
  south(90),
  west(135);

  const Direction(this.value);
  final int value;

  Direction next() {
    switch (this) {
      case north:
        return east;
      case east:
        return south;
      case south:
        return west;
      case west:
        return north;
    }
  }

  Direction previous() {
    switch (this) {
      case north:
        return west;
      case west:
        return south;
      case south:
        return east;
      case east:
        return north;
    }
  }

  @override
  String toString() {
    return '${name.split('.').last[0].toUpperCase()}${name.split('.').last.substring(1).toLowerCase()}';
  }
}
