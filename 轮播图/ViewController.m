//
//  ViewController.m
//  轮播图
//
//  Created by zyq on 2017/3/21.
//  Copyright © 2017年 Jun. All rights reserved.
//

#import "ViewController.h"
#import "scrollViewHallFocus.h"


@interface ViewController ()<scrollViewHallFocusDelegate>
@property (nonatomic,strong) NSArray * dataArray;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = @[@"ad1@2x.jpg",@"ad2@2x.jpg",@"ad3@2x.jpg",@"ad4@2x.jpg",@"ad5@2x.jpg"];
    
    [self initScrollViewHallFocus];
}

-(void)initScrollViewHallFocus
{
    scrollViewHallFocus * focus = [scrollViewHallFocus imageScrollViewHallFocus:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    focus.imageArray = _dataArray;
    focus.delegate = self;
    [self.view addSubview:focus];
}

-(void)scrollViewHallFocusClick:(NSInteger)index
{
    NSLog(@"---%ld",index);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
