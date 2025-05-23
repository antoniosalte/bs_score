enum Gender { female, male }

class Player {
  // String id;
  String name;
  // Gender gender;
  // int number;

  Player(this.name);
  // Player(this.id, this.name, this.number);
}

class PlayerScore {
  Player player;
  int? score;
  int tops = -1;
  int zone = -1;
  int tryTop = -1;
  int tryZone = -1;

  PlayerScore(this.player);
}
