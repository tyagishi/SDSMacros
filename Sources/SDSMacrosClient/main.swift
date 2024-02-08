import SDSMacros
import Combine

@IsCheckEnum
enum MyCase2 {
    case p1
    case p2
    case p3(Int)
}

@AssociatedValueEnum
enum MyCase3 {
    case p1
    case p2
    case p3(Int)
}

@DidChangeObject<Void>
class MyClass {
}
