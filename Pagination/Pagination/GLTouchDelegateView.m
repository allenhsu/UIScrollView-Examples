//
//  GLTouchDelegateView.m
//  Pagination
//
//  Created by Allen Hsu on 12/14/14.
//  Copyright (c) 2014 Glow, Inc. All rights reserved.
//

#import "GLTouchDelegateView.h"

@implementation GLTouchDelegateView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.touchDelegateView && [self pointInside:point withEvent:event]) {
        CGPoint newPoint = [self convertPoint:point toView:self.touchDelegateView];
        UIView *test = [self.touchDelegateView hitTest:newPoint withEvent:event];
        if (test) {
            return test;
        } else {
            return self.touchDelegateView;
        }
    }
    return [super hitTest:point withEvent:event];
}

@end