//
//  CHTSelectListView.m
//  CHTSelectListView
//
//  Created by cht on 17/3/13.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import "CHTSelectListView.h"

#define ROW_HEIGHT 45

static NSString *const cellId = @"cellId";

@interface CHTSelectListCell : UITableViewCell


@end

@implementation CHTSelectListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.font = [UIFont systemFontOfSize:15.0f];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    [super setSelected:selected animated:animated];
    if (selected) {
        
        self.textLabel.textColor = [UIColor orangeColor];
    }else{
        
        self.textLabel.textColor = [UIColor blueColor];
    }
}

@end



@interface CHTSelectListView ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray <NSString *>*dataArray;

@end

@implementation CHTSelectListView{
    
    CGFloat _hTable;
}

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray <NSString *>*)dataArray
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (self) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
//        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onceTap:)];
//        tap.delegate = self;
//        [self addGestureRecognizer:tap];
        
        _dataArray = dataArray;
        _hTable = ROW_HEIGHT * _dataArray.count;
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, CGRectGetWidth(frame), _hTable) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        [_tableView registerClass:[CHTSelectListCell class] forCellReuseIdentifier:cellId];
        [self addSubview:_tableView];
        
        [self addTarget:self action:@selector(onceTap) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)hide{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = _tableView.frame;
        frame.origin.y = SCREEN_HEIGHT;
        _tableView.frame = frame;
        
    }completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}

- (void)show{
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = _tableView.frame;
        frame.origin.y = SCREEN_HEIGHT - _hTable;
        _tableView.frame = frame;
        
    }];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)onceTap{
    
    [self hide];
}

- (void)onceTap:(UITapGestureRecognizer *)tap{
    
    if ([tap.view isKindOfClass:self.class]) {
        
        [self hide];
    }
}

#pragma mark - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isKindOfClass:[self class]]) {
        return YES;
    }
    return NO;
}

#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CHTSelectListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.textLabel.text = _dataArray[indexPath.row];
    if (indexPath.row == _selectedRow) {
        [cell setSelected:YES animated:YES];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    _selectedRow = indexPath.row;
    [tableView reloadData];
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectListView:didSelectedRow:)]) {
        [_delegate selectListView:self didSelectedRow:indexPath.row];
    }
    [self hide];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return ROW_HEIGHT;
}

//seperator reach to left
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end

