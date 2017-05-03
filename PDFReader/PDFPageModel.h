//
//  PDFPageModel.h
//  PDFReader
//
//  Created by lilu on 2017/5/3.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>
@class PDFPageController;
@interface PDFPageModel : NSObject <UIPageViewControllerDataSource>
@property (nonatomic, assign) CGPDFDocumentRef pdfDocument;
- (instancetype)initWithPDFDocument:(CGPDFDocumentRef) pdfDocument;
- (PDFPageController *)viewControllerAtIndex:(NSUInteger)index;
- (NSUInteger)indexOfViewController:(PDFPageController *)viewController;
@end
