extends Node


@onready var flashcard_ui = $Node3D/FlashCard as FloorFlashcard




func _ready():
	# Make sure flashcard is hidden at start
	flashcard_ui.hide()

func _process(delta):
	# Toggle flashcard visibility when E is pressed
	if Input.is_action_just_pressed("toggle_flashcard"):  
		if flashcard_ui.visible:
			flashcard_ui.hide_card()
		else:
			flashcard_ui.show_card()
