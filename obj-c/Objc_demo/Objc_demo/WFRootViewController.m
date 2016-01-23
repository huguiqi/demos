//
//  WFRootViewController.m
//  Objc_demo
//
//  Created by sam on 16/1/20.
//  Copyright © 2016年 WF. All rights reserved.
//

#import "WFRootViewController.h"
#import "WFUtil.h"
#import "HomeViewCell.h"
#import "ZTAdView.h"


#import "Show3DViewController.h"

// 主屏幕 宽高
#define DEF_SCREEN_WIDTH   ([[UIScreen mainScreen] bounds].size.width)
#define DEF_SCREEN_HEIGHT  ([[UIScreen mainScreen] bounds].size.height)

static NSString* homeCellIndentifier = @"homeCell";



@interface WFRootViewController ()<UITableViewDataSource,UITableViewDelegate,ZWAdViewDelagate,UIViewControllerPreviewingDelegate>

@property (nonatomic,weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong)ZTAdView * advertView;

@end

@implementation WFRootViewController
{
    NSArray *homeArrays;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    homeArrays = [NSArray arrayWithObjects:@"第一栏",@"第二栏",@"第三栏", nil];
    
    
    
    self.advertView = [[ZTAdView alloc] initWithFrame:CGRectMake(0, 0, DEF_SCREEN_WIDTH, ScaleWidth(182))];
    _advertView.pageControlPosition = ZWPageControlPosition_BottomCenter;
    _advertView.placeImageSource = @"";
    _advertView.delegate = self;
    _advertView.adPeriodTime = 5;
    _advertView.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _advertView.pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//    _tableView.backgroundColor = Color_Gray_bg;
    
    
    
    _tableView.tableHeaderView = _advertView;
    
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerNib:InstantiateNibFromNibName(@"HomeViewCell") forCellReuseIdentifier:homeCellIndentifier];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [UIPreviewAction actionWithTitle:@"test" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"peek action");
    }];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [homeArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeViewCell *homeCell = [tableView dequeueReusableCellWithIdentifier:homeCellIndentifier];
    [homeCell setText:[homeArrays objectAtIndex:[indexPath row]]];
    if ([self has3DTouch]) {
        if ([indexPath row]==1) {
            [self registerForPreviewingWithDelegate:self sourceView:homeCell];
        }
    }
    
    return homeCell;

}

- (BOOL)has3DTouch
{
    // 如果开启了3D touch
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        return YES;
        
    }
    return NO;
}


- (nullable UIViewController *)previewingContext:(id <UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location{
    
    if ([self.presentedViewController isKindOfClass:[Show3DViewController class]]) {
        return nil;
    }
     Show3DViewController *childVC = (Show3DViewController *)InstantiateControllerFromXIB([Show3DViewController class]);
    
    childVC.preferredContentSize = CGSizeMake(0.0f,300.0f);
    
    CGRect rect = CGRectMake(10, location.y - 10, self.view.frame.size.width - 20,20);
    previewingContext.sourceRect = rect;
    return childVC;
}


- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit{
    
     [self showViewController:viewControllerToCommit sender:self]; 
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
