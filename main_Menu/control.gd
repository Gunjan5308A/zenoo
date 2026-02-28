extends Control


@onready var controls_image = $ControlsImage
@onready var close_button = $ControlsImage/CloseButton
var menu_scene = preload("res://main.tscn")

func _ready() -> void:
	controls_image.visible = false
	
	# Connect close button
	close_button.pressed.connect(_on_close_pressed)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")  # THIS WORKS

func _on_button_3_pressed() -> void:
	controls_image.visible = true


func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_close_pressed() -> void:
	controls_image.visible = false


func _process(_delta):
	# Press ESC to close controls image
	if controls_image.visible and Input.is_action_just_pressed("ui_cancel"):
		controls_image.visible = false
