//
//  YXSelectListView.h
//  YXBigScreenClient
//
//  Created by wangtao on 2018/11/23.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YXSelectListBlock)(NSInteger index,NSString *text);

@interface YXSelectListView : UIView

@property (nonatomic, copy) YXSelectListBlock block;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) NSInteger index;

@end
