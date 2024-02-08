//
//  AssociateEnumValues.swift
//
//  Created by : Tomoaki Yagishita on 2024/02/06
//  © 2024  SmallDeskSoftware
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

/// Implementation of the `AssociateValueEnum` macro.
/// This macro will generate accessor for associated values.
///
/// For cases which has associated value(s), method "<caseName>Values" will be generated to access associated value(s).
///
/// @AssociateValueEnum
/// enum MyCase {
///     case p0
///     case p1(Double,Int)
/// }
///
///   will be expanded to
///
/// enum MyCase {
///     case p0
///     case p1(Double,Int)
///
///     var p1Values: (Double, Int)? {
///       if case .p1(let value1, let value2) = self {
///         return (value1, value2)
///       }
///       return nil
///     }
/// }
///
/// For above example, you can get associated values like followings
///
/// let caseP0 = MyCase.p0
/// let caseP1 = MyCase.p1(1.0, 2)
///
/// let values0 = caseP0.p1Values
/// // values0 should be nil because caseP0 is not p1
/// // and since p0 does not have any associateValue, method "p0Values" will NOT be generated
///
/// since p1 has associated value, method "p1Values" is generated for easy access
/// if let values1 = caseP1.p1Values {
///     // values1.0 should be 1.0
///     // values1.1 should be 2
/// }
///
public struct AssociatedValueEnumMacro: MemberMacro {
    public static func expansion(of node: AttributeSyntax,
                                 providingMembersOf declaration: some DeclGroupSyntax,
                                 //                                 conformingTo protocols: [TypeSyntax],
                                 in context: some MacroExpansionContext) throws -> [DeclSyntax] {
        guard declaration.is(EnumDeclSyntax.self) else {
            throw SDSMacroError.associatedValueEnumOnlyApplicableToEnum
        }
        
        var lines: [String] = []
        
        for member in declaration.memberBlock.members {
            guard let enumCase = member.decl.as(EnumCaseDeclSyntax.self) else { continue }

            // oneCase: EnumCaseElementSyntax
            // parameterClause : EnumCaseParameterClauseSyntax
            for caseElement in enumCase.elements {
                guard let parameterClause = caseElement.parameterClause else { continue }
                
                let parameters: EnumCaseParameterListSyntax = parameterClause.parameters
                
                var retTypes: [String] = []
                var values: [String] = []
                var retValues: [String] = []
                var valueIndex = 1
                for parameter in parameters {
                    guard let identifierType = parameter.type.as(IdentifierTypeSyntax.self) else { continue }
                    retTypes.append(identifierType.name.text)
                    values.append("let value\(valueIndex)")
                    retValues.append("value\(valueIndex)")
                    valueIndex += 1
                }
                
                lines.append("""
                               var \(caseElement.name)Values: (\(retTypes.joined(separator: ",")))? {
                                 if case .\(caseElement.name)(\(values.joined(separator: ","))) = self {
                                   return (\(retValues.joined(separator: ",")))
                                 }
                                 return nil
                               }
                               """)
            }
        }
        return lines.map({ DeclSyntax(stringLiteral: $0) })
    }
}

