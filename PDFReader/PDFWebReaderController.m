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
@end
