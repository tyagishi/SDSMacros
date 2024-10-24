//
//  DidChangeObject.swift
//
//  Created by : Tomoaki Yagishita on 2024/02/07
//  © 2024  SmallDeskSoftware
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `DidChangeObject` macro.
/// This macro will generate objectDidChange publisher in attached class.
///
/// @DidChangeObject<ChangeType>
/// class MyClass {
///     ....
/// }
///
///   will be expanded to
///
/// class MyClass {
///     ....
///
///     public let objectDidChange: PassthroughSubject<ChangeType, Never> = PassthroughSubject()
/// }
///
/// note: need to specify change type as generic parameter
///         if no change info is necessary, use Void
///
///
public struct DidChangeObjectMacro: MemberMacro, ExtensionMacro {
    public static func expansion(of node: AttributeSyntax,
                                 providingMembersOf declaration: some DeclGroupSyntax,
                                 //                                 conformingTo protocols: [TypeSyntax],
                                 in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard declaration.is(ClassDeclSyntax.self) else {
            throw SDSMacroError.didChangeObjectOnlyApplicableToClass
        }
        
        guard let genericClause = node.attributeName.as(IdentifierTypeSyntax.self)?.genericArgumentClause,
              genericClause.arguments.count == 1,
              let changeType = genericClause.arguments.first?.argument else {
            throw SDSMacroError.didChangeObjectNeedsGenericParameterForChangeType
        }
        
        return [DeclSyntax(stringLiteral: "public let objectDidChange: PassthroughSubject<\(changeType),Never> = PassthroughSubject()")]
    }

    public static func expansion(of node: AttributeSyntax, attachedTo declaration: some DeclGroupSyntax,
                                 providingExtensionsOf type: some TypeSyntaxProtocol,
                                 conformingTo protocols: [TypeSyntax],
                                 in context: some MacroExpansionContext) throws -> [ExtensionDeclSyntax] {
        guard declaration.is(ClassDeclSyntax.self) else { return [] } // should be reported already

        guard let genericClause = node.attributeName.as(IdentifierTypeSyntax.self)?.genericArgumentClause,
              genericClause.arguments.count == 1,
              let changeType = genericClause.arguments.first?.argument else { return [] } // should be reported already

        return [try ExtensionDeclSyntax("""
                                        extension \(type): ObjectDidChangeProvider {
                                            public typealias ChangeType = \(changeType)
                                        }
                                        """)]
    }
}
