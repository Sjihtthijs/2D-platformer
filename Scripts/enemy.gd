extends CharacterBody2D

# --------- VARIABLES ---------- #
@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 200
@export var InputAxis = 1


@onready var player_sprite = $AnimatedSprite2D

# --------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	velocity.x = move_speed

func _process(_delta):
	# Calling functions
	movement()
	player_animations()
	
# --------- CUSTOM FUNCTIONS ---------- #

# <-- Player Movement Code -->
func movement():
	#constant movement
	if is_on_wall():
		InputAxis = -InputAxis
		position.x += InputAxis * velocity.x * 0.001
		position = Vector2(position.x, position.y)

	
	velocity.x = move_speed
	velocity = Vector2(InputAxis * velocity.x, 0)
	move_and_slide()


func player_animations():

	if InputAxis > 0:
		player_sprite.play("Block_Right")
	elif InputAxis < 0:
		player_sprite.play("Block_Left")
	else:
		player_sprite.play("Block_idle")

# --------- SIGNALS ---------- #
func _on_collision_body_entered(_body):
	if _body.is_in_group("Sword"):
		player_sprite.play("Block_idle")
		InputAxis = 0
