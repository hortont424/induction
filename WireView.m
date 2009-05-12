//
//  WireView.m
//  Induction
//
//  Created by Timothy Horton on 2009.05.11.
//  Copyright 2009 Rensselaer Polytechnic Institute. All rights reserved.
//

#import "WireView.h"

@implementation WireView

@synthesize activeWire, magnetLocation;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        wires = [[NSMutableArray alloc] init];
		activeWire = nil;
		magnetLocation = NSMakePoint(-1,-1);
    }
    return self;
}

- (void)drawRect:(NSRect)rect
{
	CGContextRef ctx = [[NSGraphicsContext currentContext] graphicsPort];
	
	CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
	CGContextSetLineWidth(ctx, 2);
	CGContextSetLineJoin(ctx, kCGLineJoinRound);
	CGContextSetLineCap(ctx, kCGLineCapRound);
	
	int arrayCount = [wires count];
	int i;
	for(i = 0; i < arrayCount; i++)
	{
		Wire * w = (Wire *)[wires objectAtIndex:i];
		
		NSPoint beginPt = [w.begin convertPoint:[w.begin pointForOutput] toView:self];
		NSPoint endPt;
		
		if(w.end)
		{
			endPt = [w.end convertPoint:[w.end pointForInput:w.endIndex] toView:self];
		}
		else
		{
			endPt = [w.begin convertPoint:w.endPoint toView:self];
			
			if(magnetLocation.x != -1)
			{
				endPt = magnetLocation;
			}
		}
		
		CGContextMoveToPoint(ctx, beginPt.x, beginPt.y);
		/*CGContextAddCurveToPoint(ctx, (beginPt.x + endPt.x) / 2.0, (((float)beginPt.y + endPt.y) / 2.0) - (10 * ((endPt.y - beginPt.y > 0) ? 1 : -1)),
									  (((float)beginPt.x + endPt.x) / 2.0), (((float)beginPt.y + endPt.y) / 2.0) + (10 * ((endPt.y - beginPt.y > 0) ? 1 : -1)),
								      endPt.x, endPt.y);*/
		CGContextAddLineToPoint(ctx, endPt.x, endPt.y);
		//CGContextAddQuadCurveToPoint(ctx, (beginPt.x + endPt.x) / 2.0, ((beginPt.y + endPt.y) / 2.0) - 10, endPt.x, endPt.y);
		CGContextStrokePath(ctx);
	}
	
	
}

- (void)addWire:(Wire *)w
{
	[wires addObject:w];
	activeWire = w;
}

- (void)removeWire:(Wire *)w
{
	[wires removeObject:w];
	activeWire = nil;
}

- (void)addWireFrom:(GateView *)begin to:(GateView *)end at:(int)endIndex
{
	Wire * newWire = [[Wire alloc] init];
	
	newWire.begin = begin;
	newWire.end = end;
	newWire.endIndex = endIndex;
	
	[wires addObject:newWire];
}

@end
