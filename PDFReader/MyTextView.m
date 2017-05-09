//
//  MyTextView.m
//  PDFReader
//
//  Created by lilu on 2017/5/9.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copy:)) {
        return NO;
    }
    return [super canPerformAction:action withSender:sender];
}

@end
