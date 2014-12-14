//
//  GLResuableViewController.m
//  Reuse
//
//  Created by Allen Hsu on 12/14/14.
//  Copyright (c) 2014 Glow, Inc. All rights reserved.
//

#import "GLReusableViewController.h"

@interface GLReusableViewController ()
@property (weak, nonatomic) IBOutlet UILabel *instanceNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation GLReusableViewController

+ (instancetype)viewControllerFromStoryboard
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ReusableViewController"];
}

- (void)setPage:(NSNumber *)page
{
    if (_page != page) {
        _page = page;
        [self reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reloadData];
}

- (void)reloadData
{
    self.titleLabel.text = [NSString stringWithFormat:@"Page #%@", self.page];
    self.instanceNumberLabel.text = [NSString stringWithFormat:@"Instance #%ld", self.numberOfInstance];
}

@end
