extends CharacterBody2D

var velocidade = 50
var velocidade_p = 200
var direction = Vector2.ZERO
var marker= [0,0]
@onready var Maguin_Animations = $AnimatedSprite2D
var vivo:= true

func _process(delta: float) -> void:
	_verificar_vida()
	if (vivo):
		_obter_direcao(delta)
		_processar_movimento()
		_processar_animacao()
		move_and_slide()
		ScriptGlobal.Maguin1 = self

func _verificar_vida():
	if (ScriptGlobal.Vida==0 and vivo):
		Maguin_Animations.play("Morrendo")
		vivo = false

func _processar_movimento():
	velocity.x =  0
	velocity.y =  0
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -velocidade
		Maguin_Animations.flip_h=true
		
	if Input.is_action_pressed("ui_right"):
		velocity.x = velocidade
		Maguin_Animations.flip_h=false
		
	if Input.is_action_pressed("ui_up"):
		velocity.y= -velocidade
		
	if Input.is_action_pressed("ui_down"):
		velocity.y= velocidade

func _processar_animacao():

	if Input.is_action_just_pressed("Key_e"):
		Maguin_Animations.play("Ataque_Fogo")
		Maguin_Animations.position.x = -9 if Maguin_Animations.flip_h == true else 3
		_invocar_projetil(direction)

	if Maguin_Animations.animation == "Ataque_Fogo":
		velocity.x = 0
		velocity.y = 0
	else:
		if velocity.x == 0:
			Maguin_Animations.play("Parado")
			Maguin_Animations.position.x = -3
		else:
			Maguin_Animations.play("Caminhando")
			Maguin_Animations.position.x = -3

func _escudo():
	pass
	

func _obter_direcao(delta):
	marker[0]=0
	marker[1]=0
	# Check for arrow key presses
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
		marker[1]=-1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
		marker[1]=1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
		marker[0]=-1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1
		marker[0]=1

	# Normalize the direction vector if it's not zero
	if direction.length() > 0:
		direction = direction.normalized()

func _invocar_projetil(direction):
	var cena_projetil = preload("res://Cenas/cena_projetil.tscn")
	var objeto_projetil = cena_projetil.instantiate()
	
	if objeto_projetil:
		get_tree().root.add_child(objeto_projetil)
		
		
		match marker:
			[0,-1]:
				print("Norte")
				objeto_projetil.global_position = $Norte.global_position
			[1,-1]:
				objeto_projetil.global_position = $Nordeste.global_position
			[1,0]:
				objeto_projetil.global_position = $Leste.global_position
			[1,1]:
				objeto_projetil.global_position = $Sudeste.global_position
			[0,1]:
				objeto_projetil.global_position = $Sul.global_position
			[-1,1]:
				objeto_projetil.global_position = $Sudoeste.global_position
			[-1,0]:
				objeto_projetil.global_position = $Oeste.global_position
			[-1,-1]:
				objeto_projetil.global_position = $Noroeste.global_position

		# Assuming your projectile has a script with a speed variable
		var projectile_speed = velocidade_p * direction
		objeto_projetil.set("velocity", projectile_speed)

		# Optional: Set the direction to an Area2D node
	if objeto_projetil.has_node("Area2D"):
		var area_node = objeto_projetil.get_node("Area2D")
		area_node.direcao = direction
