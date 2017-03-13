//
//  ViewController.m
//  CHTSelectListViewDemo
//
//  Created by cht on 17/3/13.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import "ViewController.h"
#import "CHTSelectListView.h"

@interface ViewController ()<CHTSelectListViewDelegate>

@property (nonatomic, strong) CHTSelectListView *listView;

@end

@implementation ViewController{
    
    NSInteger _selectedRow;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnClick:(id)sender {
    
    NSArray *arr = @[@"aaa",@"bbb",@"ccc",@"eee",@"ffff"];
    
    _listView = [[CHTSelectListView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT) dataArray:arr];
    _listView.delegate = self;
    _listView.selectedRow = _selectedRow;
    [_listView show];
}

#pragma mark - selectListView delegate
- (void)selectListView:(CHTSelectListView *)selectListView didSelectedRow:(NSInteger)row{
    
    if (selectListView == _listView) {
        
        _selectedRow = row;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
