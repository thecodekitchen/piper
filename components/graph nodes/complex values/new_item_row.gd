class_name ItemRow
extends HBoxContainer

var idx:int
var label:Label
var edit:LineEdit
var button:Button
var is_new:bool=false
# Called when the node enters the scene tree for the first time.
signal updated(val,idx:int)
signal add(val)
signal delete(idx:int)

func _ready() -> void:
	label = $Label
	edit = $LineEdit
	button = $Button
	edit.text_submitted.connect(text_submitted)
	button.pressed.connect(button_pressed)

func text_submitted(text:String)->void:
	if is_new:
		emit_signal("add",text)
	else:
		emit_signal("updated",text,idx)
		
func button_pressed()->void:
	if is_new:
		emit_signal("add",edit.text)
	else:
		emit_signal("delete",idx)
