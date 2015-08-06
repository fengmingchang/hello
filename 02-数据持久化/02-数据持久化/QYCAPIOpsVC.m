//
//  QYCAPIOpsVC.m
//  02-数据持久化
//
//  Created by qingyun on 15/8/6.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYCAPIOpsVC.h"

#define kFileName   @"CAPIFile.txt"
#define BUFSIZE     256

@interface QYCAPIOpsVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) NSString *filePath;

@end

@implementation QYCAPIOpsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. 生成要保存文件的路径
    [self miscInit];
    
    // 2. 读取文件内容并更新到textField上
    [self loadData];
}

- (void)miscInit
{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _filePath = [docPath stringByAppendingPathComponent:kFileName];
}

- (void)loadData
{
    // 1. 打开文件
    const char *path = [_filePath UTF8String];
    FILE *fp = fopen(path, "r");
    if (fp == NULL) {
        perror("fopen");
        return;
    }
    
    // 2. 读取文件
    // 2.1 计算文件大小
    fseek(fp, 0, SEEK_END);
    long size = ftell(fp);
    
    // 2.2 读取文件
    rewind(fp); // 偏移文件指针到文件开始
    char buf[BUFSIZE] = {0};
    size_t count = fread(buf, size, 1, fp);
    
    // 3. 更新TextField
    if (count > 0) {
        _textField.text = [NSString stringWithUTF8String:buf];
    }
    
    // 4. 关闭文件
    fclose(fp);
}

- (IBAction)saveData:(UIBarButtonItem *)sender {
    
    // 1. 打开文件
    const char *path = [_filePath UTF8String];
    FILE *fp = fopen(path, "w+");
    if (fp == NULL) {
        perror("fopen");
        return;
    }

    
    // 2. 将textField的内容写入到文件
    NSString *content = _textField.text;
    
    size_t count = fwrite([content UTF8String], content.length, 1, fp);
    if (count > 0) {
        NSLog(@"保存文件成功!");
    }
    
    // 3. 关闭文件
    fclose(fp);
}


- (IBAction)textFieldDidEndOnExit:(UITextField *)sender {
    [sender resignFirstResponder];
}

@end
