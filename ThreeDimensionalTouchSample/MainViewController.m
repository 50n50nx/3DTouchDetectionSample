//
//  ViewController.m
//  ThreeDimensionalTouchSample
//

#import "MainViewController.h"

#import "DrawView.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet DrawView *touchAnimationView;

@property (weak, nonatomic) IBOutlet UILabel *forceValueLabel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Touch Sample"];
    [self.view setMultipleTouchEnabled:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event{
    [self refreshForTouches:event endOrCanceled:NO];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event{
    [self refreshForTouches:event endOrCanceled:NO];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self refreshForTouches:event endOrCanceled:YES];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self refreshForTouches:event endOrCanceled:YES];
}

- (void)handleGesture:(UITapGestureRecognizer *)gestureRecognizer{
    
}

- (void)refreshForTouches:(UIEvent *)event endOrCanceled:(BOOL)endOrCanceled{
    
    NSSet<UITouch *> *allTouches = [event allTouches];
    NSMutableString *wkStr = [@"" mutableCopy];
    __block int index = 0;
    if(!endOrCanceled){
        [allTouches enumerateObjectsUsingBlock:^(UITouch *obj, BOOL *stop){
            float force = obj.force;
            CGPoint location = [obj locationInView:self.view];
            NSString *displayValue = [NSString stringWithFormat:@"%d: force=%.2f {x=%.2f, y=%.2f}\n",
                                      index, force, location.x, location.y];
            [wkStr appendString:displayValue];
            index = index + 1;
        }];
    }
    
    [self.forceValueLabel setText:[wkStr copy]];
    self.touchAnimationView.currentEvent = event;
    [self.touchAnimationView setNeedsDisplay];
}

- (void)clearDisplay:(NSString *)text{
    [self.forceValueLabel setText:@""];
}

@end
