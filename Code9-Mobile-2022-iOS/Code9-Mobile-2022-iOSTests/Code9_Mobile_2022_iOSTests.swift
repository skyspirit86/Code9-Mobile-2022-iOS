//
//  Code9_Mobile_2022_iOSTests.swift
//  Code9-Mobile-2022-iOSTests
//
//  Created by Zolt Varga on 4/23/22.
//

import XCTest
@testable import Code9_Mobile_2022_iOS

class Code9_Mobile_2022_iOSTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - UserName

    func testLoginServiceValidation_UserName5Char_Fail() throws {
        // 1. Given
        let testUserName = "krco5"
        
        // 2. When
        let state = LoginService.isValideUsername(text: testUserName)
        
        // 3. Then
        XCTAssertFalse(state, "Username with less and equal then 5 chars should fail.")
    }
    
    func testLoginServiceValidation_UserName5Char_Success() throws {
        // 1. Given
        let testUserName = "krco56"
        
        // 2. When
        let state = LoginService.isValideUsername(text: testUserName)
        
        // 3. Then
        XCTAssertTrue(state, "Username with more then 6 chars should fail.")
    }
    
    // MARK: - Password
    
    func testLoginServiceValidation_PasswordValid_Success() throws {
        // 1. Given
        let testPassword = "Code9abcd!"
        
        // 2. When
        let state = LoginService.isValidePassword(text: testPassword)
        
        // 3. Then
        XCTAssertTrue(state, "Valid password failed")
    }
    
    func testLoginServiceValidation_PasswordToShort_Fail() throws {
        // 1. Given
        let testPassword = "abc"
        
        // 2. When
        let state = LoginService.isValidePassword(text: testPassword)
        
        // 3. Then
        XCTAssertFalse(state, "Password is to short")
    }
    
    func testLoginServiceValidation_PasswordWhiteSpace_Fail() throws {
        // 1. Given
        let testPassword = " abc "
        
        // 2. When
        let state = LoginService.isValidePassword(text: testPassword)
        
        // 3. Then
        XCTAssertFalse(state, "Password have whitespace")
    }
    
    func testLoginServiceValidation_PasswordOnlyNumber_Fail() throws {
        // 1. Given
        let testPassword = "123456789"
        
        // 2. When
        let state = LoginService.isValidePassword(text: testPassword)
        
        // 3. Then
        XCTAssertFalse(state, "Password have at least one digit")
    }
    
    func testLoginServiceValidation_PasswordOnlyLetters_Fail() throws {
        // 1. Given
        let testPassword = "abcdefgh"
        
        // 2. When
        let state = LoginService.isValidePassword(text: testPassword)
        
        // 3. Then
        XCTAssertFalse(state, "Password have only letters")
    }
    
    func testLoginServiceValidation_PasswordNoSign_Fail() throws {
        // 1. Given
        let testPassword = "Code9abcdd"
        
        // 2. When
        let state = LoginService.isValidePassword(text: testPassword)
        
        // 3. Then
        XCTAssertFalse(state, "Password need at least one symbol")
    }
    
    func testLoginServiceValidation_PasswordNoUpperCase_Fail() throws {
        // 1. Given
        let testPassword = "code9abcd"
        
        // 2. When
        let state = LoginService.isValidePassword(text: testPassword)
        
        // 3. Then
        XCTAssertFalse(state, "Password need at least one uppercase")
    }
}
