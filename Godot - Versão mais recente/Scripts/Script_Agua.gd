extends TileMapLayer

var t = 0

func _process(delta):
	t += delta
	 # Oscillate blue channel to simulate water movement
	var b = 0.7 + 0.3 * sin(t * 2.0)
	modulate = Color(0.3, 0.5, b)  # RGB values
	
