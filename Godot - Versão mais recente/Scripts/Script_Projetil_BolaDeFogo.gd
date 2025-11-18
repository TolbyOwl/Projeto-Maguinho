extends Area2D

var velocidade_p = 80
var direcao = Vector2.RIGHT  

func _process(delta: float) -> void:
	global_position += velocidade_p * direcao * delta
	var apontar_sprite = global_position + direcao * 10  
	look_at(apontar_sprite)
	

func _auto_destruir():
	get_parent().queue_free()

#obsoleto
func destruir_inimigo(body: Node2D) -> void:
	body.queue_free()
	get_parent().queue_free()
	
