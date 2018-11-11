//
//  ViewController.m
//  testAnimation
//
//  Created by 罗祖根 on 2018/11/11.
//  Copyright © 2018年 罗祖根. All rights reserved.
//

#import "ViewController.h"
#import <POP.h>
#import "EllipseView.h"

@interface ViewController ()

@property (nonatomic,strong)UIImageView *yeziImageView;//叶子

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.yeziImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 75, 75)];
    self.yeziImageView.image = [UIImage imageNamed:@"yezi"];
    [self.view addSubview:self.yeziImageView];
    
    EllipseView *view = [[EllipseView alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    //view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    [self rotation];
    [self donwAndLeft:^{
        [self donwAndRight:^{
            
        }];
    }];
}

- (void)rotation
{
    POPBasicAnimation *rotationa = [POPBasicAnimation linearAnimation];
    rotationa.property = [POPAnimatableProperty propertyWithName: kPOPLayerRotation];
    rotationa.fromValue = @(0);
    rotationa.duration = 0.8f;
    rotationa.toValue = @(M_PI/2);
    [rotationa setCompletionBlock:^(POPAnimation *anim, BOOL finished) {

        POPBasicAnimation *rotationb = [POPBasicAnimation linearAnimation];
        rotationb.property = [POPAnimatableProperty propertyWithName: kPOPLayerRotation];
        rotationb.duration = 0.8f;
        rotationb.fromValue = @(M_PI/2);
        rotationb.toValue = @(0);
        [rotationb setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
            [self rotation];
        }];
        [self.yeziImageView.layer pop_removeAnimationForKey:@"rotationb"];
        [self.yeziImageView.layer pop_addAnimation:rotationb forKey:@"rotationb"];
    }];
    [self.yeziImageView.layer pop_removeAnimationForKey:@"rotationa"];
    [self.yeziImageView.layer pop_addAnimation:rotationa forKey:@"rotationa"];
}

- (void)donwAndLeft:(void (^)(void))complete
{
    //先到左
    POPBasicAnimation *toleftxAnimation = [POPBasicAnimation linearAnimation];
    toleftxAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLayerPositionX];
    toleftxAnimation.toValue = @(self.yeziImageView.center.x - 100);
    toleftxAnimation.duration = 1.0f;
    //向下
    POPBasicAnimation *downAnimation = [POPBasicAnimation linearAnimation];
    downAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLayerPositionY];
    downAnimation.toValue = @(self.yeziImageView.center.y + 50);
    downAnimation.duration = 1.0f;
    [downAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        if(finished)
        {
            if(complete)
            {
                complete();
            }
        }
    }];
    
    [self.yeziImageView pop_addAnimation:downAnimation forKey:@"downAnimation1"];
    [self.yeziImageView pop_addAnimation:toleftxAnimation forKey:@"toleftxAnimation"];
}

- (void)donwAndRight:(void (^)(void))complete
{
    //到右
    POPBasicAnimation *torightxAnimation = [POPBasicAnimation linearAnimation];
    torightxAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLayerPositionX];
    torightxAnimation.toValue = @(self.yeziImageView.center.x + 100);
    torightxAnimation.duration = 1.0f;
    //向下
    POPBasicAnimation *downAnimation = [POPBasicAnimation linearAnimation];
    downAnimation.property = [POPAnimatableProperty propertyWithName: kPOPLayerPositionY];
    downAnimation.toValue = @(self.yeziImageView.center.y + 50);
    downAnimation.duration = 1.0f;
    [downAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        if(finished)
        {
            if(complete)
            {
                complete();
            }
        }
    }];
    
    POPBasicAnimation *alphaAnimation = [POPBasicAnimation animation];
    alphaAnimation.property = [POPAnimatableProperty propertyWithName:kPOPViewAlpha];
    alphaAnimation.toValue= @(0);
    alphaAnimation.duration = 1.0f;
    
    [self.yeziImageView pop_addAnimation:downAnimation forKey:@"downAnimation2"];
    [self.yeziImageView pop_addAnimation:torightxAnimation forKey:@"torightxAnimation"];
    [self.yeziImageView pop_addAnimation:alphaAnimation forKey:@"alphaAnimation"];
}
@end
