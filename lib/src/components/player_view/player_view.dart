import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import '../../directives/safe_inner_html.dart';

import '../../services/logger_service.dart';
import '../../models/creatures/player.dart';
import '../../models/items/inventory_item.dart';
import '../../models/items/healing_potion.dart';
import '../../models/items/weapon.dart';
import '../../models/quests/player_quest.dart';

@Component(selector: 'player-view',
    templateUrl: 'player_view.html',
    directives: const [CORE_DIRECTIVES, materialDirectives, SafeInnerHtml]
)
class PlayerView {
  final LoggerService _log;

  @Input() Player player;

  bool questPopupVisible = false;
  String selectedQuestText;

  final StreamController<Weapon> _onAttack = new StreamController.broadcast();
  @Output() Stream<Weapon> get onAttack => _onAttack.stream;

  final StreamController<HealingPotion> _onDrink = new StreamController.broadcast();
  @Output() Stream<HealingPotion> get onDrink => _onDrink.stream;

  PlayerView(LoggerService this._log) {
    _log.info("$runtimeType()");
  }

  void questSelected(PlayerQuest quest) {
    questPopupVisible = !questPopupVisible;
    selectedQuestText = quest.details.toHTMLString();
  }

  void attack(Weapon weapon) => _onAttack.add(weapon);
  void drink(InventoryItem item) => _onDrink.add(item.details);
}