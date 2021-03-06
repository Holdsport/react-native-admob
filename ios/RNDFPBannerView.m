#import "RNDFPBannerView.h"
#import "RNAdMobUtils.h"

#if __has_include(<React/RCTBridgeModule.h>)
#import <React/RCTBridgeModule.h>
#import <React/UIView+React.h>
#import <React/RCTLog.h>
#else
#import "RCTBridgeModule.h"
#import "UIView+React.h"
#import "RCTLog.h"
#endif
#include "RCTConvert+GADAdSize.h"
#import <CriteoPublisherSdk/CRAdUnit.h>
#import <CriteoPublisherSdk/CRBannerAdUnit.h>
#import <CriteoPublisherSdk/CRBannerView.h>
#import <CriteoPublisherSdk/CRBannerViewDelegate.h>
#import <CriteoPublisherSdk/CRBidResponse.h>
#import <CriteoPublisherSdk/CRBidToken.h>
#import <CriteoPublisherSdk/CRInterstitial.h>
#import <CriteoPublisherSdk/CRInterstitialAdUnit.h>
#import <CriteoPublisherSdk/CRInterstitialDelegate.h>
#import <CriteoPublisherSdk/CRNativeAdUnit.h>
#import <CriteoPublisherSdk/Criteo.h>
@import PrebidMobile;


@implementation RNDFPBannerView
{
    DFPBannerView  *_bannerView;
    NSString *_sportName;
}

- (void)dealloc
{
    _bannerView.delegate = nil;
    _bannerView.adSizeDelegate = nil;
    _bannerView.appEventDelegate = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        super.backgroundColor = [UIColor clearColor];

        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        UIViewController *rootViewController = [keyWindow rootViewController];

        _bannerView = [[DFPBannerView alloc] initWithAdSize:kGADAdSizeBanner];
        _bannerView.delegate = self;
        _bannerView.adSizeDelegate = self;
        _bannerView.appEventDelegate = self;
        _bannerView.rootViewController = rootViewController;
        [self addSubview:_bannerView];
    }

    return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-missing-super-calls"
- (void)insertReactSubview:(UIView *)subview atIndex:(NSInteger)atIndex
{
    RCTLogError(@"RNDFPBannerView cannot have subviews");
}
#pragma clang diagnostic pop

- (void)loadBanner {
    DFPRequest *request = [DFPRequest request];
    request.customTargeting = @{ @"sport": _sportName };
    request.testDevices = _testDevices;
      Criteo *criteoSdk = [Criteo sharedCriteo];
    if([_bannerView.adUnitID isEqualToString:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_article1_app"] || [_bannerView.adUnitID isEqualToString:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_top_app"] || [_bannerView.adUnitID isEqualToString:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_profile_app"]) {
        
        if ([_bannerView.adUnitID isEqualToString:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_article1_app"]) {
            CRBannerAdUnit *bannerAdUnit =
                [[CRBannerAdUnit alloc] initWithAdUnitId:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_article1_app"
                                                    size:CGSizeMake(320, 320)];
            [criteoSdk setBidsForRequest:request withAdUnit:bannerAdUnit];
            BannerAdUnit *bannerUnit = [[BannerAdUnit alloc] initWithConfigId:@"10095-mobilewrapper-top" size:CGSizeMake(320, 320)];
                    [bannerUnit fetchDemandWithAdObject:request completion:^(enum ResultCode result) {
            NSLog(@"Prebid demand result %ld", (long)result);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_bannerView loadRequest:request];
            });
        }];
        }
        if ([_bannerView.adUnitID isEqualToString:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_top_app"]) {
            CRBannerAdUnit *bannerAdUnit =
                [[CRBannerAdUnit alloc] initWithAdUnitId:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_top_app"
                                                    size:CGSizeMake(320, 160)];
            [criteoSdk setBidsForRequest:request withAdUnit:bannerAdUnit];
            BannerAdUnit *bannerUnit = [[BannerAdUnit alloc] initWithConfigId:@"10095-mobilewrapper-article1" size:CGSizeMake(320, 160)];
            [bannerUnit fetchDemandWithAdObject:request completion:^(enum ResultCode result) {
            NSLog(@"Prebid demand result %ld", (long)result);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_bannerView loadRequest:request];
            });
        }];

        }
        if ([_bannerView.adUnitID isEqualToString:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_profile_app"]) {
            CRBannerAdUnit *bannerAdUnit =
                [[CRBannerAdUnit alloc] initWithAdUnitId:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_profile_app"
                                                    size:CGSizeMake(320, 160)];
            [criteoSdk setBidsForRequest:request withAdUnit:bannerAdUnit];
            BannerAdUnit *bannerUnit = [[BannerAdUnit alloc] initWithConfigId:@"10095-mobilewrapper-Profile" size:CGSizeMake(320, 160)];
            [bannerUnit fetchDemandWithAdObject:request completion:^(enum ResultCode result) {
            NSLog(@"Prebid demand result %ld", (long)result);
            dispatch_async(dispatch_get_main_queue(), ^{
                [_bannerView loadRequest:request];
            });
        }];
        }
    } else {
        [_bannerView loadRequest:request];
    }

}

- (void)setSportName:(NSString *) sportName
{
    _sportName = sportName;
}

- (void)setValidAdSizes:(NSArray *)adSizes
{
    /*__block NSMutableArray *validAdSizes = [[NSMutableArray alloc] initWithCapacity:adSizes.count];
    [adSizes enumerateObjectsUsingBlock:^(id jsonValue, NSUInteger idx, __unused BOOL *stop) {
        GADAdSize adSize = [RCTConvert GADAdSize:jsonValue];
        if (GADAdSizeEqualToSize(adSize, kGADAdSizeInvalid)) {
            RCTLogWarn(@"Invalid adSize %@", jsonValue);
        } else {
            [validAdSizes addObject:NSValueFromGADAdSize(adSize)];
        }
    }];*/
    if ([_bannerView.adUnitID isEqualToString:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_article1_app"]) {
     _bannerView.validAdSizes = @[
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 320))),
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(300, 250)))
     ];
    }
    if ([_bannerView.adUnitID isEqualToString:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_top_app"]) {
     _bannerView.validAdSizes = @[
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 320))),
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 160))),
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(300, 250)))

     ];
    }
    if ([_bannerView.adUnitID isEqualToString:@"/21829114275/Holdsport.dk/holdsport.dk_app/holdsport.dk_profile_app"]) {
     _bannerView.validAdSizes = @[
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 160)))
     ];
    }
    if ([_bannerView.adUnitID isEqualToString:@"/21829114275/sportmember.de/sportmember.de_app/sportmember.de_article1_app"]) {
     _bannerView.validAdSizes = @[
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 320))),
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 160))), 
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 100))), 
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 50))),
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(300, 250)))
     ];
    }
    if ([_bannerView.adUnitID isEqualToString:@"/21829114275/sportmember.de/sportmember.de_app/sportmember.de_top_app"]) {
     _bannerView.validAdSizes = @[
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 320))),
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 250))), 
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 160))), 
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 100))), 
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 50))),
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(300, 250)))
     ];
    }
    if ([_bannerView.adUnitID isEqualToString:@"/21829114275/sportmember.de/sportmember.de_app/sportmember.de_profile_app"]) {
     _bannerView.validAdSizes = @[ 
        NSValueFromGADAdSize(GADAdSizeFromCGSize(CGSizeMake(320, 160)))
     ];
    }

}

- (void)setTestDevices:(NSArray *)testDevices
{
    _testDevices = RNAdMobProcessTestDevices(testDevices, kDFPSimulatorID);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _bannerView.frame = self.bounds;
}

# pragma mark GADBannerViewDelegate

/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(DFPBannerView *)adView
{
    if (self.onSizeChange) {
        self.onSizeChange(@{
                            @"width": @(adView.frame.size.width),
                            @"height": @(adView.frame.size.height) });
    }
    if (self.onAdLoaded) {
        self.onAdLoaded(@{});
    }
}

/// Tells the delegate an ad request failed.
- (void)adView:(DFPBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error
{
    if (self.onAdFailedToLoad) {
        self.onAdFailedToLoad(@{ @"error": @{ @"message": [error localizedDescription] } });
    }
}

/// Tells the delegate that a full screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(DFPBannerView *)adView
{
    if (self.onAdOpened) {
        self.onAdOpened(@{});
    }
}

/// Tells the delegate that the full screen view will be dismissed.
- (void)adViewWillDismissScreen:(__unused DFPBannerView *)adView
{
    if (self.onAdClosed) {
        self.onAdClosed(@{});
    }
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(DFPBannerView *)adView
{
    if (self.onAdLeftApplication) {
        self.onAdLeftApplication(@{});
    }
}

# pragma mark GADAdSizeDelegate

- (void)adView:(GADBannerView *)bannerView willChangeAdSizeTo:(GADAdSize)size
{
    CGSize adSize = CGSizeFromGADAdSize(size);
    self.onSizeChange(@{
                        @"width": @(adSize.width),
                        @"height": @(adSize.height) });
}

# pragma mark GADAppEventDelegate

- (void)adView:(GADBannerView *)banner didReceiveAppEvent:(NSString *)name withInfo:(NSString *)info
{
    if (self.onAppEvent) {
        self.onAppEvent(@{ @"name": name, @"info": info });
    }
}

@end
