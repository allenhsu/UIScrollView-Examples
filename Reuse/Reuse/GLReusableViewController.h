//
//  GLResuableViewController.h
//  Reuse
//
//  Created by Allen Hsu on 12/14/14.
//  Copyright (c) 2014 Glow, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GLReusableViewController : UIViewController

@property (assign, nonatomic) NSInteger numberOfInstance;
@property (assign, nonatomic) NSNumber *page;

- (void)reloadData;
+ (instancetype)viewControllerFromStoryboard;

@end
