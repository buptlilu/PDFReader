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
    
    
    CGRect rect = self.view.bounds;
    rect.origin = CGPointMake(0, 120);
    MyTextView *textView = [[MyTextView alloc] initWithFrame:rect];
//    [self.view addSubview:textView];
    textView.text = @"Class PDFView is implemented in both /System/Library/PrivateFrameworks/PDFKit.framework/PDFKit (0x39213b48) and /var/containers/Bundle/Application/3C2AF707-F069-4B5B-88B6-C9AD72E8BF45/PDFReader.app/PDFReader (0xa5ad8). One of the two will be used. Which one is undefined.2017-05-05 14:52:55.551783+0800 PDFReader[1294:216100] didSelectRowAtIndexPath >>>>";
    
    [self setUpToolBtns];
    
    MyWebView *webView = [[MyWebView alloc] initWithFrame:rect];
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

- (void)setUpToolBtns {
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, self.view.bounds.size.width, 60)];
    [self.view addSubview:toolView];
    
    //上一页
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 50, 60);
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"上页" forState:UIControlStateNormal];
    [toolView addSubview:btn1];
    [btn1 addTarget:self action:@selector(btnClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    //下一页
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(50, 0, 50, 60);
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"下页" forState:UIControlStateNormal];
    [toolView addSubview:btn2];
    [btn2 addTarget:self action:@selector(btnClick2:) forControlEvents:UIControlEventTouchUpInside];
    
    //放大
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(100, 0, 50, 60);
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 setTitle:@"放大" forState:UIControlStateNormal];
    [toolView addSubview:btn3];
    [btn3 addTarget:self action:@selector(btnClick3:) forControlEvents:UIControlEventTouchUpInside];
    
    //缩小
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(150, 0, 50, 60);
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn4 setTitle:@"缩小" forState:UIControlStateNormal];
    [toolView addSubview:btn4];
    [btn4 addTarget:self action:@selector(btnClick4:) forControlEvents:UIControlEventTouchUpInside];
}

//上一页
- (void)btnClick1:(UIButton *)btn {
    [self.webView stringByEvaluatingJavaScriptFromString:@"PDFViewerApplication.page--"];
}

//下一页
- (void)btnClick2:(UIButton *)btn {
    [self.webView stringByEvaluatingJavaScriptFromString:@"PDFViewerApplication.page++"];
}

//放大
- (void)btnClick3:(UIButton *)btn {
    [self.webView stringByEvaluatingJavaScriptFromString:@"PDFViewerApplication.zoomIn()"];
}

//缩小
- (void)btnClick4:(UIButton *)btn {
    [self.webView stringByEvaluatingJavaScriptFromString:@"PDFViewerApplication.zoomOut()"];
}
@end
