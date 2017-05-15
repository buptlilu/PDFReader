//
//  PDFListController.m
//  PDFReader
//
//  Created by lilu on 2017/5/3.
//  Copyright © 2017年 lilu. All rights reserved.
//

#import "PDFListController.h"
#import "PDFWebReaderController.h"
#import "PDFReaderController.h"
#import "PDFWebReaderController.h"
#import "TestController.h"
#import <QuickLook/QuickLook.h>

@interface PDFListController ()<UITableViewDelegate, UITableViewDataSource, QLPreviewControllerDataSource>
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *fileArray;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation PDFListController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = @[@"iOS 开发笔记——PDF的显示和浏览",@"Objective-C和CoreFoundation对象相互转换的内存管理总结",@"HTML5从入门到精通", @"git搭建", @"Kurt the Cat.pdf", @"git搭建未改动.pdf", @"Pride and Prejudice.pdf"];
    self.fileArray = @[@"001.pdf", @"002.pdf",  @"003.pdf", @"gitdajian.pdf", @"Kurt the Cat.pdf", @"gittest.pdf", @"Pride and Prejudice.pdf"];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

#pragma mark - QLPreviewControllerDataSource
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller {
    return 1;
}
- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index {
    NSString *fileName = [self.fileArray objectAtIndex:self.indexPath.row];
    NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    return url;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"didSelectRowAtIndexPath >>>> ");
    
    if (indexPath.section == 0) {
        PDFWebReaderController *vc = [[PDFWebReaderController alloc] init];
        vc.titleText = [self.titleArray objectAtIndex:indexPath.row];
        vc.fileName =  [self.fileArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 1) {
        PDFReaderController *vc = [[PDFReaderController alloc] init];
        vc.titleText = [self.titleArray objectAtIndex:indexPath.row];
        vc.fileName =  [self.fileArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 2) {
        QLPreviewController *vc = [[QLPreviewController alloc] init];
        self.indexPath = indexPath;
        vc.dataSource = self;
        vc.title = [self.titleArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section == 3) {
        TestController *vc = [[TestController alloc] init];
        vc.fileName = [self.fileArray objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"UIWebView";
            break;
        case 1:
            return @"CGPDFDocumentRef";
        case 2:
            return @"QLPreviewController";
        case 3:
            return @"HTML";
        default:
            break;
    }
    return @"Others";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 52;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    NSString *titleText = [self.titleArray objectAtIndex:indexPath.row];
    cell.textLabel.text = titleText;
    return cell;
}
@end
