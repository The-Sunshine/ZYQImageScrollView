//
//  scrollViewHallFocus.m
//
//
//  Created by zyq on 2017/1/22.
//  Copyright © 2017年 zyq. All rights reserved.
//



#import "scrollViewHallFocus.h"

@implementation scrollViewHallFocus
{
    UIImageView * _centerIV;
    UIImageView * _leftIV;
    UIImageView * _rightIV;
    UIPageControl * _page;
    UIScrollView * _scrollView;
    NSInteger _currentImageIndex;
    NSTimer * _timer;
    NSInteger _oldImageIndex;
    
    CGFloat _width;
    CGFloat _height;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initialization];
        [self initUI];
    }
    return self;
}
-(void)initialization
{
    /** 常用变量 */
    _width =  [UIScreen mainScreen].bounds.size.width;
    
    _height = 200;
    
    _duration = 3.0;
    
    _currentImageIndex = 0;
    
    _pageCurrentColor = [UIColor redColor];
    
    _pageIndicatorTintColor = [UIColor whiteColor];

}
+(instancetype)imageScrollViewHallFocus:(CGRect)frame
{
    scrollViewHallFocus * view = [[self alloc]initWithFrame:frame];
    
    return view;
}
-(void)initUI
{
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:scrollView];
    _scrollView = scrollView;
    
    for (NSInteger i = 0; i < 3; i++)
    {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.tag = 100 + i ;
        [scrollView addSubview:imageView];
        
        if (i == 0)_leftIV = imageView;
        if (i == 1)_centerIV = imageView;
        if (i == 2)_rightIV = imageView;
    }
    
    UIPageControl * page = [[UIPageControl alloc]init];
    page.currentPageIndicatorTintColor = _pageCurrentColor;
    page.pageIndicatorTintColor = _pageIndicatorTintColor;
    [self addSubview:page];
    _page = page;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void)tapAction:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollViewHallFocusClick:)]) {
        
        [self.delegate scrollViewHallFocusClick:_currentImageIndex];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _scrollView.frame = self.bounds;

    _scrollView.contentSize = CGSizeMake(_width * 3 , 0);
    _scrollView.contentOffset = CGPointMake(_width, 0);
    
    for (NSInteger i = 0; i < 3; i++ ) {
        
        UIImageView * imageView = [_scrollView viewWithTag:100 + i];
        imageView.frame = CGRectMake(i * _width, 0, _width, _height);
    }
    _page.center = CGPointMake(self.center.x, self.center.y + 70);
}

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    if (!_imageArray || _imageArray.count == 0) return;

    _page.numberOfPages = imageArray.count;
    
    _scrollView.scrollEnabled = imageArray.count > 1 ? YES : NO;
    
    _leftIV.image = [UIImage imageNamed:[_imageArray lastObject]];
    
    _centerIV.image = [UIImage imageNamed:_imageArray[0]];
    
    if (_imageArray.count == 1) return;
    
    _rightIV.image = [UIImage imageNamed:_imageArray[1]];

    [self startTimer];
}
#pragma mark - timer
-(void)startTimer
{
    [_timer invalidate];
    _timer = nil;
    
    _timer = [NSTimer timerWithTimeInterval:_duration target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
}
-(void)stopTimer
{
    [_timer invalidate];
    _timer = nil;
}

-(void)automaticScroll
{
        [_scrollView setContentOffset:CGPointMake(_width * 2, 0) animated:YES];
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint currentOffset = scrollView.contentOffset;
    if (currentOffset.x <= 0) {
        
        _currentImageIndex = (_currentImageIndex - 1 + _imageArray.count) % _imageArray.count;
        _page.currentPage = _currentImageIndex;

        NSInteger index1 = (_currentImageIndex - 1 + _imageArray.count) % _imageArray.count;
        NSInteger index2 = _currentImageIndex;
        NSInteger index3 = (_currentImageIndex + 1 + _imageArray.count) % _imageArray.count;
        
        _leftIV.image = [UIImage imageNamed:_imageArray[index1]];
        _centerIV.image = [UIImage imageNamed:_imageArray[index2]];
        _rightIV.image = [UIImage imageNamed:_imageArray[index3]];
       
        [scrollView setContentOffset:CGPointMake(_width, 0) animated:NO];

    } else if (currentOffset.x >= scrollView.frame.size.width * 2) {
        
        _currentImageIndex = (_currentImageIndex + 1) % _imageArray.count;
        _page.currentPage = _currentImageIndex;

        NSInteger index1 = (_currentImageIndex - 1 + _imageArray.count) % _imageArray.count;
        NSInteger index2 = _currentImageIndex;
        NSInteger index3 = (_currentImageIndex + 1 + _imageArray.count) % _imageArray.count;
        
        _leftIV.image = [UIImage imageNamed:_imageArray[index1]];
        _centerIV.image = [UIImage imageNamed:_imageArray[index2]];
        _rightIV.image = [UIImage imageNamed:_imageArray[index3]];
        
        [scrollView setContentOffset:CGPointMake(_width, 0) animated:NO];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
}
@end
