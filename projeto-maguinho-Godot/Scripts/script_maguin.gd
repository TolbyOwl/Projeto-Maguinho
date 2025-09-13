extends CharacterBody2D

var Velocidade = 50

func _physics_process(delta: float) -> void:
	velocity.x =  0
	velocity.y =  0
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -Velocidade
		$Sprite2D.flip_h=true
		
	if Input.is_action_pressed("ui_right"):
		velocity.x = Velocidade
		$Sprite2D.flip_h=false
		
	if Input.is_action_pressed("ui_up"):
		velocity.y= -Velocidade
		
	if Input.is_action_pressed("ui_down"):
		velocity.y= Velocidade
		
	move_and_slide()
