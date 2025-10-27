extends Resource
class_name FishType
 
@export var fish_name: String = "Carp"
@export_range(0, 10000, 1) var base_price: int = 50
@export_range(1.0, 200.0, 0.1) var length_avg_cm: float = 40.0
@export var tint: Color = Color.SKY_BLUE
 
@export var allowed_areas: Array[String] = ["river"]
@export var allowed_seasons: Array[String] = ["spring","summer","fall","winter"]
@export var requires_rain: bool = false
@export var time_window: Vector2i = Vector2i(600, 2000) # 6:00 -> 20:00
 
@export_range(0.2, 3.0, 0.05) var bite_time_avg: float = 1.3 # avg seconds before bite
@export_range(0.1, 2.0, 0.05) var bite_time_variance: float = 0.5
@export_range(0.0, 1.0, 0.01) var treasure_chance: float = 0.15
 
@export_range(0.0, 1.0, 0.01) var difficulty: float = 0.45
 
enum MovePattern { SMOOTH, DARTY, SINK_RISE, CHAOTIC }
@export var pattern: MovePattern = MovePattern.SMOOTH
 
@export var is_legendary: bool = false
 
