//
//  Show3DViewController.m
//  Objc_demo
//
//  Created by sam on 16/1/21.
//  Copyright © 2016年 WF. All rights reserved.
//

#import "Show3DViewController.h"

@interface Show3DViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,weak) IBOutlet UITableView *tableView;

@end

@implementation Show3DViewController{
    NSMutableArray *homeArrays;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    homeArrays = [[NSMutableArray alloc] init];
    for (int i= 0; i<20; i++) {
        [homeArrays addObject:[NSString stringWithFormat:@"第 %i 栏",i]];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [homeArrays count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"3DViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"3DViewCell"];
    }
    [cell setText:[homeArrays objectAtIndex:[indexPath row]]];
    
    return cell;
    
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
