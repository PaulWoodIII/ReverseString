//
//  TestString.m
//  TestString
//
//  Created by Paul Wood on 9/11/16.
//  Copyright © 2016 Paul Wood. All rights reserved.
//

#import <XCTest/XCTest.h>

static NSString *initalString = @"Reverse This!";
static NSString *expectedString = @"!sihT esreveR";

@interface TestString : XCTestCase

@property NSInteger timesToTest;
@property NSString *string;
@property NSMutableString *buildingString;

@end

@implementation TestString

- (void)setUp {
    [super setUp];
    _timesToTest = 1000000;
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testPerformanceExampleFirst {

    [self measureBlock:^{
        
        while (_timesToTest-- > 0){
            //Niave First crack at this
            _string = [NSString stringWithString:initalString];
            _buildingString = [[NSMutableString alloc] init];
            for (NSUInteger i = _string.length - 1; i > 0; i--){
                NSRange range = NSMakeRange(i, 1);
                [_buildingString appendString: [_string substringWithRange:range]];
            }
            //Oops We forgot the last letter
            NSRange range = NSMakeRange(0, 1);
            [_buildingString appendString: [_string substringWithRange:range]];
            XCTAssert([_buildingString isEqualToString:expectedString]);
            
        }
    }];
}

- (void)testPerformanceExampleBlocks {

    [self measureBlock:^{
        
        while (_timesToTest-- > 0){

            _string = [NSString stringWithString:initalString];
            _buildingString = [[NSMutableString alloc] init];
            [_string enumerateSubstringsInRange:NSMakeRange(0,_string.length) options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                [_buildingString appendString:substring];
            }];
            XCTAssert([_buildingString isEqualToString:expectedString]);
        }
        return;
    }];
}

- (void)testPerformanceExampleWhile {

    [self measureBlock:^{
        
        while (_timesToTest-- > 0){
        
            //Using while, being performant with a better initializer
            _string = [NSString stringWithString:initalString];
            _buildingString = [NSMutableString stringWithCapacity:_string.length];
            NSInteger length = _string.length;
            while (length--){
                [_buildingString appendFormat:@"%C", [_string characterAtIndex:length]];
            }
            XCTAssert([_buildingString isEqualToString:expectedString]);
        }
        return;
    }];
}
@end
