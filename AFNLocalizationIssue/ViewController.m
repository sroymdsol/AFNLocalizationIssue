//
//  ViewController.m
//  AFNLocalizationIssue
//
//  Created by Steve Roy on 2015-10-14.
//
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.label.text = NSLocalizedString(@"label_string", nil);
}

@end
