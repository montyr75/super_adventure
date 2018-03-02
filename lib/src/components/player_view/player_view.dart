import 'dart:async';

import 'package:angular/angular.dart';

import '../../services/logger_service.dart';
import '../../models/creatures/player.dart';
import '../../models/items/inventory_item.dart';
import '../../models/items/healing_potion.dart';
import '../../models/items/weapon.dart';

@Component(selector: 'player-view',
    templateUrl: 'player_view.html',
    directives: const [CORE_DIRECTIVES]
)
class PlayerView {
  final LoggerService _log;

  @Input() Player player;

  final StreamController<Weapon> _onAttack = new StreamController.broadcast();
  @Output() Stream<Weapon> get onAttack => _onAttack.stream;

  final StreamController<HealingPotion> _onDrink = new StreamController.broadcast();
  @Output() Stream<HealingPotion> get onDrink => _onDrink.stream;

  PlayerView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }

  void attack(Weapon weapon) => _onAttack.add(weapon);
  void drink(InventoryItem item) => _onDrink.add(item.details);
}