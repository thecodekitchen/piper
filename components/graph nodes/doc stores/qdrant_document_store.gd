extends PipelineGraphNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	data["deps"]=[
		"qdrant-haystack"
	]
	data["import"] = "haystack_integrations.document_stores.qdrant.document_store.QdrantDocumentStore"
	inputs = [
		Pipeline.DataType.Bool,
		Pipeline.DataType.URL,
		Pipeline.DataType.PlainString,
		Pipeline.DataType.Int,
		Pipeline.DataType.Bool
	]
	outputs = [
		Pipeline.DataType.DocStore
	]
	
	slot(0,Pipeline.DataType.Bool,Pipeline.DataType.DocStore)
	slot(1,Pipeline.DataType.URL)
	slot(2,Pipeline.DataType.PlainString)
	slot(3,Pipeline.DataType.Int)
	slot(4,Pipeline.DataType.Bool)
#	No input ports should allow multiple inputs
	inputs_allow_multi = [false,false,false,false,false]
	if not data.has("variables"):
		data["variables"] = {}
	if not data.has("value"):
		data["value"] = {
			"type": "haystack_integrations.document_stores.qdrant.document_store.QdrantDocumentStore",
			"in_memory": false,
			"url": "http://localhost:6333",
			"api_key": {
				"env_vars": ["QDRANT_API_KEY"],
				"strict": true,
				"type": "env_var"
			},
			"embedding_dim":768,
			"recreate_index": false
		}

func handle_port_change(port:int,val):
	match port:
		0:
			if val is bool:
				data["value"]["in_memory"] = val
		1:
#				TODO: implement URL validation
			if val is String:
				data["value"]["url"] = val
		2:
			if val is String:
				data["value"]["index"] = val
		3:
			if val is int:
				data["value"]["embedding_dim"] = val
		4:
			if val is bool:
				data["value"]["recreate_index"] = val

func handle_param_assignment(port:int,param_data)->void:
	var param = param_data["name"]
	match port:
		0:
			data["variables"]["in_memory"] = param
		1:
			data["variables"]["url"] = param
		2:
			data["variables"]["index"] = param
		3:
			data["variables"]["embedding_dim"] = param
		4:
			data["variables"]["recreate_index"] = param
			
