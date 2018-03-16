import '../items/item.dart';
import '../items/inventory_item.dart';

class Quest {
  static const String NAME_COLOR = "maroon";

  final QuestID id;
  final String name;
  final String description;

  // rewards
  final int xp;
  final int gold;       // optional
  final Item item;      // optional

  final List<InventoryItem> questCompletionItems;

  Quest(this.id, this.name, this.description, this.xp, {this.gold, this.item, this.questCompletionItems});

  bool get hasItem => item != null;

  String get htmlName => '<span style="color: $NAME_COLOR;">$name</span>';

  String toHTMLString() {
    StringBuffer sb = new StringBuffer();
    sb.writeln("<strong>Quest:</strong> ${htmlName}");
    sb.writeln();
    sb.writeln(description);
    sb.writeln();
    sb.writeln("To complete this quest, return with:");

    for (InventoryItem item in questCompletionItems) {
      sb.writeln("${item.qty} ${item.htmlName}");
    }

    return sb.toString().replaceAll('\n', '<br>');
  }
}

enum QuestID {
  clearAlchemistsGarden,
  clearFarmersField,
  retrieveSpiderVenomSack
}