//
//  GYAPIPaywallResponse.m
//  Glassfy
//
//  Created by Luca Garbolino on 27/06/22.
//

#import "GYAPIPaywallResponse.h"
#import "GYSku+Private.h"
#import "GYError.h"

#define PAYWALL_TYPE_HTML @"html"
#define PAYWALL_TYPE_NOCODE @"nocode"

@implementation GYAPIPaywallResponse

- (instancetype _Nullable)initWithObject:(NSDictionary *)obj error:(NSError **)error
{
    self = [super initWithObject:obj error:error];
    if (error && *error) {
        return self;
    }
    
    if (self) {
        NSDictionary *paywall = obj[@"paywall"];
        if ([paywall isKindOfClass:NSDictionary.class]) {
            
            NSString *version = paywall[@"version"];
            if ([version isKindOfClass:NSString.class]) {
                self.version = version;
            }
            
            GYPaywallType type = GYPaywallTypeNoCode;
            NSString *typeStr = paywall[@"type"];
            if ([typeStr isKindOfClass:NSString.class]) {
                if ([PAYWALL_TYPE_HTML isEqualToString:typeStr]) {
                    type = GYPaywallTypeHTML;
                } else if ([PAYWALL_TYPE_NOCODE isEqualToString:typeStr]) {
                    type = GYPaywallTypeNoCode;
                }
            }
            self.type = type;
            
            NSString *contentUrl = paywall[@"url"];
            if ([contentUrl isKindOfClass:NSString.class]) {
                self.contentUrl = contentUrl;
            }
            NSString *content = paywall[@"content"];
            if ([content isKindOfClass:NSString.class]) {
                self.content = content;
            }
            
            NSString *locale = paywall[@"locale"];
            if ([locale isKindOfClass:NSString.class]) {
                self.locale = locale;
            }
            
            NSString *pwid = paywall[@"pwid"];
            if ([pwid isKindOfClass:NSString.class]) {
                self.pwid = pwid;
            }
        }
        
        NSMutableArray *skus = [NSMutableArray array];
        NSArray *skusJSON = obj[@"skus"];
        if ([skusJSON isKindOfClass:NSArray.class]) {
            for (NSDictionary *skuJSON in skusJSON) {
                if (![skuJSON isKindOfClass:NSDictionary.class] || skuJSON.allKeys.count == 0) {
                    continue;
                }
                
                //ToDo manage error
                GYSku *s = [[GYSku alloc] initWithObject:skuJSON error:error];
                if (s) {
                    [skus addObject:s];
                }
            }
        }
        self.skus = skus;
        
        
        // verify
        if (!self.contentUrl && !self.content) {
            if (error) {
                *error = [GYError serverError:GYErrorCodeUnknow description:@"Unexpected data format"];
            }
        }
    }
    return self;
    
}

@end
