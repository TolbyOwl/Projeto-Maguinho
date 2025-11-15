extends CharacterBody2D

@onready var barraVida = $barraVida

var Velocidade = 50
var maxHealth = 10
var health = 10

func _ready():
	barraVida.set_health_bar(health, maxHealth)
func take_damage(damage:int):
	health -= damage
	if health < 0: health = 0
	barraVida.change_health(-damage)

func take_heal(heal:int):
	health += heal
	barraVida.change_health(+heal)



func _physics_process(_delta: float) -> void:
	velocity.x =  0
	velocity.y =  0
	
	
	if Input.is_action_pressed("ui_left"):
		velocity.x = -Velocidade
		$Sprite2D.flip_h=true
		
	if Input.is_action_pressed("ui_right"):
		velocity.x = Velocidade
		$Sprite2D.flip_h=false
		
	if Input.is_action_pressed("ui_up"):
		velocity.y= -Velocidade
		
	if Input.is_action_pressed("ui_down"):
		velocity.y= Velocidade
		
	move_and_slide()
