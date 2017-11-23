//
//  GAClectionView.m
//  Honey
//
//  Created by 李高锋 on 2017/7/31.
//  Copyright © 2017年 GaoF. All rights reserved.
//

#import "GAClectionView.h"
#import "GAEffectView.h"

#import "GAImageFilterHandle.h"

@interface GAClectionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectView;

@end

@implementation GAClectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.collectView];
        
    }
    return self;
}

- (void)setDefaultImage:(UIImage *)defaultImage {
    _defaultImage = defaultImage;
    
    [self.collectView reloadData];
}
#pragma mark - UICollectionViewDelegate&UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _resultArray.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *flag = @"effective";

    GAEffectView *cell=[collectionView dequeueReusableCellWithReuseIdentifier:flag forIndexPath:indexPath];
    
    [GAImageFilterHandle defaultImage:self.defaultImage type:[self.resultArray[indexPath.row] integerValue] imageView:cell.effectImage nameLable:cell.effectName];

    
    return cell;
}


//点击之后的操作
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //
}


#pragma mark - Lazy
- (UICollectionView *)collectView {
    if (!_collectView) {
        UICollectionViewFlowLayout *layour = [[UICollectionViewFlowLayout alloc] init];
        
        //同一行相邻两个cell的最小间距
        layour.minimumInteritemSpacing = 5;
        //最小两行之间的间距
        layour.minimumLineSpacing = 5;
        
        layour.itemSize = CGSizeMake(100, 100);
        
        _collectView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layour];
        
        _collectView.delegate = self;
        _collectView.dataSource = self;
        
        _collectView.backgroundColor = [UIColor blackColor];
        
        
        [_collectView registerClass:[GAEffectView class] forCellWithReuseIdentifier:@"effective"];
        
    }
    return _collectView;
}

@end
