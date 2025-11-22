extends CharacterBody2D

var Alvo = ScriptGlobal.Maguin1
var speed = 30
@onready var GPS = $NavigationAgent2D

func _ready() -> void:
	call_deferred("encontre_alvo")

func _physics_process(delta: float) -> void:
	if Alvo:
		GPS.target_position = Alvo.global_position
	var caminho = GPS.get_next_path_position()
	velocity = global_position.direction_to(caminho) * speed
	move_and_slide()
	$AnimatedSprite2D.flip_h = false if velocity.x > 0 else true

func encontre_alvo() -> void:
	await get_tree().physics_frame
	if Alvo:
		GPS.target_position = Alvo.global_position
