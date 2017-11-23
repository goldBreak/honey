//
//  GAImageEditView.m
//  Honey
//
//  Created by 李高锋 on 2017/9/19.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "GAImageEditView.h"

@interface GAImageEditView()

@property (nonatomic, strong) UIView *clearViewBg;

@property (nonatomic, strong) UIView *clearViewBg1;

@end

@implementation GAImageEditView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.showImageView];
        
        [self addSubview:self.clearViewBg1];
        [self addSubview:self.clearViewBg];
        
        [self addSubview:self.saveBtn];
        [self addSubview:self.editBtn];
        [self addSubview:self.closeBtn];
    }
    return self;
}

#pragma mark - Sel

- (void)saveSel:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(saveProtocol)]) {
        [self.delegate saveProtocol];
    }
}

- (void)closeSel:(UIButton *)button {
    [self removeFromSuperview];
}

- (void)editSel:(UIButton *)button {
    
    if ([self.delegate respondsToSelector:@selector(editProtocol)]) {
        [self.delegate editProtocol];
    }
}

#pragma mark - Lazy
- (UIView *)clearViewBg {
    if (!_clearViewBg) {
        _clearViewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 44)];
        _clearViewBg.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _clearViewBg;
}

- (UIView *)clearViewBg1 {
    if (!_clearViewBg1) {
        _clearViewBg1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.height - 44, self.width, 44)];
        _clearViewBg1.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _clearViewBg1;
}

- (UIImageView *)showImageView {
    
    if (!_showImageView) {
        _showImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _showImageView;
}

- (UIButton *)saveBtn {
    
    if (!_saveBtn) {
        
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveBtn.frame = CGRectMake(0, self.clearViewBg1.originy, 100, 44);
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14.];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn addTarget:self action:@selector(saveSel:) forControlEvents:UIControlEventTouchUpInside];
        _saveBtn.center = CGPointMake(self.width / 2., _saveBtn.center.y);
    }
    return _saveBtn;
}

- (UIButton *)closeBtn {
    
    if (!_closeBtn) {
        
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(self.width - 20. - 50., 0, 50, 44);
        _closeBtn.titleLabel.font = [UIFont systemFontOfSize:14.];
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closeSel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _editBtn.frame = CGRectMake( 20. , 0, 50, 44);
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:14.];
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_editBtn addTarget:self action:@selector(editSel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editBtn;
}

@end
