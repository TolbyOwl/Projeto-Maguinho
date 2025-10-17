extends ProgressBar

@onready var label = $CharacterBody2D/barraVida/Label

func set_health_bar(health, maxHealth):
	max_value = maxHealth
	value = health
	
	label.text = str(health)
	
func change_health(newValue):
	value += newValue
	label.text = str(value)
	
