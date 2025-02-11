extends GraphNodeMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/builders/AnswerBuilder.tscn"),
		preload("res://components/graph nodes/builders/PromptBuilder.tscn"),
		preload("res://components/graph nodes/builders/ChatPromptBuilder.tscn"),
		preload("res://components/graph nodes/builders/DynamicPromptBuilder.tscn"),
		preload("res://components/graph nodes/builders/DynamicChatPromptBuilder.tscn"),
	]
