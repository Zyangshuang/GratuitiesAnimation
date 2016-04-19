//
//  GratuityTwoViewController.m
//  GratuitiesAnimation
//
//  Created by zyangshuang on 16/4/19.
//  Copyright © 2016年 zyangshuang. All rights reserved.
//

#import "GratuityTwoViewController.h"
#import "ZYSGratuityView.h"


@interface GratuityTwoViewController ()<ZYSGratuityViewDelegate>
@property (nonatomic, strong)ZYSGratuityView* gratuityView;


@end

@implementation GratuityTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"打赏类型2";
    // Do any additional setup after loading the view.
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
        if (!_gratuityView) {
            _gratuityView = [[ZYSGratuityView alloc]initWithFrame:CGRectZero withButtonPosition:point type:GratuityTypeFour];
            _gratuityView.delegate = self;
            for (int i = 0; i < _gratuityView.buttonArray.count; i++) {
                UIView*backView = [_gratuityView.buttonArray objectAtIndex:i];
                backView.backgroundColor = JKColor(255, 98, 97, 1.0);
                UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 40, 20)];
                label.textColor = [UIColor whiteColor];
                label.font = [UIFont systemFontOfSize:12.0];
                label.textAlignment = NSTextAlignmentCenter;
                label.text = @"10积分";
                [backView addSubview:label];
            }
        }else{
            [_gratuityView updateButtonPosition:point];
        }
        [_gratuityView show];

    }
}

- (void)gratuityViewButtonClicked:(NSInteger)buttonIndex
{
    NSLog(@"%ld按钮被点击了",(long)buttonIndex);
}

@end
