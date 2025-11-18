extends CharacterBody2D
var velocidade = 30
var gravidade  = 30
var direcao    = 1  # 1 direita, -1 esquerda

func _physics_process(delta: float) -> void:
	velocity.y += 30	
	velocity.x = velocidade * direcao	
	if (not $RayCast2DDir.is_colliding()):
		direcao = -1		
	if (not $RayCast2DEsq.is_colliding()):
		direcao = 1		
	move_and_slide()
	
	#Area2D SERÁ USADO NO DISPARO

func atacar_personagem(body: Node2D) -> void:
	if (body.name=="Personagem"):
		ScriptGlobal.qtd_vidas -= 1
