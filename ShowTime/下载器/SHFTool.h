//
//  SHFTool.h
//  Show
//
//  Created by 司华锋 on 2017/3/28.
//  Copyright © 2017年 HF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHFTool : NSObject
/**
 * 检查是否是有效的http或者https链接
 */
+ (BOOL)checkIsUrlAtString:(NSString *)url;

/**
 * 检查对象是否为空
 */
+ (BOOL)checkIsEmpty:(id)objective;

/**
 * 编码文件名
 */
+ (NSString *)encodeFilename:(NSString *)filename;

/**
 * 解码文件名
 */
+ (NSString *)decodeFilename:(NSString *)filename;
@end
