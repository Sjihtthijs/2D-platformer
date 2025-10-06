extends CharacterBody2D

# --------- VARIABLES ---------- #
@export_category("Player Properties") # You can tweak these changes according to your likings
@export var move_speed : float = 200


@onready var player_sprite = $AnimatedSprite2D
@onready var spawn_point = %SpawnPoint
@onready var particle_trails = $ParticleTrails
@onready var death_particles = $DeathParticles

# --------- BUILT-IN FUNCTIONS ---------- #

func _ready():
	velocity.x = move_speed

func _process(_delta):
	# Calling functions
	movement()
	player_animations()
	flip_player()
	
# --------- CUSTOM FUNCTIONS ---------- #

# <-- Player Movement Code -->
func movement():
	#constant movement
	if is_on_wall():
		velocity.x *= -1
		
	velocity = Vector2(velocity.x, 0)
	move_and_slide()


func player_animations():

	if velocity.x > 0:
		player_sprite.play("Block_Right")
	else:
		player_sprite.play("Block_Left")



func flip_player():
	if velocity.x < 0: 
		player_sprite.flip_h = true
	elif velocity.x > 0:
		player_sprite.flip_h = false

# --------- SIGNALS ---------- #
func _on_collision_body_entered(_body):
	if _body.is_in_group("Player"):
		player_sprite.play("Block_idle")
		velocity.x = 0
