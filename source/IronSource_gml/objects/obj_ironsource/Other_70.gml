
show_debug_message(json_encode(async_load))

switch(async_load[?"type"])
{
	////////////////Banner
	
	case "IronSource_Init_Banner":
	break
	
	case "IronSource_Init_Interstitial":
		IronSource_Interstitial_Load();
	break
	
	case "IronSource_Init_RewardedVideo":
	break
	
	case "IronSource_Init_Offerwall":
	break
	
	case "IronSource_OnBannerAdLoaded": 
	break
	
	case "IronSource_OnBannerAdLoadFailed": 
	break
	
	case "IronSource_OnBannerAdClicked": 
	break
	
	case "IronSource_OnBannerAdScreenPresented": 
	break
	
	case "IronSource_OnBannerAdScreenDismissed": 
	break
	
	case "IronSource_OnBannerAdLeftApplication": 
	break
	
	////////////////Interstitial
	
    case "IronSource_OnInterstitialAdReady": 
	break
	
    case "IronSource_OnInterstitialAdLoadFailed": 
		IronSource_Interstitial_Load()
	break
	
    case "IronSource_OnInterstitialAdClicked": 
	break
	
    case "IronSource_OnInterstitialAdOpened": 
	break
	
    case "IronSource_OnInterstitialAdClosed": 
	break
	
    case "IronSource_OnInterstitialAdShowSucceeded": 
		IronSource_Interstitial_Load()
	break
	
    case "IronSource_OnInterstitialAdShowFailed": 
		IronSource_Interstitial_Load()
	break
	
	////////Reward Video
	
    case "IronSource_OnRewardedVideoAdOpened": 
	break
	
    case "IronSource_OnRewardedVideoAdClosed": 
	break
	
    case "IronSource_OnRewardedVideoAvailabilityChanged": 
		var available = async_load[?"value"]
	break
	
    case "IronSource_OnRewardedVideoAdStarted": 
	break

    case "IronSource_OnRewardedVideoAdEnded": 
	break
	
    case "IronSource_OnRewardedVideoAdRewarded": 
		show_message_async("Congrats!! (Reward The User)")
	break        
	
    case "IronSource_OnRewardedVideoAdShowFailed": 
	break
	
    case "IronSource_OnRewardedVideoAdClicked": 
	break
	
	////////////////Offer Wall
	
	
    case "IronSource_OnOfferwallAvailable": 
		var available = async_load[?"value"]
	break
	
    case "IronSource_OnOfferwallOpened": 
	break
	
    case "IronSource_OnOfferwallShowFailed": 
	break
	
    case "IronSource_OnOfferwallAdCredited": 
	
		show_message_async(json_encode(async_load))
		var credits = async_load[?"credits"]
		var totalCredits = async_load[?"totalCredits"]
		var totalCreditsFlag = async_load[?"totalCreditsFlag"]
		
	break
	
    case "IronSource_OnGetOfferwallCreditsFailed": 
	break

    case "IronSource_OnOfferwallClosed": 
	break        
}
