                                                                                  //
//  QYOCFileOpsVC.m
//  02-数据持久化
//
//  Created by qingyun on 15/8/6.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYOCFileOpsVC.h"

#define kFileName   @"OCFileAPIs.txt"

@interface QYOCFileOpsVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSString *filePath;
@end

@implementation QYOCFileOpsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 初始化文件路径
    [self miscInit];
    
    // 2. 读取文件
    [self loadData];
    
}

- (void)miscInit
{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    /** 在Documents目录下，创建一个test目录，
     *  并在里面创建OCFileAPIs.txt文件，用来保存textField的数据
     */
    // 1. 获取文件管理器duixiang
    NSFileManager *manager = [NSFileManager defaultManager];
    
    // 2. 创建文件夹
    NSString *testDirectory = [docPath stringByAppendingPathComponent:@"test"];
    NSError *error;
    [manager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:0 error:&error];
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    
    // 3. 创建文件
    _filePath = [testDirectory stringByAppendingPathComponent:kFileName];
    if (![manager fileExistsAtPath:_filePath]) {
        [manager createFileAtPath:_filePath contents:nil attributes:0];
        NSLog(@"%@", _filePath);
    }
}

// 读操作
- (void)loadData
{
    NSError *error;
    _textField.text = [[NSString alloc] initWithContentsOfFile:_filePath encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%@", error);
        return;
    }
}

// 写操作
- (IBAction)saveData:(UIBarButtonItem *)sender {
    NSString *content = _textField.text;
    
    NSError *error;
    [content writeToFile:_filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if (error) {
        NSLog(@"%@", error);
        return;
    }
    
    NSLog(@"保存成功!");
}

- (IBAction)textFieldDidEndOnExit:(UITextField *)sender {
    [sender resignFirstResponder];
}

@end




















