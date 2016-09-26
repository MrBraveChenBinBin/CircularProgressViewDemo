//
//  CircularProgressView.h
//  CustomCircularProgressView
//
//  Created by 彬彬 on 16/9/26.
//  Copyright © 2016年 陈彬彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircularProgressView : UIView
/** 进度 */
@property(nonatomic,assign)CGFloat signProgress;

-(void)CircularProgressViewStart;

@end
