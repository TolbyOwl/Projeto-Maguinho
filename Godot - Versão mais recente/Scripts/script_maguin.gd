extends CharacterBody2D

var velocidade = 50
var velocidade_p = 200
var direction = Vector2.ZERO
var marker= [0,0]
var escudo_estado = false
var tempo_recarga = 4
@onready var Maguin_Animations = $AnimatedSprite2D
@onready var Escudo_Animations = $AnimatedSprite_Layer2
@onready var Timer_recarga = $Recarregar_escudo
@onready var Colisao_escudo = $AnimatedSprite_Layer2/Area2D
var vivo:= true

func _process(delta: float) -> void:
	_verificar_vida()
	if (vivo):
		_escudo()
		_obter_direcao(delta)
		_processar_movimento()
		_processar_animacao()
		move_and_slide()
		ScriptGlobal.Maguin1 = self

func _verificar_vida():
	if (ScriptGlobal.Vida<=0 and vivo):
		$Morrendo.play()
		Maguin_Animations.play("Morrendo")
		vivo = false
		get_tree().change_scene_to_file("res://Cenas/Cena_Tela_Pontos.tscn")
		ScriptGlobal.salvar_resultado()

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
		var cena_projetil = preload("res://Cenas/Cena_Projetil_Fogo.tscn")
		Maguin_Animations.play("Ataque_Fogo")
		Maguin_Animations.position.x = -9 if Maguin_Animations.flip_h == true else 3
		_invocar_projetil(direction, cena_projetil)

	if Input.is_action_just_pressed("Key_q"):
		var cena_projetil = preload("res://Cenas/Cena_Projetil_Gelo.tscn")
		Maguin_Animations.play("Ataque_Gelo")
		Maguin_Animations.position.x = -9 if Maguin_Animations.flip_h == true else 3
		_invocar_projetil(direction, cena_projetil)

	if (Maguin_Animations.animation == "Ataque_Fogo" or Maguin_Animations.animation == "Ataque_Gelo") and Maguin_Animations.is_playing():
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
	if Input.is_action_just_pressed("Key_w"):
		if !escudo_estado and ScriptGlobal.Vida_Escudo == 1:
			$AnimatedSprite_Layer2/Escudo_Ativando.play()
			escudo_estado = true
		else:
			escudo_estado = false
	#print(str(escudo_estado))
	
	if ScriptGlobal.Vida_Escudo == 0:
		escudo_estado = false
	
	if escudo_estado: 
		Escudo_Animations.visible = true
		Colisao_escudo.monitorable = true
		Colisao_escudo.monitoring = true
		Colisao_escudo.DISABLE_MODE_KEEP_ACTIVE
		$Collision_Escudo.disabled = false
	else:
		Escudo_Animations.visible = false
		Colisao_escudo.monitorable = false
		Colisao_escudo.monitoring = false
		Colisao_escudo.DISABLE_MODE_REMOVE
		$Collision_Escudo.disabled = true
	
	if ScriptGlobal.Vida_Escudo == 0 and Timer_recarga.is_stopped():
		Timer_recarga.start(tempo_recarga)
	#print(str(ScriptGlobal.Vida_Escudo))


func _obter_direcao(delta):
	marker[0]=0
	marker[1]=0
	
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

	# Normalizar
	if direction.length() > 0:
		direction = direction.normalized()

func _invocar_projetil(direction, cena_projetil):
	var objeto_projetil = cena_projetil.instantiate()
	
	if objeto_projetil:
		get_tree().root.add_child(objeto_projetil)
		
		
		match marker:
			[0,-1]:
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

		
		var projectile_speed = velocidade_p * direction
		objeto_projetil.set("velocity", projectile_speed)

		
	if objeto_projetil.has_node("Area2D"):
		var area_node = objeto_projetil.get_node("Area2D")
		area_node.direcao = direction

func _recarregar_escudo():
	ScriptGlobal.Vida_Escudo = 1

func _escudo_danificado(body:Node2D):
	if body.get_parent().is_in_group("Inimigo"):
		$AnimatedSprite_Layer2/Escudo_Quebrando.play()
		ScriptGlobal.Vida_Escudo = 0

func _levar_dano(body:Node2D):
	if body.get_parent().is_in_group("Inimigo_Fraco"):
		ScriptGlobal.Vida -= 1
	elif body.get_parent().is_in_group("Inimigo_Mediano"):
		ScriptGlobal.Vida -= 2
	elif body.get_parent().is_in_group("Inimigo_Forte"):
		ScriptGlobal.Vida -= 3
