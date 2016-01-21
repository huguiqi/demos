//
//  ZWAdView.m
//  ADScrollview
//
//  Created by Zhouwu on 14/11/7.
//  Copyright (c) 2014年 com.thomas. All rights reserved.
//

#import "ZTAdView.h"
#import "UIImageView+WebCache.h"

@interface ZTAdView ()

@property(nonatomic,strong) NSMutableArray * pageControlConstraints;

@end

@implementation ZTAdView



-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        self.adPeriodTime=2.0f;
        self.adDataArray =[NSMutableArray array];
        self.adAutoplay=YES;
        [self setAdScrollView];
        [self setPageControl];
    }
    return self;
}

- (void)setAdScrollView
{
    self.adScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.adScrollView.pagingEnabled = YES;
    self.adScrollView.delegate = self;
    self.adScrollView.scrollsToTop = NO;
    self.adScrollView.showsHorizontalScrollIndicator=NO;
    [self addSubview:self.adScrollView];
}

- (void)setPageControl
{
    // UIPageControl
    self.pageControl = [[UIPageControl alloc] init];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.enabled = NO;
    self.pageControl.numberOfPages = self.adDataArray.count;
    self.pageControl.currentPage = 0;
    [self addSubview:self.pageControl];
    
    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[pageControl]-0-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[pageControl]-|"
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    self.pageControlConstraints = [NSMutableArray arrayWithArray:pageControlVConstraints];
    [self.pageControlConstraints addObjectsFromArray:pageControlHConstraints];
    
    [self addConstraints:self.pageControlConstraints];
}

#pragma mark -加载并播放广告数据内容
-(void)loadAdDataThenStart
{
    if (_adScrollView.subviews.count != 0) {
        for (UIView * subView in _adScrollView.subviews) {
            [subView removeFromSuperview];
        }
    }
    [self.adScrollView setContentSize:CGSizeMake(self.adScrollView.bounds.size.width*(self.adDataArray.count+2), self.adScrollView.bounds.size.height)];
    self.pageControl.numberOfPages = self.adDataArray.count;
    _pageControl.currentPage = 0;
    for (int i=0; i<self.adDataArray.count; i++) {
        UIImageView *adImageView= [[UIImageView alloc] initWithFrame:CGRectMake((i+1)*self.adScrollView.bounds.size.width, 0, self.adScrollView.bounds.size.width,self.adScrollView.bounds.size.height)];
        adImageView.tag=i;
        adImageView.userInteractionEnabled=YES;
        adImageView.contentMode = UIViewContentModeScaleAspectFill;
        adImageView.clipsToBounds = YES;
        [adImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@",self.adDataArray[i]]] placeholderImage:[UIImage imageNamed:self.placeImageSource]];
        [adImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adImgClick)]];
        [self.adScrollView addSubview:adImageView];
    }
    
    UIImageView *lastAdImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height)];
    lastAdImageView.contentMode = UIViewContentModeScaleAspectFill;
    lastAdImageView.clipsToBounds = YES;
    [lastAdImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@",self.adDataArray[self.adDataArray.count-1]]] placeholderImage:[UIImage imageNamed:self.placeImageSource]];
    [self.adScrollView addSubview:lastAdImageView];
    
    
    UIImageView *firstAdImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.adDataArray.count+1)*self.adScrollView.bounds.size.width, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height)];
    firstAdImageView.contentMode = UIViewContentModeScaleAspectFill;
    firstAdImageView.clipsToBounds = YES;
    [firstAdImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString alloc] initWithFormat:@"%@",self.adDataArray[0]]] placeholderImage:[UIImage imageNamed:self.placeImageSource]];
    [self.adScrollView addSubview:firstAdImageView];
    
    [self.adScrollView setContentOffset:CGPointMake(self.adScrollView.bounds.size.width, 0)];
    if (self.adAutoplay) {
        if (!self.adLoopTimer && _adDataArray.count >1) {
            self.adLoopTimer = [NSTimer scheduledTimerWithTimeInterval:self.adPeriodTime target:self selector:@selector(loopAd) userInfo:nil repeats:YES];
        }
    }

    if (_adDataArray.count == 1) {
        _adScrollView.scrollEnabled = NO;
    }
    
}

#pragma mark - 循环播放
-(void)loopAd
{
    CGFloat pageWidth = self.adScrollView.frame.size.width;
    int currentPage = self.adScrollView.contentOffset.x/pageWidth;
    if (currentPage == 0) {
        self.pageControl.currentPage = self.pageControl.numberOfPages-1;
    }
    else if (currentPage == self.pageControl.numberOfPages+1) {
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
    
    __block NSInteger currPageNumber = self.pageControl.currentPage;
    CGSize viewSize = self.adScrollView.frame.size;
    CGRect rect = CGRectMake((currPageNumber+2)*pageWidth, 0, viewSize.width, viewSize.height);
    
    [UIView animateWithDuration:0.7 animations:^{
        [self.adScrollView scrollRectToVisible:rect animated:NO];
    } completion:^(BOOL finished) {
        currPageNumber++;
        if (currPageNumber == self.pageControl.numberOfPages) {
            [self.adScrollView setContentOffset:CGPointMake(self.adScrollView.bounds.size.width, 0)];
            currPageNumber = 0;
        }
    }];
    
    currentPage = self.adScrollView.contentOffset.x/pageWidth;
    if (currentPage == 0) {
        self.pageControl.currentPage = self.pageControl.numberOfPages-1;
    }
    else if (currentPage == self.pageControl.numberOfPages+1) {
        self.pageControl.currentPage = 0;
    }
    else {
        self.pageControl.currentPage = currentPage-1;
    }
}
#pragma mark---- UIScrollView delegate methods

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
        NSInteger currentAdPage;
        currentAdPage=self.adScrollView.contentOffset.x/self.adScrollView.bounds.size.width;
        if (currentAdPage==0) {
            [scrollView scrollRectToVisible:CGRectMake(self.adScrollView.bounds.size.width*self.pageControl.numberOfPages, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height) animated:NO];
            currentAdPage=self.pageControl.numberOfPages-1;
        }
        else if (currentAdPage==(self.pageControl.numberOfPages+1)) {
            [scrollView scrollRectToVisible:CGRectMake(self.adScrollView.bounds.size.width, 0, self.adScrollView.bounds.size.width, self.adScrollView.bounds.size.height) animated:NO];
            currentAdPage=0;
        }
        else{
            currentAdPage=currentAdPage-1;
        }
        self.pageControl.currentPage=currentAdPage;
    
    if (self.adAutoplay) {
        if (!self.adLoopTimer && _adDataArray.count > 1) {
            self.adLoopTimer = [NSTimer scheduledTimerWithTimeInterval:self.adPeriodTime target:self selector:@selector(loopAd) userInfo:nil repeats:YES];
        }
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //开始拖动scrollview的时候 停止计时器控制的跳转
    if (self.adAutoplay) {
        if (self.adLoopTimer) {
            [self.adLoopTimer invalidate];
            self.adLoopTimer = nil;
        }
    }
}

- (void)setPageControlPosition:(ZWPageControlPosition)pageControlPosition
{
    NSString *vFormat = nil;
    NSString *hFormat = nil;
    
    switch (pageControlPosition) {
        case ZWPageControlPosition_TopLeft: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case ZWPageControlPosition_TopCenter: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:|[pageControl]|";
            break;
        }
            
        case ZWPageControlPosition_TopRight: {
            vFormat = @"V:|-0-[pageControl]";
            hFormat = @"H:[pageControl]-|";
            break;
        }
            
        case ZWPageControlPosition_BottomLeft: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:|-[pageControl]";
            break;
        }
            
        case ZWPageControlPosition_BottomCenter: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:|[pageControl]|";
            break;
        }
            
        case ZWPageControlPosition_BottomRight: {
            vFormat = @"V:[pageControl]-0-|";
            hFormat = @"H:[pageControl]-|";
            break;
        }
    }
    
    [self removeConstraints:self.pageControlConstraints];
    
    NSArray *pageControlVConstraints = [NSLayoutConstraint constraintsWithVisualFormat:vFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    NSArray *pageControlHConstraints = [NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                               options:kNilOptions
                                                                               metrics:nil
                                                                                 views:@{@"pageControl": self.pageControl}];
    
    [self.pageControlConstraints removeAllObjects];
    [self.pageControlConstraints addObjectsFromArray:pageControlVConstraints];
    [self.pageControlConstraints addObjectsFromArray:pageControlHConstraints];
    
    [self addConstraints:self.pageControlConstraints];
    
}


- (void)setHidePageControl:(BOOL)hidePageControl
{
    self.pageControl.hidden = hidePageControl;
}

#pragma mark - 点击
-(void)adImgClick
{
    [self.delegate adView:self didDeselectAdAtNum:self.pageControl.currentPage];
}
@end
