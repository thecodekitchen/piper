class_name GraphNodeMenu
extends PopupMenu

var editor:GraphEdit
var graph_nodes:Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	index_pressed.connect(menu_router)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func instantiate_graph_element(packed:PackedScene) -> void:
	var graph_element: GraphElement = packed.instantiate()
	var name = graph_element.name
	var match_count = 0
	for child in editor.get_children():
		if child.name.contains(name):
			match_count += 1
	if match_count != 0:
		name += str(match_count)
	graph_element.name = name
	var mouse_position: Vector2 = editor.get_local_mouse_position()
	graph_element.position_offset = (mouse_position+editor.scroll_offset)/editor.zoom
	editor.add_child(graph_element)
	
func menu_router(idx:int) -> void:
	instantiate_graph_element(graph_nodes[idx])
