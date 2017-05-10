//
//  MyWebView.m
//  PDFReader
//
//  Created by lilu on 2017/5/9.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "MyWebView.h"

@interface MyWebView ()
{
    BOOL _isCasesensitive;
    BOOL _isHighliteSearch;
    
    // Contain search string which will searched after pdf file is loaded
    NSString *searchAfterLoad;
}
@end

@implementation MyWebView


-(void) loadPDF:(NSString*)filePath
{
    // Assign new file path to the property
    _filePath = filePath;
    
    NSString *sPath = [[NSBundle mainBundle] pathForResource:@"viewer" ofType:@"html" inDirectory:@"PDFJS/web"];
    NSString *finalPath = [NSString stringWithFormat:@"%@?file=%@#page=1",sPath,filePath];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:finalPath]];
    [self loadRequest:request];
}

/**
 Display page number of pdf file
 **/
-(void) showPage:(NSInteger*)page
{
    NSString *sPath = [[NSBundle mainBundle] pathForResource:@"viewer" ofType:@"html" inDirectory:@"PDFJS/web"];
    NSString *finalPath = [NSString stringWithFormat:@"%@?file=%@#page=%d",sPath,_filePath,(int)page];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:finalPath]];
    [self loadRequest:request];
}

#pragma mark - Search related function
/**
 Search stirng in pdf file
 **/
-(void) search:(NSString*)searchStirng
{
    [self search:searchStirng withHighliteSearch:NO withCasesencitive:NO];
}

/**
 Search stirng in pdf file.
 \param isHighliteSearch highlite search all result
 \param isCasesensitive perform search with case sensitive
 **/
-(void) search:(NSString*)searchStirng withHighliteSearch:(BOOL)isHighliteSearch withCasesencitive:(BOOL)isCasesensitive
{
    _isHighliteSearch = isHighliteSearch;
    _isCasesensitive = isCasesensitive;
    _searchString = searchStirng;
    NSString *javaScript = [NSString stringWithFormat:@"var event = document.createEvent('CustomEvent');event.initCustomEvent('find', true, true, {query: '%@',caseSensitive: %@,highlightAll: %@,findPrevious:false});window.dispatchEvent(event);",_searchString,_isCasesensitive?@"true":@"false",_isHighliteSearch?@"true":@"false"];
    
    [self stringByEvaluatingJavaScriptFromString:javaScript];
}

/**
 Perform next search result
 **/
-(void) nextSearchResult
{
    NSString *javaScript = [NSString stringWithFormat:@"var event = document.createEvent('CustomEvent');event.initCustomEvent('findagain', true, true, {query: '%@',caseSensitive: %@,highlightAll: %@,findPrevious:false});window.dispatchEvent(event);",_searchString,_isCasesensitive?@"true":@"false",_isHighliteSearch?@"true":@"false"];
    
    [self stringByEvaluatingJavaScriptFromString:javaScript];
}

/**
 Perform previous search result
 **/
-(void) previousSearchResult
{
    NSString *javaScript = [NSString stringWithFormat:@"var event = document.createEvent('CustomEvent');event.initCustomEvent('findagain', true, true, {query: '%@',caseSensitive: %@,highlightAll: %@,findPrevious:true});window.dispatchEvent(event);",_searchString,_isCasesensitive?@"true":@"false",_isHighliteSearch?@"true":@"false"];
    [self stringByEvaluatingJavaScriptFromString:javaScript];
}

/**
 Highlte all search result
 **/
-(void) setHighliteSearch:(BOOL) isHighliteSearch
{
    _isHighliteSearch = isHighliteSearch;
}

/**
 Display result on base of case sensitive value
 **/
-(void) setCasesensitiveSearch:(BOOL) isCasesensitive
{
    _isCasesensitive = isCasesensitive;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIMenuItem *customMenuItem1 = [[UIMenuItem alloc] initWithTitle:@"查词" action:@selector(customAction1:)];
        UIMenuItem *customMenuItem2 = [[UIMenuItem alloc] initWithTitle:@"翻译" action:@selector(customAction2:)];
        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:customMenuItem1, customMenuItem2, nil]];
//        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerWillShow:) name:UIMenuControllerWillShowMenuNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuControllerDidShow:) name:UIMenuControllerDidShowMenuNotification object:nil];
    }
    return self;
}

#pragma mark - UIMenuControllerWillShowMenuNotification
- (void)menuControllerWillShow:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    UIMenuController *menuVc = (UIMenuController *)note.object;
    CGRect rect = [[menuVc valueForKey:@"_targetRect"] CGRectValue];
    NSLog(@"note:%@", note);
    NSLog(@"userInfo:%@", userInfo);
}

- (void)menuControllerDidShow:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    UIMenuController *menuVc = (UIMenuController *)note.object;
    CGRect rect = [[menuVc valueForKey:@"_targetRect"] CGRectValue];
    NSLog(@"note:%@", note);
    NSLog(@"userInfo:%@", userInfo);
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    NSLog(@"%@", NSStringFromSelector(action));
    
    if (action == @selector(customAction1:)) {
        return YES;
    }
    
    if (action == @selector(customAction2:)) {
        return YES;
    }

    if (action == @selector(copy:)) {
        return YES;
    }
    
    if (action == @selector(selectAll:)) {
        return YES;
    }
    
    return NO;
//    if (action == @selector(flag:)) {
//        return YES;
//    }
    return [super canPerformAction:action withSender:sender];
}

- (void)customAction1:(UIMenuItem *)item {
    NSString *str = [self stringFromPasteboard];
    NSLog(@"customAction1");
    NSLog(@"res:%@", str);
}

- (void)customAction2:(UIMenuItem *)item {
    NSLog(@"customAction2");
}

- (NSString *)stringFromPasteboard {
    NSString *tempStr = [UIPasteboard generalPasteboard].string;
    [[UIApplication sharedApplication] sendAction:@selector(copy:) to:nil from:self forEvent:nil];
    NSLog(@"frame:%@", NSStringFromCGRect([UIMenuController sharedMenuController].menuFrame));
    NSString *str = [UIPasteboard generalPasteboard].string;
    [UIPasteboard generalPasteboard].string = tempStr;
    return str;
}
@end
