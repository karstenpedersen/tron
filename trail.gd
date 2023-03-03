extends Line2D

var target: Node2D = null
var time: float = 0.2
var cooldown: float = time

var point_index = 0


func _process(delta):
	if target != null and cooldown <= 0:
		point_index += 1
		add_point(target.position, point_index)
		cooldown = time
	
	if points.size() > 10:
		point_index -= 1
		remove_point(0)

	set_point_position(point_index, target.position)
	
	cooldown -= delta
