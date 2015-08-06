//
//  ViewController.m
//  01-沙盒
//
//  Created by qingyun on 15/8/6.
//  Copyright (c) 2015年 河南青云信息技术有限公司. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 1. 沙盒的根目录
    NSString *homePath = NSHomeDirectory();
    NSLog(@"homePath:%@", homePath);
    
    // 2. bundle的根目录
    NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
    NSLog(@"bundlePath:%@", bundlePath);
    
    // 3. Documents目录
    NSString *documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"documentsPath:%@", documentsPath);
    
    // 4. Caches目录
    NSString *cachedPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"cachedPath:%@", cachedPath);
    
    // 5. Libraries目录
    NSString *librariesPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"librariesPath:%@", librariesPath);
    
    // 6. tmp目录
    NSString *tmpPath = NSTemporaryDirectory();
    NSLog(@"tmpPath:%@", tmpPath);
}


@end
























