
ironsource_offerwall_set_client_side_callbacks(true)

ironsource_init()

ironsource_banner_init()
ironsource_interstitial_init()
ironsource_rewarded_video_init()
ironsource_offerwall_init()

ironsource_interstitial_load();
ironsource_rewarded_video_load();

show_debug_message("----------------- ironsource_validate_integration START ---------------------")
ironsource_validate_integration()
show_debug_message("----------------- ironsource_validate_integration END ---------------------")
