//
//  UIMaltiTouchView.m
//  ThreeDimensionalTouchSample
//

#import "UIMaltiTouchView.h"

@implementation UIMaltiTouchView

- (void)drawRect:(CGRect) rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    NSSet<UITouch *> *allTouches = [self.currentEvent allTouches];
    [allTouches enumerateObjectsUsingBlock:^(UITouch *obj, BOOL *stop){
        float force = obj.force;
        CGPoint location = [obj locationInView:self];
        //円の半径
        float r = force * 20.0;
        
        float cx = location.x;
        float cy = location.y;
        
        CGRect rectEllipse = CGRectMake(cx-r, cy-r, r*2, r*2);
        CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 0.1);
        CGContextFillEllipseInRect(context, rectEllipse);

        CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 0.5);
        CGContextSetLineWidth(context, 2.0);
        CGContextStrokeEllipseInRect(context, rectEllipse);
        
        NSString *label = [NSString stringWithFormat:@"%.3f", force];
        UIFont *font = [UIFont boldSystemFontOfSize:24.0];
        
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineBreakMode = NSLineBreakByWordWrapping;
        style.alignment = NSTextAlignmentCenter;
        
        NSDictionary *attributes = @{
                                     NSForegroundColorAttributeName : [UIColor grayColor],
                                     NSFontAttributeName : font,
                                     NSParagraphStyleAttributeName : style
                                     };
        [label drawInRect:CGRectMake(cx-50, cy-70, 100, 100) withAttributes:attributes];
        
    }];
}

@end
