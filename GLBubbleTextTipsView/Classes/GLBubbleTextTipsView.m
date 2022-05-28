//
//  GLBubbleTextTipsView.m
//  HiYaMain
//
//  Created by mac on 2021/10/22.
//

#import "GLBubbleTextTipsView.h"
#import <Masonry/Masonry.h>

#define   kGLBubbleTextTipsTitleSpacing   10
#define   GLBubbleTextTipsViewDotW       14
#define   GLBubbleTextTipsViewDotH       10

@interface GLBubbleTextTipsView ()

///文本内容
@property (nonatomic, strong) UILabel *titleLabel;

///箭头三角形
@property (nonatomic, strong) UIImageView *dotView;

///渐变背景
@property (nonatomic, strong) UIImageView *bubbleView;

///背景色
@property (nonatomic, strong) UIColor *bgColor;

@end

@implementation GLBubbleTextTipsView

-(void)dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];

    NSLog(@"GLBubbleTextTipsView dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)dissmiss {
    [self dissmiss:YES];
}

- (void)dissmiss:(BOOL)animated {
    [UIView animateWithDuration:animated ? 0.25 : 0 animations:^{
        self.bubbleView.alpha = 0;
        self.dotView.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.dissmissBlock) {
            self.dissmissBlock(self);
        }
        [self removeFromSuperview];
    }];
}

- (void)setupUI {
    [self addSubview:self.bubbleView];
    
    [self addSubview:self.dotView];
    [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@0);
        make.width.equalTo(@(GLBubbleTextTipsViewDotW));
        make.height.equalTo(@(GLBubbleTextTipsViewDotH));
    }];
    
    [self.bubbleView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kGLBubbleTextTipsTitleSpacing));
        make.top.equalTo(@(kGLBubbleTextTipsTitleSpacing));
        make.bottom.equalTo(@(-kGLBubbleTextTipsTitleSpacing));
        make.right.equalTo(@(-kGLBubbleTextTipsTitleSpacing));
    }];
}

-(CGSize)showTipsViewWithText:(NSString *)text
                      width:(CGFloat)width
                      point:(CGPoint)point
                      align:(kGLArrowDirection)align
                      bgColor:(UIColor *)bgColor
                    textColor:(UIColor *)textColor
                alignOffset:(CGFloat)alignOffset
                isArrowDwon:(BOOL)isArrowDwon {
    [self updateText:text];
    
    CGFloat spacing = kGLBubbleTextTipsTitleSpacing * 2;
    CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    CGFloat offsetX = 20;
    switch (align) {
        case kGLArrowDirectionLeft:
            offsetX = 20;
            
            break;
        case kGLArrowDirectionCenter:
            offsetX = (size.width + 30 - GLBubbleTextTipsViewDotW) / 2;
            
            break;
        default:
            offsetX = size.width - 20;
            
            break;
    }
    
    offsetX += alignOffset;
    //箭头在下
    if (isArrowDwon) {
        CGFloat offsetY = ceilf(size.height) + spacing;
        [self.bubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(point.x);
            make.top.mas_equalTo(point.y - offsetY);
            make.width.mas_equalTo(ceilf(size.width) + spacing);
            make.height.mas_equalTo(ceilf(size.height) + spacing);
        }];
        
        [self.dotView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(point.x + offsetX);
            make.top.mas_equalTo(point.y + ceilf(size.height) + spacing - offsetY);
        }];
    } else {
        [self.dotView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(point.x + offsetX);
            make.top.mas_equalTo((point.y));
        }];
        
        [self.bubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(point.x);
            make.top.equalTo(self.dotView.mas_bottom);
            make.width.mas_equalTo(ceilf(size.width) + spacing);
            make.height.mas_equalTo(ceilf(size.height) + spacing);
        }];
    }
    
    [self layoutIfNeeded];
    UIColor *color = bgColor ?: [UIColor blackColor];
    self.bgColor = color;
    
    self.bubbleView.backgroundColor = color;
    self.titleLabel.textColor = textColor ?: [UIColor whiteColor];
    [self makeTriangle:align isArrowDwon:isArrowDwon];
    
    [self addShowAnimation];
    return CGSizeMake(size.width + spacing, size.height + spacing);
}

-(void)updateText:(NSString *)text {
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 5;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    self.titleLabel.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//画三角形
-(void)makeTriangle:(kGLArrowDirection)align isArrowDwon:(BOOL)isArrowDwon {
    CGFloat w = GLBubbleTextTipsViewDotW;
    CGFloat h = GLBubbleTextTipsViewDotH;
    CGFloat s = 0.4;//调整圆弧系数
    CGFloat offsetW = s * w;
    //等腰梯形
    UIBezierPath *path = [UIBezierPath bezierPath];
    //圆弧
    UIBezierPath *pathRound = [UIBezierPath bezierPath];
    pathRound.lineWidth = 1.0;
    pathRound.lineCapStyle = kCGLineCapRound; //终点处理
    pathRound.lineJoinStyle = kCGLineJoinRound; //线条拐角
    
    if(isArrowDwon) {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(w, 0)];
        [path addLineToPoint:CGPointMake(w / 2.0 + offsetW / 2.0, (1 - s) * h)];
        [path addLineToPoint:CGPointMake(w / 2.0 - offsetW / 2.0, (1 - s) * h)];
        
        [pathRound moveToPoint:CGPointMake(w / 2.0 - offsetW / 2.0 , (1 - s) * h)];
        [pathRound addQuadCurveToPoint:CGPointMake(w / 2.0 + offsetW / 2.0, (1 - s) * h) controlPoint:CGPointMake(0.5 * w, 1 * h)];
    } else {
        [path moveToPoint:CGPointMake(w / 2.0 - offsetW / 2.0, s * h)];
        [path addLineToPoint:CGPointMake(w / 2.0 + offsetW / 2.0, s * h)];
        [path addLineToPoint:CGPointMake(w, h)];
        [path addLineToPoint:CGPointMake(0, h)];
        
        [pathRound moveToPoint:CGPointMake(w / 2.0 - offsetW / 2.0, s * h)];
        [pathRound addQuadCurveToPoint:CGPointMake(w / 2.0 + offsetW / 2.0, s * h) controlPoint:CGPointMake(0.5 * w, 0)];
    }
    
    //连线
    [path stroke];
    [pathRound stroke];
    
    [path closePath];
    [pathRound closePath];
    
    //等腰梯形
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.path = path.CGPath;
    //圆弧
    CAShapeLayer *layerRound = [[CAShapeLayer alloc] init];
    layerRound.path = pathRound.CGPath;
    
    UIColor *color = self.bgColor;
    
    //填充
    layer.fillColor = color.CGColor;
    layerRound.fillColor = color.CGColor;

    [self.dotView.layer addSublayer:layer];
    [self.dotView.layer addSublayer:layerRound];
}

-(void)addShowAnimation {
    self.bubbleView.alpha = 0;
    self.dotView.alpha = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.bubbleView.alpha = 1;
        self.dotView.alpha = 1;
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self dissmiss];
}

//bubble_left_up
+ (GLBubbleTextTipsView *)showTipsViewWithText:(NSString *)text
                                         width:(CGFloat)width
                                         point:(CGPoint)point
                                         align:(kGLArrowDirection)align
                                   alignOffset:(CGFloat)alignOffset
                                   isArrowDwon:(BOOL)isArrowDwon {
    return [self showTipsViewWithText:text rootView:nil width:width point:point align:align bgColor:nil textColor:nil alignOffset:alignOffset isArrowDwon:isArrowDwon];
}

//bubble_left_up
+ (GLBubbleTextTipsView *)showTipsViewWithText:(NSString *)text
                                        rootView:(UIView *)rootView
                                         width:(CGFloat)width
                                         point:(CGPoint)point
                                         align:(kGLArrowDirection)align
                                   alignOffset:(CGFloat)alignOffset
                                   isArrowDwon:(BOOL)isArrowDwon {
    return [self showTipsViewWithText:text rootView:rootView width:width point:point align:align bgColor:nil textColor:nil alignOffset:alignOffset isArrowDwon:isArrowDwon];
}

+ (GLBubbleTextTipsView *)showTipsViewWithText:(NSString *)text rootView:(UIView *)rootView width:(CGFloat)width point:(CGPoint)point align:(kGLArrowDirection)align bgColor:(UIColor *)bgColor textColor:(UIColor *)textColor alignOffset:(CGFloat)alignOffset isArrowDwon:(BOOL)isArrowDwon {
    if (rootView == nil) {
        rootView = [UIApplication sharedApplication].keyWindow;
    }
    GLBubbleTextTipsView *view = [[GLBubbleTextTipsView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    CGSize size = [view showTipsViewWithText:text width:width point:point align:align bgColor:bgColor textColor:textColor alignOffset:alignOffset isArrowDwon:isArrowDwon];
    [rootView addSubview:view];
    view->_textSize = size;
    return view;
}

-(UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIImageView *)bubbleView {
    if (!_bubbleView) {
        _bubbleView = [UIImageView new];
        _bubbleView.layer.cornerRadius = 10;
        _bubbleView.layer.masksToBounds = YES;
    }
    return _bubbleView;
}
-(UIImageView *)dotView {
    if (!_dotView) {
        _dotView = [UIImageView new];
    }
    return _dotView;
}

@end
