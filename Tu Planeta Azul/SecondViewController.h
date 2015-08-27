//
//  SecondViewController.h
//  Tu Planeta Azul
//
//  Created by José Juan Mota Torres on 26/08/15.
//  Copyright (c) 2015 José Juan Mota Torres. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UIPickerViewDataSource,UIPickerViewDelegate>

{
    NSArray *dataArray;
}


@property (weak, nonatomic) IBOutlet UITextField *pickerTextField;

@end

