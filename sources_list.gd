extends VBoxContainer

@onready var doc_label_scene:PackedScene = preload("res://components/doc_source_Label.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.updated_sources.connect(update_sources)

func update_sources()->void:
	for child in get_children():
		child.queue_free()
	for src in Globals.sources:
		print(src)
		if src.has("meta") and src["meta"].has("file_path"):
			var doc_label = doc_label_scene.instantiate()
			doc_label.text = src["meta"]["file_path"]
			doc_label.tooltip_text = src["content"]
			doc_label.mouse_filter = Control.MOUSE_FILTER_STOP
			add_child(doc_label)
