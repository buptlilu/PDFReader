//
//  PDFReaderController.h
//  PDFReader
//
//  Created by lilu on 2017/5/3.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PDFPageModel;
@interface PDFReaderController : UIViewController
@property (nonatomic, strong) UIPageViewController *pageVc;
@property (nonatomic, strong) PDFPageModel *model;
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *fileName;
@end
