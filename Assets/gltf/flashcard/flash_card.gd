extends PanelContainer

@onready var input_field = $VBoxContainer/LineEdit # Adjust path if needed

func _ready():
	# Start hidden and small
	self.modulate.a = 0 
	self.scale = Vector2(0.5, 0.5)
	self.pivot_offset = self.size / 2 
	self.hide() # Fully hide at start

func _input(event):
	# Toggle card visibility with "E"
	if event is InputEventKey and event.pressed and event.keycode == KEY_E:
		if not self.visible:
			show_card()
		else:
			hide_card()

func show_card():
	self.show()
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "modulate:a", 1.0, 0.3)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.3).set_trans(Tween.TRANS_BACK)
	input_field.grab_focus() # Ready to type immediately

func hide_card():
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "modulate:a", 0.0, 0.2)
	tween.tween_property(self, "scale", Vector2(0.5, 0.5), 0.2)
	tween.chain().callback(self.hide)

# --- EARLIER PART: INPUT LOGIC ---
func _on_line_edit_text_submitted(new_text: String):
	var player_answer = new_text.strip_edges().to_lower()
	
	if player_answer == "puzzle": # Example answer
		print("Correct!")
		hide_card() # Hide after a correct answer
	else:
		print("Wrong answer: ", player_answer)
	
	input_field.clear()
