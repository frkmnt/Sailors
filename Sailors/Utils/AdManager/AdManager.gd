extends Node

#==== Class Comments ====#
# This node handles all ad interactions. 


#==== References ====#
var r_parent

#==== Components ====#
var c_admob
var c_banner_timer # displays a new banner on tick
var c_request_new_ad_timer # in case the ad isn't loaded in time, retry

#==== Constants ====#
const i_banner_timer_timeout = 30
const i_request_new_add_timer_timeout = 0.5

#==== Variables ====#
var b_is_banner_loaded = false
var b_is_interstitial_loaded = false
var b_is_rewarded_loaded = false


#==== Bootstrap ====#

func initialize(parent):
	r_parent = parent
	c_admob = $AdMob
	initialize_banner_timer()
	initialize_request_new_ad_timer()

func initialize_banner_timer():
	c_banner_timer = Timer.new()
	c_banner_timer.connect("timeout", self, "play_admob_banner")
	c_banner_timer.set_one_shot(true)
	add_child(c_banner_timer)

func initialize_request_new_ad_timer():
	c_request_new_ad_timer = Timer.new()
	c_request_new_ad_timer.set_one_shot(true)
	add_child(c_request_new_ad_timer)


#==== Banners ====#

func play_admob_banner():
	request_admob_banner_ad()
	show_admob_banner_ad()
	initialize_timeout_timer()

func request_admob_banner_ad():
	c_admob.load_banner()

func show_admob_banner_ad():
	c_admob.show_banner()


func initialize_timeout_timer():
	c_banner_timer.start(i_banner_timer_timeout)



#==== Interstitials ====#

func play_admob_interstitial():
	request_admob_interstitial_ad()
#	show_admob_interstitial_ad()

func request_admob_interstitial_ad():
	c_admob.load_interstitial()

func show_admob_interstitial_ad():
	if c_admob.is_interstitial_loaded():
		c_admob.show_interstitial()
	else:
		c_request_new_ad_timer.connect("timeout", self, "show_admob_interstitial_ad")
		c_request_new_ad_timer.start(i_request_new_add_timer_timeout)


#==== Rewarded ====#

func play_admob_rewarded():
	request_admob_rewarded_ad()
	show_admob_rewarded_ad()

func request_admob_rewarded_ad():
	c_admob.load_rewarded_video()

func show_admob_rewarded_ad():
	if c_admob.is_rewarded_video_loaded():
		c_admob.show_interstitial()
	else:
		c_request_new_ad_timer.connect("timeout", self, "show_admob_rewarded_ad")
		c_request_new_ad_timer.start(i_request_new_add_timer_timeout)

#==== Error Management ====#

func on_ad_load_error(error_id):
	print("An error ocurred when trying to load an ad.\nError ID: ", error_id)
