extends FileDialog
# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	filters = ["*.json; JSON Files"]
	file_selected.connect(load_graph)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func load_graph(path:String)->void:
	Globals.load_pipeline(path)
	Globals.initialize_pipeline_graph()
