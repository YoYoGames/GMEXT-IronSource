
#import "IronSource/IronSource.h"
#import <IronSource/ISConfigurations.h>
#import <AdSupport/AdSupport.h>

@interface IronSourceGM:NSObject <ISBannerDelegate,ISInterstitialDelegate,ISRewardedVideoDelegate,ISOfferwallDelegate>
{
    double bottom;
}

@property (nonatomic, strong) ISBannerView *bannerView;
@property (nonatomic, strong) NSString *IS_AppKey;

@end


