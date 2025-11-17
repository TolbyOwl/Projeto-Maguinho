extends CharacterBody2D

var velocidade := 400
var gravidade := 30
var forca_pulo := 800
var viva:= true

func _ready() -> void:
	pass
	#ScriptGlobal.resetar()

func _process(delta: float) -> void:
	_verificar_vida()
	if (viva):		
		_aplicar_gravidade()
		_processar_movimento()
		_processar_animacao()
		_processar_pulo()
		move_and_slide()

func _verificar_vida():
	if (ScriptGlobal.qtd_vidas==0 and viva):
		$AnimationPlayer.play("morrendo")
		viva = false

func _game_over():
	get_tree().change_scene_to_file("res://cena_game_over.tscn")
	

func _aplicar_gravidade() -> void:
	velocity.y += gravidade

func _processar_movimento() -> void:
	velocity.x = 0
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -velocidade
		$Sprite2D.scale.x = -abs($Sprite2D.scale.x)
	elif Input.is_action_pressed("ui_right"):
		velocity.x = velocidade
		$Sprite2D.scale.x = abs($Sprite2D.scale.x)

func _processar_pulo() -> void:
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -forca_pulo
		$AnimationPlayer.play("pulando")

func _processar_animacao() -> void:
	if not is_on_floor():
		return  # deixa a animação de pulo cuidar sozinha

	if Input.is_action_just_pressed("ui_accept"):
		$AnimationPlayer.play("atirando")
		var cena_disparo = preload("res://cena_disparo.tscn")
		var objeto_disparo = cena_disparo.instantiate()
		get_tree().root.add_child(objeto_disparo)
		if ($Sprite2D.scale.x < 0):
			objeto_disparo.global_position = $Marker2DEsq.global_position
			objeto_disparo.get_node("Area2D").direcao = -1
		else:
			objeto_disparo.global_position = $Marker2DDir.global_position
			objeto_disparo.get_node("Area2D").direcao = 1


	if $AnimationPlayer.current_animation == "atirando":
		velocity.x = 0
	else:
		if velocity.x == 0:
			$AnimationPlayer.play("parado")
		else:
			$AnimationPlayer.play("correndo")
