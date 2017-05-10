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
    [self scanMyPage];
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

#pragma mark - functions
- (void)scanMyPage {
    CGPDFPageRef myPage = CGPDFDocumentGetPage(self.pdfDocument, self.pageNumber);
    CGPDFContentStreamRef myContentStream = CGPDFContentStreamCreateWithPage(myPage);
    CGPDFOperatorTableRef myTable = [self createTable];
    CGPDFScannerRef myScanner = CGPDFScannerCreate(myContentStream, myTable, NULL);
    CGPDFScannerScan(myScanner);
    CGPDFScannerRelease(myScanner);
    CGPDFContentStreamRelease(myContentStream);
    CGPDFOperatorTableRelease(myTable);
}

- (CGPDFOperatorTableRef)createTable {
    CGPDFOperatorTableRef table = CGPDFOperatorTableCreate();
    
    CGPDFOperatorTableSetCallback (table, "MP", &op_MP);//Define marked-content point
    CGPDFOperatorTableSetCallback (table, "DP", &op_DP);//Define marked-content point with property list
    CGPDFOperatorTableSetCallback (table, "BMC", &op_BMC);//Begin marked-content sequence
    CGPDFOperatorTableSetCallback (table, "BDC", &op_BDC);//Begin marked-content sequence with property list
    CGPDFOperatorTableSetCallback (table, "EMC", &op_EMC);//End marked-content sequence
    
    //Text State operators
    CGPDFOperatorTableSetCallback(table, "Tc", &op_Tc);
    CGPDFOperatorTableSetCallback(table, "Tw", &op_Tw);
    CGPDFOperatorTableSetCallback(table, "Tz", &op_Tz);
    CGPDFOperatorTableSetCallback(table, "TL", &op_TL);
    CGPDFOperatorTableSetCallback(table, "Tf", &op_Tf);
    CGPDFOperatorTableSetCallback(table, "Tr", &op_Tr);
    CGPDFOperatorTableSetCallback(table, "Ts", &op_Ts);
    
    //text showing operators
    CGPDFOperatorTableSetCallback(table, "TJ", &op_TJ);
    CGPDFOperatorTableSetCallback(table, "Tj", &op_Tj);
    CGPDFOperatorTableSetCallback(table, "'", &op_apostrof);
    CGPDFOperatorTableSetCallback(table, "\"", &op_double_apostrof);
    
    //text positioning operators
    CGPDFOperatorTableSetCallback(table, "Td", &op_Td);
    CGPDFOperatorTableSetCallback(table, "TD", &op_TD);
    CGPDFOperatorTableSetCallback(table, "Tm", &op_Tm);
    CGPDFOperatorTableSetCallback(table, "T*", &op_T);
    
    //text object operators
    CGPDFOperatorTableSetCallback(table, "BT", &op_BT);//Begin text object
    CGPDFOperatorTableSetCallback(table, "ET", &op_ET);//End text object
    
    return table;
}

#pragma mark - mark OP
static void op_MP (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}


static void op_DP (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_BMC (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_BDC (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_EMC (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

#pragma mark - Text State operators
static void op_Tc (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
    NSLog(@"%s", __func__);
}

static void op_Tw (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_Tz (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_TL (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_Tf (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_Tr (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_Ts (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

#pragma mark - text showing operators
static void scannerPopOp(CGPDFScannerRef s, void *info) {
    
}

static void op_TJ (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_Tj (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_apostrof (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_double_apostrof (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

#pragma mark - text positioning operators
static void op_Td (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_TD (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_Tm (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_T (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

#pragma mark - text object operators
static void op_BT (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}

static void op_ET (CGPDFScannerRef s, void *info) {
    scannerPopOp(s, &info);
    NSLog(@"%s", __func__);
}
@end
