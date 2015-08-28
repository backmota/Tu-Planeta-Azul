//
//  SecondViewController.m
//  Tu Planeta Azul
//
//  Created by José Juan Mota Torres on 26/08/15.
//  Copyright (c) 2015 José Juan Mota Torres. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController (){
    int numid;
    NSData *datatemp;
    NSString *idmasgrande;
    NSMutableArray *idsarray;
}
@end

@implementation SecondViewController
@synthesize nombre,email,telefono,mensaje,opcionesSegm;
@synthesize fetchedResultsController, managedObjectContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //------- codigo para cargar el JSON
    mensaje.scrollEnabled = YES;
    mensaje.text = @"Mensaje";
    mensaje.textColor = [UIColor lightGrayColor];
    mensaje.delegate = self;
    mensaje.layer.borderWidth = 1.0f;
    mensaje.layer.borderColor = [[UIColor grayColor] CGColor];
    /*
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
                                                        
                                                        
                                                        NSArray *jsonDataArray = [[NSArray alloc] initWithArray:
                                                                                  [NSJSONSerialization JSONObjectWithData:data
                                                                                                                  options:NSJSONReadingMutableContainers error:&error]];
                                                        
                                                        //obtenemos los elementos de tipo "user_id"
                                                        for (int p=0; p<jsonDataArray.count; p++) {
                                                            NSDictionary *dictObject = [jsonDataArray objectAtIndex:p]; //los agregamos a un dictionary
                                                            NSLog(@"%@",[dictObject valueForKey:@"user_id"]);
                                                            
                                                            //llenamos un array con los puros ids
                                                            idsarray = [[NSMutableArray alloc]init];
                                                            [idsarray addObject:[dictObject valueForKey:@"user_id"]];
                                                            
                                                        }
                                                    
     
                                                        for (int a=0; a<idsarray.count; a++) {
                                                            NSLog(@"Elementos del array: %@",idsarray[a]);
                                                        }
                                                        
                                                        //NSLog(@"\n id mas grande: %@",idmasgrande);
                                                       
                                                        NSLog(@"\n ---------------- \n");
                                                        NSLog(@"\n %@", json_string);
                                                      //  NSLog(@"%@",[datosdelJson ]);
                                                       // NSLog(@"surv_id: %@",[datosdelJson objectForKey:@"surv_id"]);
                                                   }
                                                }];
    [dataTask resume];
    
    
    */
    
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView {
    mensaje.text = @"";
    mensaje.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView{
    
    if(mensaje.text.length == 0){
        mensaje.textColor = [UIColor lightGrayColor];
        mensaje.text = @"Mensaje";
        [mensaje resignFirstResponder];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    self.nombre.text = @"";
    self.email.text = @"";
    self.telefono.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)Guardar:(id)sender {

    //----->  fecha del sistema
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    //pasando la fecha a tipo string
    NSString *fecha = [dateFormatter stringFromDate:[NSDate date]];

    //------>  vendedor o comprador
    NSInteger opcionelegida = opcionesSegm.selectedSegmentIndex;
   
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
       
        //guardar el objeto
        if (![context save:&error]) {
            NSLog(@"No se pudo guardar! %@ %@", error, [error localizedDescription]);
        }
    
        [self dismissViewControllerAnimated:YES completion:nil];
        [self limpiar];
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

-(void)limpiar{
    self.nombre.text = @"";
    self.email.text = @"";
    self.telefono.text = @"";
    self.mensaje.text = @"";
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
