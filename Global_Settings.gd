extends Node

signal FPS_displayed(value)
signal Contrast_updated(value)
signal Brightness_updated(value)



func toggle_fullscreen(toggle):
	OS.window_fullscreen = toggle
	SaveSettingsData.Data_Settings.FullScreen_on = toggle
	SaveSettingsData.Data_Save()
	
	
func toggle_vsync(toggle):
	OS.vsync_enabled = toggle
	SaveSettingsData.Data_Settings.V_Sync = toggle
	SaveSettingsData.Data_Save()
	
	
func toggle_fps_display(toggle):
	emit_signal("FPS_displayed", toggle)
	SaveSettingsData.Data_Settings.Display_FPS = toggle
	SaveSettingsData.Data_Save()
	
	
func set_max_fps(value):
	Engine.target_fps = value if value < 144 else 0
	SaveSettingsData.Data_Settings.Max_FPS = Engine.target_fps if value < 144 else 144
	SaveSettingsData.Data_Save()
	
func update_contrast (value):
	emit_signal("Contrast_updated",value)
	SaveSettingsData.Data_Settings.Contrast = value
	SaveSettingsData.Data_Save()

	
func update_brightness(value):
	emit_signal("Brightness_updated", value)
	SaveSettingsData.Data_Settings.Brightness = value
	SaveSettingsData.Data_Save()
	
	
func update_master_vol(vol):
	AudioServer.set_bus_volume_db(0, vol)
	SaveSettingsData.Data_Settings.Master_Volume = vol
	SaveSettingsData.Data_Save()
	
	
func update_music_vol(vol):
	AudioServer.set_bus_volume_db(1, vol)
	SaveSettingsData.Data_Settings.Music_Volume = vol
	SaveSettingsData.Data_Save()
		
func update_sfx_vol(vol):
	AudioServer.set_bus_volume_db(2, vol)
	SaveSettingsData.Data_Settings.SFX_Volume = vol
	SaveSettingsData.Data_Save()
	
