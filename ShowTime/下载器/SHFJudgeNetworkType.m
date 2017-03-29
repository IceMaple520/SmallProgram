//
//  SHFJudgeNetworkType.m
//  Show
//
//  Created by 司华锋 on 2017/3/28.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "SHFJudgeNetworkType.h"
#import "AFNetworkReachabilityManager.h"

NSString *const networkUnknown = @"Unknown";
NSString *const networkIsWIFI = @"WIFI";
NSString *const networkIsWWAN = @"WWAN";
NSString *const networkINotReachable = @"NotReachable";
NSString *const SHFCurrentNetworkType = @"currentNetworkType";

@implementation SHFJudgeNetworkType
+ (void)judgeNetworkTypeIs:(networkBlock)networkType {
    __block BOOL isCheck = YES;//判断是否在请求当前网络类型，YES是，NO不是
    __block __weak AFNetworkReachabilityManager * manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSString *netWorkTypeStr = nil;
        if (status ==  AFNetworkReachabilityStatusUnknown) {
            netWorkTypeStr = networkUnknown;
        } else if (status == AFNetworkReachabilityStatusNotReachable) {
            netWorkTypeStr = networkINotReachable;
            
        } else if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
            netWorkTypeStr = networkIsWWAN;
            //使用手机流量
        } else if (status == AFNetworkReachabilityStatusReachableViaWiFi) {
            netWorkTypeStr = networkIsWIFI;
            //WIFI
        } else {
            netWorkTypeStr = networkUnknown;
            //未知
        }
        
        [self setNetworkType:netWorkTypeStr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isCheck == YES) {
                networkType(netWorkTypeStr);
                
                isCheck = NO;
            }
        });
    }];
}

+ (void)setNetworkType:(NSString *)type {
    [[NSUserDefaults standardUserDefaults] setObject:type forKey:SHFCurrentNetworkType];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
