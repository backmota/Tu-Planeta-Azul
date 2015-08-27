//
//  ThirdViewController.m
//  Tu Planeta Azul
//
//  Created by José Juan Mota Torres on 26/08/15.
//  Copyright (c) 2015 José Juan Mota Torres. All rights reserved.
//

#import "ThirdViewController.h"
#import <Foundation/Foundation.h>


@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


- (IBAction)cargarDatos:(id)sender {
   
    NSDictionary *headers = @{ @"content-type": @"application/json" };
    NSDictionary *parameters = @{ @"user_id": @1,
                                  @"surv_name": @"nombre",
                                  @"surv_email": @"email@email.com",
                                  @"surv_phone": @"5555555555",
                                  @"surv_craftsman": @"comprador",
                                  @"surv_message": @"mebakjsbkas a osdaosd oasd oasd",
                                  @"surv_date": @"2015-08-22 13:22:33" };
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.249.66.3:8080/WSRestSurvey/Api/SURVEY_USER/"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:postData];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                         NSLog(@"%@", httpResponse);
                                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CARGA"
                                                                                                        message:@"Error"
                                                                                                       delegate:self
                                                                                              cancelButtonTitle:@"OK"
                                                                                              otherButtonTitles:nil];
                                                        [alert show];
                                                    } else {
                                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"CARGA"
                                                                                                        message:@"Exitosa"
                                                                                                       delegate:self
                                                                                              cancelButtonTitle:@"OK"
                                                                                              otherButtonTitles:nil];
                                                        [alert show];
                                                    }
                                                }];
    [dataTask resume];
    
}
@end
