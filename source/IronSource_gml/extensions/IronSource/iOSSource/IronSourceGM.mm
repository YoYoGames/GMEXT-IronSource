
#import "IronSourceGM.h"

const int EVENT_OTHER_SOCIAL = 70;
extern int CreateDsMap( int _num, ... );
extern void CreateAsynEventWithDSMap(int dsmapindex, int event_index);
extern UIViewController *g_controller;
extern UIView *g_glView;
extern int g_DeviceWidth;
extern int g_DeviceHeight;

extern "C" void dsMapClear(int _dsMap );
extern "C" int dsMapCreate();
extern "C" void dsMapAddInt(int _dsMap, char* _key, int _value);
extern "C" void dsMapAddDouble(int _dsMap, char* _key, double _value);
extern "C" void dsMapAddString(int _dsMap, char* _key, char* _value);

extern "C" int dsListCreate();
extern "C" void dsListAddInt(int _dsList, int _value);
extern "C" void dsListAddString(int _dsList, char* _value);
extern "C" const char* dsListGetValueString(int _dsList, int _listIdx);
extern "C" double dsListGetValueDouble(int _dsList, int _listIdx);
extern "C" int dsListGetSize(int _dsList);

extern "C" void createSocialAsyncEventWithDSMap(int dsmapindex);

extern "C" const char* extOptGetString(char* _ext, char* _opt);

@implementation IronSourceGM

-(id)init {
    if ( self = [super init] ) {
        // self->testingAds = false;
        return self;
    }
}

//-(void) IronSource_Init:(NSString*) appKey{self.IS_AppKey = appKey;}
-(void) IronSource_Init
{
	self.IS_AppKey = [NSString stringWithUTF8String: extOptGetString((char*)"IronSource", (char*)"AppKey_iOS")];
}

-(void) IronSource_Init_Banner
{
    [IronSource setBannerDelegate:self];
	[IronSource initWithAppKey:self.IS_AppKey adUnits:@[IS_BANNER]];
	
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_Init_Banner");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

-(void) IronSource_Init_Interstitial
{
	[IronSource setInterstitialDelegate:self];
	[IronSource initWithAppKey:self.IS_AppKey adUnits:@[IS_INTERSTITIAL]];
	
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_Init_Interstitial");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}
	
-(void) IronSource_Init_RewardedVideo
{
	[IronSource setRewardedVideoDelegate:self];
	[IronSource initWithAppKey:self.IS_AppKey adUnits:@[IS_REWARDED_VIDEO]];
	
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_Init_RewardedVideo");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

-(void) IronSource_Init_Offerwall
{
	[IronSource setOfferwallDelegate:self];
	[IronSource initWithAppKey:self.IS_AppKey adUnits:@[IS_OFFERWALL]];	
	
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_Init_Offerwall");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

-(void) IronSource_ValidateIntegration
{
	[ISIntegrationHelper validateIntegration];
}

-(void) IronSource_Banner_Create:(NSString*) placement_name size:(double) size bottom: (double)bottom
{
    self->bottom = bottom;
    if(self.bannerView != nil)
    {
		[IronSource destroyBanner: self.bannerView];
        [self.bannerView removeFromSuperview];
        //[self.bannerView release];
        self.bannerView = nil;
    }
    
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [g_glView addSubview:self.bannerView];
    
    ISBannerSize *bannerSize;
    switch((int)size)
    {
        case 0: {bannerSize = ISBannerSize_BANNER; break;}
        case 1: {bannerSize = ISBannerSize_LARGE; break;}
        case 2: {bannerSize = ISBannerSize_RECTANGLE; break;}
        case 3: {bannerSize = ISBannerSize_SMART; break;}
        default:{bannerSize = ISBannerSize_SMART; break;}//return;
    }
    
    [IronSource loadBannerWithViewController:g_controller size:bannerSize];
}

-(void) IronSource_Banner_Move: (double)bottom
{
    int x_ = 1;
    int y_;
    if(bottom)
        y_ = 2;
    else
        y_ = 0;
    
    if(self.bannerView != nil)
    {
        CGSize size = self.bannerView.frame.size;
        int adW = size.width;
        int adH = size.height;

        //display -> view coords
        int x = -1;
        int y = -1;
        
        switch((int)x_)
        {
            case 0:
                x = 0;
            break;
                
            case 1:
                x = (int)(g_glView.bounds.size.width -  adW) / 2;
            break;
                
            case 2:
                x = (int)(g_glView.bounds.size.width) - adW;
            break;
                
        }
        
        switch((int)y_)
        {
            case 0:
                y = 0;
            break;
                
            case 1:
                y = (int)(g_glView.bounds.size.height - adH) / 2;
            break;
                
            case 2:
                y = (int)(1.0 * g_glView.bounds.size.height) - adH;
            break;
                
        }
        
        CGRect frame = self.bannerView.frame;
        frame.origin.x = x;
        frame.origin.y = y;
        self.bannerView.frame = frame;
    }
}

-(void) IronSource_Banner_Hide
{
    if( self.bannerView != nil )
        self.bannerView.hidden = true;
}

-(void) IronSource_Banner_Show
{
    if( self.bannerView != nil )
        self.bannerView.hidden = false;
}

-(void) IronSource_Banner_Remove
{
    if( self.bannerView != nil )
    {
        [IronSource destroyBanner: self.bannerView];
        [self.bannerView removeFromSuperview];
        //[self.bannerView release];
        self.bannerView = nil;
    }
}

-(double) IronSource_Banner_GetWidth
{
	if (self.bannerView == nil)
		return 0;
	
	return self.bannerView.bounds.size.width;
}

-(double) IronSource_Banner_GetHeight
{
	if (self.bannerView == nil)
		return 0;
	
	return self.bannerView.bounds.size.height;
}

- (void)bannerDidLoad:(ISBannerView *)bannerView 
{
    self.bannerView = bannerView;
    
    [g_glView addSubview:self.bannerView];
    [self IronSource_Banner_Move:bottom];
    
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnBannerAdLoaded");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)bannerDidFailToLoadWithError:(NSError *)error 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnBannerAdLoadFailed");
	createSocialAsyncEventWithDSMap(dsMapIndex);	
}


- (void)didClickBanner 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnBannerAdClicked");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)bannerWillPresentScreen 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnBannerAdScreenPresented");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)bannerDidDismissScreen 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnBannerAdScreenDismissed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)bannerWillLeaveApplication 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnBannerAdLeftApplication");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)bannerDidShow {
  //this one is only for iOS???
}


//////////////////////////// IronSource Interstitial ////////////////////////////////////////////// 
	
-(void) IronSource_Interstitial_Load
{
	[IronSource loadInterstitial];
}

-(void) IronSource_Interstitial_IsCapped:(NSString*)placement_name
{
	[IronSource isInterstitialCappedForPlacement:placement_name];
}

-(void) IronSource_Interstitial_Show:(NSString*) placement_name
{
    [IronSource showInterstitialWithViewController:g_controller placement:placement_name];
}

-(double) IronSource_Interstitial_IsReady
{
	if([IronSource hasInterstitial])
		return 1.0;
	return 0.0;
}

-(void)interstitialDidLoad 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnInterstitialAdReady");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)interstitialDidFailToShowWithError:(NSError *)error 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnInterstitialAdLoadFailed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)didClickInterstitial 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnInterstitialAdClicked");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)interstitialDidClose 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnInterstitialAdClosed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)interstitialDidOpen 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnInterstitialAdOpened");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

-(void)interstitialDidFailToLoadWithError:(NSError *)error 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnInterstitialAdShowFailed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)interstitialDidShow 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnInterstitialAdShowSucceeded");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

///////////////////////////////// RewardedVideo ////////////////////////////////////////////////////////
//[IronSource shouldTrackReachability:YES];//?????
//[IronSource setDynamicUserId:@"DynamicUserId"];
-(void) IronSource_RewardedVideo_Show:(NSString*)placement_name
{
	[IronSource showRewardedVideoWithViewController:g_controller placement:placement_name];
}

-(double) IronSource_RewardedVideo_IsReady
{
	if([IronSource hasRewardedVideo])
		return 1.0;
	return 0.0;
}

-(double) IronSource_RewardedVideo_IsCapped:(NSString*) placement_name
{
	if([IronSource isRewardedVideoCappedForPlacement:placement_name])
		return 1.0;
	return 0.0;
}

- (void)rewardedVideoHasChangedAvailability:(BOOL)available
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnRewardedVideoAvailabilityChanged");
	if(available)
		dsMapAddDouble(dsMapIndex, "value",0.0);
	else
		dsMapAddDouble(dsMapIndex, "value",1.0);
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)didReceiveRewardForPlacement:(ISPlacementInfo *)placementInfo 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnRewardedVideoAdRewarded");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)rewardedVideoDidFailToShowWithError:(NSError *)error 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnRewardedVideoAdShowFailed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)rewardedVideoDidOpen 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnRewardedVideoAdOpened");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)rewardedVideoDidClose 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnRewardedVideoAdClosed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)didClickRewardedVideo:(ISPlacementInfo *)placementInfo
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnRewardedVideoAdClicked");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)rewardedVideoDidStart 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnRewardedVideoAdStarted");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)rewardedVideoDidEnd 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnRewardedVideoAdEnded");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}
	
/////////////////////////////Offerwall
	
-(void) IronSource_Offerwall_GetCredits
{
	[IronSource offerwallCredits];
}

-(void) IronSource_Offerwall_Show:(NSString*) placement_name
{
	[IronSource showOfferwallWithViewController:g_controller placement:placement_name];
}

-(void) IronSource_Offerwall_SetClientSideCallbacks: (double)bool_
{
	[ISSupersonicAdsConfiguration configurations].useClientSideCallbacks = [NSNumber numberWithInt:(int) bool_];
}

- (void)offerwallHasChangedAvailability:(BOOL)available 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnOfferwallAvailable");
	if(available)
		dsMapAddDouble(dsMapIndex, "value",0.0);
	else
		dsMapAddDouble(dsMapIndex, "value",1.0);
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

-(void)offerwallDidShow 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnOfferwallOpened");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)offerwallDidFailToShowWithError:(NSError *)error 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnOfferwallShowFailed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)didReceiveOfferwallCredits:(NSDictionary *)creditInfo
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnOfferwallAdCredited");

	dsMapAddDouble(dsMapIndex, "credits",[[creditInfo valueForKey:@"credits"] doubleValue]);
    dsMapAddDouble(dsMapIndex, "totalCredits",[[creditInfo valueForKey:@"totalCredits"] doubleValue]);
	if([[creditInfo valueForKey:@"totalCreditsFlag"] boolValue])
        dsMapAddDouble(dsMapIndex, "totalCreditsFlag",1.0);
	else
        dsMapAddDouble(dsMapIndex, "totalCreditsFlag",0.0);
		
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)didFailToReceiveOfferwallCreditsWithError:(NSError *)error
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnGetOfferwallCreditsFailed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)offerwallDidClose
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","IronSource_OnOfferwallClosed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}
	
@end

