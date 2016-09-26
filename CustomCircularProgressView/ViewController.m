//
//  ViewController.m
//  CustomCircularProgressView
//
//  Created by 彬彬 on 16/9/26.
//  Copyright © 2016年 陈彬彬. All rights reserved.
//

#import "ViewController.h"
#import "CBBCircularProgressView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CBBCircularProgressView * circularProgressView =[[CBBCircularProgressView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    circularProgressView.center = self.view.center;
    circularProgressView.signProgress = 0.8;
    [circularProgressView CircularProgressViewStart];
    [self.view addSubview:circularProgressView];
    
}


@end
