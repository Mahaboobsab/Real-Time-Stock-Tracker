//
//  ViewController.h
//  StockTracker
//
//  Created by Mahaboobsab Nadaf on 18/07/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCell.h"
#import "DetailViewController.h"
#import "SearchViewController.h"
#import "SellViewController.h"

@protocol myProtocol
-(void)recieveData : (NSString *)data;
@end

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,myProtocol>
- (IBAction)swifeLeft:(id)sender;
- (IBAction)swifeRight:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)deleteButton:(id)sender;

@property(strong,nonatomic)NSDictionary *jsonAPI;
@property(strong, nonatomic)NSString *urlString;
@property(strong,nonatomic)NSData * data;

@property(strong,nonatomic)NSMutableArray *companySymbol;
@property(strong,nonatomic)NSMutableArray *companyName;
@property(strong,nonatomic)NSMutableArray *companyClose;
@property(strong,nonatomic)NSMutableArray *percentChange;
@property(strong,nonatomic)NSMutableArray *netChange;
@property(strong,nonatomic)NSMutableArray *serverTimestamp;

@property(strong,nonatomic)NSMutableArray *jsonArray;

@property(nonatomic,assign)NSInteger sendIndex;
@property(nonatomic,assign)int decideSegue;
@property(strong, nonatomic)NSIndexPath *selectedPath;
- (IBAction)addCompanies:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
@property (weak, nonatomic) IBOutlet UIView *activityView;
- (IBAction)sellButton:(id)sender;
- (IBAction)buyButton:(id)sender;
@end

