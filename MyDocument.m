//
//  MyDocument.m
//  Induction
//
//  Created by Timothy Horton on 2009.05.11.
//  Copyright Rensselaer Polytechnic Institute 2009 . All rights reserved.
//

#import "MyDocument.h"
#import "GateView.h"

@implementation MyDocument

@synthesize wires;

- (id)init
{
    self = [super init];
    if (self) {
    
        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.
    
    }
    return self;
}

- (NSString *)windowNibName
{
    // Override returning the nib file name of the document
    // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this method and override -makeWindowControllers instead.
    return @"MyDocument";
}

- (IBAction)addSomeRandomGates:(id)sender
{
	GateView * a = [[GateView alloc] initWithFrame:NSMakeRect(50, 50, 64, 64)];
	GateView * b = [[GateView alloc] initWithFrame:NSMakeRect(200, 70, 64, 64)];
	GateView * c = [[GateView alloc] initWithFrame:NSMakeRect(200, 200, 64, 64)];
	
	[[myWindow contentView] addSubview:a];
	[[myWindow contentView] addSubview:b];
	[[myWindow contentView] addSubview:c];
	
	a.gateType = GATE_NAND;
	b.gateType = GATE_INVERTER;
	c.gateType = GATE_NAND;
	
	[a.outputs addObject:b];
	[b.inputs addObject:a];
	
	[b.inputs addObject:c];
	[c.outputs addObject:b];
	
	a.wires = b.wires = c.wires = wires;
	
	[a display];
	[b display];
	[c display];
	
	[wires addWireFrom:a to:b at:0];
	[wires addWireFrom:c to:b at:1];
	
	[wires display];
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
	myWindow = [aController window];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to write your document to data of the specified type. If the given outError != NULL, ensure that you set *outError when returning nil.

    // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.

    // For applications targeted for Panther or earlier systems, you should use the deprecated API -dataRepresentationOfType:. In this case you can also choose to override -fileWrapperRepresentationOfType: or -writeToFile:ofType: instead.

    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError
{
    // Insert code here to read your document from the given data of the specified type.  If the given outError != NULL, ensure that you set *outError when returning NO.

    // You can also choose to override -readFromFileWrapper:ofType:error: or -readFromURL:ofType:error: instead. 
    
    // For applications targeted for Panther or earlier systems, you should use the deprecated API -loadDataRepresentation:ofType. In this case you can also choose to override -readFromFile:ofType: or -loadFileWrapperRepresentation:ofType: instead.
    
    if ( outError != NULL ) {
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	}
    return YES;
}

@end
