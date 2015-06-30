//
//  ViewController.m
//  ShareContactVcard
//
//  Created by spice on 29/06/15.
//  Copyright (c) 2015 SpiceDigital. All rights reserved.
//

#import "ViewController.h"
#import "vCardSerialization.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize latitudeValue,longitudeValue;
@synthesize pathToFile;

- (void)viewDidLoad
{
    self.name=@"Deepak";
    self.phone=@"9212138007";
    latitudeValue=37.00;
    longitudeValue=27.00;
    self.website=@"www.github.com/dsrawat4u";
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


- (NSString *)vCardRepresentation
{
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    
    [mutableArray addObject:@"BEGIN:VCARD"];
    [mutableArray addObject:@"VERSION:3.0"];
    
    [mutableArray addObject:[NSString stringWithFormat:@"FN:%@", self.name]];
    
    
    [mutableArray addObject:[NSString stringWithFormat:@"EMAIL;type=INTERNET;type=WORK:%@", @"dsrawat4u@gmail.com"]];

    [mutableArray addObject:[NSString stringWithFormat:@"X-SOCIALPROFILE;type=twitter:http://twitter.com/%@",@"dsrawat4u"]];
    [mutableArray addObject:[NSString stringWithFormat:@"BDAY:%@",@"1987-03-17"]];

    


    
    
   // [mutableArray addObject:[NSString stringWithFormat:@"ADR:;;%@",
                    //         [self addressWithSeparator:@";"]]];
    
    if (self.phone != nil)
        [mutableArray addObject:[NSString stringWithFormat:@"TEL:%@", self.phone]];
    
    [mutableArray addObject:[NSString stringWithFormat:@"GEO:%f;%f",
                            latitudeValue, longitudeValue]];
    
    [mutableArray addObject:[NSString stringWithFormat:@"URL:http://%@",
                             self.website]];
    
    [mutableArray addObject:@"END:VCARD"];
    
    NSString *string = [mutableArray componentsJoinedByString:@"\n"];
    
    //[mutableArray release];
    
    return string;
    
   
    
}

-(IBAction)generateCard:(id)sender
{
    //NSLog(@"return string=%@",[self vCardRepresentation]);
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentDirectory=[paths objectAtIndex:0];
     pathToFile = [NSString stringWithFormat:@"%@/%@", documentDirectory,@"ContactList.vcf"];
    [[self vCardRepresentation] writeToFile:pathToFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
   // NSLog(@"strBackupFileLocation=%@",strBackupFileLocation);
    
  
}

-(IBAction)showCard:(id)sender
{
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@", pathToFile];
   // NSURL *getURL = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    //NSData *data = [NSData dataWithContentsOfURL:getURL];
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:urlString];

    NSArray *records = [vCardSerialization addressBookRecordsWithVCardData:data error:nil];
    ABPersonViewController *viewController = [[ABPersonViewController alloc] init];
    viewController.displayedPerson = (__bridge ABAddressBookRef)[records firstObject];
    navigationViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
   
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] initWithTitle:@"Detail"];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    
    [button setImage:[UIImage imageNamed:@"plain.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]
                                   initWithCustomView:button];
    
    navigationItem.leftBarButtonItem = buttonItem;

    //now present this navigation controller modally
    [self presentViewController:navigationViewController
                       animated:YES
                     completion:^{
                         
                     }];

}

-(void)viewWillAppear:(BOOL)animated
{
   
    
}
-(void)buttonClicked
{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
