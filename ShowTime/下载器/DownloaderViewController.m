//
//  DownloaderViewController.m
//  Show
//
//  Created by 司华锋 on 2017/3/28.
//  Copyright © 2017年 HF. All rights reserved.
//

#import "DownloaderViewController.h"

#import "SHFDownloader.h"
@interface DownloaderViewController ()<SHFDownloaderDelegate>
@property (nonatomic,assign) NSString *downloaderUrl;
@property (nonatomic,strong) UILabel *speenLabel;

@property (nonatomic,strong) SHFDownloader *downloader;
@end

@implementation DownloaderViewController
//- (UILabel *)speenLabel
//{
//    if (_speenLabel == nil) {
//        _speenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 150, 44)];
//        _speenLabel.textColor  =[UIColor redColor];
//        _speenLabel.textAlignment = NSTextAlignmentCenter;
//        _speenLabel.font = [UIFont systemFontOfSize:18];
//    }
//    return _speenLabel;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
}
- (void)setUI
{
    NSArray *titleArray = @[@"开始下载",@"暂停下载",@"继续下载",@"取消下载"];
    for (NSInteger i = 0; i < titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor grayColor]];
        btn.frame = CGRectMake((self.view.frame.size.width + 8) / 4 * i, 0, (self.view.frame.size.width - 8) / 4, 44);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    self.downloader = [SHFDownloader sharedDownloader];
    self.downloader.maxDownloaderNum = 3;
    self.downloader.zylDownloaderDelegate = self;
    self.downloaderUrl = @"http://sbslive.cnrmobile.com/storage/storage2/18/01/18/46eeb50b3f21325a6f4bd0e8ba4d2357.3gp";
   
    
    _speenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 300, 44)];
    _speenLabel.textColor = [UIColor redColor];
    _speenLabel.textAlignment = NSTextAlignmentCenter;
    _speenLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:_speenLabel];

}
- (void)btnClick:(UIButton *)sender
{
    switch (sender.tag - 100) {
        case 0:
        {
            [self.downloader startDownloadWithDownloadUrl:self.downloaderUrl filename:@"吃饭睡觉下载电影" fileType:@"3gp" isHand:NO];
            
            
            
            break;
        }
        case 1:
        {
            
            [self.downloader pauseDownloaderWithDownloadUrl:self.downloaderUrl];
            
            
            break;
        }
        case 2:
        {
          
            [self.downloader resumeDownloaderWithDownloadUrl:self.downloaderUrl];
            
            
            break;
        }
        case 3:
        {
            
            [self.downloader deleteDownloaderInfoWithDownloderUrl:self.downloaderUrl];
            
            
            break;
        }
        default:
            break;
    }

}


#pragma mark - 下载器的代理***********************************************************
#pragma mark - 下载的速度
/*************************************************************************/
- (void)downloaderSpeed:(NSInteger)speed andDownloaderUrl:(NSString *)downloaderUrl {
    NSString *speedStr = nil;
    if (speed >= 0 && speed < 1024) {
        //B
        speedStr = [NSString stringWithFormat:@"下载速度为：%ldb/s", (long)speed];
    } else if (speed >= 1024 && speed < 1024 * 1024) {
        //KB
        speedStr = [NSString stringWithFormat:@"下载速度为：%.2lfkb/s", (long)speed / 1024.0];
    } else if (speed >= 1024 * 1024) {
        //MB
        speedStr = [NSString stringWithFormat:@"下载速度为：%.2lfmb/s", (long)speed / 1024.0 / 1024.0];
    }
    _speenLabel.text = speedStr;
    NSLog(@"文件：%@的下载速度：%@", downloaderUrl,speedStr);
}

- (void)downloaderRate:(float)rate withDownloaderUrl:(NSString *)downloaderUrl {
    
}

- (void)downloaderState:(SHFDownloaderState)state andDownloaderUrl:(NSString *)downloaderUrl {
    NSLog(@"下载器的状态%lu", (unsigned long)state);
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
