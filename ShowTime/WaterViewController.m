//
//  WaterViewController.m
//  ShowTime
//
//  Created by 司华锋 on 2017/2/23.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "WaterViewController.h"
#import "WaterView.h"

#import "AFNetworking.h"

@interface WaterViewController ()

@end

@implementation WaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUp];
}
- (void)setUp
{
    WaterView *water = [[WaterView alloc] initWithFrame:CGRectMake(50, 120, 200, 200)];
    water.layer.cornerRadius = 100;
    [self.view addSubview:water];

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
