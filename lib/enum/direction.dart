enum Direction {
  north(0),
  east(0.25),
  south(0.5),
  west(0.75);

  const Direction(this.value);
  final double value;

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
