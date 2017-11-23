//
//  GAWelcomeViewController.m
//  Honey
//
//  Created by 李高锋 on 16/10/30.
//  Copyright © 2016年 GaoF. All rights reserved.
//

#import "GAWelcomeViewController.h"
#import "GAWelcome.h"

@interface GAWelcomeViewController ()

@property (nonatomic, strong) GAWelcome *welcomeView;

@end

@implementation GAWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _welcomeView = [[GAWelcome alloc] initWithFrame:self.view.frame];
    self.view = _welcomeView;
    [_welcomeView createSense];
//    [_welcomeView maskAnimation];
}



@end
