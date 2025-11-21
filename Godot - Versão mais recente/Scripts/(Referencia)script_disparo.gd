extends Area2D

var velocidade = 5
var direcao    = 1 # 1 direta, -1 esquerda
func _process(delta: float) -> void:
	global_position.x += velocidade * direcao
	
#func destruir_inimigo(body: Node2D) -> void:
	#if (body.name=="Inimigo"):
		#var cena_vida   = preload("res://cena_vida.tscn")
		#var objeto_vida = cena_vida.instantiate()
		#get_tree().root.add_child(objeto_vida)
		#objeto_vida.global_position = body.global_position
		#body.queue_free()
		#get_parent().queue_free()
	
