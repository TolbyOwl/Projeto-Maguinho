extends Camera2D

var target = Node2D

func _ready() -> void:
	target = get_node("res://Cenas/Cena_Maguin.tscn")

func _process(delta: float) -> void:
	if target: 
		position = target.position
