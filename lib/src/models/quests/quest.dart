import '../items/item.dart';
import '../items/inventory_item.dart';

class Quest {
  final QuestID id;
  final String name;
  final String description;

  // rewards
  final int xp;
  final int gold;       // optional
  final Item item;      // optional

  final List<InventoryItem> questCompletionItems;

  Quest(this.id, this.name, this.description, this.xp, {this.gold, this.item, this.questCompletionItems});
}

enum QuestID {
  clearAlchemistsGarden,
  clearFarmersField
}