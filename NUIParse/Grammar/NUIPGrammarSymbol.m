//
//  NUIPGrammarSymbol.m
//  NUIParse
//
//  Created by Tom Davie on 13/03/2011.
//  Copyright 2011 In The Beginning... All rights reserved.
//

#import "NUIPGrammarSymbol.h"

@implementation NUIPGrammarSymbol

@synthesize ruleName;
@synthesize terminal;

+ (id)nonTerminalWithName:(NSString *)name
{
    return [[[self alloc] initWithName:name isTerminal:NO] autorelease];
}

+ (id)terminalWithName:(NSString *)name
{
    return [[[self alloc] initWithName:name isTerminal:YES] autorelease];
}

- (id)initWithName:(NSString *)initName isTerminal:(BOOL)isTerminal;
{
    self = [super init];
    
    if (nil != self)
    {
        [self setRuleName:initName];
        [self setTerminal:isTerminal];
    }
    
    return self;
}

- (id)init
{
    return [self initWithName:@"" isTerminal:NO];
}

#define NUIPGrammarSymbolNameKey     @"n"
#define NUIPGrammarSymbolTerminalKey @"t"

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    if (nil != self)
    {
        [self setRuleName:[aDecoder decodeObjectForKey:NUIPGrammarSymbolNameKey]];
        [self setTerminal:[aDecoder decodeBoolForKey:NUIPGrammarSymbolTerminalKey]];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[self ruleName] forKey:NUIPGrammarSymbolNameKey];
    [aCoder encodeBool:[self isTerminal] forKey:NUIPGrammarSymbolTerminalKey];
}

- (BOOL)isGrammarSymbol
{
    return YES;
}

- (BOOL)isEqual:(id)object
{
    return ([object isGrammarSymbol] &&
            ((NUIPGrammarSymbol *)object)->terminal == terminal &&
            [((NUIPGrammarSymbol *)object)->ruleName isEqualToString:name]);
}

- (BOOL)isEqualToGrammarSymbol:(NUIPGrammarSymbol *)object
{
    return (object != nil && object->terminal == terminal && [object->ruleName isEqualToString:name]);
}

- (NSUInteger)hash
{
    return [[self ruleName] hash];
}

- (NSString *)description
{
    if ([self isTerminal])
    {
        return [NSString stringWithFormat:@"\"%@\"", [self ruleName]];
    }
    else
    {
        return [NSString stringWithFormat:@"<%@>", [self ruleName]];
    }
}

- (void)dealloc
{
    [ruleName release];
    
    [super dealloc];
}

@end

@implementation NSObject (NUIPGrammarSymbol)

- (BOOL)isGrammarSymbol
{
    return NO;
}

@end
