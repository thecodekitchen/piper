extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	inputs = [Pipeline.DataType.DocStore]
	outputs = []
	slot(0,Pipeline.DataType.DocStore)
	data["policy"] = "NONE"
	
func handle_port_change(port:int,val)->void:
	match port:
		0:
			if val is Dictionary and val.has("type"):
				var store_type = val["type"]
				val.erase("type")
				data["document_store"] = {
					"type": store_type,
					"init_parameters":val
				}
			else:
				push_error("invalid doc store connected to ", name)
