//
//  TableViewCell.h
//  StockTracker
//
//  Created by Mahaboobsab Nadaf on 18/07/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *symbilLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLbl;
@property (weak, nonatomic) IBOutlet UIView *bgColorView;
@property (weak, nonatomic) IBOutlet UILabel *firstlblOfBg;

@property (weak, nonatomic) IBOutlet UILabel *secondLblOfBg;
@property (weak, nonatomic) IBOutlet UILabel *middleLbl1;
@property (weak, nonatomic) IBOutlet UILabel *middleTimeLbl;
@property (weak, nonatomic) IBOutlet UIButton *buyButtonOut;
@property (weak, nonatomic) IBOutlet UIButton *sellButtOut;
@property (weak, nonatomic) IBOutlet UIButton *deleteButtOut;

@end
