//
//  CHTSelectListView.h
//  CHTSelectListView
//
//  Created by cht on 17/3/13.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHTSelectListView;

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@protocol CHTSelectListViewDelegate <NSObject>

@optional
- (void)selectListView:(CHTSelectListView *)selectListView didSelectedRow:(NSInteger)row;

@end

@interface CHTSelectListView : UIControl

@property (nonatomic, assign) id <CHTSelectListViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray <NSString *>*)dataArray;

- (void)show;

@end

