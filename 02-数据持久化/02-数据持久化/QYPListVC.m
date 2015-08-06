//
//  QYPListVC.m
//  02-数据持久化
//
//  Created by qingyun on 15/8/6.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "QYPListVC.h"

#define kFileName   @"QYPlist.plist"

@interface QYPListVC ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) NSString *filePath;
@end

@implementation QYPListVC

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. 初始化文件路径
    [self miscInit];
    
    // 2. 读取文件内容
    [self loadData];
}

- (void)miscInit
{
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    _filePath = [docPath stringByAppendingPathComponent:kFileName];
    NSLog(@"%@", _filePath);
}

- (void)loadData
{
    // 1. 将Plist文件反序列化为字典对象
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:_filePath];
    
    NSLog(@"%@", dict);
    
    // 2. 将字典中的textField字段取出来，并更新label
    _label.text = dict[@"textField"];
}

- (IBAction)saveData:(UIBarButtonItem *)sender {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    // 1. 往一个字典里写入了一个键值对
    dict[@"textField"] = _textField.text;
    dict[@"foo"] = @"bar";
    dict[@"name"] = @"zhangsan";
    dict[@"age"] = @18;
    dict[@"date"] = [NSDate date];
    
    // 2. 将字典写成PList文件
    BOOL result = [dict writeToFile:_filePath atomically:YES];
    if (result) {
        NSLog(@"保存文件成功!");
    }
    
}

- (IBAction)textFieldDidEndOnExit:(UITextField *)sender {
    [sender resignFirstResponder];
}



@end
