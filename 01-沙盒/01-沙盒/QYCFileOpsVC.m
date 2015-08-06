//
//  QYCFileOpsVC.m
//  01-沙盒
//
//  Created by qingyun on 15/8/6.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYCFileOpsVC.h"

#define kFileName   @"CAPIFile.txt"

@interface QYCFileOpsVC ()
@property (nonatomic, strong) NSString *filePath;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation QYCFileOpsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self miscInit];

    // 从文件读取数据，并更新到textField上
    [self loadData];
}

- (void)miscInit
{

    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _filePath = [docPath stringByAppendingPathComponent:kFileName];
    NSLog(@"%@", _filePath);
}

- (IBAction)textFieldDidEndOnExit:(UITextField *)sender {
    [sender resignFirstResponder];
}

// 读
- (void)loadData
{
    // 1. 打开文件
    const char *path = [_filePath UTF8String];
    FILE *fp = fopen(path, "r");
    if (fp == NULL) {
        perror("fopen");
        return;
    }
    
    // 2. 读取文件内容
    // 将来存放读取到的数据
    char buf[BUFSIZ] = {0};
    
    // 2.1 计算文件大小
    // 偏移到文件最后
    fseek(fp, 0, SEEK_END);
    long size = ftell(fp);
    
    // 2.2 读取文件
    rewind(fp); // 文件指针偏移到文件开始
    size_t count = fread(buf, size, 1, fp);
    
    // 3. 更新textField
    if (count > 0) {
        _textField.text = [NSString stringWithUTF8String:buf];
    }
    
    // 4. 关闭文件
    fclose(fp);
}

// 写
- (IBAction)saveData:(UIBarButtonItem *)sender {
    
    // 1. 打开文件
    const char *path = [_filePath UTF8String];
    FILE *fp = fopen(path, "w+");
    if (fp == NULL) {
        perror("fopen");
        return;
    }
    
    // 2. 将textField的内容写入到文件
    // 2.1 取出内容
    NSString *content = _textField.text;
    
    // 2.2 写入文件
    size_t count = fwrite([content UTF8String], content.length, 1, fp);
    if (count > 0) {
        NSLog(@"文件保存成功!");
    }
    
    // 3. 关闭文件
    fclose(fp);
}


@end
