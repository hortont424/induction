//
//  GateView.m
//  Induction
//
//  Created by Timothy Horton on 2009.05.11.
//  Copyright 2009 Rensselaer Polytechnic Institute. All rights reserved.
//

#import "GateView.h"
#import <QuartzCore/QuartzCore.h>

@implementation GateView

@synthesize gateType, gateState, inputs, outputs, wires;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
	{
        gateType = GATE_INVERTER;
		gateState = NO;
		mouseDown = NO;
		draggingWire = NO;
		
		inputs = [[NSMutableArray alloc] init];
		outputs = [[NSMutableArray alloc] init];
		
		inputCount = 2;
		
		outer = [self bounds];
		inner = NSInsetRect([self bounds], 10, 10);
    }
    return self;
}

- (void)mouseDown:(NSEvent *)theEvent
{
	if([theEvent clickCount] == 2)
	{
		mouseDown = NO;
		gateState = !gateState;
		[self setNeedsDisplay:YES];
		
		return;
	}
	
	clickOrigin = [self convertPoint:[theEvent locationInWindow] fromView:nil];
	
	NSPoint pfo = [self pointForOutput];
	CGRect targetRect = CGRectMake(pfo.x - 2, pfo.y - 2, 14, 4);

	if(CGRectContainsPoint(targetRect, CGPointMake(clickOrigin.x,clickOrigin.y)))
	{
		draggingWire = YES;
		
		wireBeingDragged = [[Wire alloc] init];
		[wireBeingDragged setBegin:self];
		[wireBeingDragged setEndPoint:clickOrigin];
		
		[wires addWire:wireBeingDragged];
	}
	else
	{
		mouseDown = YES;
	}
}

- (void)mouseUp:(NSEvent *)theEvent
{
	mouseDown = draggingWire = NO;
	
	[wires removeWire:wireBeingDragged];
	[wires setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)theEvent
{
	NSPoint mousePoint = [theEvent locationInWindow];

	if(mouseDown)
	{
		mousePoint.x -= clickOrigin.x;
		mousePoint.y -= clickOrigin.y;
		
		[self setFrameOrigin:mousePoint];
		[self setNeedsDisplay:YES];
	}
	
	if(draggingWire && wireBeingDragged)
	{
		[wireBeingDragged setEndPoint:[self convertPoint:mousePoint fromView:nil]];
		[wires setNeedsDisplay:YES];
	}
	
	[wires setNeedsDisplay:YES];
}

- (void)constructPathForGate:(GateType)gate withinRect:(NSRect)rect
{
	if(gate == GATE_INVERTER)
	{
		CGContextMoveToPoint(ctx, rect.origin.x, rect.origin.y);
		CGContextAddLineToPoint(ctx, rect.origin.x, rect.size.height + rect.origin.y);
		CGContextAddLineToPoint(ctx, rect.origin.x + rect.size.width, (rect.size.height / 2) + rect.origin.y);
		CGContextClosePath(ctx);
		
		rightmost = rect.origin.x + rect.size.width;
	}
	else if(gate == GATE_NAND)
	{
		CGContextMoveToPoint(ctx, rect.origin.x, rect.origin.y);
		CGContextAddLineToPoint(ctx, rect.origin.x, rect.origin.y + rect.size.height);
		CGContextAddCurveToPoint(ctx, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height,
								      rect.origin.x + rect.size.width, rect.origin.y,
									  rect.origin.x, rect.origin.y);
		CGContextClosePath(ctx);
		
		rightmost = rect.origin.x + rect.size.width - 10;
	}
}

- (NSPoint)pointForInput:(int)inputIndex
{
	float y = (1.0/inputCount) * (inputIndex + 1) * inner.size.height;
	float off = (((float)((1.0/inputCount))) * inner.size.height) / 2.0;
	
	return NSMakePoint(inner.origin.x, (y - off) + inner.origin.y);
}

- (NSPoint)pointForOutput
{
	return NSMakePoint(rightmost, (inner.size.height / 2) + inner.origin.y);
}

- (void)drawInputs
{
	CGContextSetLineWidth(ctx, 2);
	CGContextSetLineJoin(ctx, kCGLineJoinMiter);
	CGContextSetLineCap(ctx, kCGLineCapSquare);
	
	int currentInput = 0;
	
	for(; currentInput < inputCount; currentInput++)
	{
		if([inputs count] > currentInput && [inputs objectAtIndex:currentInput])
			continue;
		
		NSPoint pfi = [self pointForInput:currentInput];
		
		CGContextMoveToPoint(ctx, pfi.x, pfi.y);
		CGContextAddLineToPoint(ctx, pfi.x - 10, pfi.y);
		CGContextStrokePath(ctx);
	}
}

- (void)drawOutputs
{
	if([outputs count] || draggingWire)
		return;
	
	CGContextSetLineWidth(ctx, 2);
	CGContextSetLineJoin(ctx, kCGLineJoinMiter);
	CGContextSetLineCap(ctx, kCGLineCapButt);

	NSPoint pfo = [self pointForOutput];
	
	CGContextMoveToPoint(ctx, pfo.x, pfo.y);
	CGContextAddLineToPoint(ctx, pfo.x + 10, pfo.y);
	CGContextStrokePath(ctx);
}

- (void)drawRect:(NSRect)rect
{
	ctx = [[NSGraphicsContext currentContext] graphicsPort];
	
	[self constructPathForGate:gateType withinRect:inner]; // to get numbers right
	CGContextBeginPath(ctx);
	
	[self drawInputs];
	[self drawOutputs];
	
	CGContextSetRGBStrokeColor(ctx, 0, 0, 0, 1);
	CGContextSetRGBFillColor(ctx, 1, 1, 0, 1);
	CGContextSetLineWidth(ctx, 4);
	CGContextSetLineJoin(ctx, kCGLineJoinRound);
	CGContextSetLineCap(ctx, kCGLineCapRound);
	
	[self constructPathForGate:gateType withinRect:inner];
	CGContextSaveGState(ctx);
	CGContextSetShadow(ctx, CGSizeMake(2, -2), 3);
	CGContextStrokePath(ctx);
	CGContextRestoreGState(ctx);
	
	if(gateState)
		CGContextSetRGBFillColor(ctx, .98, .91, .31, 1);
	else
		CGContextSetRGBFillColor(ctx, .91, .91, .91, 1);

	[self constructPathForGate:gateType withinRect:inner];
	CGContextFillPath(ctx);
}

@end
