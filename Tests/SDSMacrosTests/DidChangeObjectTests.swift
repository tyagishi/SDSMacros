//
//  File.swift
//
//  Created by : Tomoaki Yagishita on 2024/02/07
//  © 2024  SmallDeskSoftware
//


import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class DidChangeObjectTests: XCTestCase {
    
    func test_DidChangeObjectTests_basic() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @DidChangeObject<Int>
            class MyClass {
            }
            """, expandedSource: """

            class MyClass {
            
                public let objectDidChange: PassthroughSubject<Int, Never> = PassthroughSubject()
            }
            
            extension MyClass: ObjectDidChangeProvider {
                typealias ChangeDetailType = Int
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func test_DidChangeObjectTests_tupple() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @DidChangeObject<(Int,Double)>
            class MyClass {
            }
            """, expandedSource: """

            class MyClass {
            
                public let objectDidChange: PassthroughSubject<(Int, Double), Never> = PassthroughSubject()
            }
            
            extension MyClass: ObjectDidChangeProvider {
                typealias ChangeDetailType = (Int, Double)
            }
            """,
             macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func test_DidChangeObjectTests_internalType() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @DidChangeObject<MyChange>
            class MyClass {
              struct MyChange {}
            }
            """, expandedSource: """

            class MyClass {
              struct MyChange {}

                public let objectDidChange: PassthroughSubject<MyChange, Never> = PassthroughSubject()
            }
            
            extension MyClass: ObjectDidChangeProvider {
                typealias ChangeDetailType = MyChange
            }
            """,
             macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    // MARK: error cases
    func test_DidChangeObjectTests_onStruct() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion(
            """
            @DidChangeObject<Int>
            struct MyStruct {
                var value: Int = 0
            }
            """, expandedSource: """
            
            struct MyStruct {
                var value: Int = 0
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "@DidChangeObject can only be applied to a class", line: 1, column: 1)
            ],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_DidChangeObjectTests_ApplyWithoutGenerics() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion(
            """
            @DidChangeObject
            class MyStruct {
                var value: Int = 0
            }
            """, expandedSource: """
            
            class MyStruct {
                var value: Int = 0
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "@DidChangeObject needs one Generic parameter to indicate change type", line: 1, column: 1)
            ],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}

    
