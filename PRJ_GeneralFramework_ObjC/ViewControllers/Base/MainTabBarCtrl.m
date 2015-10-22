//
//  MainTabBarCtrl.m
//  PRJ_GeneralFramework
//
//  Created by 256app on 15/8/7.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import "MainTabBarCtrl.h"
#import "PublicMacro.h"

@interface MainTabBarCtrl ()

@end

@implementation MainTabBarCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialization];
}

#define kBtnTag 9000
- (void)initialization
{
    UIView *tabBarView = [[UINib nibWithNibName:@"MainTabBarView" bundle:nil] instantiateWithOwner:self options:nil][0];
    tabBarView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 49);
    [self.tabBar addSubview:tabBarView];
}

- (IBAction)btnClick:(UIButton *)sender {
    UIButton *preBtn = (UIButton *)[self.view viewWithTag:self.selectedIndex + kBtnTag];
    preBtn.userInteractionEnabled = YES;
    preBtn.selected = NO;
    self.selectedIndex = sender.tag - kBtnTag;
    sender.userInteractionEnabled = NO;
    sender.selected = YES;
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
