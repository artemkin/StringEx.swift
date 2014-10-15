//
//  StringEx.swift
//  StringEx
//
//  Copyright (c) 2014 Stanislav Artemkin <artemkin@gmail.com>. All rights reserved.
//

import Foundation


extension String {

    /// If the string represents an unsigned integer that fits into a specified
    /// unsigned integer type, returns the corresponding integer.
    /// This accepts strings that match the regular expression "[0-9]+" only.
    public func toUInt()   -> UInt?   { return toUnsignedT() }
    public func toUInt8()  -> UInt8?  { return toUnsignedT() }
    public func toUInt16() -> UInt16? { return toUnsignedT() }
    public func toUInt32() -> UInt32? { return toUnsignedT() }
    public func toUInt64() -> UInt64? { return toUnsignedT() }

    /// If the string represents an integer that fits into a specified integer type,
    /// returns the corresponding integer.  This accepts strings that match the regular
    /// expression "[-+]?[0-9]+" only.
    public func toInt8()   -> Int8?   { return toSignedT() }
    public func toInt16()  -> Int16?  { return toSignedT() }
    public func toInt32()  -> Int32?  { return toSignedT() }
    public func toInt64()  -> Int64?  { return toSignedT() }

    /// If the string represents a floating point number, returns the corresponding
    /// number as double. It is more strict than C strtod: whitespace characters
    /// and empty strings aren't allowed.
    public func toDouble() -> Double? { return toDoubleImpl() }
}

protocol UnsignedIntegerTypeEx: UnsignedIntegerType {
    class var max: Self { get }
    init(_: UInt32)
}
extension UInt:   UnsignedIntegerTypeEx {}
extension UInt8:  UnsignedIntegerTypeEx {}
extension UInt16: UnsignedIntegerTypeEx {}
extension UInt32: UnsignedIntegerTypeEx {}
extension UInt64: UnsignedIntegerTypeEx {}

extension String {
    func toUnsignedT<T: UnsignedIntegerTypeEx>() -> T? {
        if self.isEmpty {
            return nil
        }

        let maxDiv10 = T.max / 10

        var x: T = 0
        for ch in self.unicodeScalars {
            let value = ch.value
            if value < 0x30 || value > 0x39 || x > maxDiv10 {
                return nil
            }
            x *= 10
            let num = T(value - 0x30)
            if x > (T.max - num) {
                return nil
            }
            x += num
        }
        return x
    }
}


protocol SignedIntegerTypeEx: SignedIntegerType {
    class var max: Self { get }
    class var min: Self { get }
    init(_: UInt32)
}
extension Int8:  SignedIntegerTypeEx {}
extension Int16: SignedIntegerTypeEx {}
extension Int32: SignedIntegerTypeEx {}
extension Int64: SignedIntegerTypeEx {}

extension String {
    func toSignedT<T: SignedIntegerTypeEx>() -> T? {
        if self.isEmpty {
            return nil
        }

        var characters = self.unicodeScalars
        let firstVal = first(characters)!.value
        let isMinus = firstVal == 0x2D
        if isMinus || firstVal == 0x2B /* + */ {
            characters = dropFirst(characters)
            if characters.startIndex == characters.endIndex {
                return nil
            }
        }

        if isMinus {
            let minDiv10 = T.min / 10
            var x: T = 0

            for ch in characters {
                let value = ch.value
                if value < 0x30 || value > 0x39 || x < minDiv10 {
                    return nil
                }
                x *= 10
                let num = T(value - 0x30)
                if x < (T.min + num) {
                    return nil
                }
                x -= num
            }
            return x
        }

        let maxDiv10 = T.max / 10
        var x: T = 0

        for ch in characters {
            let value = ch.value
            if value < 0x30 || value > 0x39 || x > maxDiv10 {
                return nil
            }
            x *= 10
            let num = T(value - 0x30)
            if x > (T.max - num) {
                return nil
            }
            x += num
        }
        return x
    }
}

extension String {

    func toDoubleImpl() -> Double? {
        if self.isEmpty || self.hasPrefix(" ") {
            return nil
        }

        return self.withCString() { p -> Double? in
            var end: UnsafeMutablePointer<Int8> = nil
            let result = strtod(p, &end)
            return end.memory != 0 ? nil : result
        }
    }
}
