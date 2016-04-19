//
//  GratuityAlertView.m
//  GratuitiesAnimation
//
//  Created by zyangshuang on 16/4/19.
//  Copyright © 2016年 zyangshuang. All rights reserved.
//

#import "GratuityAlertView.h"


@interface GratuityAlertView()
@property (nonatomic, strong)UILabel* tipsLabel;
@property (nonatomic, strong)NSArray* buttonArray;
@end

@implementation GratuityAlertView

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString*)tipsString buttonTitles:(NSArray*)buttonTitleArray
{
    if (self = [super initWithFrame:CGRectMake(0, 0, JKWindowWidth, JKWindowHeight)]) {
        self.backgroundColor = JKColor(70, 70, 70, 0.5);
        [self createViews:tipsString buttonTitles:buttonTitleArray];
    }
    return self;
}

- (void)createViews:(NSString*)tipsString buttonTitles:(NSArray*)buttonTitleArray
{
    NSString* cancleString = @"";
    NSString* sureString = @"";
    if (buttonTitleArray.count == 1) {
        cancleString = buttonTitleArray[0];
    }else if (buttonTitleArray.count == 2){
        cancleString = buttonTitleArray[0];
        sureString = buttonTitleArray[1];
    }
    UIView* backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, JKWindowWidth - 80, 180)];
    backView.center = self.center;
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.cornerRadius = 5.0f;
    backView.layer.masksToBounds = YES;
    backView.tag = 1288;
    [self addSubview:backView];
    
    UILabel* tipsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, backView.width - 20, backView.height/2.0)];
    tipsLabel.textColor = JKColor(70, 70, 70, 1.0);
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    tipsLabel.numberOfLines = 0;
    tipsLabel.font = [UIFont systemFontOfSize:16.0];
    [backView addSubview:tipsLabel];
    self.tipsLabel = tipsLabel;
    self.tipsLabel.text = tipsString;
    
    UIView* lineView = [[UIView alloc]initWithFrame:CGRectMake(8, tipsLabel.bottom, backView.width - 16, 0.5)];
    lineView.backgroundColor = JKColor(230, 230, 230, 1.0);
    [backView addSubview:lineView];
    
    CGFloat buttonWidth = 40;
    UIButton* cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(buttonWidth/2.0, backView.height/4.0*3 -buttonWidth/2.0 , backView.width/2 - buttonWidth, buttonWidth)];
    cancleButton.layer.cornerRadius = 3.f;
    cancleButton.layer.borderColor = JKColor(200, 200, 200, 1.0).CGColor;
    cancleButton.layer.borderWidth = 0.5;
    cancleButton.layer.masksToBounds = YES;
    cancleButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [cancleButton setTitle:cancleString forState:UIControlStateNormal];
    [cancleButton setTitleColor:JKColor(170, 170, 170, 1.0) forState:UIControlStateNormal];
    cancleButton.tag = 123;
    [backView addSubview:cancleButton];
    
    
    UIButton* sureButton = [[UIButton alloc]initWithFrame:CGRectMake(cancleButton.right+buttonWidth, cancleButton.top, cancleButton.width, cancleButton.height)];
    sureButton.layer.cornerRadius = 3.f;
    sureButton.layer.masksToBounds = YES;
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [sureButton setTitle:sureString forState:UIControlStateNormal];
    sureButton .backgroundColor = JKColor(255, 98, 97, 1.0);
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureButton.tag = 124;
    [backView addSubview:sureButton];
    
    [cancleButton addTarget:self action:@selector(alertViewButtonClickedwithIndex:) forControlEvents:UIControlEventTouchUpInside];
    [sureButton addTarget:self action:@selector(alertViewButtonClickedwithIndex:) forControlEvents:UIControlEventTouchUpInside];
    backView.hidden = YES;
    
    
}

- (void)alertViewButtonClickedwithIndex:(UIButton*)button;
{
    NSInteger index = button.tag - 123;
    
    if ([_delegate respondsToSelector:@selector(alertViewButtonClicked:)]) {
        [_delegate alertViewButtonClicked:index];
    }
    
    [self dismissAnimation];
    
}

- (void)updateTipsLabel:(NSString*)newTips
{
    self.tipsLabel.text = newTips;
}

- (void)showAnimation
{
    UIView* backView = [self viewWithTag:1288];
    backView.hidden = NO;
    [backView setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
    [UIView animateWithDuration:0.3 animations:^{
        [backView setTransform:CGAffineTransformMakeScale(1, 1)];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissAnimation
{
    UIView* backView = [self viewWithTag:1288];
    backView.hidden = NO;
    [backView setTransform:CGAffineTransformMakeScale(1, 1)];
    [UIView animateWithDuration:0.3 animations:^{
        [backView setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self showAnimation];
}

@end
