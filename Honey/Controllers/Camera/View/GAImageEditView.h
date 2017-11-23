//
//  GAImageEditView.h
//  Honey
//
//  Created by 李高锋 on 2017/9/19.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol imageViewProtocol <NSObject>

- (void)saveProtocol;
- (void)editProtocol;

@end


@interface GAImageEditView : UIView

@property (nonatomic, strong) UIImageView *showImageView;
@property (nonatomic, strong) UIButton    *saveBtn;
@property (nonatomic, strong) UIButton    *closeBtn;
@property (nonatomic, strong) UIButton    *editBtn;

@property (nonatomic, weak) id<imageViewProtocol> delegate;

@end
