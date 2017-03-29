//
//  WaterVeiw.h
//  ShowTime
//
//  Created by 司华锋 on 2017/2/23.
//  Copyright © 2017年 HF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterView : UIView

//振幅
@property (nonatomic,assign) CGFloat waveAmpliture;
//周期
@property (nonatomic,assign) CGFloat waveCycle;
//速度
@property (nonatomic,assign) CGFloat waveSpeed;


//
@property (nonatomic,assign) CGFloat waveWaterHeight;
//
@property (nonatomic,assign) CGFloat waveWaterWidth;
//
@property (nonatomic,assign) CGFloat wavePointY;

//波浪X位移
@property (nonatomic,assign) CGFloat waveOffsetX;
//波浪颜色
@property (nonatomic,assign) UIColor *waveColor;

//
@property (nonatomic,assign) CGFloat waveSpeed2;

//所占百分比
@property (nonatomic,strong) UILabel *percentLabel;







@end
