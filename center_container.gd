extends CenterContainer


@onready var player_health_bar = $HBoxContainer/PlayerHealthBar
@onready var enemy_health_bar = $HBoxContainer/EnemyHealthBar


func _ready() -> void:
	Global.health_updated.connect(_on_health_update)


func _on_health_update(team, health, max_health):
	if team == 'enemy':
		enemy_health_bar.max_value = max_health
		enemy_health_bar.value = health
	elif team == 'ally':
		player_health_bar.max_value = max_health
		player_health_bar.value = health
	else:
		print('Healthbar update does not have a team!')
