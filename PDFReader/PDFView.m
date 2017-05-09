//
//  PDFView.m
//  PDFReader
//
//  Created by lilu on 2017/5/3.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "PDFView.h"

@implementation PDFView
#pragma mark - init
- (instancetype)initWithFrame:(CGRect)frame page:(int)pageNumber pdfDocument:(CGPDFDocumentRef)pdfDocument {
    self = [super initWithFrame:frame];
    self.pageNumber = pageNumber;
    self.pdfDocument = pdfDocument;
    return self;
}

#pragma mark - touch event
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    
    // 当前触摸点
    CGPoint currentPoint = [touch locationInView:self.superview];
    NSLog(@"point(%g, %g)", currentPoint.x, currentPoint.y);
}

#pragma mark - override
- (void)drawInContext:(CGContextRef)context atPageNo:(int)page_no{
    // PDF page drawing expects a Lower-Left coordinate system, so we flip the coordinate system
    // before we start drawing.
    CGContextTranslateCTM(context, 0.0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    if (self.pageNumber == 0) {
        self.pageNumber = 1;
    }
    CGPDFPageRef page = CGPDFDocumentGetPage(self.pdfDocument, self.pageNumber);
    CGContextSaveGState(context);
    CGAffineTransform pdfTransform = CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, self.bounds, 0, true);
    CGContextConcatCTM(context, pdfTransform);
    CGContextDrawPDFPage(context, page);
    CGContextRestoreGState(context);
}

- (void)drawRect:(CGRect)rect {
    [self drawInContext:UIGraphicsGetCurrentContext() atPageNo:self.pageNumber];
}
@end
