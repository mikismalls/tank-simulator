extends Node2D
class_name PolygonEditor

# PolygonEditor.gd
# Кастомный Node2D для редактирования корпуса и башни в виде полигонов

var points: PackedVector2Array = PackedVector2Array()
var is_closed: bool = false
var grid_step: float = 16.0
var selected_point_index: int = -1

func _draw():
    if points.size() > 0:
        # Рисуем рёбра
        for i in range(points.size() - 1):
            draw_line(points[i], points[i+1], Color.WHITE, 2.0)

        if is_closed and points.size() >= 3:
            draw_line(points[points.size() - 1], points[0], Color.WHITE, 2.0)

            # Рисуем заливку
            var colors = PackedColorArray([Color(1, 1, 1, 0.2)])
            draw_polygon(points, colors)

        # Рисуем вершины
        for i in range(points.size()):
            var color = Color.RED if i == selected_point_index else Color.BLUE
            draw_circle(points[i], 4.0, color)

func _unhandled_input(event):
    if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
        var click_pos = get_local_mouse_position().snapped(Vector2(grid_step, grid_step))

        if event.pressed:
            if not is_closed:
                # Проверка на замыкание
                if points.size() >= 3 and click_pos.distance_to(points[0]) < grid_step:
                    is_closed = true
                else:
                    points.append(click_pos)
                queue_redraw()
            else:
                # Выбор вершины для перемещения
                selected_point_index = -1
                for i in range(points.size()):
                    if click_pos.distance_to(points[i]) < grid_step:
                        selected_point_index = i
                        break
                queue_redraw()

        elif not event.pressed:
            selected_point_index = -1
            queue_redraw()

    elif event is InputEventMouseMotion and selected_point_index != -1:
        points[selected_point_index] = get_local_mouse_position().snapped(Vector2(grid_step, grid_step))
        # TODO: Добавить валидацию (запрет самопересечений)
        queue_redraw()

func get_area() -> float:
    if not is_closed or points.size() < 3:
        return 0.0
    return Geometry2D.area(points)
