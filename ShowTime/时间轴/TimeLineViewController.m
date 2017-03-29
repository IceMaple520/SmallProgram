//
//  TimeLineViewController.m
//  Show
//
//  Created by 司华锋 on 2017/3/28.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "TimeLineViewController.h"
#import "MNTimeLineView.h"
@interface TimeLineViewController ()<MNTimeLineTimeDelegate>

@property (nonatomic,strong) MNTimeLineView *lineView;

@end

@implementation TimeLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}
- (void)setUI
{
    _lineView = [[MNTimeLineView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 80)];
    _lineView.backgroundColor = [UIColor grayColor];
    _lineView.delegate = self;
    _lineView.userInteractionEnabled = YES;
    [_lineView setTimeLineWithDate:[NSDate date]];
    [self.view addSubview:_lineView];

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 200, 120, 120)];
    imageView.image = UIImageFrom(@"11-47-12-48-23.jpg");
    imageView.layer.cornerRadius = 60;
    imageView.layer.masksToBounds = YES;
    [self.view addSubview:imageView];
    [imageView.layer addAnimation:[self animationTime:8.0f] forKey:nil];
}
- (CABasicAnimation *)animationTime:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:M_PI * 2.0];
    animation.duration = duration;
    animation.cumulative = YES;
    animation.repeatCount = HUGE_VALF;
   
    return animation;
}

-(void)MNTimeLinePresentTime:(NSDate * _Nonnull )time{

}
- (void)scrollViewWillBegin{

}
-(void)touchViewEnd{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
