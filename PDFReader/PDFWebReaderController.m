//
//  PDFWebReaderController.m
//  PDFReaderTest
//
//  Created by lilu on 2017/5/3.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "PDFWebReaderController.h"
#import "PDFWebView.h"

@interface PDFWebReaderController ()
@property (nonatomic, weak) PDFWebView *webView;
@end

@implementation PDFWebReaderController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.titleText;
    
    PDFWebView *webView = [[PDFWebView alloc] initWithFrame:CGRectMake(10, 10, 200, 400)];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    self.webView = webView;
    
    // 创建URL
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.fileName withExtension:nil];
    // 创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 通过url加载文件
    [self.webView loadRequest:request];
}

//- (BOOL)canResignFirstResponder {
//    NSString *str = [self.webView stringFromPasteboard];
//    NSLog(@"webStr:%@", str);
//    return NO;
//}
//
//- (BOOL)canBecomeFirstResponder {
//    return YES;
//}
@end
