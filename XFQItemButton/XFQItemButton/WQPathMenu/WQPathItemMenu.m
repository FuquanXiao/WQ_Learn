//
//  WQPathItemMenu.m
//  XFQItemButton
//
//  Created by apple on 2019/3/1.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "WQPathItemMenu.h"
#import "WQPathItemView.h"

@interface WQPathItemMenu()
{
    NSTimer *_timer;
}
@property (nonatomic,assign)CGRect centerButtonFrame;
@property (nonatomic,strong)UIButton *centerButton;
@property (nonatomic,assign) CGPoint pathCenterButtonBloomCenter;
@property (nonatomic,strong)NSMutableArray *itemArray;
@property (nonatomic,strong)NSMutableArray *itemButtonArray;
@property (nonatomic, getter = isExpanding) BOOL expanding;

@property (nonatomic,assign)int flag;

@end


@implementation WQPathItemMenu


- (NSMutableArray *)itemButtonArray{
    if (!_itemButtonArray) {
        _itemButtonArray = [[NSMutableArray alloc] init];
    }
    return _itemButtonArray;
}

- (instancetype)initWithCenterButtonFrame:(CGRect)frame{
    _centerButtonFrame = frame;
    return [self initWithFrame:[UIScreen mainScreen].bounds];
    
}

- (instancetype) initWithFrame:(CGRect)frame{
    _centerButtonFrame = frame;
    if (self = [super initWithFrame: frame]) {
        self.backgroundColor = [UIColor cyanColor];
        self.frame = [UIScreen mainScreen].bounds;
        [self _creteUI];
    }
    return self;
}

- (void)tapHandle:(UITapGestureRecognizer *)gesture{
    
    NSInteger tag = gesture.view.tag - 100;
    [self expandAnimation];
    if ([self.delegate respondsToSelector:@selector(wq_pathItemMenuSelectedIndex:)]) {
        [self.delegate wq_pathItemMenuSelectedIndex:tag];
    }
    
}

- (void)showItemsButtonWithArray:(NSMutableArray *)itemArray{
    _itemArray = itemArray;
    [self setExpanding:YES];
    _animationDuration = 0.5f;
    _timeOffset = 0.036f;
    _bloomRadius = 180;

    _pathCenterButtonBloomCenter = CGPointMake(CGRectGetMidX(_centerButtonFrame), CGRectGetMidY(_centerButtonFrame));
    
    
    for (int i = 0; i < itemArray.count ; i++) {
        WQPathItemView *button = itemArray[i];
        button.backgroundColor = [UIColor redColor];
        button.tag =  100 + i;
        CGFloat currentAngle = [self getAngleWithTotalItemCount:4 currentIndex:i];
        button.startPoint = _pathCenterButtonBloomCenter;
        button.farPoint =  [self createEndPointWithRadius:(self.bloomRadius + 30) andAngel:currentAngle];
        
         button.nearPoint =  [self createEndPointWithRadius:(self.bloomRadius - 30) andAngel:currentAngle];
        button.endPoint =  [self createEndPointWithRadius:self.bloomRadius andAngel:currentAngle];
        button.center = _pathCenterButtonBloomCenter;
        button.bounds = CGRectMake(0, 0, 60, 60);
        [self insertSubview:button belowSubview:_centerButton];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle:)];
        
        [button addGestureRecognizer:tapGes];
        
    }
}

- (void)expandAnimation{
    
    if (!_timer)
    {
        _flag = self.isExpanding ? 0 : ((int)[_itemArray count]);
        SEL selector = self.isExpanding ? @selector(_gotoExpan) : @selector(_gotoClose);
        _timer = [NSTimer timerWithTimeInterval:_timeOffset target:self selector:selector userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer fire];

    }
    
}

- (void)_gotoClose{
    if (_flag == -1)
    {
        [self setExpanding:YES];
        [_timer invalidate];
        _timer = nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_animationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self removeFromSuperview];
        });
        return;
    }
    
    int tag = 100 + _flag;
    WQPathItemView *item = (WQPathItemView *)[self viewWithTag:tag];
    CAAnimationGroup *foldAnimation = [self close:tag];
    
    [item.layer addAnimation:foldAnimation forKey:@"foldAnimation"];
    item.center = item.startPoint;
    _flag --;
}


- (void)_gotoExpan{
    if (_flag == _itemArray.count)
    {
        [self setExpanding:NO];
        [_timer invalidate];
        _timer = nil;
        return;
    }
     int tag = 100 + _flag;
    WQPathItemView *item = (WQPathItemView *)[self viewWithTag:tag];
    CAAnimationGroup *foldAnimation = [self expand:tag];
    
    [item.layer addAnimation:foldAnimation forKey:@"expanAnimation"];
    item.center = item.endPoint;
    _flag ++;

}


- (CGFloat)getAngleWithTotalItemCount:(NSInteger)totalCount currentIndex:(NSInteger)index{
    CGFloat totalAngle = M_PI;
    CGFloat marginAngle = M_PI/12.0;
    CGFloat statrtAngle = M_PI_2;
    if (totalCount == 1) {
        return M_PI/2.0;
    }
    CGFloat gapAngle =  (totalAngle - 2 * marginAngle) * 1.0/(totalCount - 1);
    return statrtAngle + marginAngle + gapAngle * index;
}

- (CAAnimationGroup *)close:(NSInteger)tag{
    WQPathItemView *item = (WQPathItemView *)[self viewWithTag:tag];
    
    
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = _animationDuration;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, item.endPoint.x, item.endPoint.y);
    CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
    CGPathAddLineToPoint(path, NULL, item.startPoint.x, item.startPoint.y);
    positionAnimation.path = path;
    CGPathRelease(path);
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:positionAnimation, nil];
    animationgroup.duration = _animationDuration;
    animationgroup.fillMode = kCAFillModeForwards;
    animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    animationgroup.delegate = self;
    return animationgroup;
}




- (CAAnimationGroup *)expand:(NSInteger)tag{
    WQPathItemView *item = (WQPathItemView *)[self viewWithTag:tag];
    
    CAKeyframeAnimation *rotateAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.values = [NSArray arrayWithObjects:[NSNumber numberWithFloat:-M_PI_4],[NSNumber numberWithFloat:M_PI_4],[NSNumber numberWithFloat:0.0f], nil];
    rotateAnimation.duration = _animationDuration;
    rotateAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:.0],
                                [NSNumber numberWithFloat:.4],
                                [NSNumber numberWithFloat:.5], nil];
    
    
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.duration = _animationDuration;
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, item.startPoint.x, item.startPoint.y);
    CGPathAddLineToPoint(path, NULL, item.farPoint.x, item.farPoint.y);
    CGPathAddLineToPoint(path, NULL, item.nearPoint.x, item.nearPoint.y);
    CGPathAddLineToPoint(path, NULL, item.endPoint.x, item.endPoint.y);
    positionAnimation.path = path;
    CGPathRelease(path);

    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue  = [NSNumber numberWithFloat:1.0f];

    opacityAnimation.toValue  = [NSNumber numberWithFloat:1.0f];
    
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    scaleAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1)];
    
    CAAnimationGroup *animationgroup = [CAAnimationGroup animation];
    animationgroup.animations = [NSArray arrayWithObjects:rotateAnimation,positionAnimation,opacityAnimation,scaleAnimation, nil];
    animationgroup.duration = _animationDuration;
    animationgroup.fillMode = kCAFillModeForwards;
    animationgroup.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];

    return animationgroup;
}


- (void)clickAddButton{
    [self expandAnimation];
}



- (CGPoint)createEndPointWithRadius:(CGFloat)itemExpandRadius andAngel:(CGFloat)angel
{
    
    if (angel > M_PI_2) {
        return CGPointMake(self.pathCenterButtonBloomCenter.x + MIN(cosf(angel) * itemExpandRadius, itemExpandRadius),
                           self.pathCenterButtonBloomCenter.y - MIN(sinf(angel) * itemExpandRadius, itemExpandRadius));
    }
    else if (angel > M_PI)
    {
        return CGPointMake(self.pathCenterButtonBloomCenter.x + MIN(cosf(angel) * itemExpandRadius, itemExpandRadius),
                           self.pathCenterButtonBloomCenter.y - MIN(sinf(angel) * itemExpandRadius, itemExpandRadius));
    }
    return CGPointZero;
}


- (void)_creteUI{
    UIButton *button = [[UIButton alloc] initWithFrame:
                        _centerButtonFrame];
    button.layer.cornerRadius = 27.5;
    button.backgroundColor = [UIColor greenColor];
    [button addTarget:self action:@selector(clickAddButton) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"jiahao"] forState:UIControlStateNormal];
    self.centerButton = button;
    [self addSubview:button];
    if (CGRectEqualToRect(_centerButtonFrame, CGRectMake(0, 0, 0, 0))) {
        button.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2.0, [UIScreen mainScreen].bounds.size.height/2.0);
        button.bounds = CGRectMake(0, 0, 60, 60);
    }
}

@end
