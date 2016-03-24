//
//  ViewController.m
//  循环滑动
//
//  Created by Lzy on 16/1/14.
//  Copyright © 2016年 Lzy. All rights reserved.
//

#import "ViewController.h"

#define with [UIScreen mainScreen].bounds.size.width
@interface ViewController ()<UIScrollViewDelegate>
{
    NSArray *arr;
    UIScrollView *scrollView1;
}
@property (nonatomic,assign)NSInteger showIndex;
@property(nonatomic,assign)NSInteger ArrCount;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.showIndex = 0;
    arr=@[@"1.jpg",@"2",@"3",@"4",@"5",@"2",@"3"];
    self.ArrCount=arr.count;
    [self creatScrollView];
}

#pragma mark - 顶部滑动视图
- (void)creatScrollView{
    
    scrollView1=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, with, 400)];
    scrollView1.delegate=self;
    [self.view addSubview:scrollView1];
    scrollView1.pagingEnabled = YES;
    scrollView1.contentSize = CGSizeMake(3 * with, 0);
    scrollView1.showsHorizontalScrollIndicator = NO;
    scrollView1.contentOffset = CGPointMake(with, 0);
    for (NSInteger i = 0; i < 3; i ++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(with * i, 0, with, with)];
        imgView.image=[UIImage imageNamed:arr[0]];
        imgView.tag = i + 10;
        if (i == 0) {
            imgView.image=[UIImage imageNamed:arr[arr.count-1]];
        }else{
            imgView.image=[UIImage imageNamed:arr[[self getIndex:self.showIndex]]];
        }
        [scrollView1 addSubview:imgView];
    }
}
- (NSInteger)getIndex:(NSInteger)index{
    
    if (index >self.ArrCount-1) {
        return 0;
    }else if (index <0){
        return self.ArrCount-1;
    }
    return index;
}

#pragma mark - UIScrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        if (scrollView.contentOffset.x >= with * 2) {
            // 301 012 123 230
            self.showIndex = [self getIndex:++self.showIndex];
            scrollView.contentOffset = CGPointMake(with, 0);
        }else if (scrollView.contentOffset.x <= 0) {
            self.showIndex = [self getIndex:--self.showIndex];
            scrollView.contentOffset = CGPointMake(with, 0);
            //NSLog(@"%ld",self.showIndex);
        }
        for (NSInteger i = 10; i < 13; i ++) {
            UIImageView *imgView = (UIImageView *)[self.view viewWithTag:i];
            if (i == 10) {
                imgView.image=[UIImage imageNamed:arr[[self getIndex:self.showIndex-1]]];
               // NSLog(@"1=%ld",[self getIndex:self.showIndex-1]);
            }else if (i == 11){
                imgView.image=[UIImage imageNamed:arr[[self getIndex:self.showIndex]]];
               // NSLog(@"2=%ld",[self getIndex:self.showIndex]);
            }else{
                imgView.image=[UIImage imageNamed:arr[[self getIndex:self.showIndex+1]]];
               // NSLog(@"3=%@",arr[[self getIndex:self.showIndex+1]]);
            }
        }
}
@end