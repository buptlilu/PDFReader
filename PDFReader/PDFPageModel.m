//
//  PDFPageModel.m
//  PDFReader
//
//  Created by lilu on 2017/5/3.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "PDFPageModel.h"
#import "PDFPageController.h"

@interface PDFPageModel ()

@end

@implementation PDFPageModel
#pragma mark - init
- (instancetype)initWithPDFDocument:(CGPDFDocumentRef)pdfDocument {
    self = [super init];
    if (self) {
        self.pdfDocument = pdfDocument;
    }
    return self;
}

#pragma mark - functions
- (PDFPageController *)viewControllerAtIndex:(NSUInteger)index {
    // Return the data view controller for the given index.
    long pageSum = CGPDFDocumentGetNumberOfPages(self.pdfDocument);
    if (pageSum== 0 || index >= pageSum+1) {
        return nil;
    }
    // Create a new view controller and pass suitable data.
    PDFPageController *pageController = [[PDFPageController alloc] init];
    pageController.pdfDocument = self.pdfDocument;
    pageController.pageNumber  = index;
    return pageController;
}

- (NSUInteger)indexOfViewController:(PDFPageController *)viewController {
    return viewController.pageNumber;
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController: (PDFPageController *)viewController];
    if ((index == 1) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController: (PDFPageController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    long pageSum = CGPDFDocumentGetNumberOfPages(self.pdfDocument);
    if (index >= pageSum + 1) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


@end
