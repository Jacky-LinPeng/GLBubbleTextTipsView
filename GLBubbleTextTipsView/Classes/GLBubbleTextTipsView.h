//
//  GLBubbleTextTipsView.h
//  HiYaMain
//
//  Created by mac on 2021/10/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,kGLArrowDirection){
    //箭头位置
    kGLArrowDirectionLeft = 0,//左
    kGLArrowDirectionCenter,//左中
    kGLArrowDirectionRight,//左下
};

@interface GLBubbleTextTipsView : UIView

@property (nonatomic, assign, readonly) CGSize textSize;

@property (nonatomic, copy) void (^dissmissBlock)(GLBubbleTextTipsView *view);

/// 弹出tips气泡提示
/// @param text 文本
/// @param width 最大宽度
/// @param point 坐标位置
/// @param align 箭头位置
/// @param alignOffset 箭头位置偏移
/// @param isArrowDwon 箭头是否朝下
+ (GLBubbleTextTipsView *)showTipsViewWithText:(NSString *)text
                      width:(CGFloat)width
                      point:(CGPoint)point
                      align:(kGLArrowDirection)align
                alignOffset:(CGFloat)alignOffset
                isArrowDwon:(BOOL)isArrowDwon;

/// 弹出tips气泡提示
/// @param text 文本
/// @param rootView 父视图
/// @param width 最大宽度
/// @param point 坐标位置
/// @param align 箭头位置
/// @param alignOffset 箭头位置偏移
/// @param isArrowDwon 箭头是否朝下
+ (GLBubbleTextTipsView *)showTipsViewWithText:(NSString *)text
                                        rootView:(UIView *)rootView
                                         width:(CGFloat)width
                                         point:(CGPoint)point
                                         align:(kGLArrowDirection)align
                                   alignOffset:(CGFloat)alignOffset
                                   isArrowDwon:(BOOL)isArrowDwon;

/// 弹出tips气泡提示
/// @param text 文本
/// @param rootView 父视图
/// @param width 最大宽度
/// @param point 坐标位置
/// @param align 箭头位置
/// @param bgColor 背景颜色
/// @param textColor 字体颜色
/// @param alignOffset 箭头位置偏移
/// @param isArrowDwon 箭头是否朝下
+ (GLBubbleTextTipsView *)showTipsViewWithText:(NSString *)text
                                      rootView:(UIView *)rootView
                                         width:(CGFloat)width
                                         point:(CGPoint)point
                                         align:(kGLArrowDirection)align
                                       bgColor:(UIColor *)bgColor
                                     textColor:(UIColor *)textColor
                                   alignOffset:(CGFloat)alignOffset
                                   isArrowDwon:(BOOL)isArrowDwon;


/// 回收
- (void)dissmiss;

/// 回收
- (void)dissmiss:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
