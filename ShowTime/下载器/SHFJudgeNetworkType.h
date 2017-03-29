//
//  SHFJudgeNetworkType.h
//  Show
//
//  Created by 司华锋 on 2017/3/28.
//  Copyright © 2017年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString *const networkUnknown;
extern NSString *const networkIsWIFI;
extern NSString *const networkIsWWAN;
extern NSString *const networkINotReachable;
extern NSString *const SHFCurrentNetworkType;

typedef void(^networkBlock)(NSString *networkType);
@interface SHFJudgeNetworkType : NSObject
/**
 * 判断当前网络类型，要借助AFN，提前导入
 */
+ (void)judgeNetworkTypeIs:(networkBlock)networkType;
@end
