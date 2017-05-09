//
//  PDFView.h
//  PDFReader
//
//  Created by lilu on 2017/5/3.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFView : UITextView
@property (nonatomic, assign) CGPDFDocumentRef pdfDocument;
@property (nonatomic, assign) int pageNumber;
- (instancetype)initWithFrame:(CGRect)frame page:(int)pageNumber pdfDocument:(CGPDFDocumentRef)pdfDocument;
@end
