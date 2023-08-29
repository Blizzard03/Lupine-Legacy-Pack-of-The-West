class_name Main_Menu
extends Node2D

#Audio 
onready var background_sound = $Backsound
onready var New_Game_Sound = $Buttons_List/Button/New_Game_Button/New_Game_Sound
onready var Con_Sound = $Buttons_List/Button/Continue_Button/Continue_Sound
onready var Options_Sound= $Buttons_List/Button/Options_Button/Options_Sound
onready var Exit_Sound = $Buttons_List/Button/Exit_Button/Exit_Sound
onready var Howling = $Howl/Howling


func _ready():
	background_sound.play()
	
func _on_New_Game_Button_pressed():
	get_tree().change_scene("res://Assets/Scence/How to Play/How to Play.tscn")

func _on_Continue_Button_pressed():
	pass #

func _on_Options_Button_pressed():
	get_tree().change_scene("res://Assets/Scence/Options/Options_Settings.tscn")

func _on_Exit_Button_pressed():
	get_tree().quit()
	
func _on_New_Game_Button_mouse_entered():
	New_Game_Sound.play()

func _on_Options_Button_mouse_entered():
	Options_Sound.play()
	
func _on_Exit_Button_mouse_entered():
	Exit_Sound.play()

func _on_Continue_Button_mouse_entered():
	Con_Sound.play()

func _on_Howl_mouse_entered():
	pass # Replace with function body.
