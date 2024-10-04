extends Line2D

@onready var raycast : RayCast2D

func _ready():
	raycast = get_parent() as RayCast2D

func _process(delta):
	points[1].x = raycast.target_position.x
	points[1].y = raycast.target_position.y
