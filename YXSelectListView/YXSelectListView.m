//
//  YXSelectListView.m
//  YXBigScreenClient
//
//  Created by wangtao on 2018/11/23.
//  Copyright © 2018年 wangtao. All rights reserved.
//

#import "YXSelectListView.h"
#import "UIView+Frame.h"

static NSInteger viewH = 44;

@interface YXSelectListView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIImageView *containtView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) UIView *listView;
@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation YXSelectListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonAction:)];
        [self addGestureRecognizer:tap];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _containtView = [[UIImageView alloc] initWithFrame:self.bounds];
    _containtView.userInteractionEnabled = YES;
    [self addSubview:_containtView];
    
    _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.yx_width - viewH - 20, viewH)];
    _textLabel.text = @"投影";
    _textLabel.font = [UIFont systemFontOfSize:14];
    _textLabel.textColor = [UIColor darkGrayColor];
    [_containtView addSubview:_textLabel];
    UIButton *selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    selectButton.frame = CGRectMake(self.yx_width - viewH, 0, viewH, viewH);
    [selectButton setImage:[UIImage imageNamed:@"baoxiu_xiala"] forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    _selectButton = selectButton;
    [_containtView addSubview:selectButton];
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1;
    self.layer.cornerRadius = 4;
}

- (void)buttonAction:(UIButton *)sender {
    [self.superview addSubview:self.listView];
    _selectButton.selected = !_selectButton.selected;
    if(_selectButton.selected == YES) {
        [self.listView.superview bringSubviewToFront:self.listView];
        [self showListView];
    } else {
        [self hideListView];
    }
}

- (void)showListView {
    [UIView animateWithDuration:0.25 animations:^{
        self.listView.frame  = CGRectMake(self.yx_x,self.yx_bottom,self.yx_width, viewH * self.dataSource.count);
        self.listTableView.frame = CGRectMake(0, 0,self.yx_width, viewH * self.dataSource.count);
    }completion:^(BOOL finished) {
        
    }];
}

- (void)hideListView {
    [UIView animateWithDuration:0.25 animations:^{
        self.listView.frame  = CGRectMake(self.yx_x,self.yx_bottom,self.yx_width, 0);
        self.listTableView.frame = CGRectMake(0, 0,self.yx_width, 0);
    }completion:^(BOOL finished) {
        
    }];
}

- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    _textLabel.text = dataSource[0];
    [self.listTableView reloadData];
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    _textLabel.text = self.dataSource[index];
}

#pragma mark - UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.font = [UIFont fontWithName:@"PingFang-SC-Regular" size: 14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor redColor];
    if (self.block) {
        self.block(indexPath.row, self.dataSource[indexPath.row]);
    }
    _textLabel.text = self.dataSource[indexPath.row];
    _selectButton.selected = NO;
    [self hideListView];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor blackColor];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

#pragma mark - other
- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, viewH, self.yx_width, 0) style:UITableViewStylePlain];
        _listTableView.rowHeight = viewH;
        _listTableView.dataSource = self;
        _listTableView.delegate = self;
        _listTableView.scrollEnabled = NO;
        _listTableView.backgroundColor = [UIColor whiteColor];
        _listTableView.tableFooterView = [UIView new];
        _listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _listTableView;
}

- (UIView *)listView {
    if (!_listView) {
        _listView = [[UIView alloc] initWithFrame:CGRectMake(self.yx_x, self.yx_bottom, self.yx_width, 0)];
        _listView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _listView.layer.borderWidth = 0.6;
        [_listView addSubview:self.listTableView];
        _listView.layer.shadowColor = [UIColor colorWithRed:211/255.0 green:224/255.0 blue:220/255.0 alpha:0.5].CGColor;
        _listView.layer.shadowOffset = CGSizeMake(0,4);
        _listView.layer.shadowOpacity = 1;
        _listView.layer.shadowRadius = 6;
        _listView.userInteractionEnabled = YES;
    }
    return _listView;
}


@end
