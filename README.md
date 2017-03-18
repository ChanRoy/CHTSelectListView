# CHTSelectListView
simple select view on the bottom of main view

![CHTSelectListView](https://github.com/ChanRoy/CHTSelectListView/blob/master/CHTSelectListView.gif)

## Introduction

*a simple select view on the bottom of main view.*

*the picture above show the usage.*

## Usage

### init method

```
- (instancetype)initWithFrame:(CGRect)frame
                    dataArray:(NSArray <NSString *>*)dataArray;
```

### show method
```
- (void)show;
```

### delegate

```
@property (nonatomic, assign) id <CHTSelectListViewDelegate>delegate;
```

### protocol
```
@optional
- (void)selectListView:(CHTSelectListView *)selectListView
        didSelectedRow:(NSInteger)row;
```

## used demo

```
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *arr = @[@"aaa",@"bbb",@"ccc",@"eee",@"ffff"];
    _listView = [[CHTSelectListView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT) dataArray:arr];
    _listView.delegate = self;

}

- (IBAction)btnClick:(id)sender {
    
        [_listView show];
}

#pragma mark - selectListView delegate
- (void)selectListView:(CHTSelectListView *)selectListView didSelectedRow:(NSInteger)row{
    
    if (selectListView == _listView) {
        
        NSLog(@"did click %ld row",row);
    }
}
```

More detail showed in the `CHTSelectListViewDemo Project`

## LICENSE

MIT

