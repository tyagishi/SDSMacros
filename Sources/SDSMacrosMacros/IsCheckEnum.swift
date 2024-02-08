//
//  IsCheckEnum.swift
//
//  Created by : Tomoaki Yagishita on 2024/02/05
//  © 2024  SmallDeskSoftware
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `IsCheckEnum` macro.
/// This macro will generate type check method for each cases in enum
///
/// For each cases, method "is<CaseName>" will be generated for type check
/// enum MyCase {
///     case p1
///     case p2
/// }
///
/// will be expanded to
///
/// enum MyCase {
///     case p1
///     case p2
///
///     var isP1: Bool {
///         if case .p1 = self {
///             return true
///         }
///
///     var isP1: Bool {
///         if case .p1 = self {
///             return true
///         }
/// }
///
/// For above example, you can check enum case with ease.
///
/// let caseP1 = MyCase.p1
/// let caseP2 = MyCase.p2
///
/// caseP1.isP1 will return true
/// caseP1.isP2 will return false
///
/// caseP2.isP1 will return false
/// caseP2.isP2 will return true
///
public struct IsCheckEnumMacro: MemberMacro {
    public static func expansion(of node: AttributeSyntax,
                                 providingMembersOf declaration: some DeclGroupSyntax,
                                 //                                 conformingTo protocols: [TypeSyntax],
                                 in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard declaration.is(EnumDeclSyntax.self) else {
            throw SDSMacroError.isCheckEnumOnlyApplicableToEnum
        }
        let check = declaration.memberBlock.members
            .compactMap { $0.decl.as(EnumCaseDeclSyntax.self) }
            .flatMap({ $0.elements })
            .map({ $0.name })
            .map { ($0, $0.initialUppercased) }
            .map { original, uppercased in
          """
          var is\(uppercased): Bool {
            if case .\(original) = self {
              return true
            }
          
            return false
          }
          """
            }
        return check.map({ DeclSyntax(stringLiteral: $0)  })
    }
}

extension TokenSyntax {
    fileprivate var initialUppercased: String {
        let name = self.text
        guard let initial = name.first else {
            return name
        }
        
        return "\(initial.uppercased())\(name.dropFirst())"
    }
}
