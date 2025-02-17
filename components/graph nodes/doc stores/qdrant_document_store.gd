extends PipelineGraphNode

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	data["deps"]=[
		"qdrant-haystack"
	]
	data["import"] = "haystack_integrations.document_stores.qdrant.document_store.QdrantDocumentStore"
	inputs = [
		Pipeline.DataType.URL,
		Pipeline.DataType.PlainString,
		Pipeline.DataType.Int,
		Pipeline.DataType.Bool
	]
	outputs = [
		Pipeline.DataType.DocStore
	]
	
	slot(0,Pipeline.DataType.URL,Pipeline.DataType.DocStore)
	slot(1,Pipeline.DataType.PlainString)
	slot(2,Pipeline.DataType.Int)
	slot(3,Pipeline.DataType.Bool)
#	No input ports should allow multiple inputs
	inputs_allow_multi = [false,false,false,false,false]
	if not data.has("api_variables"):
		data["api_variables"] = {}
	if not data.has("value"):
		data["value"] = {
			"type": "haystack_integrations.document_stores.qdrant.document_store.QdrantDocumentStore",
			"url": "http://localhost:6333",
			"api_key": {
				"env_vars": ["QDRANT_API_KEY"],
				"strict": true,
				"type": "env_var"
			},
			"index": "example",
			"embedding_dim":768,
			"recreate_index": false
		}

func handle_port_change(port:int,val):
	match port:
		0:
#				TODO: implement URL validation
			if val is String:
				data["value"]["url"] = val
		1:
			if val is String:
				data["value"]["index"] = val
		2:
			if val is int:
				data["value"]["embedding_dim"] = val
		3:
			if val is bool:
				data["value"]["recreate_index"] = val

func handle_param_assignment(port:int,param_data)->void:
	var param = param_data["name"]
	match port:
		0:
			data["api_variables"]["url"] = param
		1:
			data["api_variables"]["index"] = param
		2:
			data["api_variables"]["embedding_dim"] = param
		3:
			data["api_variables"]["recreate_index"] = param
			
