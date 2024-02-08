// The Swift Programming Language
// https://docs.swift.org/swift-book

@attached(member, names: arbitrary)
public macro IsCheckEnum() = #externalMacro(module: "SDSMacrosMacros", type: "IsCheckEnumMacro")

@attached(member, names: arbitrary)
public macro AssociatedValueEnum() = #externalMacro(module: "SDSMacrosMacros", type: "AssociatedValueEnumMacro")

@attached(member, names: arbitrary)
public macro DidChangeObject<ChangeType> () = #externalMacro(module: "SDSMacrosMacros", type: "DidChangeObjectMacro")
