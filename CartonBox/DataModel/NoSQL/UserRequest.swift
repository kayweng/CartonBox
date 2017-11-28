//
//  UserRequest.swift
//  MySampleApp
//
//
// Copyright 2017 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-swift v0.19
//

import Foundation
import UIKit
import AWSDynamoDB

@objcMembers
class UserRequest: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _requestId: String?
    var _active: NSNumber?
    var _bucketId: String?
    var _createdOn: String?
    var _description: String?
    var _files: Set<String>?
    var _modifiedOn: String?
    var _receipents: Set<String>?
    var _status: String?
    var _title: String?
    
    class func dynamoDBTableName() -> String {

        return "cartonbox-mobilehub-2074369928-UserRequest"
    }
    
    class func hashKeyAttribute() -> String {

        return "_userId"
    }
    
    class func rangeKeyAttribute() -> String {

        return "_requestId"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
               "_userId" : "userId",
               "_requestId" : "requestId",
               "_active" : "active",
               "_bucketId" : "bucketId",
               "_createdOn" : "createdOn",
               "_description" : "description",
               "_files" : "files",
               "_modifiedOn" : "modifiedOn",
               "_receipents" : "receipents",
               "_status" : "status",
               "_title" : "title",
        ]
    }
}
