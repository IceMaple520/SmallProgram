//
//  PlayerViewController.m
//  Show
//
//  Created by 司华锋 on 2017/3/28.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "PlayerViewController.h"
#import "SHFPlayer.h"
@interface PlayerViewController ()<SHFPlayerDelegate>
@property (nonatomic,strong) SHFPlayer *player;
@end

@implementation PlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}
- (void)setUI
{
    _player = [[SHFPlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) urlString:@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"];
    _player.backgroundColor = [UIColor blackColor];
    _player.tag = 300;
    _player.delegate = self;
    [self.view addSubview:_player];
}
- (void)changeMaxView:(UIView *)sf
{
    [self.view bringSubviewToFront:sf];
    self.navigationController.navigationBarHidden = YES;
}
- (void)changeMinView:(UIView *)sf
{
    self.navigationController.navigationBarHidden = NO;


}
- (void)isCurrentView:(UIView *)sf
{
    if (self.player == nil) {
        self.player = (SHFPlayer*)sf;
        
    }else if(self.player.tag == sf.tag){
        
        NSLog(@"%ld",(long)self.player.tag);
        
    }else{
        
        [self.player.myPlayer pause];
        self.player.playButton.selected = NO;
        self.player.playButton.alpha = 1 ;
        self.player = (SHFPlayer*)sf;
        return;
    }
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
