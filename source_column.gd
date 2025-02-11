extends VBoxContainer

var view:Viewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	view = get_viewport()
	view.size_changed.connect(_resize)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _resize()->void:
	var view_size = view.get_visible_rect().size
	size.x = view_size.x * 0.2
	size.y = view_size.y - 40
