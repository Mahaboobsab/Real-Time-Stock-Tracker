//
//  SellViewController.h
//  StockTracker
//
//  Created by Meheboob Nadaf on 20/07/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSArray *sellArray;

@end
