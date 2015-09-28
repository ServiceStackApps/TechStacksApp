//
//  TechStacks.dtos.extras.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/4/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import Foundation

// @Route("/technology/search", "GET")
public class FindTechnologies : NSObject, IReturn
{
    public typealias Return = FindTechnologiesResponse
    
    required public override init(){}
    
    public var skip:Int?
    public var take:Int?
    public var orderBy:String?
    public var orderByDesc:String?
    public var include:String?
    public var meta:[String:String] = [:]
    
    public var name:String?
    public var reload:Bool?
}

// @Route("/techstacks/search", "GET")
public class FindTechStacks : NSObject, IReturn
{
    public typealias Return = FindTechStacksResponse
    
    required public override init(){}
    
    public var skip:Int?
    public var take:Int?
    public var orderBy:String?
    public var orderByDesc:String?
    public var include:String?
    public var meta:[String:String] = [:]
    
    public var reload:Bool?
}

public class FindTechnologiesResponse : NSObject
{
    required public override init(){}
    
    public var offset:Int?
    public var total:Int?
    public var results:[Technology] = []
    public var meta:[String:String] = [:]
    public var responseStatus:ResponseStatus?
}

public class FindTechStacksResponse : NSObject
{
    required public override init(){}
    
    public var offset:Int?
    public var total:Int?
    public var results:[TechnologyStack] = []
    public var meta:[String:String] = [:]
    public var responseStatus:ResponseStatus?
}

extension FindTechnologies : JsonSerializable
{
    public static var typeName:String { return "FindTechnologies" }
    public static var metadata = Metadata.create([
        Type<FindTechnologies>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<FindTechnologies>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        Type<FindTechnologies>.optionalProperty("skip", get: { $0.skip }, set: { $0.skip = $1 }),
        Type<FindTechnologies>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
        Type<FindTechnologies>.optionalProperty("orderBy", get: { $0.orderBy }, set: { $0.orderBy = $1 }),
        Type<FindTechnologies>.optionalProperty("orderByDesc", get: { $0.orderByDesc }, set: { $0.orderByDesc = $1 }),
        Type<FindTechnologies>.optionalProperty("include", get: { $0.include }, set: { $0.include = $1 }),
        Type<FindTechnologies>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension FindTechnologiesResponse : JsonSerializable
{
    public static var typeName:String { return "FindTechnologiesResponse" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<FindTechnologiesResponse>.optionalProperty("offset", get: { $0.offset }, set: { $0.offset = $1 }),
            Type<FindTechnologiesResponse>.optionalProperty("total", get: { $0.total }, set: { $0.total = $1 }),
            Type<FindTechnologiesResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<FindTechnologiesResponse>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
            Type<FindTechnologiesResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ])
    }
}

extension FindTechStacks : JsonSerializable
{
    public static var typeName:String { return "FindTechStacks" }
    public static var metadata = Metadata.create([
        Type<FindTechStacks>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        Type<FindTechStacks>.optionalProperty("skip", get: { $0.skip }, set: { $0.skip = $1 }),
        Type<FindTechStacks>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
        Type<FindTechStacks>.optionalProperty("orderBy", get: { $0.orderBy }, set: { $0.orderBy = $1 }),
        Type<FindTechStacks>.optionalProperty("orderByDesc", get: { $0.orderByDesc }, set: { $0.orderByDesc = $1 }),
        Type<FindTechStacks>.optionalProperty("include", get: { $0.include }, set: { $0.include = $1 }),
        Type<FindTechStacks>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension FindTechStacksResponse : JsonSerializable
{
    public static var typeName:String { return "FindTechStacksResponse" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<FindTechStacksResponse>.optionalProperty("offset", get: { $0.offset }, set: { $0.offset = $1 }),
            Type<FindTechStacksResponse>.optionalProperty("total", get: { $0.total }, set: { $0.total = $1 }),
            Type<FindTechStacksResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<FindTechStacksResponse>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
            Type<FindTechStacksResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ])
    }
}
