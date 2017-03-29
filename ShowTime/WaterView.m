//
//  WaterVeiw.m
//  ShowTime
//
//  Created by 司华锋 on 2017/2/23.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "WaterView.h"
#import <QuartzCore/QuartzCore.h>


#define rgba(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface WaterView()
@property (nonatomic,strong) CADisplayLink *displayLink;
@property (nonatomic,strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic,strong) CAShapeLayer *secondWaveLayer;
@property (nonatomic,strong) CAShapeLayer *thirdWaveLayer;

@end



@implementation WaterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = rgba(160, 180, 190, 1);
        self.layer.masksToBounds = YES;
        [self configParams];
        [self startWave];
        [self setUI];
    }
    return self;
}
- (void)configParams
{
    _waveWaterWidth = self.frame.size.width;
    _waveWaterHeight = 80;
    _waveColor = rgba(180, 150, 80, 0.4);
    _waveSpeed = 0.08/M_PI;
    _waveSpeed2 = 0.08/M_PI;
    _waveOffsetX = 0;
    _wavePointY = self.frame.size.height - _waveWaterHeight;
    _waveAmpliture = 6;
    _waveCycle = 1.29 * M_PI / _waveWaterWidth;
    
}
- (void)setUI
{
    _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height / 2 - 20, self.frame.size.width, 40)];
    _percentLabel.font = [UIFont boldSystemFontOfSize:30];
    _percentLabel.textColor = [UIColor whiteColor];
    _percentLabel.text = [NSString stringWithFormat:@"%.2f",_waveWaterHeight / self.frame.size.height * 100];
    _percentLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_percentLabel];
    
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width - 40, self.frame.size.height / 2, 20, 20)];
    l.textColor = [UIColor whiteColor];
    l.text = @"%";
    [self addSubview:l];
    
}
- (void)startWave
{
    [self.layer addSublayer:self.firstWaveLayer];
    [self.layer addSublayer:self.secondWaveLayer];
    [self.layer addSublayer:self.thirdWaveLayer];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];

}

- (CAShapeLayer *)firstWaveLayer
{
    if (!_firstWaveLayer) {
        
        _firstWaveLayer = [CAShapeLayer layer];
        _firstWaveLayer.fillColor = [[UIColor colorWithRed:180/255.0f green:150/255.0f blue:80/255.0f alpha:0.4] CGColor];
        
    }
    return _firstWaveLayer;
}

- (CAShapeLayer *)secondWaveLayer
{
    if (!_secondWaveLayer) {
        _secondWaveLayer = [CAShapeLayer layer];
        _secondWaveLayer.fillColor = [[UIColor colorWithRed:180/255.0f green:150/255.0f blue:80/255.0f alpha:0.4] CGColor];
    }
    return _secondWaveLayer;
}
- (CAShapeLayer *)thirdWaveLayer
{
    if (!_thirdWaveLayer) {
        _thirdWaveLayer = [CAShapeLayer layer];
        _thirdWaveLayer.fillColor = [[UIColor colorWithRed:180/255.0f green:150/255.0f blue:80/255.0f alpha:0.4] CGColor];
    }
    return _thirdWaveLayer;
}

- (CADisplayLink *)displayLink
{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave)];
    }
    return _displayLink;
}

- (void)getCurrentWave
{
    _waveOffsetX += _waveSpeed;
    [self setFirstWaveLayerPath];
    [self setSecondWaveLayerPath];
    [self setThirdWaveLayerPath];

}
- (void)setFirstWaveLayerPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = _wavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <= _waveWaterWidth; x++) {
        y = _waveAmpliture * sin(_waveCycle * x + _waveOffsetX - 10) + _wavePointY + 10;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, _waveWaterWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    _firstWaveLayer.path = path;
    CGPathRelease(path);
   
}
- (void)setSecondWaveLayerPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = _wavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <= _waveWaterWidth; x++) {
        y = (_waveAmpliture - 2) * sin(_waveCycle * x + _waveOffsetX) + _wavePointY;
        CGPathAddLineToPoint(path, nil, x, y);
        
    }
    
    CGPathAddLineToPoint(path, nil, _waveWaterWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    _secondWaveLayer.path = path;
    CGPathRelease(path);

}
- (void)setThirdWaveLayerPath
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = _wavePointY;
    CGPathMoveToPoint(path, nil, 0, y);
    for (float x = 0.0f; x <= _waveWaterWidth; x++) {
        y = (_waveAmpliture + 2)* sin(_waveCycle * x + _waveOffsetX + 20) + _wavePointY - 10;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, _waveWaterWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    
    _thirdWaveLayer.path = path;
    CGPathRelease(path);


}













@end
