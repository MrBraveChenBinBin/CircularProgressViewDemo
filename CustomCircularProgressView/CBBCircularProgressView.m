//
//  CircularProgressView.m
//  CustomCircularProgressView
//
//  Created by 彬彬 on 16/9/26.
//  Copyright © 2016年 陈彬彬. All rights reserved.
//

#import "CBBCircularProgressView.h"

#define degreesToRadians(x) (M_PI*(x)/180.0)
#define PROGRESS_LINE_WIDTH 10 //弧线的宽度

@interface CBBCircularProgressView()
{
    CAShapeLayer *_trackLayer;
    CAShapeLayer *_progressLayer;

}

/** 进度条中间文字  */
@property(nonatomic,weak)UILabel*lable;
/** 进度 */
@property(nonatomic,assign)CGFloat progress;
/** 定时器 */
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation CBBCircularProgressView

/** 画板 */
- (void)drawRect:(CGRect)rect {
    
    // 创建一个track shape layer
    _trackLayer = [CAShapeLayer layer];
    _trackLayer.frame = self.bounds;
    _trackLayer.fillColor = [[UIColor clearColor] CGColor];
    _trackLayer.strokeColor = [[UIColor cyanColor]  CGColor];
    [self.layer addSublayer:_trackLayer];
    
    // 指定path的渲染颜色
    _trackLayer.opacity = 1; // 背景透明度
    _trackLayer.lineCap = kCALineCapRound;// 指定线的边缘是圆的
    _trackLayer.lineWidth = PROGRESS_LINE_WIDTH; // 线的宽度
    
    
    // 上面说明过了用来构建圆形
    
    /*
     center：圆心的坐标
     radius：半径
     startAngle：起始的弧度
     endAngle：圆弧结束的弧度
     clockwise：YES为顺时针，No为逆时针
     方法里面主要是理解startAngle与endAngle
     */
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                        radius:self.frame.size.width/2
                                                    startAngle:degreesToRadians(270)
                                                      endAngle:degreesToRadians(-90) clockwise:NO];
    
    _trackLayer.path = [path CGPath]; // 把path传递給layer，然后layer会处理相应的渲染，整个逻辑和CoreGraph是一致的。
    

    
    
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor = [[UIColor clearColor] CGColor];
    _progressLayer.strokeColor = [[UIColor redColor] CGColor];
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = PROGRESS_LINE_WIDTH;
    _progressLayer.path = [path CGPath];
    _progressLayer.opacity = 1;
    _progressLayer.strokeEnd = 0;
    
    [self.layer addSublayer:_progressLayer];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
         self.backgroundColor = [UIColor clearColor];
        [self setUpSubViews];
        
    }
    return self;
}

- (void)setUpSubViews{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height-20)/2, self.frame.size.width, 20)];
    label.textColor = [UIColor blueColor];
    label.textAlignment =1;
    self.lable = label;
    [self addSubview:label];
}

-(void)CircularProgressViewStart{
    if (self.timer == nil) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(ChangeCircleValue:) userInfo:nil repeats:YES];
            [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        });
        
    }
}

-(void)ChangeCircleValue:(NSTimer *)timer{
    
    if (self.progress >= self.signProgress){
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    self.progress += 0.01;
    self.lable.text = [NSString stringWithFormat:@"%.1f％",self.progress * 100];
    _progressLayer.strokeEnd = self.progress;
   
}
@end
