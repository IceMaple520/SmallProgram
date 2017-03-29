//
//  SHFSingleDownloaderModel.m
//  Show
//
//  Created by 司华锋 on 2017/3/28.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "SHFSingleDownloaderModel.h"

@implementation SHFSingleDownloaderModel
// Specify default values for properties

//将downloadUrl设置为主key
+ (NSString *)primaryKey {
    return @"downloadUrl";
}

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

+ (NSArray *)ignoredProperties
{
    return @[@"localUrl", @"isExistInRealm"];
}

@end
