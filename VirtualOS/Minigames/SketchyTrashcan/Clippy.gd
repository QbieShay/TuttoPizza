extends Control

export var text_speed = 1.0
export var modulation_speed = 0.8

onready var clippy_text = $Panel/ClippyText
onready var c_inter = $ColorInterpolator
onready var c_fader = $FadeInterpolator
onready var start_mod = Color(1.0, 1.0, 1.0, 0.0)
onready var end_mod = Color(1.0, 1.0, 1.0, 1.0)

func change_text(text):
	clippy_text.text = text
	clippy_text.visible_characters = -1
	# non funziona l'interpolazione sui characters
	#c_inter.interpolate_property(clippy_text, 'visible_characters', clippy_text.visible_characters, clippy_text.get_total_character_count(), text_speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	c_fader.interpolate_property(self, 'modulate', self.modulate, end_mod, modulation_speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	#c_inter.start()
	c_fader.start()

func _on_CloseButton_pressed():
	c_fader.interpolate_property(self, 'modulate', self.modulate, start_mod, modulation_speed, Tween.TRANS_LINEAR, Tween.EASE_IN)
	c_fader.start()