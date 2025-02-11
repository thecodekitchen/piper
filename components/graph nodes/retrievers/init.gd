extends PipelineGraphNode


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	data["deps"]=[
		"qdrant-haystack"
	]
	data["import"] = "haystack_integrations.components.retrievers.qdrant.retriever.QdrantEmbeddingRetriever"
	data["component_name"] = "retriever"
	inputs =[Pipeline.DataType.DocStore]
	slot(0,Pipeline.DataType.DocStore)

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
