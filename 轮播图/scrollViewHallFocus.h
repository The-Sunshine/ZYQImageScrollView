//
//  scrollViewHallFocus.h
//  
//
//  Created by zyq on 2017/1/22.
//  Copyright © 2017年 zyq. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol scrollViewHallFocusDelegate  <NSObject>

-(void)scrollViewHallFocusClick:(NSInteger)index;

@end
@interface scrollViewHallFocus : UIView <UIScrollViewDelegate>

/** 初始化 */
+(instancetype)imageScrollViewHallFocus:(CGRect)frame;

/** 数据源 */
@property (nonatomic, strong) NSArray * imageArray;

/** 其他页page颜色 */
@property (nonatomic,strong) UIColor  * pageIndicatorTintColor;

/** 当前页page颜色 */
@property (nonatomic,strong) UIColor  * pageCurrentColor;

/** 滚动间隔 */
@property (nonatomic,assign) CGFloat  duration;

/** 代理 */
@property (nonatomic,weak) id<scrollViewHallFocusDelegate> delegate;


@end
