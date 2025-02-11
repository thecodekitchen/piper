class_name ToolCallResult

var _result:String
var _origin:ToolCall
var _error:bool

func _init(result:String,origin:ToolCall,error:bool)->void:
	_result=result
	_origin=origin
	_error=error	
