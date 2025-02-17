extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_changed.connect(update_doc_store_url)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_doc_store_url(new:String)->void:
	Globals.qdrant_url = new
