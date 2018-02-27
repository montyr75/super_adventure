class Item {
  final ItemID id;
  final String name;
  final String namePlural;

  Item(this.id, this.name, this.namePlural);
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