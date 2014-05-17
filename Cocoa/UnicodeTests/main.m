//
//  main.m
//  UnicodeTests
//
//  Created by Peter W A Wood on 14/05/2014.
//  Copyright (c) 2014 Peter W A Wood. All rights reserved.
//

#import <Foundation/Foundation.h>

int passed = 0;
int failed = 0;
NSString *testName;

void testFailed() {
    failed += 1;
    printf("Test %s Failed\n", [testName UTF8String]);
}

int countGraphemeClusters(NSString *str) {
    int graphemeClusterCount = 0;
    for (int i=0; i < [str length]; ++graphemeClusterCount) {
        i += [str rangeOfComposedCharacterSequenceAtIndex:i].length;
    }
    return graphemeClusterCount;
}

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        NSString *unicodeString;
        NSMutableString *reversed = [NSMutableString stringWithCapacity:10];
        NSMutableString *changed = [NSMutableString stringWithCapacity:25];
        NSMutableArray *graphemeClusters = [NSMutableArray arrayWithCapacity:10];
        NSRange aCluster;
        NSRange substrRange;
        int position;
        int elements;
        NSLocale *turkish = [[NSLocale alloc] initWithLocaleIdentifier:@"tr_TR"];
        NSLocale *german = [[NSLocale alloc] initWithLocaleIdentifier:@"de_DE"];
        
        testName = @"Unicode  1";
        unicodeString = @"c\u0327";
        if ([unicodeString isEqualToString:[@"\u00E7" decomposedStringWithCanonicalMapping]]) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 2";
        unicodeString = @"c\u0327";
        if (![unicodeString isEqualToString:@"\u00E7"]) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 3";
        unicodeString = @"noe\u0308l";
        if (countGraphemeClusters(unicodeString) == 4) {
            passed += 1;
        } else {
            testFailed();
        }

        testName = @"Unicode 4";
        unicodeString = @"noe\u0308l";
        position = 0;
        elements = -1;
        while (position < [unicodeString length]) {
            aCluster = [unicodeString rangeOfComposedCharacterSequenceAtIndex:position];
            position += aCluster.length;
            [graphemeClusters addObject:[NSValue valueWithRange:aCluster]];
            elements += 1;
        }
        for (int i = elements; i > -1; i--) {
            [reversed appendString:[unicodeString substringWithRange:[[graphemeClusters objectAtIndex:i] rangeValue]]];
        }
        if ([reversed isEqualToString:@"le\u0308on"]) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 5";
        unicodeString = @"noe\u0308l";
        elements = 3;
        for (position = 0; (position < 3) && (position < [unicodeString length]); ++elements) {
            position += [unicodeString rangeOfComposedCharacterSequenceAtIndex:position].length;
        }
        substrRange.location = 0;
        substrRange.length = position;
        if ([[unicodeString substringWithRange:substrRange] isEqualToString:@"noe\u0308"]) {
            passed += 1;
        } else {
            testFailed();
        }
    
        testName = @"Unicode 6";
        unicodeString = @"ba\uFB04e";
        if ([[unicodeString uppercaseString] isEqualToString: @"BAFFLE"]) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 7";
        unicodeString = @"cant\u00F9";
        if ([[unicodeString uppercaseString] isEqualToString:@"CANT\u00D9"]) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 8";
        unicodeString = @"cantu\u0300";
        if ([[unicodeString uppercaseString] isEqualToString:@"CANTU\u0300"]) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 9";
        unicodeString = @"\U0001D11E - The Treble Clef";
        [changed setString:unicodeString];
        [changed replaceOccurrencesOfString:@"\U0001D11E"
                                 withString:@"\U0001D122"
                                    options: 0
                                      range: NSMakeRange(0, [unicodeString length])];
        [changed replaceOccurrencesOfString:@"Treble"
                                 withString:@"Bass"
                                    options:0
                                      range:NSMakeRange(0, [unicodeString length])];
        if ([changed isEqualToString:@"\U0001D122 - The Bass Clef"]) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 10";
        unicodeString = @"\U0001D122 - The Bass Clef";
        if (countGraphemeClusters(unicodeString) == 17) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 11";
        unicodeString = @"i";
        if ([[unicodeString uppercaseStringWithLocale:turkish] isEqualToString:@"\u0130"]) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 12";
        unicodeString = @"I";
        if ([[unicodeString lowercaseStringWithLocale:turkish] isEqualToString:@"\u0131"]) {
         passed += 1;
        } else {
         testFailed();
        }
        
        testName = @"Unicode 13";
        unicodeString = @"stra\u00DFe";
        if ([[unicodeString uppercaseString] isEqualToString:@"STRASSE"]) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 14";
        unicodeString = @"\u03C8\u3099";
        if (countGraphemeClusters(unicodeString) == 1) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 15";
        unicodeString = @"e\u0308\U0001D11E\u03C8\u3099";
        if (countGraphemeClusters(unicodeString) == 3) {
            passed += 1;
        } else {
            testFailed();
        }
        
        testName = @"Unicode 16";
        unicodeString = @"wei\u00DF";
        if (NSOrderedSame == [unicodeString compare:@"weiss"
                                            options:NSCaseInsensitiveSearch
                                              range:NSMakeRange(0, [unicodeString length])
                                             locale:german]) {
            passed += 1;
        } else {
            testFailed();
        }
        
        printf("Number of Tests: %d\n", passed + failed);
        printf("Number Passed:   %d\n", passed);
        printf("Number Failed:   %d\n", failed);
       
        
    }
    return 0;
}


