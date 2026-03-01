extends Node

@onready var flashcard_ui: FloorFlashcard = $FlashCard as FloorFlashcard
@onready var level1_subtractor: CSGBox3D = $layer1/solid_shape/CSGBox3D/Decor1
@onready var level2_subtractor: CSGBox3D = $layer2/floor/subractor
@onready var level3_subtractor: CSGBox3D = $layer3/floor/subractor  # if you have more floors
@onready var end_screen: TextureRect = $endScreen

var current_floor = 1
var total_floors = 3  # adjust depending on your riddles

func _ready():
	if flashcard_ui:
		flashcard_ui.connect("correct_answer", Callable(self, "on_correct_riddle"))
		print("[DEBUG] Signal connected to flashcard")
	else:
		print("[ERROR] flashcard_ui is null!")

	print("[DEBUG] Level manager ready. Current floor:", current_floor)
	#end_screen.visible = false
	
	
func on_correct_riddle():
	print("[DEBUG] on_correct_riddle called | current_floor:", current_floor)
	open_hole(current_floor)

	# Move to next floor
	current_floor += 1
	if current_floor <= total_floors:
		print("[DEBUG] Moving to next floor:", current_floor)
	else:
		print("[DEBUG] All floors completed!")
		show_end_screen()

func open_hole(floor):
	match floor:
		1:
			if level1_subtractor:
				print("[DEBUG] Opening level 1 hole")
				level1_subtractor.operation = CSGShape3D.OPERATION_SUBTRACTION
				level1_subtractor.visible = true
		2:
			if level2_subtractor:
				print("[DEBUG] Opening level 2 hole")
				level2_subtractor.operation = CSGShape3D.OPERATION_SUBTRACTION
				level2_subtractor.visible = true
		3:
			if level3_subtractor:
				print("[DEBUG] Opening level 3 hole")
				level3_subtractor.operation = CSGShape3D.OPERATION_SUBTRACTION
				level3_subtractor.visible = true

func show_end_screen():
	print("[DEBUG] Showing end screen")
	end_screen.visible = true
	# Optional: unlock mouse if player is locked
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
