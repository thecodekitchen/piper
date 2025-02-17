extends LineEdit


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text_changed.connect(update_ollama_url)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update_ollama_url(new:String)->void:
	Globals.ollama_url = new
