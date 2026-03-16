extends Control

# Signal emmitted after being closed
signal back_pressed
@export var video: PackedScene
var vid

@export var audio: PackedScene
var aud

@export var main_menu: PackedScene
var menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$frame/VBoxContainer/Video.call_deferred("grab_focus")

#func _physics_process(_delta: float) -> void:
	#if Input.is_action_just_pressed("back_button"):
		#on_back_button_pressed()
#
#
#func on_back_button_pressed():
	#back_pressed.emit()
	#queue_free()


func _on_back_pressed() -> void:
	back_pressed.emit()
	queue_free()


func _on_video_pressed() -> void:
	vid = video.instantiate()
	add_child(vid)
	
	$frame.hide()
	
	vid.tree_exited.connect(func():$frame.show() )
	

func _on_frame_visibility_changed() -> void:
	$frame/VBoxContainer/Video.grab_focus()



func _on_audio_pressed() -> void:
	aud = audio.instantiate()
	add_child(aud)
	
	$frame.hide()
	
	aud.tree_exited.connect(func():$frame.show() )


func _on_mainmenu_pressed() -> void:
	#menu = main_menu.instantiate()
	#add_child(menu)
	var men = main_menu.instantiate()
	add_child(men)
	
	
