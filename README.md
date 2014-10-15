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
    public func toUInt()   -> UInt?
    public func toUInt8()  -> UInt8?
    public func toUInt16() -> UInt16?
    public func toUInt32() -> UInt32?
    public func toUInt64() -> UInt64?

    /// If the string represents an integer that fits into a specified integer type,
    /// returns the corresponding integer.  This accepts strings that match the regular
    /// expression "[-+]?[0-9]+" only.
    public func toInt8()   -> Int8?
    public func toInt16()  -> Int16?
    public func toInt32()  -> Int32?
    public func toInt64()  -> Int64?

    /// If the string represents a floating point number, returns the corresponding
    /// number as double. It is more strict than C strtod: whitespace characters
    /// and empty strings aren't allowed.
    public func toDouble() -> Double?
}
```
