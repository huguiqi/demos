//
//  WFImageMoShaViewController.m
//  demoKits
//
//  Created by 胡 桂祁 on 6/27/14.
//  Copyright (c) 2014 Jinjiang.com. All rights reserved.
//

#import "WFImageMoShaViewController.h"
#import "UIImage+ImageEffects.h"

@interface WFImageMoShaViewController ()

@end

@implementation WFImageMoShaViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *image = [[UIImage alloc] applyTintEffectWithColor:[UIColor blueColor]];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view setTintColor:[UIColor colorWithPatternImage:image]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
