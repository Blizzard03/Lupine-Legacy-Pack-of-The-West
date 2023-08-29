class_name Blizzard
extends KinematicBody2D

signal exp_gain(exp)

export (int) var speed = 70

#Blizzard Stat
export (int) var Blizzard_Health = 100
export (float) var Blizzard_Stregth = 10.5
export (float) var Blizzard_Attack = 5.5
export (float) var Blizzard_Defense = 4.5

# Leveling System
export (int) var Blizzard_LV = 1
export (int) var Blizzard_XP = 0
export (int) var Blizzard_XP_Tot = 0
export (int) var Blizzard_XP_Required = get_required_exp(Blizzard_LV + 1)

func get_required_exp(Blizzard_LV):
	return round(pow(Blizzard_LV, 1.8) + Blizzard_LV * 4)

func gain_exp(experience):
	Blizzard_XP_Tot += experience
	Blizzard_XP += experience
	var exp = []
	while Blizzard_XP >= Blizzard_XP_Required :
		Blizzard_XP -= Blizzard_XP_Required
		exp.append([Blizzard_XP_Required, Blizzard_XP_Required])
		LVUP()
	exp.append([Blizzard_XP, get_required_experience(Blizzard_LV + 1)])
	emit_signal("exp_gain", exp)


#Move Blizzard
func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("Move_Right") - Input.get_action_strength("Move_Left")
	input_vector.y = Input.get_action_strength("Move_Down") - Input.get_action_strength("Move_Up")
	
	move_and_slide(input_vector*speed)
	


	
