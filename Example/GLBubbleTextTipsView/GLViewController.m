//
//  GLViewController.m
//  GLBubbleTextTipsView
//
//  Created by lin peng on 05/28/2022.
//  Copyright (c) 2022 lin peng. All rights reserved.
//

#import "GLViewController.h"

@import GLBubbleTextTipsView;

@interface GLViewController ()

@end

@implementation GLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //箭头向下
    {
        UIColor *bgColor = [UIColor colorWithRed:237 / 255.0 green:102 / 255.0 blue:100 / 255.0 alpha:1];
        [GLBubbleTextTipsView showTipsViewWithText:@"这是气泡引导，不用重复造轮子啦" rootView:self.view width:150 point:CGPointMake(100, 200) align:kGLArrowDirectionLeft bgColor:bgColor textColor:[UIColor whiteColor] alignOffset:0 isArrowDwon:YES];
    }
    
    //箭头向上
    {
        UIColor *bgColor = [UIColor colorWithRed:34 / 255.0 green:34 / 255.0 blue:34 / 255.0 alpha:1];
        GLBubbleTextTipsView *tips = [GLBubbleTextTipsView showTipsViewWithText:@"这是气泡引导，不用重复造轮子啦" rootView:self.view width:120 point:CGPointMake(100, 250) align:kGLArrowDirectionCenter bgColor:bgColor textColor:[UIColor whiteColor] alignOffset:0 isArrowDwon:NO];
        [tips setDissmissBlock:^(GLBubbleTextTipsView * _Nonnull view) {
            NSLog(@"消失啦");
        }];
    }
    
    {
        UIColor *bgColor = [UIColor colorWithRed:137 / 255.0 green:32 / 255.0 blue:100 / 255.0 alpha:1];
        GLBubbleTextTipsView *tips = [GLBubbleTextTipsView showTipsViewWithText:@"这是气泡引导，不用重复造轮子啦" rootView:self.view width:120 point:CGPointMake(100, 400) align:kGLArrowDirectionRight bgColor:bgColor textColor:[UIColor whiteColor] alignOffset:0 isArrowDwon:YES];
        [tips setDissmissBlock:^(GLBubbleTextTipsView * _Nonnull view) {
            NSLog(@"消失啦");
        }];
    }
    
    {
        UIColor *bgColor = [UIColor colorWithRed:56 / 255.0 green:130 / 255.0 blue:134 / 255.0 alpha:1];
        GLBubbleTextTipsView *tips = [GLBubbleTextTipsView showTipsViewWithText:@"这是气泡引导，不用重复造轮子啦！！！！" rootView:self.view width:250 point:CGPointMake(100, 450) align:kGLArrowDirectionRight bgColor:bgColor textColor:[UIColor whiteColor] alignOffset:0 isArrowDwon:NO];
        [tips setDissmissBlock:^(GLBubbleTextTipsView * _Nonnull view) {
            NSLog(@"消失啦");
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
