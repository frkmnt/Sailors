extends Control

#==== Class Comments ====#
# Handles the wave animation. All the tracks have 3 key frames,
# initial_pos > destination_pos > initial_pos.
# This class manages the destination_pos of all the tracks, randomizing it
# within a range each time.

#==== Components ====#
var c_boat_anim_player

#==== Constants ====#
const a_wave_bg_range = [17, 30]
const a_boat_range = [40, 50]
const a_wave_fg_range = [55, 65]


#==== Bootstrap ====#

func initialize():
	c_boat_anim_player = $BoatAnimPlayer
	start_animation()



#==== Logic ====#
func randomize_layer_positions():
	var animation = c_boat_anim_player.get_animation("waves_animation_loop")
	animation.track_set_key_value(0, 1, \
		Vector2(0, randomize_value_in_range(a_wave_bg_range[0], a_wave_bg_range[1])))
	animation.track_set_key_value(1, 1, \
		Vector2(0, randomize_value_in_range(a_boat_range[0], a_boat_range[1])))
	animation.track_set_key_value(2, 1, \
		Vector2(0, randomize_value_in_range(a_wave_fg_range[0], a_wave_fg_range[1])))
	

func randomize_value_in_range(min_val, max_val):
	return floor(rand_range(min_val, max_val))


func start_animation():
	c_boat_anim_player.play("waves_animation_loop")

func stop_animation():
	c_boat_anim_player.stop(true)
