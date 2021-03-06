//
//  MNTimeLine.m
//  text
//
//  Created by 蛮牛科技 on 16/3/23.
//  Copyright © 2016年 蛮牛科技. All rights reserved.
//

#import "MNTimeLine.h"
#import "MNTimeLineView.h"
#define kWinH [UIScreen mainScreen].bounds.size.height
#define kWinW [UIScreen mainScreen].bounds.size.width
#define minUnitTime
#define rightBorderLineX -m_nEndX + kWinW + 320
#define timelineW 80


@interface MNTimeLine ()
// 储存可视区域的视图及其index
@property (nonatomic, strong) NSMutableDictionary *visibleListViewsItems;

//@property (nonatomic, strong) NSMutableSet *dequeueViewPool;

@end

@implementation MNTimeLine


-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        m_nStartX = 1;
        m_nEndX = self.frame.size.width;
        self.backgroundColor = [UIColor colorWithRed:34/255.0f green:34/255.0f blue:34/255.0f alpha:1];
     }
    return self;
}


-(void)drawRect:(CGRect)rect{
    
    context = UIGraphicsGetCurrentContext();
    
    CGContextSynchronize(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    
    CGContextSetLineWidth(context, 1.0);
    
//    CGContextSetRGBStrokeColor(context, 1.f, 128/255.f, 37/255.f, 1.0);
    CGContextSetRGBStrokeColor(context, 50/255.f, 128/255.f, 224/255.f, 1.0);

    CGContextBeginPath(context);
    
    
//    CGContextMoveToPoint(context, m_nStartX, self.frame.size.height * 4 / 5);
//    
//    //下一点
//    CGContextAddLineToPoint(context, m_nEndX
//                            , self.frame.size.height * 4 / 5);
//    
//    CGContextStrokePath(context);
    
    
    float nDeltaX = (m_nEndX - m_nStartX  + 1) / 720;
    
    NSLog(@"当前每隔的宽度%f",nDeltaX);
    NSLog(@"当前可视区域X%f",self.videoX);
    
    if (!self.endDrawRect) {
            if (nDeltaX != 0) {
                 if (nDeltaX > 60) {
                    float mDeltaX = (m_nEndX - m_nStartX  + 1) /7200;
                     int m = self.videoX / mDeltaX;
                     int y = kWinW / mDeltaX;
                    for (int x = m; x < y + m; x ++){
                        if ((1 + x*mDeltaX) > m_nEndX) {
                            [self drawRectSizeA:(x - m_nEndX/mDeltaX) mDeltaX:mDeltaX];
                        }else{
                            [self drawRectSizeA:x mDeltaX:mDeltaX];
  
                        }
                    }
                  }else if (nDeltaX > 35){
                    float mDeltaX = (m_nEndX - m_nStartX  + 1) /3600;
                    int m = self.videoX / mDeltaX;
                    int y = kWinW / mDeltaX;
                    for (int x = m; x < y + m; x ++){
                        if ((1 + x*mDeltaX) > m_nEndX) {
                            [self drawRectSizeB:(x - m_nEndX/mDeltaX) nDeltaX:mDeltaX];
                        }else{
                            [self drawRectSizeB:x nDeltaX:mDeltaX];
                            
                        }

                    }
                    
                }
                
                else{
                    int m = self.videoX / nDeltaX;
                    int y = kWinW / nDeltaX;

                    for (int x = m; x < y + m; x ++){
                        if ((1 + x*nDeltaX) > m_nEndX) {
                        [self drawRectSizeC:(x - m_nEndX/nDeltaX) nDeltaX:nDeltaX];
                    }else{
                        [self drawRectSizeC:x nDeltaX:nDeltaX];
                    }
                    
                }
            }
        }
    }else{

    if (nDeltaX != 0) {
        if (nDeltaX > 60) {
            float mDeltaX = (m_nEndX - m_nStartX  + 1) /7200;
            for (int x = 0; x < 7200; x ++){
                [self drawRectSizeA:x mDeltaX:mDeltaX];
            }

            NSLog(@"22");
        }else if (nDeltaX > 35){
            float mDeltaX = (m_nEndX - m_nStartX  + 1) /3600;
            for (int x = 0; x < 3600; x ++){
                [self drawRectSizeB:x nDeltaX:mDeltaX];
            }
            
        }
        
        else{
            for (int x = 0; x < 720; x ++){
                [self drawRectSizeC:x nDeltaX:nDeltaX];
                
            }
            
        }
    }
        
        //报警区域
        for (MNDrawRect *drawRect in self.rectangleArray) {
            CGRect rect = CGRectMake(drawRect.start_time, 0, drawRect.stop_time - drawRect.start_time, timelineW);
//            NSValue *value = [NSValue valueWithCGRect:rectangleRect];
//        
//            CGRect rect = [value CGRectValue];
            if (drawRect.event == MNREC) {
                [self drawRectangle:rect red:50/255.0f green:128/255.0f blue:224/255.0f alpha:0.3];
            }else if (drawRect.event == MNAlarmeventMove){
                [self drawRectangle:rect red:246/255.0f green:197/255.0f blue:53/255.0f alpha:0.5];
            }
            
            
         }
        CGContextSynchronize(context);
        CGContextSetLineCap(context, kCGLineCapSquare);
        
        CGContextSetLineWidth(context, 1.0);
        
        //        CGContextSetRGBStrokeColor(context, 1.f, 128/255.f, 37/255.f, 1.0);
        CGContextSetRGBStrokeColor(context, 50/255.f, 128/255.f, 224/255.f, 1.0);
        
        CGContextBeginPath(context);
    
    }
    
}
-(void)drawTimeLabel:(NSString *)str X: (float)x{
    CGPoint point = CGPointMake(x, 30);
    
    [str drawAtPoint:point withAttributes:@{NSFontAttributeName:
                                                [UIFont fontWithName:@"HelveticaNeue-Bold" size:13.f],
                                            NSForegroundColorAttributeName:UIColorFromRGB(0x3280e0)
                                            }];
//    CGContextSetRGBStrokeColor(context, 1.f, 128/255.f, 37/255.f, 1.0);
    CGContextSetRGBStrokeColor(context, 50/255.f, 128/255.f, 224/255.f, 1.0);
  
}

-(void)drawRectSizeA:(int)x mDeltaX:(float)mDeltaX{
    if (x % 7200){
        if (x % 3600) {
            if (x % 300) {
                if (x % 10) {
                        [self drawScaleWithX:(1 + x*mDeltaX) Y:self.frame.size.height  Height:5];
                        [self drawScaleWithX:(1 + x*mDeltaX) Y:5 Height:5];
                    
                }else{
                    [self drawScaleWithX:(1 + x*mDeltaX) Y:self.frame.size.height  Height:15];
                    [self drawScaleWithX:(1 + x*mDeltaX) Y:15 Height:15];
                    if (x/5 > 60) {
                        if ((x/5) % 60 < 10){
                            NSString *str = [NSString stringWithFormat:@"%d:0%d",x/5/60,(x/5) % 60];
                            [self drawTimeLabel:str X:1 + x*mDeltaX];
                            
                        }else{
                            NSString *str = [NSString stringWithFormat:@"%d:%d",x/5/60,(x/5) % 60];
                            [self drawTimeLabel:str X:1 + x*mDeltaX];
                            
                        }
                        
                    }else{
                        if (x/5 < 10) {
                            NSString *str = [NSString stringWithFormat:@"00:0%d",x/5];
                            [self drawTimeLabel:str X:1 + x*mDeltaX];
                            
                        }else{
                            NSString *str = [NSString stringWithFormat:@"00:%d",x/5 ];
                            [self drawTimeLabel:str X:1 + x*mDeltaX];
                            
                        }
                    }
                }
       
                
            }else{
                [self drawScaleWithX:(1 + x*mDeltaX) Y:self.frame.size.height Height:25];
                [self drawScaleWithX:(1 + x*mDeltaX) Y:25 Height:25];

                NSString *str  =[NSString stringWithFormat:@"%d:00",x/300];
                [self drawTimeLabel:str X:1 + x*mDeltaX];
            }
        }else{
            [self drawScaleWithX:(1 + x*mDeltaX) Y:self.frame.size.height Height:self.frame.size.height];
            [self drawTimeLabel:@"12:00" X:1 + x*mDeltaX];
        }
    }else{
        [self drawScaleWithX:(1 + x*mDeltaX) Y:self.frame.size.height Height:self.frame.size.height];
        [self drawTimeLabel:@"00:00" X:1 + x*mDeltaX];
    }
}

-(void)drawRectSizeB:(int)x nDeltaX:(float)nDeltaX{
    if (x % 3600) {
        if (x % 1800){
            if (x % 150) {
                if (x % 5) {
                    [self drawScaleWithX:(1 + x*nDeltaX) Y:self.frame.size.height Height:5];
                    [self drawScaleWithX:(1 + x*nDeltaX) Y:5 Height:5];
                
                }else{
                    [self drawScaleWithX:(1 + x*nDeltaX) Y:self.frame.size.height Height:10];
                    [self drawScaleWithX:(1 + x*nDeltaX) Y:10 Height:10];
                    if (x/5 > 30) {
                        if (((x/5)* 2) % 60 < 10){
                            NSString *str = [NSString stringWithFormat:@"%d:0%d",x/150,((x/5)* 2) % 60];
                            [self drawTimeLabel:str X:1 + x*nDeltaX];
                            
                        }else{
                            NSString *str = [NSString stringWithFormat:@"%d:%d",x/150,((x/5)* 2) % 60];
                            [self drawTimeLabel:str X:1 + x*nDeltaX];
                            
                        }
                        
                    }else{
                        if (((x/5)* 2) % 60 < 10) {
                            NSString *str = [NSString stringWithFormat:@"00:0%d",((x/5)* 2) % 60];
                            [self drawTimeLabel:str X:1 + x*nDeltaX];
                            
                        }else{
                            NSString *str = [NSString stringWithFormat:@"00:%d",((x/5)* 2) % 60];
                            [self drawTimeLabel:str X:1 + x*nDeltaX];
                            
                        }
                    }
//                    NSString *str  =[NSString stringWithFormat:@"%d:%d",x/150,((x/5) % 60) * 2];
//                    [self drawTimeLabel:str X:(1 + x*nDeltaX)];
//                    
                }
                
            }else{
                [self drawScaleWithX:(1 + x*nDeltaX) Y:self.frame.size.height  Height:15];
                [self drawScaleWithX:(1 + x*nDeltaX) Y:15 Height:15];

                NSString *str  =[NSString stringWithFormat:@"%d:00",x/150];
                [self drawTimeLabel:str X:1 + x*nDeltaX];
            }
        }else{
            [self drawScaleWithX:(1 + x*nDeltaX) Y:self.frame.size.height  Height:self.frame.size.height];
            [self drawTimeLabel:@"12:00" X:1 + x*nDeltaX];
        }
    }else{
        [self drawScaleWithX:(1 + x*nDeltaX) Y:self.frame.size.height Height:self.frame.size.height];
        [self drawTimeLabel:@"00:00" X:1];
        
    }

}
-(void)drawRectSizeC:(int)x nDeltaX:(float)nDeltaX{
    if (x % 720) {
        if (x % 360){
            if (x % 30) {
                if (x % 5) {
                    [self drawScaleWithX:(1 + x*nDeltaX) Y:self.frame.size.height  Height:5];
                    [self drawScaleWithX:(1 + x*nDeltaX) Y:5 Height:5];

                    
                }else{
                    [self drawScaleWithX:(1 + x*nDeltaX) Y:self.frame.size.height Height:10];
                    [self drawScaleWithX:(1 + x*nDeltaX) Y:10 Height:10];
                    if (nDeltaX > 8) {
                        if (x > 30) {
                            NSString *str = [NSString stringWithFormat:@"%d:%d0",x/30,(x/5) % 6];
                            [self drawTimeLabel:str X:1 + x*nDeltaX];
                            
                            
                        }else{
                                 NSString *str = [NSString stringWithFormat:@"0%d:%d0",x/30,(x/5) % 6];
                                [self drawTimeLabel:str X:1 + x*nDeltaX];
                                
                         }

                    }

                }
                
            }else{
                [self drawScaleWithX:(1 + x*nDeltaX) Y:self.frame.size.height Height:15];
                [self drawScaleWithX:(1 + x*nDeltaX) Y:15 Height:15];

                NSString *str  =[NSString stringWithFormat:@"%d:00",x/30];
                [self drawTimeLabel:str X:1 + x*nDeltaX];
            }
        }else{
            [self drawScaleWithX:(1 + x*nDeltaX) Y:self.frame.size.height Height:self.frame.size.height];
            [self drawTimeLabel:@"12:00" X:1 + x*nDeltaX];
        }
    }else{
        [self drawScaleWithX:(1 + x*nDeltaX) Y:self.frame.size.height Height:self.frame.size.height];
        [self drawTimeLabel:@"00:00" X:1];
        
    }
}
-(void)drawScaleWithX:(float)nX Y:(float)nY Height:(float)nHeight{
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, nX, nY);
    
    CGContextAddLineToPoint(context, nX, nY - nHeight);
    CGContextStrokePath(context);
}

//画矩形
-(void)drawRectangle:(CGRect)rect red:(float)red green:(float)green blue:(float)blue alpha:(float)alpha {
   // CGContextBeginPath(context);
    //CGContextStrokeRect(context, rect);
     CGContextSetRGBFillColor(context,red,green,blue,alpha);
    
  
    CGContextFillRect(context, rect);
 
    //CGContextSetRGBStrokeColor(context, red, green, blue, alpha);
    //设置画笔线条粗细
    //CGContextSetLineWidth(context, 0.5);
    //画矩形边框
   // CGContextAddRect(context,rect);
    
    CGContextStrokePath(context);
    
    
//    CGContextSynchronize(context);
//    CGContextSetLineCap(context, kCGLineCapSquare);

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    NSLog(@"11");
}
@end
