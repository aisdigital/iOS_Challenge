//
//  APIResquestTests.swift
//  ios-challengeTests
//
//  Created by Caio Madeira on 10/06/21.
//

import XCTest

class APIResquestTests: XCTestCase {

    override func setUpWithError() throws {


    }

    override func tearDownWithError() throws {

    }

    func test_make_request_and_wait_for_response_or_errors() throws {
        let urlExample = "https://api.themoviedb.org/3/movie/550?api_key=fc7b558bc5ed606ada8b90b526bb85ee"
        //let apiKeyV3 = "fc7b558bc5ed606ada8b90b526bb85ee"
        //let apiHost = "https://api.themoviedb.org/3"
        
        let url = URL(string: urlExample)!
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            print("response: \(String(describing:response))")
            print("error: \(String(describing: error))")
            
            
        }
        session.resume()
        XCTAssertEqual(session, session)
        XCTAssertEqual(session, nil)
        //("Optional(LocalDataTask <38A7A569-B372-4CDB-9481-A12E6CAC6723>.<1>)") is not equal to ("nil")
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
