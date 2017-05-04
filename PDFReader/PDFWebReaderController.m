//
//  PDFWebReaderController.m
//  PDFReaderTest
//
//  Created by lilu on 2017/5/3.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "PDFWebReaderController.h"

@interface PDFWebReaderController ()
@property (nonatomic, weak) UIWebView *webView;
@end

@implementation PDFWebReaderController

#pragma mark - life cycle
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIMenuItem *customMenuItem1 = [[UIMenuItem alloc] initWithTitle:@"Custom 1" action:@selector(customAction1:)];
    UIMenuItem *customMenuItem2 = [[UIMenuItem alloc] initWithTitle:@"Custom 2" action:@selector(customAction2:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:customMenuItem1, customMenuItem2, nil]];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[UIMenuController sharedMenuController] setMenuItems:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleText;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    self.webView = webView;
    
    // 创建URL
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.fileName withExtension:nil];
    
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 通过url加载文件
    [self.webView loadRequest:request];
}

#pragma mark - functions
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(_define:)) {
        return NO;
    }
    if (action == @selector(selectAll:)) {
        return YES;
    }
    
    if ([self.webView isFirstResponder]) {
        if (action == @selector(customAction1:) || action == @selector(customAction2:)) {
            return YES;
        }
    }
    
    return [super canPerformAction:action withSender:sender];
}

- (void)customAction1:(UIMenuItem *)item {
    NSLog(@"customAction1");
}

- (void)customAction2:(UIMenuItem *)item {
    NSLog(@"customAction2");
}
@end
