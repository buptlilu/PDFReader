//
//  PDFPageController.m
//  PDFReader
//
//  Created by lilu on 2017/5/3.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "PDFPageController.h"
#import "YDPDFView.h"

@interface PDFPageController ()

@end

@implementation PDFPageController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    YDPDFView *view = [[YDPDFView alloc] initWithFrame:self.view.bounds page:self.pageNumber pdfDocument:self.pdfDocument];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
}

@end
