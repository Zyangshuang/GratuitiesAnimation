//
//  ViewController.m
//  GratuitiesAnimation
//
//  Created by zyangshuang on 16/4/19.
//  Copyright © 2016年 zyangshuang. All rights reserved.
//

#import "ViewController.h"
#import "GratuityAlertView.h"
#import "ZYSGratuityView.h"
#import "GratuityOneViewController.h"
#import "GratuityTwoViewController.h"

@interface ViewController ()<GratuityAlertViewDelegate>
@property (nonatomic, strong)GratuityAlertView* alertView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)gratuityTypeOne:(id)sender {
    GratuityOneViewController* gratuityOneVC = [[GratuityOneViewController alloc]init];
    [self.navigationController pushViewController:gratuityOneVC animated:YES];
}

- (IBAction)gratuityTypeTwo:(id)sender {
    
    GratuityTwoViewController* gratuityTwoVC = [[GratuityTwoViewController alloc]init];
    [self.navigationController pushViewController:gratuityTwoVC animated:YES];
}
- (IBAction)alertViewClicked:(id)sender {
    if (!_alertView) {
        _alertView = [[GratuityAlertView alloc]initWithFrame:CGRectZero withTitle:@"自定义弹框哦~~" buttonTitles:@[@"取消",@"确认"]];
        _alertView.delegate = self;
    }else{
        [_alertView updateTipsLabel:@"自定义弹框哦2~~"];
    }
    
    [_alertView show];
}

- (void)alertViewButtonClicked:(NSInteger)index
{
    NSLog(@"确认按钮被点击啦");
}

@end
