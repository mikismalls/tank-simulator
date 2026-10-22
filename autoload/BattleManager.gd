extends Node

# Autoload BattleManager.gd
# Управление глобальным состоянием боя

var score: int = 0
var is_paused: bool = false

func pause_game(state: bool):
    is_paused = state
    get_tree().paused = state
