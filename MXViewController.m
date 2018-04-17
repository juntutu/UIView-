//
//  MXViewController.m
//  Finance
//
//  Created by Grayson on 2018/4/3.
//  Copyright © 2018年 Grayson. All rights reserved.
//

#import "MXViewController.h"

@interface MXViewController ()

@end

@implementation MXViewController
{
    UIView *view1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的权益";

    self.view.backgroundColor = [UIColor whiteColor];

    view1 = [[UIView alloc] initWithFrame:CGRectMake(8, 30, kWindowWidth-16, 80)];
    view1.backgroundColor = [UIColor purpleColor];
    view1.layer.masksToBounds = YES;
    view1.layer.borderWidth = 0.5;
    view1.layer.borderColor = [UIColor grayColor].CGColor;
    [self.view addSubview:view1];

    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(view1.frame)+10, (kWindowWidth-40)/3, 30)];
    [btn1 setTitle:@"开始" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor blackColor];
    [btn1 addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn1];

    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn1.frame)+10, CGRectGetMaxY(view1.frame)+10, btn1.width, 30)];
    [btn2 setTitle:@"暂停" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor blackColor];
    [btn2 addTarget:self action:@selector(demosAnimationPause:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn2];

    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetMaxX(btn2.frame)+10, CGRectGetMaxY(view1.frame)+10, btn2.width, 30)];
    [btn3 setTitle:@"恢复" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor blackColor];
    [btn3 addTarget:self action:@selector(demosAnimationContinue:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:btn3];
}

- (void)start {
    view1.y = 30;
    [UIView animateWithDuration:10.0 animations:^{
        view1.y = kWindowHeight-200;
    } completion:^(BOOL finished) {

    }];
}

- (void)demosAnimationPause:(UIButton *)sender {
    //将当前时间CACurrentMediaTime转换为layer上的时间, 即将parent time转换为local time
    CFTimeInterval pauseTime = [view1.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    //设置layer的timeOffset, 在继续操作也会使用到
    view1.layer.timeOffset = pauseTime;
    //local time与parent time的比例为0, 意味着local time暂停了
    view1.layer.speed = 0;
}

- (void)demosAnimationContinue:(UIButton *)sender {
    CFTimeInterval pauseTime = view1.layer.timeOffset;//时间转换
    CFTimeInterval timeSincePause = CACurrentMediaTime() - pauseTime;//计算暂停时间
    view1.layer.timeOffset = 0;//取消
    view1.layer.beginTime = timeSincePause;//local time相对于parent time时间的beginTime
    view1.layer.speed = 1;//继续
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
