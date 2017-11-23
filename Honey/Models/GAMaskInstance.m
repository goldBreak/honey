//
//  GAMaskInstance.m
//  Honey
//
//  Created by 李高锋 on 2017/7/5.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "GAMaskInstance.h"

static GAMaskInstance *instance;
static dispatch_once_t predicate;

@interface GAMaskInstance ()

@property (nonatomic, strong) NSMutableArray *effectArray;

@end


@implementation GAMaskInstance

+ (instancetype)instance {
    
    dispatch_once(&predicate, ^{
        instance = [[GAMaskInstance alloc] init];
    });
    
    return instance;
}

- (void)createCamera {
    //初始化一下内容！
    //第一个模块，模糊模块
    
}


@end
