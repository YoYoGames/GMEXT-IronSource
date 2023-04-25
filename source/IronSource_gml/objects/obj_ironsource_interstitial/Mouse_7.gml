
if(IronSource_Interstitial_IsCapped(IronSource_Default_Interstitial)) 
	return;

if(IronSource_Interstitial_IsReady()) 
	IronSource_Interstitial_Show(IronSource_Default_Interstitial);
