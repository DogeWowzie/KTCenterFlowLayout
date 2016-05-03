//
//  KTVariableHeightCollectionViewController.m
//  CenterFlow
//
//  Created by Kyle Truscott on 5/3/16.
//  Copyright © 2016 keighl. All rights reserved.
//

#import "KTVariableHeightCollectionViewController.h"
#import "KTCenterFlowLayout.h"
#import "KTAwesomeCell.h"
#import "Constants.h"

@interface KTVariableHeightCollectionViewController ()
@property (strong) NSArray *states;
@property (strong) KTAwesomeCell *sizingCell;
@end

@implementation KTVariableHeightCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Variable Heights";
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [(KTCenterFlowLayout *)self.collectionViewLayout setMinimumInteritemSpacing:15.f];
    [(KTCenterFlowLayout *)self.collectionViewLayout setMinimumLineSpacing:15.f];
    [(KTCenterFlowLayout *)self.collectionViewLayout setSectionInset:UIEdgeInsetsMake(20, 20, 20, 20)];
    
    [self.collectionView registerClass:[KTAwesomeCell class] forCellWithReuseIdentifier:@"AwesomeCell"];
    
    self.sizingCell = [KTAwesomeCell new];
    
    self.states = [Constants states];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.states.count;
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KTAwesomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AwesomeCell"
                                                                    forIndexPath:indexPath];
    
    cell.label.text = self.states[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewFlowLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.sizingCell.label.text = self.states[indexPath.row];
    [self.sizingCell setNeedsLayout];
    [self.sizingCell layoutIfNeeded];

    CGSize size = self.sizingCell.intrinsicContentSize;
    size.height = (self.sizingCell.label.text.length == 7) ? size.height+20 : size.height;
    size.height = (self.sizingCell.label.text.length == 5) ? size.height+25 : size.height;
    size.height = (self.sizingCell.label.text.length == 8) ? size.height+45 : size.height;
    return size;
}

@end
