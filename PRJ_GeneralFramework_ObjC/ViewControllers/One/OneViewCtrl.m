//
//  OneViewCtrl.m
//  PRJ_GeneralFramework
//
//  Created by 256app on 15/8/7.
//  Copyright (c) 2015年 256app. All rights reserved.
//

#import "OneViewCtrl.h"
#import "BaseViewCtrl+Photo.h"
#import "BaseViewCtrl+Category.h"

@interface OneViewCtrl ()
{
    __weak IBOutlet UITableView *_tableView;
}

@end

@implementation OneViewCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)initView
{
    self.navigationItem.leftBarButtonItem = nil;
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadDataNew)];
    _tableView.footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadDataMore)];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:RJCellIdentifier];
}

- (void)loadData
{
    if (_pageIndex == 0) {
        [self.dataSource removeAllObjects];
    }
    for (NSInteger i = 0; i < 10; i++) {
        [self.dataSource addObject:@(arc4random()%100)];
    }
    
    [_tableView reloadData];
    [self endRefreshing];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RJCellIdentifier];
    NSLog(@"%ld==%ld", self.dataSource.count, indexPath.row);
    cell.textLabel.text = [self.dataSource[indexPath.row] stringValue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"Next" sender:nil];
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
