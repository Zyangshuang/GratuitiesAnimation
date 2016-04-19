//
//  ZYSGratuityView.m
//  GratuitiesAnimation
//
//  Created by zyangshuang on 16/4/19.
//  Copyright © 2016年 zyangshuang. All rights reserved.
//

#import "ZYSGratuityView.h"

@interface ZYSGratuityView()

@property (nonatomic, assign) CGPoint buttonPoint;
@property (nonatomic, assign) EGratuityType Buttontype;
@property (nonatomic, strong) NSMutableArray*gratuityPointArray;
@end

@implementation ZYSGratuityView

- (instancetype)initWithFrame:(CGRect)frame withButtonPosition:(CGPoint)point type:(EGratuityType)type
{
    if (self = [super initWithFrame: CGRectMake(0, 0, JKWindowWidth, JKWindowHeight)]) {
        self.backgroundColor = JKColor(70, 70, 70, 0.3);
        self.buttonArray = [NSMutableArray array];
        self.gratuityPointArray = [NSMutableArray array];
        self.buttonPoint = point;
        self.Buttontype = type;
        [self createViews:point type:type];
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gratuityViewTapped)];
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)createViews:(CGPoint)point type:(EGratuityType)type
{
    if (type == GratuityViewThree) {
        UIView* bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 80.0, 80.0)];
        bigView.center = point;
        bigView.layer.masksToBounds = YES;
        bigView.layer.cornerRadius = bigView.width/2.0;
        [self addSubview:bigView];
        bigView.tag = 428 ;
        
        UIView*middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60.0, 60.0)];
        middleView.center = point;
        middleView.layer.cornerRadius = middleView.width/2.0;
        middleView.layer.masksToBounds = YES;
        [self addSubview:middleView];
        middleView.tag = 428+1;
        
        UIView* littleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50.0, 50.0)];
        littleView.center = point;
        littleView.layer.cornerRadius = littleView.width/2.0;
        littleView.layer.masksToBounds = YES;
        littleView.tag = 428 +2;
        [self addSubview:littleView];
        
        bigView.hidden = YES;
        middleView.hidden = YES;
        littleView.hidden = YES;
        [self.buttonArray addObject:bigView];
        [self.buttonArray addObject:middleView];
        [self.buttonArray addObject:littleView];
        [self.gratuityPointArray removeAllObjects];
        [self.gratuityPointArray addObject:@(bigView.width)];
        [self.gratuityPointArray addObject:@(middleView.width)];
        [self.gratuityPointArray addObject:@(littleView.width)];
        
        for (int i = 0; i < self.buttonArray.count; i++) {
            UIView* backView = [self.buttonArray objectAtIndex:i];
            UITapGestureRecognizer* gratuityTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gratuityTaped:)];
            backView.userInteractionEnabled = YES;
            [backView addGestureRecognizer:gratuityTap];
        }
        
    }else{
        for (int i = 0; i < 4; i++) {
            UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40.0, 40.0)];
            backView.layer.cornerRadius = backView.width/2.0;
            backView.layer.masksToBounds = YES;
            [self.buttonArray addObject:backView];
            [self.gratuityPointArray addObject:[NSNumber numberWithFloat:backView.width]];
            [self addSubview:backView];
            backView.hidden = YES;
            backView.tag = 428 +i;
            UITapGestureRecognizer* gratuityTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gratuityTaped:)];
            backView.userInteractionEnabled = YES;
            [backView addGestureRecognizer:gratuityTap];
        }
    }
}

- (void)showViewWithAnimation
{
    if (self.Buttontype == GratuityViewThree) {
        CGFloat bigViewWidth = [[_gratuityPointArray objectAtIndex:0] floatValue];
        CGFloat middleViewWidth = [[_gratuityPointArray objectAtIndex:1] floatValue];
        CGFloat littleViewWidth = [[_gratuityPointArray objectAtIndex:2] floatValue];
        
        UIView* bigView = [self.buttonArray objectAtIndex:0];
        bigView.size = CGSizeMake(bigViewWidth, bigViewWidth);
        bigView.hidden = NO;
        UIView* middleView = [self.buttonArray objectAtIndex:1];
        middleView.size = CGSizeMake(middleViewWidth, middleViewWidth);
        middleView.hidden = NO;
        UIView* littleView = [self.buttonArray objectAtIndex:2];
        littleView.size = CGSizeMake(littleViewWidth, littleViewWidth);
        littleView.hidden = NO;
        
        CGPoint point = self.buttonPoint;
        if (self.buttonPoint.x < JKWindowWidth/2.0) {
            bigView.center = CGPointMake(point.x + 10, point.y - 30 - bigView.height/2.0);
            middleView.center = CGPointMake(bigView.right, bigView.top - middleView.height/2.0 - 5);
            littleView.center = CGPointMake(middleView.right+5 +littleView.width/2.0, middleView.top - 5);
        }else if(self.buttonPoint.y < JKWindowHeight/3.0){
            bigView.center = CGPointMake(point.x - 10, point.y + 20 +bigView.width/2.0);
            middleView.center = CGPointMake(bigView.left, bigView.bottom +middleView.height/2.0);
            littleView.center = CGPointMake(middleView.left -10 - littleView.width/2.0, middleView.top + 15+littleView.height/2.0);
        }else{
            bigView.center = CGPointMake(point.x - 10 , point.y - 10 - bigView.width/2.0);
            middleView.center = CGPointMake(bigView.left, bigView.top - middleView.height/2.0);
            littleView.center = CGPointMake(middleView.left - littleView.width/2.0 - 5, middleView.top +5);
        }
        
        [self createAnimation:bigView withPosition:bigView.frame];
        [self createAnimation:middleView withPosition:middleView.frame];
        [self createAnimation:littleView withPosition:littleView.frame];
    }else{
        CGFloat viewWidth = [self.gratuityPointArray[0] floatValue];
        
        UIView* leftView = [self.buttonArray objectAtIndex:0];
        leftView.size = CGSizeMake(viewWidth, viewWidth);
        leftView.hidden = NO;
        UIView* leftUpView = [self.buttonArray objectAtIndex:1];
        leftUpView.size = CGSizeMake(viewWidth, viewWidth);
        leftUpView.hidden = NO;
        UIView* rightUpView = [self.buttonArray objectAtIndex:2];
        rightUpView.size = CGSizeMake(viewWidth, viewWidth);
        rightUpView.hidden = NO;
        UIView* rightView = [self.buttonArray objectAtIndex:3];
        rightView.size = CGSizeMake(viewWidth, viewWidth);
        rightView.hidden = NO;
        
        CGPoint point = self.buttonPoint;
        if(self.buttonPoint.y < JKWindowHeight/3.0){
            leftView.center = CGPointMake(point.x - viewWidth/2.0 - viewWidth, point.y +viewWidth/2.0);
            leftUpView.center = CGPointMake(point.x - 10 - viewWidth/2.0, point.y +viewWidth/2.0 + viewWidth);
            rightUpView.center = CGPointMake(point.x + 10 + viewWidth/2.0, leftUpView.centerY);
            rightView.center = CGPointMake(point.x + viewWidth/2.0 + viewWidth, leftView.centerY);
        }else{
            leftView.center = CGPointMake(point.x - viewWidth/2.0 - viewWidth, point.y -viewWidth/2.0);
            leftUpView.center = CGPointMake(point.x - 10 - viewWidth/2.0, point.y -viewWidth/2.0 - viewWidth);
            rightUpView.center = CGPointMake(point.x + 10 + viewWidth/2.0, leftUpView.centerY);
            rightView.center = CGPointMake(point.x + viewWidth/2.0 + viewWidth, leftView.centerY);
        }
        [self createAnimation:leftView withPosition:leftView.frame];
        [self createAnimation:leftUpView withPosition:leftUpView.frame];
        [self createAnimation:rightUpView withPosition:rightUpView.frame];
        [self createAnimation:rightView withPosition:rightView.frame];
    }
    
    
}

- (void)gratuityViewTapped
{
    for (int i = 0; i < self.buttonArray.count; i++) {
        UIView* animationView = [self.buttonArray objectAtIndex:i];
        [self dismissAnimation:animationView];
    }
}

- (void)dismissAnimation:(UIView*)animationView
{
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        animationView.transform = CGAffineTransformScale(animationView.transform, 1.2, 1.2);
    } completion:^(BOOL finished) {
        animationView.transform = CGAffineTransformScale(animationView.transform, 1, 1);
        [UIView animateWithDuration:0.3 animations:^{
            animationView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                animationView.frame = CGRectMake(0, 0, 0, 0);
                animationView.center = self.buttonPoint;
                
            } completion:^(BOOL finished) {
                [weakSelf removeFromSuperview];
                
            }];
        }];
    }];
}

- (void)createAnimation:(UIView*)animationView withPosition:(CGRect)position
{
    animationView.frame = CGRectZero;
    animationView.center = self.buttonPoint;
    [animationView setTransform:CGAffineTransformMakeRotation(M_PI_2)];
    [UIView animateWithDuration:0.3 animations:^{
        animationView.frame = position;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            animationView.transform = CGAffineTransformMakeRotation(0);
        } completion:^(BOOL finished) {
            
        }];
    }];
}

- (void)updateButtonPosition:(CGPoint)point
{
    self.buttonPoint = point;
}

- (void)gratuityTaped:(UITapGestureRecognizer*)tap
{
    [self gratuityViewTapped];
    NSInteger index = tap.view.tag - 428;
    if ([_delegate respondsToSelector:@selector(gratuityViewButtonClicked:)]) {
        [_delegate gratuityViewButtonClicked:index];
    }
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self showViewWithAnimation];
}

@end
