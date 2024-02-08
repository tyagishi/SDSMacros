# SDSMacros
convenient macro library for swift

### IsCheckEnum macro for enum
```swift
/// Implementation of the `IsCheckEnum` macro.
/// This macro will generate type check method for each cases in enum
///
/// For each cases, method "is<CaseName>" will be generated for type check
@IsCheckEnum
enum MyCase {
    case p1
    case p2
}

/// will be expanded to

enum MyCase {
    case p1
    case p2

    var isP1: Bool {
        if case .p1 = self {
            return true
        }

    var isP1: Bool {
        if case .p1 = self {
            return true
        }
}
///
```

### AssociateEnumValues for enum
```swift
/// Implementation of the `AssociateEnumValues` macro.
/// This macro will generate accessor for associated values.
///
/// For cases which has associated value(s), method "<caseName>Values" will be generated to access associated value(s).
///
@AssociateValueEnum
enum MyCase {
    case p0
    case p1(Double,Int)
}

///   will be expanded to

enum MyCase {
    case p0
    case p1(Double,Int)

    var p1Values: (Double, Int)? {
      if case .p1(let value1, let value2) = self {
        return (value1, value2)
      }
      return nil
    }
}
///
```

### DidChangeObject for class
```swift
/// Implementation of the `DidChangeObject` macro.
/// This macro will generate objectDidChange publisher in attached class.
///
@DidChangeObject<ChangeType>
class MyClass {
    ....
}

///   will be expanded to

class MyClass {
    ....

    public let objectDidChange: PassthroughSubject<ChangeType, Never> = PassthroughSubject()
}
///
/// note: need to specify change type as generic parameter
///         if no change info is necessary, use Void
///
```
