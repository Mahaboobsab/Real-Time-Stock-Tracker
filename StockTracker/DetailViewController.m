//
//  DetailViewController.m
//  StockTracker
//
//  Created by Mahaboobsab Nadaf on 19/07/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self getSession:self.urlCmp];
    
    [self updateLabels];
    
    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)receiveArrray : (NSArray *)selectedArray{

self.urlCmp = [[NSString alloc]init];
    self.receivedArray = selectedArray;
    self.urlCmp = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"symbol"]];
    NSLog(@"Received Array is : %@",self.receivedArray);
}
-(void)updateLabels{


    self.openLbl.text = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"open"]];
    self.highLbl.text = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"high"]];
    self.HighLblFifty.text = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"lastPrice"]];
    self.volumeLbl.text = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"volume"]];
    self.echangeLbl.text = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"exchange"]];
    self.preCloseLbl.text = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"close"]];
     self.lowLbl.text = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"low"]];
    self.lowFiftyLbl.text = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"low"]];
    self.modeLbl.text = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"mode"]];
    
    
    self.flagLbl.text = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"flag"]];
    
    self.topCloseLbl.text = [NSString stringWithFormat:@"%@",[self.receivedArray valueForKey:@"close"]];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ - %@",[self.receivedArray valueForKey:@"symbol"],[self.receivedArray valueForKey:@"name"]];
   
    NSString *tmp = @"%";
   self.netChangePercLbl.text =[NSString stringWithFormat:@"%@ ( %@%@)",[self.receivedArray valueForKey:@"netChange"],[self.receivedArray valueForKey:@"percentChange"],tmp];
    
    
    
    NSString *searchtext = @"-";
    NSRange range2 = [self.netChangePercLbl.text rangeOfString:searchtext];
    if (range2.location != NSNotFound)
    {
        self.netChangePercLbl.textColor = [UIColor redColor];
        
    }
    
   
    
}

-(void)getSession : (NSString *)appendCmp{
    
    
    self.urlString = [[NSString alloc]init];
    
    self.json = [[NSDictionary alloc]init];
    
    //Initializing string with URL
    self.urlString = [NSString stringWithFormat:@"https://www.quandl.com/api/v3/datasets/WIKI/%@.json?api_key=NatZ5z6wP13yWXvqGrmQ",appendCmp];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:self.urlString]completionHandler:^(NSData * data, NSURLResponse *  response, NSError *  error) {
        self.json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSLog(@"json is : %@",self.json);
        
        
        
        self.json = [self.json valueForKey:@"dataset"];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.myTextView.text = [NSString stringWithFormat:@"%@",[self.json valueForKey:@"description"]];
        });

       
        
        self.myArray = [[NSMutableArray alloc] init];
        _myArray = [self.json valueForKey:@"data"];
        _myArray = [_myArray objectAtIndex:0];
        
        self.formattedArray = [[NSMutableArray alloc] init];
        NSLog(@"json is myArray : %@",_myArray);
        
        for (int i = 1; i<12; i++) {
            if (i==5) {
                i++;
            }
            
            
            
            NSString *formatedString = [NSString stringWithFormat:@"%@", [_myArray objectAtIndex:i]];
            float myFloat = [formatedString floatValue];
            [_formattedArray addObject:[NSString stringWithFormat:@"%.f", myFloat]];
        }
        NSLog(@"Formatted Array is : %@",_formattedArray);
        
        [self floatChart];
    }];
    [dataTask resume];
    
    

}

-(void)floatChart{


    NSMutableArray *randomNumericData = [[NSMutableArray alloc] init];
    for (int i=0; i<10; i++) {
        [randomNumericData addObject:[[TKChartDataPoint alloc] initWithX:@(i) Y:[self.formattedArray objectAtIndex:i]]];
    }
    self.chartView.allowAnimations = YES;
    self.chartView.hidden = NO;
    self.chartView.title.textColor = [UIColor orangeColor];
    self.chartView.title.text = [NSString stringWithFormat:@"%@",[self.myArray objectAtIndex:0]];
    
     dispatch_async(dispatch_get_main_queue(), ^{
         
    [self.chartView addSeries:[[[TKChartLineSeries alloc]init ]initWithItems:randomNumericData]];
     
     });
}
@end
