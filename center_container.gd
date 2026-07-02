extends CenterContainer


@onready var player_health_bar = $HBoxContainer/PlayerHealthBar
@onready var enemy_health_bar = $HBoxContainer/EnemyHealthBar


func _ready() -> void:
	Global.health_updated.connect(_on_health_update)


func _on_health_update(team, health, max_health):
	var this_bar
	
	if team == 'enemy': this_bar = enemy_health_bar
	elif team == 'ally': this_bar = player_health_bar
	else: print('Healthbar update does not have a team!')
		
	this_bar.max_value = max_health
	this_bar.value = health
	
	Global.health_bar_flash(this_bar)
