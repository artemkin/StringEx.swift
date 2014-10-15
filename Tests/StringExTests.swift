//
//  StringExTests.swift
//  StringExTests
//
//  Copyright (c) 2014 Stanislav Artemkin <artemkin@gmail.com>. All rights reserved.
//

import XCTest
import StringEx

class StringExTests: XCTestCase {
    
    func test_stringToUInt() {
        XCTAssert("".toUInt() == nil)
        XCTAssert(" ".toUInt() == nil)
        XCTAssert(" 1".toUInt() == nil)
        XCTAssert("1 ".toUInt() == nil)
        XCTAssert("-1".toUInt() == nil)
        XCTAssert("0".toUInt() == 0)
        XCTAssert("11".toUInt() == 11)
        XCTAssert("12345".toUInt() == 12345)
        XCTAssert(String(UInt.max).toUInt() == UInt.max)
        XCTAssert(String(UInt.min).toUInt() == UInt.min)
        XCTAssert("18446744073709551620".toUInt() == nil) // 18446744073709551620 / 10 * 10 > UInt.max
        XCTAssert("18446744073709551616".toUInt() == nil) // UInt.max + 1
    }

    func test_stringToInt() {
        XCTAssert("".toInt8() == nil)
        XCTAssert(" ".toInt8() == nil)
        XCTAssert("-".toInt8() == nil)
        XCTAssert("+".toInt8() == nil)
        XCTAssert(" 1".toInt8() == nil)
        XCTAssert("1 ".toInt8() == nil)
        XCTAssert("-1".toInt8() == -1)
        XCTAssert("+1".toInt8() == 1)
        XCTAssert("0".toInt8() == 0)
        XCTAssert("11".toInt8() == 11)
        XCTAssert("11.".toInt8() == nil)
        XCTAssert("123".toInt8() == 123)
        XCTAssert("-123".toInt8() == -123)
        XCTAssert("-130".toInt8() == nil)
        XCTAssert("130".toInt8() == nil)
        XCTAssert(String(Int8.max).toInt8() == Int8.max)
        XCTAssert(String(Int8.min).toInt8() == Int8.min)
        XCTAssert("0000000000000000123".toInt8() == 123)
        XCTAssert("+0000000000000000123".toInt8() == 123)
        XCTAssert("-0000000000000000123".toInt8() == -123)
        XCTAssert("--000000000000000123".toInt8() == nil)
        XCTAssert("0-000000000000000123".toInt8() == nil)
        XCTAssert("+-000000000000000123".toInt8() == nil)
    }

    func test_stringToDouble() {
        XCTAssert("".toDouble() == nil)
        XCTAssert(" ".toDouble() == nil)
        XCTAssert("-".toDouble() == nil)
        XCTAssert(".".toDouble() == nil)
        XCTAssert("e".toDouble() == nil)
        XCTAssert("+".toDouble() == nil)
        XCTAssert(" 1".toDouble() == nil)
        XCTAssert("1 ".toDouble() == nil)
        XCTAssert(".1".toDouble() == 0.1)
        XCTAssert(" .1".toDouble() == nil)
        XCTAssert(".1 ".toDouble() == nil)
        XCTAssert("-1".toDouble() == -1)
        XCTAssert("+1".toDouble() == 1)
        XCTAssert("0".toDouble() == 0)
        XCTAssert("11".toDouble() == 11)
        XCTAssert("11.".toDouble() == 11)
        XCTAssert("123".toDouble() == 123)
        XCTAssert("-123".toDouble() == -123)
        XCTAssert("test-123".toDouble() == nil)
        XCTAssert("1 2 3".toDouble() == nil)
        XCTAssert("12e-3".toDouble() == 12e-3)
        XCTAssert("12 e-3".toDouble() == nil)
        XCTAssert("123.45678".toDouble() == 123.45678)
        XCTAssert("-123.45678".toDouble() == -123.45678)
        XCTAssert("0.1".toDouble() == 0.1)
        XCTAssert("0.2".toDouble() == 0.2)
        XCTAssert("0.3".toDouble() == 0.3)
        XCTAssert("1.23456789012345e36".toDouble() == 1.23456789012345e36)
    }
}
