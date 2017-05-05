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
+ (void)initialize {
    UIMenuItem *customMenuItem1 = [[UIMenuItem alloc] initWithTitle:@"查词" action:@selector(customAction1:)];
    UIMenuItem *customMenuItem2 = [[UIMenuItem alloc] initWithTitle:@"翻译" action:@selector(customAction2:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:customMenuItem1, customMenuItem2, nil]];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        UIMenuItem *customMenuItem1 = [[UIMenuItem alloc] initWithTitle:@"Custom 1" action:@selector(customAction1:)];
//        UIMenuItem *customMenuItem2 = [[UIMenuItem alloc] initWithTitle:@"Custom 2" action:@selector(customAction2:)];
//        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:customMenuItem1, customMenuItem2, nil]];
//        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillShow:) name:UIMenuControllerWillShowMenuNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerDidShow:) name:UIMenuControllerDidShowMenuNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerWillShowMenuNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIMenuControllerDidShowMenuNotification object:nil];
}

#pragma mark - UIMenuControllerWillShowMenuNotification
- (void)menuControllerWillShow:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    UIMenuController *menuVc = (UIMenuController *)note.object;
    [menuVc setMenuVisible:NO animated:NO];
    CGRect rect = [[menuVc valueForKey:@"_targetRect"] CGRectValue];
    NSLog(@"note:%@", note);
    NSLog(@"userInfo:%@", userInfo);
}

- (void)menuControllerDidShow:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    UIMenuController *menuVc = (UIMenuController *)note.object;
//    [menuVc setMenuVisible:NO animated:NO];
    CGRect rect = [[menuVc valueForKey:@"_targetRect"] CGRectValue];
    NSLog(@"note:%@", note);
    NSLog(@"userInfo:%@", userInfo);
}

#pragma mark - UIResponderStandardEditActions
- (void)copy:(id)sender {
    NSLog(@"%@", NSStringFromClass([sender class]));
    [super copy:sender];
}

#pragma mark - functions
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    NSLog(@"%s", __func__);
    
    if (action == @selector(copy:)) {
        return NO;
    }
    
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
    NSString *tempStr = [UIPasteboard generalPasteboard].string;
    [[UIApplication sharedApplication] sendAction:@selector(copy:) to:nil from:self forEvent:nil];
    NSLog(@"frame:%@", NSStringFromCGRect([UIMenuController sharedMenuController].menuFrame));
    NSString *str = [UIPasteboard generalPasteboard].string;
    [UIPasteboard generalPasteboard].string = tempStr;
    NSLog(@"customAction1");
    NSLog(@"res:%@", str);
}

- (void)customAction2:(UIMenuItem *)item {
    NSLog(@"customAction2");
}
@end
