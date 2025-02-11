extends GraphNodeMenu
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	editor = $"../../VBoxContainer/GraphEdit"
	graph_nodes = [
		preload("res://components/graph nodes/converters/AzureOCRDocumentConverter.tscn"),
		preload("res://components/graph nodes/converters/CSVToDocument.tscn"),
		preload("res://components/graph nodes/converters/DOCXToDocument.tscn"),
		preload("res://components/graph nodes/converters/HTMLToDocument.tscn"),
		preload("res://components/graph nodes/converters/JSONConverter.tscn"),
		preload("res://components/graph nodes/converters/MarkdownToDocument.tscn"),
		preload("res://components/graph nodes/converters/OpenAPIServiceToFunctions.tscn"),
		preload("res://components/graph nodes/converters/OutputAdapter.tscn"),
		preload("res://components/graph nodes/converters/PDFMinerToDocument.tscn"),
		preload("res://components/graph nodes/converters/PPTXToDocument.tscn"),
		preload("res://components/graph nodes/converters/PyPDFToDocument.tscn"),
		preload("res://components/graph nodes/converters/TextFileToDocument.tscn"),
		preload("res://components/graph nodes/converters/TikaDocumentConverter.tscn"),
		preload("res://components/graph nodes/converters/UnstructuredFileConverter.tscn"),
		preload("res://components/graph nodes/converters/XLSXToDocument.tscn")
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
