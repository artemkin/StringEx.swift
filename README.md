StringEx.swift
==============

Useful Extensions of Swift String

String to number conversion
---------------------------

```swift
extension String {

    /// If the string represents an unsigned integer that fits into a specified
    /// unsigned integer type, returns the corresponding integer.
    /// This accepts strings that match the regular expression "[0-9]+" only.
    func toUInt()   -> UInt?
    func toUInt8()  -> UInt8?
    func toUInt16() -> UInt16?
    func toUInt32() -> UInt32?
    func toUInt64() -> UInt64?

    /// If the string represents an integer that fits into a specified integer type,
    /// returns the corresponding integer.  This accepts strings that match the regular
    /// expression "[-+]?[0-9]+" only.
    func toInt8()   -> Int8?
    func toInt16()  -> Int16?
    func toInt32()  -> Int32?
    func toInt64()  -> Int64?

    /// If the string represents a floating point number, returns the corresponding
    /// number as double. It is more strict than C strtod: whitespace characters
    /// and empty strings aren't allowed.
    func toDouble() -> Double?
}
```
