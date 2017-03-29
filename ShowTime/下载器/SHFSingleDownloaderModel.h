//
//  SHFSingleDownloaderModel.h
//  Show
//
//  Created by 司华锋 on 2017/3/28.
//  Copyright © 2017年 HF. All rights reserved.
//

#import <Realm/Realm.h>

@interface SHFSingleDownloaderModel : RLMObject
@property NSString *downloadUrl;

@property NSString *fileType;

@property NSString *filename;

@property float downloaderProgress;

@property NSString *localUrl;

@property BOOL isExistInRealm;
@end
