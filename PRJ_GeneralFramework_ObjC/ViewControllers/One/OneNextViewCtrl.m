//
//  OneNextViewCtrl.m
//  PRJ_GeneralFramework
//
//  Created by 256app on 15/8/7.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import "OneNextViewCtrl.h"

@interface OneNextViewCtrl ()

@end

@implementation OneNextViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)loadData
{
    [self POST:@"&c=Index&a=goods_type" parameters:nil requestCode:123];
    [self POST:@"&c=Index&a=goods_type" parameters:nil requestCode:456];
}

- (void)requestFailure:(NSInteger)requestCode error:(NSError *)error
{
    NSLog(@"=========%ld", requestCode);
}

- (void)httpRequestSuccess:(NSInteger)requestCode result:(id)responseObject
{
    NSLog(@"=========%ld", requestCode);
}

- (void)requestData
{
//    [HttpRequest POST:@"&c=Index&a=goods_type" parameters:nil requestCode:123 delegate:self object:nil];
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
