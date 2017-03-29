//
//  ViewController.m
//  ShowTime
//
//  Created by 司华锋 on 2017/2/13.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "ViewController.h"

#import "ZBarSDK.h"




@interface ViewController ()<ZBarReaderDelegate>
{
    UIImageView *plane;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(40, 40, 50, 50)];
    btn.backgroundColor = [UIColor lightGrayColor];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [btn addTarget:self action:@selector(moviePlane:) forControlEvents:UIControlEventTouchUpInside];
//    [btn setTitle:@"扫我" forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(saoyisao:) forControlEvents:UIControlEventTouchUpInside];
    [btn addTarget:self action:@selector(transition:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btn];
    
    plane = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    plane.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:plane];
}


- (void)btnClick:(id)sender
{
   
    [UIView beginAnimations:nil context:NULL];
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(180, 200);
    plane.layer.affineTransform = moveTransform;
    plane.layer.opacity = 1;
    [UIView commitAnimations];
    
    
    
}


- (void)moviePlane:(UIButton *)sender
{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
    anim.duration = 3.0f;
    anim.fromValue = [NSNumber numberWithFloat:.25];
    anim.toValue = [NSNumber numberWithFloat:1.0];
    anim.cumulative = YES;
    anim.repeatCount = 2;
    [plane.layer addAnimation:anim forKey:@"animationOpacity"];
    
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(180, 200);
    CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    moveAnim.duration = 6.0;
    moveAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeAffineTransform(moveTransform)];
    [plane.layer addAnimation:moveAnim forKey:@"animationTransform"];
    

}
- (void)saoyisao:(UIButton *)sender
{
    ZBarReaderController *reader = [[ZBarReaderController alloc] init];
    reader.readerDelegate = self;
    reader.showsZBarControls = YES;
    
    ZBarImageScanner *scanner = reader.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    
    [self presentViewController:reader animated:YES completion:nil];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for (symbol in results) {
        break;
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)transition:(UIButton *)sender
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor blackColor];
    view.frame = CGRectMake(50, 200, 50, 100);
//    view.alpha = 0.5;
    [self.view addSubview:view];

    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromBottom;
    [view.layer addAnimation:transition forKey:@"animation"];
    
}

- (void)setAnimation:(UIButton *)sender
{
    
    
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
