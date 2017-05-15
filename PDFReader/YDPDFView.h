//
//  YDPDFView.h
//  PDFReader
//
//  Created by lilu on 2017/5/15.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDPDFView : UIView
@property (nonatomic, assign) CGPDFDocumentRef pdfDocument;
@property (nonatomic, assign) int pageNumber;
- (instancetype)initWithFrame:(CGRect)frame page:(int)pageNumber pdfDocument:(CGPDFDocumentRef)pdfDocument;
@end
