import 'item.dart';

class InventoryItem {
  final Item details;
  int _qty;

  InventoryItem(this.details, this._qty);

  void increaseQty([int by = 0]) => _qty++;
  void decreaseQty([int by = 0]) => _qty--;

  int get qty => _qty;
}