extends Node
#class_name Events


signal game_started

signal round_ready
signal ball_launch_authorized

signal goal_scored(last_hit_by_team_id: int, cage_owner_team_id: int, value: int)
