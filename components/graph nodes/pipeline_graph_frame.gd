class_name PipelineGraphFrame
extends GraphFrame

var copy:PackedScene
var node_copies:Array[PackedScene]
var copy_offset:Vector2
var editor:PipelineGraphEdit
var component_type:Pipeline.ComponentType
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_children().size() > 0 && get_child(0) is VBoxContainer:
		var vbox = get_children()[0]
		var nodes = vbox.get_children() as Array[PipelineGraphNode]
		editor = get_parent() as PipelineGraphEdit
		editor.delete_nodes_request.connect(handle_delete_request)
		editor.copy_nodes_request.connect(handle_copy)
		editor.paste_nodes_request.connect(handle_paste)
		var offset = 0
		for node in nodes:
			node.reparent(editor)
			editor.attach_graph_element_to_frame(node.name,name)
			node.position_offset.y += offset
			offset += node.size.y + 20

# Called every frame. 'delta' is the elapsed time since the previous frame.
func handle_delete_request(nodes:Array[StringName]) -> void:
	if self.selected:
		var attached = editor.get_attached_nodes_of_frame(name)
		if attached.size()>0:
			for node_name in attached:
				var node = editor.get_node(NodePath(node_name))
				node.queue_free()	
		if nodes.has(StringName(self.name)):
			self.queue_free()

func handle_copy() -> void:
	if self.selected:
		var packed = PackedScene.new()
		var result = packed.pack(self)
		if result == OK:
			copy_offset.x = offset_left + 100
			copy_offset.y = offset_top
			copy = packed
			print("Frame packed successfully")
		else:
			print("Failed to pack frame")
		pack_attached_nodes()
	else:
		copy = null
		copy_offset.x = offset_left
		copy_offset.y = offset_top
		
func handle_paste() -> void:
	if copy && node_copies.size() > 0:
		var clone = copy.instantiate()
		editor.add_child(clone)
		clone.position_offset = copy_offset
		var vert_offset = 50
		for i in range(node_copies.size()):
			var node_copy = node_copies[i].instantiate() as PipelineGraphNode
			editor.add_child(node_copy)
			var new_offset = copy_offset
			new_offset.x += 30
			new_offset.y += vert_offset
			node_copy.position_offset = new_offset
			vert_offset += node_copy.size.y + 10
			editor.attach_graph_element_to_frame(node_copy.name,clone.name)
		copy_offset.x += 150
		
func pack_attached_nodes()->void:
	var attached = editor.get_attached_nodes_of_frame(name)
	for node_name in attached:
		var node = editor.get_node(NodePath(node_name))
		var packed = PackedScene.new()
		var result = packed.pack(node)
		if result == OK:
			node_copies.append(packed)
