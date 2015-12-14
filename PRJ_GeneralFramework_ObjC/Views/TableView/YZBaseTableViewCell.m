//
//  YZBaseTableViewCell.m
//  PRJ_GeneralFramework_ObjC
//
//  Created by 256app on 15/12/14.
//  Copyright © 2015年 C. All rights reserved.
//

#import "YZBaseTableViewCell.h"

@implementation YZBaseTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//+ (instancetype)initWithTable:(UITableView *)tableView withModle:(id)model
//{
//    self = [[[self class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
//    
//    return self;
//}

@end
