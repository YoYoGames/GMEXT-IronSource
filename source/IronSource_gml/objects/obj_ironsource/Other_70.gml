
show_debug_message(json_encode(async_load))

switch(async_load[?"type"])
{
	////////////////Banner
	
	case "ironsource_banner_init":
	break
	
	case "ironsource_interstitial_init":
		ironsource_interstitial_load();
	break
	
	case "ironsource_rewarded_video_init":
	break
	
	case "ironsource_offerwall_init":
	break
	
	case "ironsource_banner_loaded": 
	break
	
	case "ironsource_banner_load_failed": 
	break
	
	case "ironsource_banner_clicked": 
	break
	
	case "ironsource_banner_presented": 
	break
	
	case "ironsource_banner_dismissed": 
	break
	
	case "ironsource_banner_left_application": 
	break
	
	////////////////Interstitial
	
    case "ironsource_interstitial_ready": 
	break
	
    case "ironsource_interstitial_load_failed": 
		ironsource_interstitial_load()
	break
	
    case "ironsource_interstitial_clicked": 
	break
	
    case "ironsource_interstitial_opened": 
	break
	
    case "ironsource_interstitial_closed": 
	break
	
    case "ironsource_interstitial_show_failed": 
		ironsource_interstitial_load()
	break
	
	////////Reward Video
	
	case "ironsource_rewarded_video_ready":
	break
	
	case "ironsource_rewarded_video_load_failed":
	break

    case "ironsource_rewarded_video_opened": 
	break
	
    case "ironsource_rewarded_video_closed": 
	break
	
    case "ironsource_rewarded_video_started": 
	break

    case "ironsource_rewarded_video_ended": 
	break
	
    case "ironsource_rewarded_video_rewarded": 
		show_message_async("Congrats!! (Reward The User)")
	break        
	
    case "ironsource_rewarded_video_show_failed": 
	break
	
    case "ironsource_rewarded_video_clicked": 
	break
	
	////////////////Offer Wall
	
	
    case "ironsource_offerwall_available": 
		var available = async_load[?"value"]
	break
	
    case "ironsource_offerwall_opened": 
	break
	
    case "ironsource_offerwall_show_failed": 
	break
	
    case "ironsource_offerwall_credited": 
		
		var credits = async_load[?"credits"]
		var totalCredits = async_load[?"credits_total"]
		var totalCreditsFlag = async_load[?"credits_total_flag"]
		
	break
	
    case "ironsource_offerwall_credits_failed": 
	break

    case "ironsource_offerwall_closed": 
	break        
}
