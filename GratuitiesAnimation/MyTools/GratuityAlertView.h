//
//  GratuityAlertView.h
//  GratuitiesAnimation
//
//  Created by zyangshuang on 16/4/19.
//  Copyright © 2016年 zyangshuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GratuityAlertViewDelegate <NSObject>

- (void)alertViewButtonClicked:(NSInteger)index;

@end

@interface GratuityAlertView : UIView

@property (nonatomic, weak) id<GratuityAlertViewDelegate>delegate;
@property (nonatomic, assign)NSInteger gratuityCount;

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString*)tipsString buttonTitles:(NSArray*)buttonTitleArray;
- (void)updateTipsLabel:(NSString*)newTips;
- (void)show;
@end

