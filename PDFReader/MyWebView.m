//
//  MyWebView.m
//  PDFReader
//
//  Created by lilu on 2017/5/9.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "MyWebView.h"

@implementation MyWebView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIMenuItem *customMenuItem1 = [[UIMenuItem alloc] initWithTitle:@"查词" action:@selector(customAction1:)];
        UIMenuItem *customMenuItem2 = [[UIMenuItem alloc] initWithTitle:@"翻译" action:@selector(customAction2:)];
        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:customMenuItem1, customMenuItem2, nil]];
//        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillShow:) name:UIMenuControllerWillShowMenuNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerDidShow:) name:UIMenuControllerDidShowMenuNotification object:nil];
    }
    return self;
}

#pragma mark - UIMenuControllerWillShowMenuNotification
- (void)menuControllerWillShow:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    UIMenuController *menuVc = (UIMenuController *)note.object;
    CGRect rect = [[menuVc valueForKey:@"_targetRect"] CGRectValue];
    NSLog(@"note:%@", note);
    NSLog(@"userInfo:%@", userInfo);
}

- (void)menuControllerDidShow:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    UIMenuController *menuVc = (UIMenuController *)note.object;
    CGRect rect = [[menuVc valueForKey:@"_targetRect"] CGRectValue];
    NSLog(@"note:%@", note);
    NSLog(@"userInfo:%@", userInfo);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(customAction1:)) {
        return YES;
    }
    
    if (action == @selector(customAction2:)) {
        return YES;
    }
    
    return NO;
    
    if (action == @selector(_define:)) {
        return NO;
    }
    if (action == @selector(selectAll:)) {
        return NO;
    }
//    if (action == @selector(flag:)) {
//        return YES;
//    }
    return [super canPerformAction:action withSender:sender];
}

@end
