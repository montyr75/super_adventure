class Item {
  static const String NAME_COLOR = "green";

  final ItemID id;
  final String name;
  final String namePlural;
  final String type;

  Item(this.id, this.name, this.namePlural, [this.type = 'item']);

  String get htmlName => '<span style="color: $NAME_COLOR;">$name</span>';
  String get htmlNamePlural => '<span style="color: $NAME_COLOR;">$namePlural</span>';
}

enum ItemID {
  rustySword,
  ratTail,
  pieceOfFur,
  snakeFang,
  snakeSkin,
  club,
  healingPotion,
  spiderFang,
  spiderSilk,
  adventurerPass
}