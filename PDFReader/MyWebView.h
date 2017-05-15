//
//  MyWebView.h
//  PDFReader
//
//  Created by lilu on 2017/5/9.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, YDPDFWebViewScaleType) {
    YDPDFWebViewScaleTypeDefault, //默认 值设置为1
    YDPDFWebViewScaleTypeAuto, //自动缩放 auto
    YDPDFWebViewScaleTypeActual, //实际大小 page-actual
    YDPDFWebViewScaleTypeFit, //适合界面  page-fit
    YDPDFWebViewScaleTypeWidth, //适合页宽 page-width
};
@interface MyWebView : UIWebView
/**
 scale type
 */
@property (nonatomic, assign) YDPDFWebViewScaleType type;
/**
 界面比例
 */
@property (nonatomic, assign) CGFloat scale;
/**
 放大
 */
- (void)zoomIn;
/**
 缩小
 */
- (void)zoomOut;
/**
 上一页
 */
- (void)prePage;
/**
 下一页
 */
- (void)nextPage;
/**
 转到某一页

 @param page page number
 */
- (void)showPage:(NSInteger)page;

/**
 PDF file path for display
 **/
@property (readonly) NSString *filePath;

@property (readonly) NSString *searchString;

/**
 Load pdf file into web view
 **/
- (void)loadPDF:(NSString *)filePath;

/**
 Search stirng in pdf file
 **/
-(void) search:(NSString*)searchStirng;

/**
 Search stirng in pdf file.
 \param isHighliteSearch highlite search all result
 \param isCasesensitive perform search with case sensitive
 **/
-(void) search:(NSString*)searchStirng withHighliteSearch:(BOOL)isHighliteSearch withCasesencitive:(BOOL)isCasesensitive;

/**
 Perform next search result
 **/
-(void) nextSearchResult;

/**
 Perform previous search result
 **/
-(void) previousSearchResult;

/**
 Highlte all search result
 **/
-(void) setHighliteSearch:(BOOL) isHighliteSearch;

/**
 Display result on base of case sensitive value
 **/
-(void) setCasesensitiveSearch:(BOOL) isCasesensitiveSearch;

@end
