extends Area2D

var velocidade_p = 80
var direcao = Vector2.RIGHT  

func _ready() -> void:
	if get_parent().get_parent().name == "Tela_Pontos":
		$Tempo_Vida.start(15.0)

func _process(delta: float) -> void:
	global_position += velocidade_p * direcao * delta
	var apontar_sprite = global_position + direcao * 10  
	look_at(apontar_sprite)
	
func _auto_destruir() -> void:
	get_parent().queue_free()
	
