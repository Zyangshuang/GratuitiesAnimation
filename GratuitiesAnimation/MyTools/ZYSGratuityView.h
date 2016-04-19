//
//  ZYSGratuityView.h
//  GratuitiesAnimation
//
//  Created by zyangshuang on 16/4/19.
//  Copyright © 2016年 zyangshuang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EGratuityType) {
    GratuityViewThree = 0,
    GratuityTypeFour
};

@protocol ZYSGratuityViewDelegate <NSObject>

- (void)gratuityViewButtonClicked:(NSInteger)buttonIndex;

@end

@interface ZYSGratuityView : UIView
@property (nonatomic, strong) NSMutableArray* buttonArray;
@property (nonatomic, weak) id<ZYSGratuityViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame withButtonPosition:(CGPoint)point type:(EGratuityType)type;

- (void)updateButtonPosition:(CGPoint)point;
- (void)show;
@end
