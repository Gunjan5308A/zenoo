class_name FloorFlashcard
extends PanelContainer

signal correct_answer  # emitted when a riddle is answered correctly

@onready var input_field = $VBoxContainer/LineEdit
@onready var question_label = $VBoxContainer/Label

var riddles = [
	{"question":"Bed, plate, box,\n candle, bottle,\n ___ (fill the gap)", "answer":"stool"},
	{"question":"I run but never walk.\n I have a mouth but never talk. \nWhat am I?", "answer":"rain"},
	{"question":"something is not working", "answer":"torch"}
]

var current_riddle_index = 0

func _ready():
	hide()  # Start hidden
	modulate.a = 0
	scale = Vector2(0.5, 0.5)
	pivot_offset = size / 2
	input_field.connect("text_submitted", Callable(self, "_on_line_edit_text_submitted"))
	print("[DEBUG] Flashcard ready. Current riddle index:", current_riddle_index)
	update_question()

func show_card():
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	input_field.grab_focus()
	print("[DEBUG] Showing flashcard")
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	tween.tween_property(self, "scale", Vector2(1,1), 0.3).set_trans(Tween.TRANS_BACK)

func hide_card():
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "modulate:a", 0.0, 0.2)
	tween.tween_property(self, "scale", Vector2(0.5,0.5), 0.2)
	tween.tween_callback(Callable(self, "hide"))
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	print("[DEBUG] Hiding flashcard")

func update_question():
	if current_riddle_index < riddles.size():
		question_label.text = riddles[current_riddle_index]["question"]
		input_field.editable = true
		print("[DEBUG] Next question:", riddles[current_riddle_index]["question"])
	else:
		question_label.text = "All riddles completed!"
		input_field.editable = false

func _on_line_edit_text_submitted(new_text: String):
	if current_riddle_index >= riddles.size():
		return
	var player_answer = new_text.strip_edges().to_lower()
	var correct_answer = riddles[current_riddle_index]["answer"]
	print("[DEBUG] Player answered:", player_answer, "| Correct answer:", correct_answer)
	if player_answer == correct_answer:
		print("Correct! ✅")
		hide_card()
		current_riddle_index += 1
		update_question()
		emit_signal("correct_answer")
	else:
		print("Wrong answer ❌:", player_answer)
	input_field.clear()
