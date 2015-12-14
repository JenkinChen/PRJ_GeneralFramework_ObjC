//
//  CustomNavCtrl.m
//  PRJ_GeneralFramework
//
//  Created by 256app on 15/8/7.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import "CustomNavCtrl.h"
#import "PublicMacro.h"

@interface CustomNavCtrl () <UINavigationControllerDelegate>

@end

@implementation CustomNavCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialization];
}

- (void)initialization
{
    self.navigationBar.tintColor = UIColorWhite;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:UIImageName(@"公用-导航栏-返回-白色") style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    [super pushViewController:viewController animated:animated];
}

- (void)popBack
{
    [super popViewControllerAnimated:YES];
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
