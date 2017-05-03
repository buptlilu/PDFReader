//
//  PDFPageController.m
//  PDFReader
//
//  Created by lilu on 2017/5/3.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "PDFPageController.h"
#import "PDFView.h"

@interface PDFPageController ()

@end

@implementation PDFPageController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    PDFView *view = [[PDFView alloc] initWithFrame:self.view.bounds page:self.pageNumber pdfDocument:self.pdfDocument];
    [self.view addSubview:view];
}

@end
