//
//  SecondViewController.h
//  Tu Planeta Azul
//
//  Created by José Juan Mota Torres on 26/08/15.
//  Copyright (c) 2015 José Juan Mota Torres. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface SecondViewController : UIViewController <UITextViewDelegate> /*<UIPickerViewDataSource,UIPickerViewDelegate>

{
    NSArray *dataArray;
}


@property (weak, nonatomic) IBOutlet UITextField *pickerTextField; */

//Elementos interfaz
@property (weak, nonatomic) IBOutlet UISegmentedControl *opcionesSegm;
@property (weak, nonatomic) IBOutlet UITextField *nombre;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *telefono;
@property (weak, nonatomic) IBOutlet UITextView *mensaje;

//Base Datos
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)Guardar:(id)sender;
@end