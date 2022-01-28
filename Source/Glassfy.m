//
//  Glassfy.m
//  Glassfy
//
//  Created by Luca Garbolino on 18/12/20.
//


#import "Glassfy.h"
#import "GYManager.h"
#import "GYLogger.h"

@interface Glassfy()
@property (nonnull, nonatomic, strong) dispatch_queue_t glqueue;
@property (nullable, nonatomic, strong) GYManager *manager;
@end

@implementation Glassfy

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.glqueue = dispatch_queue_create("com.glassfy.sdk", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

+ (Glassfy *)shared
{
    static Glassfy *sharedInstance = nil;
    static dispatch_once_t initOnceToken;
    dispatch_once(&initOnceToken, ^{
        sharedInstance = [[Glassfy alloc] init];
    });
    return sharedInstance;
}

#pragma mark - public methods

+ (NSString *)sdkVersion
{
    return @"1.2.0-beta.0";
}

+ (void)initializeWithAPIKey:(NSString *)apiKey
{
    [self initializeWithAPIKey:apiKey watcherMode:NO];
}

+ (void)initializeWithAPIKey:(NSString *)apiKey watcherMode:(BOOL)watcherMode
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        Glassfy.shared.manager = [GYManager managerWithApiKey:apiKey watcherMode:watcherMode];
    });
}

+ (void)loginUser:(NSString *_Nullable)userId withCompletion:(GYErrorCompletion _Nullable)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager loginUser:userId withCompletion:block];
    });
}

+ (void)logoutWithCompletion:(GYErrorCompletion)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager logoutWithCompletion:block];
    });
}

+ (void)permissionsWithCompletion:(GYPermissionsCompletion)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager permissionsWithCompletion:block];
    });
}

+ (void)offeringsWithCompletion:(GYOfferingsCompletion)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager offeringsWithCompletion:block];
    });
}

+ (void)skuWithIdentifier:(NSString *)skuid completion:(GYSkuBlock)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager skuWithIdentifier:skuid completion:block];
    });
}

+ (void)purchaseSku:(GYSku *)sku completion:(GYPaymentTransactionBlock)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager purchaseSku:sku completion:block];
    });
}

+ (void)purchaseSku:(GYSku *)sku withDiscount:(SKProductDiscount *)discount completion:(GYPaymentTransactionBlock)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager purchaseSku:sku withDiscount:discount completion:block];
    });
}

+ (void)restorePurchasesWithCompletion:(GYPermissionsCompletion)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager restorePurchasesWithCompletion:block];
    });
}

+ (void)setEmailUserProperty:(NSString *)email completion:(GYErrorCompletion)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager setEmailUserProperty:email completion:block];
    });
}

+ (void)setDeviceToken:(NSString *_Nullable)deviceToken completion:(GYErrorCompletion)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager setDeviceToken:deviceToken completion:block];
    });
}

+ (void)setExtraUserProperty:(NSDictionary *)extra completion:(GYErrorCompletion)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager setExtraUserProperty:extra completion:block];
    });
}

+ (void)getUserProperties:(GYUserPropertiesCompletion)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager getUserProperties:block];
    });
}

+ (void)getPaywall:(NSString *)paywallId completion:(GYPaywallCompletion)block
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        [Glassfy.shared.manager getPaywall:paywallId completion:block];
    });
}

+ (void)setLogLevel:(GYLogLevel)level
{
    dispatch_async(Glassfy.shared.glqueue, ^{
        GYLogSetLevel(level);
    });
}

@end
