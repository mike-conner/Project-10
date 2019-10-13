//
//  NASA_APPTests.swift
//  NASA APPTests
//
//  Created by Mike Conner on 8/18/19.
//  Copyright © 2019 Mike Conner. All rights reserved.
//

import XCTest
@testable import NASA_APP

class NASA_APPTests: XCTestCase {

    let sessionTest = WebAPI()
    
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }
    
    // test code to return a result of 200 from api.
    func testAsynchronousURLConnection() {
        let URL = NSURL(string: "https://api.nasa.gov/")!
        let myExpectation = expectation(description: "GET \(URL)")

        let session = URLSession.shared
        let task = session.dataTask(with: URL as URL) { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")

            if let HTTPResponse = response as? HTTPURLResponse,
                let responseURL = HTTPResponse.url,
                let MIMEType = HTTPResponse.mimeType
            {
                XCTAssertEqual(responseURL.absoluteString, URL.absoluteString, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(HTTPResponse.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(MIMEType, "text/html", "HTTP response content type should be text/html")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }

            myExpectation.fulfill()
        }

        task.resume()

        waitForExpectations(timeout: task.originalRequest!.timeoutInterval) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            task.cancel()
        }
    }
    
    func testGetMarsPhoto() {
        let myExpectation = expectation(description: "Expecting photo to not be nil")
        sessionTest.getMarsPhotos(rover: .Curiosity, date: "2019-09-13") { (photos) in
            XCTAssertNotNil(photos)
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testGetLocationPhoto() {
        let myExpectation = expectation(description: "Expecting imagge to not be nil")
        sessionTest.getEyeInTheSkyPhoto(lat: 40.6892, lon: 74.0445) { (image) in
            XCTAssertNotNil(image)
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    // Maximum latitude is 90 degrees so by stubbing 91 as my latitude value, I should not be able to decode my data response. This results in failing the 'do' block and sending it to the 'catch' block where I return an image object with a url of "" to run my XCTAssertEqual test.
    func testIncorrectLatitudeData() {
        let myExpectation = expectation(description: "Expecting image to be nil")
        sessionTest.getEyeInTheSkyPhoto(lat: 91, lon: 74.0445) { (image) in
            XCTAssertEqual(image.url, "")
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
}
