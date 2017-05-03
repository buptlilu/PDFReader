//
//  PDFPageController.h
//  PDFReader
//
//  Created by lilu on 2017/5/3.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PDFPageController : UIViewController
@property (nonatomic, assign) CGPDFDocumentRef pdfDocument;
@property (nonatomic, assign) long pageNumber;

@end
