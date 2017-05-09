//
//  MyWebView.h
//  PDFReader
//
//  Created by lilu on 2017/5/9.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyWebView : UIWebView

/**
 PDF file path for display
 **/
@property (readonly) NSString *filePath;

@property (readonly) NSString *searchString;

/**
 Load pdf file into web view
 **/
-(void) loadPDF:(NSString*)filePath;

/**
 Display page number of pdf file
 **/
-(void) showPage:(NSInteger*)page;

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
