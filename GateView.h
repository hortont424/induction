//
//  GateView.h
//  Induction
//
//  Created by Timothy Horton on 2009.05.11.
//  Copyright 2009 Rensselaer Polytechnic Institute. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Wire;
@class WireView;

typedef enum
{
	GATE_INVERTER,
	GATE_NAND
} GateType;

@interface GateView : NSView
{
	NSPoint clickOrigin;
	bool mouseDown, draggingWire;
	
	Wire * wireBeingDragged;
	
	GateType gateType;
	bool gateState;
	
	int rightmost;
	
	int magneticInput;
	
	GateView ** inputs;
	GateView ** outputs;

	NSMutableArray * inputsTrackingAreas;
	
	int inputCount;
	
	NSRect outer, inner;
	
	WireView * wires;
	
	CGContextRef ctx;
}

- (NSPoint)pointForInput:(int)inputIndex;
- (NSPoint)pointForOutput;

- (void)mouseExited:(NSEvent *)theEvent;

@property (nonatomic,assign) GateType gateType;
@property (nonatomic,assign) bool gateState;

@property (nonatomic,assign) GateView ** inputs;
@property (nonatomic,assign) GateView ** outputs;

@property (nonatomic,retain) WireView * wires;

@end
