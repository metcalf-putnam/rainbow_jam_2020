extends Node


# From Player/parts
signal destruction

# From city
signal health_changed

# From scenes and player triggers
signal new_title
signal memory_scene
signal normal_scene
signal ui_changed

# From objects
signal player_hit # From Tiffany mini game
signal memory_destroyed

# From dialogue
signal change_player_active_state
signal dialogue_started
signal thought_started
signal deep_thought_started
signal deep_thought_finished
