extends Node

@export var SPEED = 100
@export var damage = 1

var dir : float
var spawnPos : Vector2
var spawnRot : float

func _ready():
	global_position = spawnPos
	global_rotation = spawnRot
	
func _physics_process(delta):
	var attack_direction = input.get_vector("left", "right", "up", "down")
	velocity = Vector2(0-SPEED).rotated(dir)
	if (input.is_action_just_pressed(atacar)):
		var novoProjetil = projetile.instanciate() as Area2D

	move_and_slide()
	
func _on_area_2d_body_entered(body):
	print("HIT!!!!")
	queue_free()

func _on_shotLife_time_out():
	queue_free()



func on_hurtbox_entered(body : Node2D):
	if body is_in_group(inimigo):
		print ("enemy netered ", body.damage)
		barraVida.change_health
		
