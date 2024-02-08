import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@main
struct SDSMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        IsCheckEnumMacro.self,
        AssociatedValueEnumMacro.self,
        DidChangeObjectMacro.self,
    ]
}

enum SDSMacroError: CustomStringConvertible, Error {
    // macro: IsCheckEnum
    case isCheckEnumOnlyApplicableToEnum

    // macro: AssociateValueEnum
    case associatedValueEnumOnlyApplicableToEnum
    case associatedValueEnumDoesNotSupportManyCaseInOneLine
    
    // macro: DidChangeObject
    case didChangeObjectOnlyApplicableToClass
    case didChangeObjectNeedsGenericParameterForChangeType

    var description: String {
        switch self {
        case .isCheckEnumOnlyApplicableToEnum: return "@IsCheckEnum can only be applied to  an enum"
        case .associatedValueEnumOnlyApplicableToEnum: return "@AssociatedValueEnum can only be applied to  an enum"
        case .associatedValueEnumDoesNotSupportManyCaseInOneLine: return "@AssociatedValueEnum does not support many cases definition in one case"
        case .didChangeObjectOnlyApplicableToClass: return "@DidChangeObject can only be applied to a class"
        case .didChangeObjectNeedsGenericParameterForChangeType: return "@DidChangeObject needs one Generic parameter to indicate change type"
        }
    }
}



