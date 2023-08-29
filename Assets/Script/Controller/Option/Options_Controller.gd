extends Node2D




#Video Settings

onready var Display_Mode = $TextureRect/VBoxContainer/Settings/Video/GridContainer/Display_Mode_Options
onready var V_Sync = $TextureRect/VBoxContainer/Settings/Video/GridContainer/V_Sync_Switch
onready var Display_FPS = $TextureRect/VBoxContainer/Settings/Video/GridContainer/Display_FPS_Switch
onready var Max_FPS_Label = $TextureRect/VBoxContainer/Settings/Video/GridContainer/Max_FPS_Settings/Max_FPS_Label
onready var Max_FPS = $TextureRect/VBoxContainer/Settings/Video/GridContainer/Max_FPS_Settings/Max_FPS_Slider
onready var Max_Contrast_Label = $TextureRect/VBoxContainer/Settings/Video/GridContainer/Contrast_Settings/Max_Contrast_Label
onready var Contrast = $TextureRect/VBoxContainer/Settings/Video/GridContainer/Contrast_Settings/Contrast_Slider
onready var Max_Brightness_Label = $TextureRect/VBoxContainer/Settings/Video/GridContainer/Brightness_Settings/Max_Brightness_Label
onready var Brightness = $TextureRect/VBoxContainer/Settings/Video/GridContainer/Brightness_Settings/Brightness_Slider

#Audio Settings
onready var Master_Volume = $TextureRect/VBoxContainer/Settings/Audio/GridContainer/Master_Volume_Settings/Master_Slider
onready var Max_Master_Volume_Label = $TextureRect/VBoxContainer/Settings/Audio/GridContainer/Master_Volume_Settings/Max_Master_Label
onready var Music_Volume = $TextureRect/VBoxContainer/Settings/Audio/GridContainer/Music_Volume_Settings/Music_Slider
onready var Max_Music_Volume_Label = $TextureRect/VBoxContainer/Settings/Audio/GridContainer/Music_Volume_Settings/Max_Music_Label
onready var SFX_Volume = $TextureRect/VBoxContainer/Settings/Audio/GridContainer/SFX_Volume_Settings/SFX_Slider
onready var Max_SFX_Volume_Label = $TextureRect/VBoxContainer/Settings/Audio/GridContainer/SFX_Volume_Settings/Max_SFX_Label

#Audio SFX
onready var Back_Button_Sound = $TextureRect/VBoxContainer/HBoxContainer/Back_Button/Back_Sound
onready var Save_Button_Sound = $TextureRect/VBoxContainer/HBoxContainer/Save_Button/Save


	
func _on_Back_Button_pressed():
	get_tree().change_scene("res://Assets/Scence/Main_Menu/Main_Menu.tscn")


func _on_Save_Button_pressed():
	#Video
	Display_Mode.select(1 if SaveSettingsData.Data_Settings.FullScreen_on else 0)
	GlobalSettings.toggle_fullscreen(SaveSettingsData.Data_Settings.FullScreen_on)
	V_Sync.pressed = SaveSettingsData.Data_Settings.V_Sync
	Display_FPS.pressed = SaveSettingsData.Data_Settings.Display_FPS
	Max_FPS.value = SaveSettingsData.Data_Settings.Max_FPS
	Contrast.value = SaveSettingsData.Data_Settings.Contrast
	Brightness.value = SaveSettingsData.Data_Settings.Brightness
	
	#Audio
	Master_Volume.value = SaveSettingsData.Data_Settings.Master_Volume
	Music_Volume.value = SaveSettingsData.Data_Settings.Music_Volume
	SFX_Volume.value = SaveSettingsData.Data_Settings.SFX_Volume

func _on_Display_Mode_Options_item_selected(index):
	GlobalSettings.toggle_fullscreen(true if index==1 else false)


func _on_V_Sync_Switch_toggled(button_pressed):
	GlobalSettings.toggle_vsync(button_pressed)


func _on_Display_FPS_Switch_toggled(button_pressed):
	GlobalSettings.toggle_fps_display(button_pressed)


func _on_Max_FPS_Slider_value_changed(value):
	GlobalSettings.set_max_fps(value)
	Max_FPS_Label.text = str(value) if value < Max_FPS.max_value else "Max"


func _on_Contrast_Slider_value_changed(value):
	GlobalSettings.update_contrast(value)
	Max_Contrast_Label.text = str (value) if value < Contrast.max_value else "Max"


func _on_Brightness_Slider_value_changed(value):
	GlobalSettings.update_brightness(value)
	Max_Brightness_Label.text = str(value) if value < Brightness.max_value else "Max"


func _on_Master_Slider_value_changed(value):
	GlobalSettings.update_master_vol(value)
	Max_Master_Volume_Label.text = str(value) if value < Master_Volume.max_value else "Max"
	

func _on_Music_Slider_value_changed(value):
	GlobalSettings.update_music_vol(value)
	Max_Music_Volume_Label.text = str(value) if value < Music_Volume.max_value else "Max"


func _on_SFX_Slider_value_changed(value):
	GlobalSettings.update_sfx_vol(value)
	Max_SFX_Volume_Label.text = str(value) if value < SFX_Volume.max_value else "Max"


func _on_Back_Button_mouse_entered():
	Back_Button_Sound.play()


func _on_Save_Button_mouse_entered():
	Save_Button_Sound.play()



