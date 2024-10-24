// The Swift Programming Language
// https://docs.swift.org/swift-book
import Combine

@attached(member, names: arbitrary)
public macro IsCheckEnum() = #externalMacro(module: "SDSMacrosMacros", type: "IsCheckEnumMacro")

@attached(member, names: arbitrary)
public macro AssociatedValueEnum() = #externalMacro(module: "SDSMacrosMacros", type: "AssociatedValueEnumMacro")

public protocol ObjectDidChangeProvider {
    associatedtype ChangeType
    var objectDidChange: PassthroughSubject<ChangeType, Never> { get }
}

@attached(member, names: arbitrary)
@attached(extension, conformances: ObjectDidChangeProvider, names: arbitrary)
public macro DidChangeObject<ChangeType> () = #externalMacro(module: "SDSMacrosMacros", type: "DidChangeObjectMacro")

