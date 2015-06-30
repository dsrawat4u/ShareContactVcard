//
//  ViewController.h
//  ShareContactVcard
//
//  Created by spice on 29/06/15.
//  Copyright (c) 2015 SpiceDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    UINavigationController *navigationViewController;
    
}
-(IBAction)showCard:(id)sender;
-(IBAction)generateCard:(id)sender;

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)NSString *pathToFile;
@property(nonatomic,retain)NSString * name;
@property(nonatomic,retain)NSString * phone;
@property(atomic)float latitudeValue;
@property(atomic)float longitudeValue;
@property(nonatomic,retain)NSString * website;
@end
