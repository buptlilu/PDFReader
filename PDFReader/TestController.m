//
//  TestController.m
//  PDFReader
//
//  Created by lilu on 2017/5/5.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "TestController.h"
#import "MyTextView.h"
#import "MyWebView.h"

@interface TestController ()
@property (nonatomic, strong) MyWebView *webView;
@end

@implementation TestController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyTextView *textView = [[MyTextView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:textView];
    textView.text = @"Class PDFView is implemented in both /System/Library/PrivateFrameworks/PDFKit.framework/PDFKit (0x39213b48) and /var/containers/Bundle/Application/3C2AF707-F069-4B5B-88B6-C9AD72E8BF45/PDFReader.app/PDFReader (0xa5ad8). One of the two will be used. Which one is undefined.2017-05-05 14:52:55.551783+0800 PDFReader[1294:216100] didSelectRowAtIndexPath >>>>";
    
    MyWebView *webView = [[MyWebView alloc] initWithFrame:self.view.bounds];
    self.webView = webView;
    [self.view addSubview:webView];
//    [webView loadHTMLString:textView.text baseURL:nil];
//    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    NSString *pdfFilePath = [[NSBundle mainBundle] pathForResource:@"compressed.tracemonkey-pldi-09" ofType:@"pdf"];
    pdfFilePath = [[NSBundle mainBundle] pathForResource:@"002" ofType:@"pdf"];
    pdfFilePath = [[NSBundle mainBundle] pathForResource:self.fileName ofType:nil];
    [webView loadPDF:pdfFilePath];

//    [webView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:self.fileName withExtension:nil]]];
}
@end
