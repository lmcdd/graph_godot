extends Node2D
 
var distance_min = 32
var points = [Vector2(0,0)]
 
func _ready():
	randomize()
	var i = 0
	while i < 64:
		var point = Vector2(randi()%512-256,randi()%512-256)
		var q = true
		for j in points:
			if point.distance_to(j) < distance_min:
				q = false
		if q:
			points.append(point)
			i += 1
	points = get_dots_with_neighbor(points)
	update()
   
func get_neighbor(start_dot, dots, dots_with_neighbor):
	if dots.size() >= 2:
		var dmin = 9999
		var mdot = dots[0]
		for dot in dots:
			var d = start_dot.distance_to(dot)
			if d != 0 and dmin >= d and dots_with_neighbor.has(dot):
				if dots_with_neighbor[dot] != start_dot:
					dmin = d
					mdot = dot
		return mdot

func get_dots_with_neighbor(dots):
	var dots_with_neighbor = {}
	for dot in dots:
		var next_dot = get_neighbor(dot, dots, dots_with_neighbor)
		dots_with_neighbor[dot] = next_dot
	return dots_with_neighbor
	
func _draw():
	for i in points.keys():
		print(i, ' ',points[i])
		draw_circle(i,8,Color(1,0,1))
		draw_line(i,points[i],Color(1,1,0),2,true)
	
