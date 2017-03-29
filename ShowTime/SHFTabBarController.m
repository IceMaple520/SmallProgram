//
//  SHFTabBarController.m
//  Show
//
//  Created by 司华锋 on 2017/3/28.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "SHFTabBarController.h"

#import "SHFNavigationController.h"

#import "WaterViewController.h"
#import "PlayerViewController.h"
#import "TimeLineViewController.h"
#import "DownloaderViewController.h"
@interface SHFTabBarController ()

@end

@implementation SHFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    [self setUpItem];
}
-(void)setUpItem
{
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x888888)} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColorFromRGB(0x3280e0)} forState:UIControlStateSelected];
    self.tabBar.tintColor = UIColorFromRGB(0x3280e0);
    
}
- (void)setUI
{
    [self setChildViewController:[[WaterViewController alloc] init] withNormalImage:@"cloud_default" withSelectedImage:@"cloud_click" withTitle:@"水波"];
    
    [self setChildViewController:[[TimeLineViewController alloc] init] withNormalImage:@"event_default" withSelectedImage:@"event_click" withTitle:@"时间"];
    
    [self setChildViewController:[[DownloaderViewController alloc] init] withNormalImage:@"placeback_default" withSelectedImage:@"placeback_click" withTitle:@"下载"];
    
    [self setChildViewController:[[PlayerViewController alloc] init] withNormalImage:@"me_default" withSelectedImage:@"me_click" withTitle:@"视频"];
    
}

- (void)setChildViewController:(UIViewController *)childViewController withNormalImage:(NSString *)normalImage withSelectedImage:(NSString *)selectedImage withTitle:(NSString *)title
{
    SHFNavigationController *nav = [[SHFNavigationController alloc] initWithRootViewController:childViewController];
    childViewController.tabBarItem.image = UIImageFrom(normalImage);
    childViewController.tabBarItem.selectedImage = UIImageFrom(selectedImage);
    childViewController.tabBarItem.title = title;
    childViewController.title = title;
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self addChildViewController:nav];
    
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
