import 'item.dart';

class InventoryItem {
  final Item details;
  int _qty;

  InventoryItem(this.details, this._qty);

  void increaseQty([int by = 0]) => _qty++;
  void decreaseQty([int by = 0]) => _qty--;

  int get qty => _qty;

  String get name => qty == 1 ? details.name : details.namePlural;
  String get htmlName => qty == 1 ? details.htmlName : details.htmlNamePlural;
}