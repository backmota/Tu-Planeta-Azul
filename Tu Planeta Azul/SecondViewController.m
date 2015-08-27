//
//  SecondViewController.m
//  Tu Planeta Azul
//
//  Created by José Juan Mota Torres on 26/08/15.
//  Copyright (c) 2015 José Juan Mota Torres. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
@synthesize nombre,email,telefono,mensaje,opcionesSegm;
@synthesize fetchedResultsController, managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];    /*
    dataArray=[[NSArray alloc]initWithObjects:@"Vendedor",@"Comprador", nil];
    UIPickerView *picker=[[UIPickerView alloc]init];
    picker.dataSource=self;
    picker.delegate=self;
    [picker setShowsSelectionIndicator:YES];
    [self.pickerTextField setInputView:picker];
    */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Guardar:(id)sender {

    //----->  fecha del sistema
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
   // NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
    
    //pasando la fecha a tipo string
    NSString *fecha = [dateFormatter stringFromDate:[NSDate date]];

    
    //------>  vendedor o comprador
    NSInteger opcionelegida = opcionesSegm.selectedSegmentIndex;
    NSLog(@"opcion elegida es %li",(long)opcionelegida);
   
    NSString *craftsman;
    if (opcionelegida==1) {
        craftsman = @"Vendedor";
    }else{
        craftsman = @"Comprador";
    }
    
    //------> validar telefono
    
    NSString *tel;
    
    if ([self.telefono.text length]>6 && [self.telefono.text length]<11) {
        tel  = [NSString stringWithFormat:@"%@",self.telefono.text];
    }else{
        tel = @"";
    }
    
    //------> cargar a base de datos

    if( [self.nombre.text length]!=0 && [self.email.text length]!=0 && [self.mensaje.text length]!=0 && [tel length]!=0 && [fecha length]!=0 && [craftsman length]!=0 ) {
    
        NSManagedObjectContext *context = [self managedObjectContext];
        NSManagedObject *nuevoDato = [NSEntityDescription insertNewObjectForEntityForName:@"Datos" inManagedObjectContext:context];
    
        [nuevoDato setValue:self.nombre.text forKey:@"nombre"];
        [nuevoDato setValue:self.email.text forKey:@"email"];
        [nuevoDato setValue:self.mensaje.text forKey:@"mensaje"];
        [nuevoDato setValue:tel forKey:@"telefono"];
        [nuevoDato setValue:fecha forKey:@"fecha"];
        [nuevoDato setValue:craftsman forKey:@"craftsman"];
        [nuevoDato setValue:@"6" forKey:@"id"];
    
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self alerta];
    }
    
}

- (NSManagedObjectContext *)managedObjectContext{
    
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

-(void)alerta{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:@"Formato verifica los datos"
                                                   delegate:self
                                          cancelButtonTitle:@"Corregir"
                                          otherButtonTitles:nil];
    [alert show];
}

//UIPickerView
/*
 
 - (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
 {
 return 1;
 }
 
 - (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
 {
 return [dataArray count];
 }
 
 - (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
 {
 return [dataArray objectAtIndex:row];
 }
 
 -(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
 {
 self.pickerTextField.text=[dataArray objectAtIndex:row];
 }
 */

@end
