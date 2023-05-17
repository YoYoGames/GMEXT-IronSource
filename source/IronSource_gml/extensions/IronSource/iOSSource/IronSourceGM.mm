
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

//-(void) ironsource_init:(NSString*) appKey{self.IS_AppKey = appKey;}
-(void) ironsource_init
{
	self.IS_AppKey = [NSString stringWithUTF8String: extOptGetString((char*)"IronSource", (char*)"AppKey_iOS")];
}

-(void) ironsource_banner_init
{
    [IronSource setBannerDelegate:self];
	[IronSource initWithAppKey:self.IS_AppKey adUnits:@[IS_BANNER]];
	
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_banner_init");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

-(void) ironsource_interstitial_init
{
	[IronSource setInterstitialDelegate:self];
	[IronSource initWithAppKey:self.IS_AppKey adUnits:@[IS_INTERSTITIAL]];
	
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_interstitial_init");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}
	
-(void) ironsource_rewarded_video_init
{
	[IronSource setRewardedVideoDelegate:self];
	[IronSource initWithAppKey:self.IS_AppKey adUnits:@[IS_REWARDED_VIDEO]];
	
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_rewarded_video_init");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

-(void) ironsource_offerwall_init
{
	[IronSource setOfferwallDelegate:self];
	[IronSource initWithAppKey:self.IS_AppKey adUnits:@[IS_OFFERWALL]];	
	
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_offerwall_init");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

-(void) ironsource_validate_integration
{
	[ISIntegrationHelper validateIntegration];
}

-(void) ironsource_banner_create:(NSString*) placement_name size:(double) size bottom: (double)bottom
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

-(void) ironsource_banner_move: (double)bottom
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

-(void) ironsource_banner_hide
{
    if( self.bannerView != nil )
        self.bannerView.hidden = true;
}

-(void) ironsource_banner_show
{
    if( self.bannerView != nil )
        self.bannerView.hidden = false;
}

-(void) ironsource_banner_remove
{
    if( self.bannerView != nil )
    {
        [IronSource destroyBanner: self.bannerView];
        [self.bannerView removeFromSuperview];
        //[self.bannerView release];
        self.bannerView = nil;
    }
}

-(double) ironsource_banner_get_width
{
	if (self.bannerView == nil)
		return 0;
	
	return self.bannerView.bounds.size.width;
}

-(double) ironsource_banner_get_height
{
	if (self.bannerView == nil)
		return 0;
	
	return self.bannerView.bounds.size.height;
}

- (void)bannerDidLoad:(ISBannerView *)bannerView 
{
    self.bannerView = bannerView;
    
    [g_glView addSubview:self.bannerView];
    [self ironsource_banner_move:bottom];
    
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_banner_loaded");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)bannerDidFailToLoadWithError:(NSError *)error 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_banner_load_failed");
	createSocialAsyncEventWithDSMap(dsMapIndex);	
}


- (void)didClickBanner 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_banner_clicked");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)bannerWillPresentScreen 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_banner_presented");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)bannerDidDismissScreen 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_banner_dismissed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)bannerWillLeaveApplication 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_banner_left_application");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)bannerDidShow {
  //this one is only for iOS???
}


//////////////////////////// IronSource Interstitial ////////////////////////////////////////////// 
	
-(void) ironsource_interstitial_load
{
	[IronSource loadInterstitial];
}

-(void) ironsource_interstitial_is_capped:(NSString*)placement_name
{
	[IronSource isInterstitialCappedForPlacement:placement_name];
}

-(void) ironsource_interstitial_show:(NSString*) placement_name
{
    [IronSource showInterstitialWithViewController:g_controller placement:placement_name];
}

-(double) ironsource_interstitial_is_ready
{
	if([IronSource hasInterstitial])
		return 1.0;
	return 0.0;
}

-(void)interstitialDidLoad 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_interstitial_ready");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)interstitialDidFailToShowWithError:(NSError *)error 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_interstitial_load_failed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)didClickInterstitial 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_interstitial_clicked");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)interstitialDidClose 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_interstitial_closed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)interstitialDidOpen 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_interstitial_opened");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

-(void)interstitialDidFailToLoadWithError:(NSError *)error 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_interstitial_show_failed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)interstitialDidShow 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_interstitial_show_succeeded");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

///////////////////////////////// RewardedVideo ////////////////////////////////////////////////////////
//[IronSource shouldTrackReachability:YES];//?????
//[IronSource setDynamicUserId:@"DynamicUserId"];
-(void) ironsource_rewarded_video_show:(NSString*)placement_name
{
	[IronSource showRewardedVideoWithViewController:g_controller placement:placement_name];
}

-(double) ironsource_rewarded_video_is_ready
{
	if([IronSource hasRewardedVideo])
		return 1.0;
	return 0.0;
}

-(double) ironsource_rewarded_video_is_capped:(NSString*) placement_name
{
	if([IronSource isRewardedVideoCappedForPlacement:placement_name])
		return 1.0;
	return 0.0;
}

- (void)rewardedVideoHasChangedAvailability:(BOOL)available
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_rewarded_video_availability_changed");
	if(available)
		dsMapAddDouble(dsMapIndex, "available",1.0);
	else
		dsMapAddDouble(dsMapIndex, "available",0.0);
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)didReceiveRewardForPlacement:(ISPlacementInfo *)placementInfo 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_rewarded_video_rewarded");
	dsMapAddString(dsMapIndex, "reward_name", placementInfo.rewardName);
	dsMapAddDouble(dsMapIndex, "reward_amount", placementInfo.rewardAmount);
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)rewardedVideoDidFailToShowWithError:(NSError *)error 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_rewarded_video_show_failed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)rewardedVideoDidOpen 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_rewarded_video_opened");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)rewardedVideoDidClose 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_rewarded_video_closed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)didClickRewardedVideo:(ISPlacementInfo *)placementInfo
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_rewarded_video_clicked");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)rewardedVideoDidStart 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_rewarded_video_started");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


- (void)rewardedVideoDidEnd 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_rewarded_video_ended");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}
	
/////////////////////////////Offerwall
	
-(void) ironsource_offerwall_get_credits
{
	[IronSource offerwallCredits];
}

-(void) ironsource_offerwall_show:(NSString*) placement_name
{
	[IronSource showOfferwallWithViewController:g_controller placement:placement_name];
}

-(void) ironsource_offerwall_set_client_side_callbacks: (double)bool_
{
	[ISSupersonicAdsConfiguration configurations].useClientSideCallbacks = [NSNumber numberWithInt:(int) bool_];
}

- (void)offerwallHasChangedAvailability:(BOOL)available 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_offerwall_availability_changed");
	if(available)
		dsMapAddDouble(dsMapIndex, "available",1.0);
	else
		dsMapAddDouble(dsMapIndex, "available",0.0);
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

-(void)offerwallDidShow 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_offerwall_opened");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)offerwallDidFailToShowWithError:(NSError *)error 
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_offerwall_show_failed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)didReceiveOfferwallCredits:(NSDictionary *)creditInfo
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_offerwall_credited");

	dsMapAddDouble(dsMapIndex, "credits",[[creditInfo valueForKey:@"credits"] doubleValue]);
    dsMapAddDouble(dsMapIndex, "credits_total",[[creditInfo valueForKey:@"credits_total"] doubleValue]);
	if([[creditInfo valueForKey:@"credits_total_flag"] boolValue])
        dsMapAddDouble(dsMapIndex, "credits_total_flag",1.0);
	else
        dsMapAddDouble(dsMapIndex, "credits_total_flag",0.0);
		
	createSocialAsyncEventWithDSMap(dsMapIndex);
}

- (void)didFailToReceiveOfferwallCreditsWithError:(NSError *)error
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_offerwall_credits_failed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}


-(void)offerwallDidClose
{
	int dsMapIndex = dsMapCreate();
	dsMapAddString(dsMapIndex, "type","ironsource_offerwall_closed");
	createSocialAsyncEventWithDSMap(dsMapIndex);
}
	
@end

