//
//  GratuityOneViewController.m
//  GratuitiesAnimation
//
//  Created by zyangshuang on 16/4/19.
//  Copyright © 2016年 zyangshuang. All rights reserved.
//

#import "GratuityOneViewController.h"
#import "ZYSGratuityView.h"
#import "GratuityAlertView.h"

@interface GratuityOneViewController ()<ZYSGratuityViewDelegate,GratuityAlertViewDelegate>
@property (nonatomic, strong)ZYSGratuityView* gratuityView;
@property (nonatomic, strong)GratuityAlertView* alertView;
@property (nonatomic, strong)NSMutableArray* gratutityArray;
@end

@implementation GratuityOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"打赏类型1";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [touches.anyObject locationInView:self.view];
    if (point.y < JKWindowHeight/4.0) {
        return;
    }else{
        if (!self.gratuityView) {
            self.gratutityArray = [NSMutableArray array];
            
            self.gratuityView = [[ZYSGratuityView alloc]initWithFrame:CGRectZero withButtonPosition:point type:GratuityViewThree];
            self.gratuityView.delegate = self;
            UIView* bigView = [self.gratuityView.buttonArray objectAtIndex:0];
            bigView.hidden = NO;
            UIView* middleView = [self.gratuityView.buttonArray objectAtIndex:1];
            middleView.hidden = NO;
            UIView* littleView = [self.gratuityView.buttonArray objectAtIndex:2];
            littleView.hidden = NO;
            
            UILabel* bigLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, bigView.width, 20)];
            bigLabel.font = [UIFont systemFontOfSize:16.0];
            bigLabel.textColor = [UIColor whiteColor];
            bigLabel.text = @"20积分";
            bigLabel.textAlignment = NSTextAlignmentCenter;
            [bigView addSubview:bigLabel];
            bigView.backgroundColor = JKColor(238, 177, 21, 1.0);
            
            UILabel* middleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, middleView.width, 20)];
            middleLabel.textColor = JKColor(238, 177, 21, 1.0);
            middleLabel.font = [UIFont systemFontOfSize:14.0];
            middleLabel.textAlignment = NSTextAlignmentCenter;
            middleLabel.text = @"10积分";
            [middleView addSubview:middleLabel];
            middleView.backgroundColor = JKColor(255, 98, 97, 1.0);
            
            UILabel * littileLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, littleView.width, 20)];
            littileLabel.font = [UIFont systemFontOfSize:12.0];
            littileLabel.textAlignment =  NSTextAlignmentCenter;
            littileLabel.textColor = JKColor(255, 98, 97, 1.0);
            littileLabel.text = @"5积分";
            [littleView addSubview:littileLabel];
            littleView.layer.borderColor = JKColor(255, 98, 97, 1.0).CGColor;
            littleView.layer.borderWidth = 0.5;
            littleView.backgroundColor = [UIColor whiteColor];
            [[UIApplication sharedApplication].keyWindow addSubview:self.gratuityView];
            [self.gratutityArray addObjectsFromArray:@[@20,@10,@5]];
            
        }else{
            
            [self.gratuityView updateButtonPosition:point];
            
        }
        [self.gratuityView show];

    }
}

- (void)gratuityViewButtonClicked:(NSInteger)buttonIndex
{
    NSInteger jifen = [self.gratutityArray[buttonIndex] integerValue];
    if (!_alertView) {
        _alertView = [[GratuityAlertView alloc]initWithFrame:CGRectZero withTitle:[NSString stringWithFormat:@"打赏TA需要消耗您的%ld积分",(long)jifen] buttonTitles:@[@"取消",@"确定"]];
        _alertView.delegate = self;
    }else{
        [_alertView updateTipsLabel:[NSString stringWithFormat:@"打赏TA需要消耗您的%ld积分",(long)jifen]];
    }
    _alertView.gratuityCount = jifen;
    [_alertView show];
}

- (void)alertViewButtonClicked:(NSInteger)index
{
    NSLog(@"打赏%ld积分成功",(long)_alertView.gratuityCount);
}

@end
