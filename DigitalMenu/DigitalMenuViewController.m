//
//  DigitalMenuViewController.m
//  DigitalMenu
//
//  Created by Stanislav Pak on 16.06.13.
//  Copyright (c) 2013 Stanislav Pak. All rights reserved.
//

#import "DigitalMenuViewController.h"

@interface DigitalMenuViewController ()

@end

@implementation DigitalMenuViewController

@synthesize userName = _userName;
@synthesize gTitle = _gTitle;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)showRestaurants:(id)sender {
    self.userName = self.nameField.text;
    NSString *nameString = self.userName;
    if ([nameString length] == 0) {
        nameString = @"World";
    }
    NSString *greeting = [[NSString alloc] initWithFormat:@"Hello, %@!", nameString];
    self.gTitle.text = greeting;
}


- (BOOL) textFieldShouldReturn:(UITextField *) theTextField {
    if (theTextField == self.nameField) {
        [theTextField resignFirstResponder];
    }
    return YES;
}

@end
