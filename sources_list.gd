extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.updated_sources.connect(update_sources)

func update_sources()->void:
	for child in get_children():
		child.queue_free()
	for src in Globals.sources:
		print(src)
		if src.has("meta") and src["meta"].has("file_path"):
			var doc_label = Label.new()
			doc_label.text = src["meta"]["file_path"]
			add_child(doc_label)
