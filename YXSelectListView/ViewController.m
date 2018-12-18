//
//  ViewController.m
//  YXSelectListView
//
//  Created by wangtao on 2018/12/18.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import "ViewController.h"
#import "YXSelectListView.h"
#import "UIView+Frame.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    YXSelectListView *listView = [[YXSelectListView alloc] initWithFrame:CGRectMake(0, 0, self.view.yx_width - 40, 44)];
    listView.center = self.view.center;
    listView.dataSource = @[@"投影",@"触摸",@"网络",@"系统",@"主机"];
    listView.block = ^(NSInteger index, NSString *text) {
    };
    [self.view addSubview:listView];
}


@end
