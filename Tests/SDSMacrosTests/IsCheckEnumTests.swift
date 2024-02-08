//
//  IsCheckEnumTests.swift
//
//  Created by : Tomoaki Yagishita on 2024/02/05
//  © 2024  SmallDeskSoftware
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class IsCheckEnumTests: XCTestCase {
    
    func testIsCheckEnumBasic() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @IsCheckEnum
            enum MyCase {
                case p1
                case p2
            }
            """, expandedSource: """

            enum MyCase {
                case p1
                case p2
            
                var isP1: Bool {
                  if case .p1 = self {
                    return true
                  }

                  return false
                }

                var isP2: Bool {
                  if case .p2 = self {
                    return true
                  }

                  return false
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func test_IsCheckEnumOnStruct() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion(
            """
            @IsCheckEnum
            struct MyStruct {
                var value: Int = 0
            }
            """, expandedSource: """
            
            struct MyStruct {
                var value: Int = 0
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "@IsCheckEnum can only be applied to  an enum", line: 1, column: 1)
            ],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
