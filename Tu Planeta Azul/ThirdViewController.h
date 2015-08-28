//
//  ThirdViewController.h
//  Tu Planeta Azul
//
//  Created by José Juan Mota Torres on 26/08/15.
//  Copyright (c) 2015 José Juan Mota Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ThirdViewController : UIViewController

@property (strong) NSMutableArray *datosguardados;



- (IBAction)cargarDatos:(id)sender;

@end
