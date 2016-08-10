//
//  ViewController.m
//  StockTracker
//
//  Created by Mahaboobsab Nadaf on 18/07/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self createActivityIndicator];
       [self memoryAlloc];
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *jsonArray = [defaults objectForKey:@"jsonArray"];
    
    
    
    [self.jsonArray addObjectsFromArray:jsonArray];
    
 
    
    if (self.jsonArray == nil) {
        [self apiCall:@"YHOO,FB,GOOG,IBM"];
        
    }
    [self updateArray];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.companySymbol.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.bgColorView.layer.cornerRadius= 10.0;
    cell.bgColorView.layer.masksToBounds=true;
    
    cell.buyButtonOut.hidden  = YES;
    cell.deleteButtOut.hidden = YES;
    cell.sellButtOut.hidden = YES;
    
    cell.symbilLabel.text = [self.companySymbol objectAtIndex:indexPath.row];
    cell.companyLbl.text = [self.companyName objectAtIndex:indexPath.row];
    cell.middleLbl1.text = [NSString stringWithFormat:@"%@",[self.companyClose objectAtIndex:indexPath.row]];
    
    NSString *str = @"%";
    cell.secondLblOfBg.text = [NSString stringWithFormat:@"%@%@",[self.percentChange objectAtIndex:indexPath.row],str];
    
    
   
    
    cell.firstlblOfBg.text = [NSString stringWithFormat:@"%@",[self.netChange objectAtIndex:indexPath.row]];
    
    NSString *searchtext = @"-";
    NSRange range2 = [cell.firstlblOfBg.text rangeOfString:searchtext];
    if (range2.location == NSNotFound)
    {
        [cell.bgColorView setBackgroundColor:[UIColor greenColor]];
        NSString *str2 = @"+";
        cell.firstlblOfBg.text = [NSString stringWithFormat:@"%@%@",str2,[self.netChange objectAtIndex:indexPath.row]];
        
    }
    
    
    else{
    
    cell.firstlblOfBg.text = [NSString stringWithFormat:@"%@",[self.netChange objectAtIndex:indexPath.row]];
        
        [cell.bgColorView setBackgroundColor:[UIColor redColor]];
        
    }
    
    cell.middleTimeLbl.text = [NSString stringWithFormat:@"%@",[self.serverTimestamp objectAtIndex:indexPath.row]];
   
    NSRange range = NSMakeRange(14, 5);
  cell.middleTimeLbl.text = [ cell.middleTimeLbl.text substringWithRange:range];
    return cell;
}


- (IBAction)addCompanies:(id)sender {
    
    self.decideSegue = 1;
    [self performSegueWithIdentifier:@"search" sender:self];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    self.decideSegue = 0;
    self.sendIndex = indexPath.row;
    
    [self performSegueWithIdentifier:@"detail" sender:self];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if (self.decideSegue == 0) {
        
    
    DetailViewController *detailVc = [segue destinationViewController];
    [detailVc receiveArrray:[self.jsonArray objectAtIndex:self.sendIndex]];
    }
    
    else if(self.decideSegue == 2)
    {
    
        
    }
    
    else if(self.decideSegue == 3)
    {
        
        
    }
    else{
    
        UIViewController* VC2 = [segue destinationViewController];
        if ([VC2 isKindOfClass:[SearchViewController class]])
        {
            SearchViewController* viewController2 = (SearchViewController *)VC2;
            viewController2.delegate = self;
        }
    }
    
    
}

-(void)apiCall : (NSString *)companySymbol{

   
    self.urlString = [NSString stringWithFormat:@"http://marketdata.websol.barchart.com/getQuote.json?key=2eee11a63bfe53d791d9d11803f3ef5d&symbols=%@",companySymbol];
    
   
    ;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:self.urlString]completionHandler:^(NSData * data, NSURLResponse *  response, NSError *  error) {
        self.jsonAPI = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
        
        NSLog(@"JSON is : %@",self.jsonAPI);
        
        if (self.jsonAPI != nil) {
            
            
            
            self.jsonAPI = [self.jsonAPI objectForKey:@"results"];
            
            
            
            if (self.jsonAPI == (NSDictionary*) [NSNull null]){
                NSLog(@"Json API is nil++++++++++++");
                [self hideActivityIndicator];
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                               message:@"Failed to Fetch Data"
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                                      handler:^(UIAlertAction * action) {
                                                                      
                                                                  
                                                                      }];
                
                [alert addAction:defaultAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            
            
            
            
            else{
                
              
                [self.jsonArray addObjectsFromArray:(NSMutableArray *) self.jsonAPI];
                NSLog(@"Json API is Successfull------");
            }
            
            [self updateArray];
            
            
        }
        NSLog(@"All Company Symbils : %@",self.companySymbol);
        
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.myTableView reloadData];
        });
    }];
    
    [dataTask resume];
    
    

}
-(void)recieveData:(NSString *)data{

    
    self.decideSegue = 0;
    
    if([ self.companySymbol containsObject:data])
    {
        
        NSLog(@"Object  present");
        
    }
    else{
        [self createActivityIndicator];
    [self apiCall:data];
    }
}




- (IBAction)swifeLeft:(id)sender {
    
    NSLog(@"Inside Swife Left...");
    
    CGPoint location = [sender locationInView:self.myTableView];
    self.selectedPath = [self.myTableView indexPathForRowAtPoint:location];
    
    TableViewCell *cell = [self.myTableView cellForRowAtIndexPath:self.selectedPath];
    
    cell.sellButtOut.hidden = NO;
    cell.deleteButtOut.hidden = NO;
    cell.buyButtonOut.hidden = NO;
    
    
    
   
    
}

- (IBAction)swifeRight:(id)sender {
     NSLog(@"Inside Swife Right...");
    
    CGPoint location = [sender locationInView:self.myTableView];
    self.selectedPath = [self.myTableView indexPathForRowAtPoint:location];
    
    
    TableViewCell *cell = [self.myTableView cellForRowAtIndexPath:self.selectedPath];
    
    cell.sellButtOut.hidden = YES;
    cell.deleteButtOut.hidden = YES;
    cell.buyButtonOut.hidden = YES;
}

- (IBAction)deleteButton:(UIButton*)sender {
    
     NSIndexPath *indexPath = [self.myTableView indexPathForCell:(TableViewCell *)sender.superview.superview];
    
     TableViewCell *cell = [_myTableView cellForRowAtIndexPath:indexPath];
    
    cell.sellButtOut.hidden = YES;
    cell.deleteButtOut.hidden = YES;
    cell.buyButtonOut.hidden = YES;
    
    [self.jsonArray removeObjectAtIndex:indexPath.row];
   
    [self updateArray];
    [self.myTableView reloadData];
}

-(void)updateArray{
    
    //[self memoryAlloc];
    
    [self.companySymbol removeAllObjects];
    [self.companyName removeAllObjects];
     [self.companyClose removeAllObjects];
    [self.percentChange removeAllObjects];
     [self.netChange removeAllObjects];
      [self.serverTimestamp removeAllObjects];

    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
   
    [defaults setObject:self.jsonArray forKey:@"jsonArray"];
    
    [defaults synchronize];
    
    NSLog(@"Data saved");

    
    [self.companySymbol addObjectsFromArray:[self.jsonArray valueForKey:@"symbol"] ];
    
    [self.companyName addObjectsFromArray: [self.jsonArray valueForKey:@"name"] ];
    
    [self.companyClose addObjectsFromArray:[self.jsonArray valueForKey:@"close"] ];
    
    [self.percentChange addObjectsFromArray: [self.jsonArray valueForKey:@"percentChange"] ];
    
    [self.netChange addObjectsFromArray:[self.jsonArray valueForKey:@"netChange"] ];
    
    [self.serverTimestamp addObjectsFromArray:[self.jsonArray valueForKey:@"serverTimestamp"] ];
    
    [self.myTableView reloadData];
    
    [self hideActivityIndicator];
    
    
}

-(void)memoryAlloc{

    self.companyName = [[NSMutableArray alloc] init];
    self.companySymbol = [[NSMutableArray alloc] init];
    self.companyClose = [[NSMutableArray alloc] init];
    self.percentChange = [[NSMutableArray alloc] init];
    self.netChange = [[NSMutableArray alloc] init];
    self.serverTimestamp = [[NSMutableArray alloc] init];
    self.jsonArray = [[NSMutableArray alloc] init];
}

-(void)createActivityIndicator{
    
    self.activityView.layer.cornerRadius= 10.0;
    self.activityView.layer.masksToBounds=true;
    self.activityView.hidden=NO;
    [self.activity startAnimating];
    
}

-(void)hideActivityIndicator{
    
   
    dispatch_async(dispatch_get_main_queue(), ^{
         self.activityView.hidden=YES;
        [self.activity stopAnimating];
    });
    
    
}

- (IBAction)sellButton:(id)sender {
     self.decideSegue = 2;
    [self performSegueWithIdentifier:@"sell" sender:self];
}

- (IBAction)buyButton:(id)sender {
    
    self.decideSegue = 3;
    [self performSegueWithIdentifier:@"sell" sender:self];

}

-(void)viewWillAppear:(BOOL)animated{

    
    
    [self.myTableView reloadData];
}
@end
