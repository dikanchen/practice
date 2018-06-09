//
//  ViewController.m
//  Practice
//
//  Created by Dikan Chen on 6/9/18.
//  Copyright © 2018 Dikan Chen. All rights reserved.
//

#import "ViewController.h"

#import "TableViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

@synthesize tag;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchTapped:(id)sender {
    tag = self.textField.text;
    [self performSegueWithIdentifier:@"segue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"segue"]){
        TableViewController *vc = [segue destinationViewController];
        vc.store = tag;
    }
}

@end
