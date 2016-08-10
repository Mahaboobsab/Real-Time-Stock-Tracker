//
//  SearchViewController.h
//  StockTracker
//
//  Created by Mahaboobsab Nadaf on 18/07/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@protocol myProtocol;

@interface SearchViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property(nonatomic, weak) id<myProtocol>delegate;

@property(strong,nonatomic)NSMutableArray *companySymbol;
@property(strong,nonatomic)NSMutableArray *companyName;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property(strong,nonatomic)NSDictionary *jsonAPI;
@property(strong, nonatomic)NSString *urlString;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@end
