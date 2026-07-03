extends Camera2D


var hit_zoom_amount = 1.035
var zoom_tween

var shake_strength = 0
const SHAKE_DECAY = 8


func _ready() -> void:
	Global.health_updated.connect(_on_health_update)
	Global.camera = self
	
	
func _process(delta: float) -> void:
	var strength = shake_strength ** 2
	
	offset = Vector2(
		randf_range(-strength, strength),
		randf_range(-strength, strength) * 0.2
	)
	
	if shake_strength > 0:
		shake_strength -= SHAKE_DECAY * delta
		
	elif shake_strength < 0:
		shake_strength = 0
	

func _on_health_update(team, health, max_health):
	if team == 'ally' and 1==2:
		zoom = Vector2(hit_zoom_amount, hit_zoom_amount)
		
		if zoom_tween: zoom_tween.kill()
		zoom_tween = create_tween()

		zoom_tween.set_trans(Tween.TRANS_CUBIC)
		zoom_tween.set_ease(Tween.EASE_OUT)
		zoom_tween.tween_property(self, "zoom", Vector2(1.0, 1.0), 0.3)
