//
//  SearchViewController.m
//  StockTracker
//
//  Created by Mahaboobsab Nadaf on 18/07/16.
//  Copyright © 2016 com.NeoRays. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.companyName = [[NSMutableArray alloc]init];
    self.companySymbol = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.companySymbol.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [self.companySymbol objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.companyName objectAtIndex:indexPath.row];
    
    return cell;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
  
    
   
    [self clickedOnTextField:self.searchTextField.text];
    
    return YES;
    
    
}

-(void)clickedOnTextField :(NSString *)str{

    [self.companyName removeAllObjects];
    [self.companySymbol removeAllObjects];
    
       self.urlString = [NSString stringWithFormat:@"http://chstocksearch.herokuapp.com/api/%@",str];
    self.urlString = [self.urlString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:self.urlString]completionHandler:^(NSData * data, NSURLResponse *  response, NSError *  error) {
        self.jsonAPI = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        
        
        NSLog(@"JSON is : %@",self.jsonAPI);
        
        if (self.jsonAPI != nil) {
            
       
        
        for (NSDictionary *dict in self.jsonAPI) {
            
            [self.companySymbol addObject: [dict valueForKey:@"symbol"] ];
            
            [self.companyName addObject: [dict valueForKey:@"company"] ];
            
        }
                     }
        NSLog(@"All Company Symbils : %@",self.companySymbol);
        
        dispatch_async(dispatch_get_main_queue(), ^{
        [self.myTableView reloadData];
         });
        
        
    }];
    
    [dataTask resume];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    [self.delegate recieveData:[self.companySymbol objectAtIndex:indexPath.row]];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
