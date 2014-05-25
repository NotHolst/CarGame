extends RigidBody2D
 
var input_states = preload("input_states.gd")
 
 
var move_left = input_states.new("ui_left")
var move_right = input_states.new("ui_right")
var move_up = input_states.new("ui_up")
var move_down = input_states.new("ui_down")
       
 
export var run_speed = 600
export var acceleration = 1
export var deceleration = 2
 
export var rot_degree = 3
 
var current_speed = 0
var current_rot = 0.0
var rot = 0.0
 
 
func _ready():
        # Initalization here
        set_fixed_process(true)
       
func _fixed_process( delta ):
	
	if get_linear_velocity().length() == 0:
		print("yes")
	else:
		print("no")
       
	if move_left.check() == 1 or move_right.check() == 1:
		rot = get_rot()
		current_rot = get_rot()
	if move_left.check() == 2:
		rotate_player(rot_degree*clamp((get_linear_velocity().length()*.005),0,1),delta)
	elif move_right.check() == 2:
		rotate_player(-rot_degree*clamp((get_linear_velocity().length()*.005),0,1),delta)
       
 
       
	if move_up.check() == 2:
		move(-run_speed,acceleration,delta)
	elif move_down.check() == 2:
		move(run_speed*0.5,acceleration,delta)
	elif move_up.check() == 0 and move_down.check() == 0:
		move(0,deceleration,delta)

       
### apply the speed vector to the velocity     
	set_linear_velocity(Vector2(0,current_speed).rotated(get_rot()))
	#print(get_linear_velocity().length())
       
       
 
func move(speed, acceleration, delta):
	current_speed = lerp(current_speed, speed, acceleration*delta)
 
 
func rotate_player(degree,delta):
	if current_speed < 0:
		current_rot += deg2rad(degree)
	else:
		current_rot -= deg2rad(degree)
       
	rot = lerp(rot,current_rot,5*delta)
               
	set_rot(rot)