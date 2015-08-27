//
//  FirstViewController.m
//  Tu Planeta Azul
//
//  Created by José Juan Mota Torres on 26/08/15.
//  Copyright (c) 2015 José Juan Mota Torres. All rights reserved.
//

#import "FirstViewController.h"
#import <Foundation/Foundation.h>

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary *headers = @{ @"content-type": @"application/json" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://192.249.66.3:8080/WSRestSurvey/Api/SURVEY_USER/"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"%@", error);
                                                    } else {
                                                     
                                                        NSString *json_string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                                                        NSLog(@"%@", json_string);
                                                    }
                                                }];
    [dataTask resume];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
