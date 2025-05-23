//
//  AssociateEnumValuesTests.swift
//
//  Created by : Tomoaki Yagishita on 2024/02/06
//  © 2024  SmallDeskSoftware
//

import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

final class AssociatedValueEnumTests: XCTestCase {
    
    func test_AssociatedValueEnum_OneInt() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1(Int)
            }
            """, expandedSource: """

            enum MyCase {
                case p1(Int)

                var p1Values: (Int)? {
                  if case .p1(let value1) = self {
                    return (value1)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }


    
    func test_AssociatedValueEnum_OneDouble() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1(Double)
            }
            """, expandedSource: """

            enum MyCase {
                case p1(Double)

                var p1Values: (Double)? {
                  if case .p1(let value1) = self {
                    return (value1)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_OneOptionalDouble() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1(Double?)
            }
            """, expandedSource: """

            enum MyCase {
                case p1(Double?)

                var p1Values: (Double?)? {
                  if case .p1(let value1) = self {
                    return (value1)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_WithNoAssociateValue() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1(Double)
                case p2
            }
            """, expandedSource: """

            enum MyCase {
                case p1(Double)
                case p2

                var p1Values: (Double)? {
                  if case .p1(let value1) = self {
                    return (value1)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_IntAndDouble() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1(Int)
                case p2(Double)
            }
            """, expandedSource: """

            enum MyCase {
                case p1(Int)
                case p2(Double)

                var p1Values: (Int)? {
                  if case .p1(let value1) = self {
                    return (value1)
                  }
                  return nil
                }
            
                var p2Values: (Double)? {
                  if case .p2(let value1) = self {
                    return (value1)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_OptionalIntAndDouble() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1(Int?)
                case p2(Double)
            }
            """, expandedSource: """

            enum MyCase {
                case p1(Int?)
                case p2(Double)

                var p1Values: (Int?)? {
                  if case .p1(let value1) = self {
                    return (value1)
                  }
                  return nil
                }
            
                var p2Values: (Double)? {
                  if case .p2(let value1) = self {
                    return (value1)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_IntDouble() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1(Double,Int)
            }
            """, expandedSource: """

            enum MyCase {
                case p1(Double,Int)

                var p1Values: (Double, Int)? {
                  if case .p1(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_IntDoubleAndStringFloat() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1(Double,Int)
                case p2(String,Float)
            }
            """, expandedSource: """

            enum MyCase {
                case p1(Double,Int)
                case p2(String,Float)

                var p1Values: (Double, Int)? {
                  if case .p1(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }

                var p2Values: (String, Float)? {
                  if case .p2(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_IntOptionalDoubleAndStringFloat() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1(Double?,Int)
                case p2(String,Float)
            }
            """, expandedSource: """

            enum MyCase {
                case p1(Double?,Int)
                case p2(String,Float)

                var p1Values: (Double?, Int)? {
                  if case .p1(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }

                var p2Values: (String, Float)? {
                  if case .p2(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_IntDoubleAndStringFloatInOneLine() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1(Double,Int), p2(String,Float)
            }
            """, expandedSource: """

            enum MyCase {
                case p1(Double,Int), p2(String,Float)

                var p1Values: (Double, Int)? {
                  if case .p1(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }

                var p2Values: (String, Float)? {
                  if case .p2(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_IntDoubleAndStringOptionalFloatInOneLine() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1(Double,Int), p2(String,Float?)
            }
            """, expandedSource: """

            enum MyCase {
                case p1(Double,Int), p2(String,Float?)

                var p1Values: (Double, Int)? {
                  if case .p1(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }

                var p2Values: (String, Float?)? {
                  if case .p2(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_IntArrayDouble() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            enum MyCase {
                case p1([Double],Int), p2(String,Float)
            }
            """, expandedSource: """

            enum MyCase {
                case p1([Double],Int), p2(String,Float)

                var p1Values: ([Double], Int)? {
                  if case .p1(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }

                var p2Values: (String, Float)? {
                  if case .p2(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_InheritAccessLevel() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion("""
            @AssociatedValueEnum
            public enum MyCase {
                case p1([Double],Int), p2(String,Float)
            }
            """, expandedSource: """

            public enum MyCase {
                case p1([Double],Int), p2(String,Float)

                public var p1Values: ([Double], Int)? {
                  if case .p1(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }

                public var p2Values: (String, Float)? {
                  if case .p2(let value1, let value2) = self {
                    return (value1, value2)
                  }
                  return nil
                }
            }
            """, macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: error cases
    func test_AssociatedValueEnum_OnStruct() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion(
            """
            @AssociatedValueEnum
            struct MyStruct {
                var value: Int = 0
            }
            """, expandedSource: """
            
            struct MyStruct {
                var value: Int = 0
            }
            """,
            diagnostics: [
                DiagnosticSpec(message: "@AssociatedValueEnum can only be applied to  an enum", line: 1, column: 1)
            ],
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    // MARK: associate value type
    func test_AssociatedValueEnum_AssociateValue_MyOwnClass() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion(
            """
            class MyOwnClass {
                var value:Int = 1
            }

            @AssociatedValueEnum
            enum MyCase {
                case p1(MyOwnClass)
            }
            """, expandedSource: """
            class MyOwnClass {
                var value:Int = 1
            }
            enum MyCase {
                case p1(MyOwnClass)
            
                var p1Values: (MyOwnClass)? {
                  if case .p1(let value1) = self {
                    return (value1)
                  }
                  return nil
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_AssociateValue_MyValueType() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion(
            """
            struct MyOwnStruct {
                var value:Int = 1
            }

            @AssociatedValueEnum
            enum MyCase {
                case p1(MyOwnStruct)
            }
            """, expandedSource: """
            struct MyOwnStruct {
                var value:Int = 1
            }
            enum MyCase {
                case p1(MyOwnStruct)
            
                var p1Values: (MyOwnStruct)? {
                  if case .p1(let value1) = self {
                    return (value1)
                  }
                  return nil
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
    
    func test_AssociatedValueEnum_AssociateValue_assosiatedType() throws {
        #if canImport(SDSMacros)
        assertMacroExpansion(
            """
            struct MyOwnStruct: Identifiable {
                var id: UUID = UUID()
                var value:Int = 1
            }

            @AssociatedValueEnum
            enum MyCase {
                case p1(MyOwnStruct.ID)
            }
            """, expandedSource: """
            struct MyOwnStruct: Identifiable {
                var id: UUID = UUID()
                var value:Int = 1
            }
            enum MyCase {
                case p1(MyOwnStruct.ID)
            
                var p1Values: (MyOwnStruct.ID)? {
                  if case .p1(let value1) = self {
                    return (value1)
                  }
                  return nil
                }
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
//    func test_AssociatedValueEnum_TwoCasesInOneCase() throws {
//        #if canImport(SDSMacros)
//        assertMacroExpansion(
//            """
//            @AssociatedValueEnum
//            enum MyCase {
//                case p1(Int), p2(Double)
//            }
//            """, expandedSource: """
//            
//            enum MyCase {
//                case p1(Int), p2(Double)
//            }
//            """,
//            diagnostics: [
//                DiagnosticSpec(message: "@AssociateValueEnum does not support many cases definition in one case", line: 1, column: 1)
//            ],
//            macros: testMacros
//        )
//        #else
//        throw XCTSkip("macros are only supported when running tests for the host platform")
//        #endif
//    }
}
