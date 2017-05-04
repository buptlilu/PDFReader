//
//  PDFWebView.m
//  PDFReader
//
//  Created by lilu on 2017/5/4.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "PDFWebView.h"

@implementation PDFWebView

#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIMenuItem *customMenuItem1 = [[UIMenuItem alloc] initWithTitle:@"Custom 1" action:@selector(customAction1:)];
        UIMenuItem *customMenuItem2 = [[UIMenuItem alloc] initWithTitle:@"Custom 2" action:@selector(customAction2:)];
        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:customMenuItem1, customMenuItem2, nil]];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }
    return self;
}

#pragma mark - functions
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    NSLog(@"%s", __func__);
    
    if (action == @selector(_define:)) {
        return NO;
    }
    
    if (action == @selector(selectAll:)) {
        return NO;
    }
    
    if (action == @selector(customAction1:) || action == @selector(customAction2:)) {
        return YES;
    }
    
    return NO;
}

- (void)customAction1:(UIMenuItem *)item {
    NSLog(@"customAction1");
}

- (void)customAction2:(UIMenuItem *)item {
    NSLog(@"customAction2");
}
@end
