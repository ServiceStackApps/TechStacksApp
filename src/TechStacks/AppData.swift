//
//  AppData.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/3/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit
import Foundation


public class AppData : NSObject
{
    var client = JsonServiceClient(baseUrl: "http://techstacks.io")
    
    struct Property {
        static let TopTechnologies = "topTechnologies"
        static let AllTiers = "allTiers"
        static let AllTechnologies = "allTechnologies"
        static let AllTechnologyStacks = "allTechnologyStacks"
    }
    
    public dynamic var allTiers:[Option] = []
    
    public dynamic var overview:AppOverviewResponse = AppOverviewResponse()
    public dynamic var topTechnologies:[TechnologyInfo] = []
    
    public dynamic var allTechnologies:[Technology] = []
    public dynamic var allTechnologyStacks:[TechnologyStack] = []
    
    public dynamic var search:String?
    public dynamic var filteredTechStacks:[TechnologyStack] = []
    public dynamic var filteredTechnologies:[Technology] = []
    
    public var technologyStackCache:[String:GetTechnologyStackResponse] = [:]
    public var technologyCache:[String:GetTechnologyResponse] = [:]
    
    override init(){
        super.init()
        self.loadDefaultImageCaches()
    }
    
    func loadOverview() -> Promise<AppOverviewResponse> {
        return client.getAsync(AppOverview())
            .then({(r:AppOverviewResponse) -> AppOverviewResponse in
                self.overview = r
                self.allTiers = r.allTiers
                self.topTechnologies = r.topTechnologies
                return r
            })
    }
    
    func loadAllTechnologies() -> Promise<GetAllTechnologiesResponse> {
        return client.getAsync(GetAllTechnologies())
            .then({(r:GetAllTechnologiesResponse) -> GetAllTechnologiesResponse in
                self.allTechnologies = r.results
                return r
            })
    }
    
    func loadAllTechStacks() -> Promise<GetAllTechnologyStacksResponse> {
        return client.getAsync(GetAllTechnologyStacks())
            .then({(r:GetAllTechnologyStacksResponse) -> GetAllTechnologyStacksResponse in
                self.allTechnologyStacks = r.results
                return r
            })
    }
    
    func loadTechnologyStack(slug:String) -> Promise<GetTechnologyStackResponse> {
        if let response = technologyStackCache[slug] {
            return Promise<GetTechnologyStackResponse> { (complete,reject) in complete(response) }
        }
        
        let request = GetTechnologyStack()
        request.slug = slug
        return client.getAsync(request)
            .then({ (r:GetTechnologyStackResponse) -> GetTechnologyStackResponse in
                self.technologyStackCache[r.result!.slug!] = r
                return r
            })
    }
    
    func searchTechStacks(query:String) -> Promise<FindTechStacksResponse> {
        self.search = query
        
        return client.getAsync(FindTechStacks(), query: ["NameContains":query, "DescriptionContains":query])
            .then({(r:FindTechStacksResponse) -> FindTechStacksResponse in
                self.filteredTechStacks = r.results
                return r
            })
    }
    
    func loadTechnology(slug:String) -> Promise<GetTechnologyResponse> {
        if let response = technologyCache[slug] {
            return Promise<GetTechnologyResponse> { (complete,reject) in complete(response) }
        }
        
        let request = GetTechnology()
        request.slug = slug
        return client.getAsync(request)
            .then({ (r:GetTechnologyResponse) -> GetTechnologyResponse in
                self.technologyCache[r.technology!.slug!] = r
                return r
            })
    }
    
    func searchTechnologies(query:String) -> Promise<FindTechnologiesResponse> {
        self.search = query

        return client.getAsync(FindTechnologies(), query:["NameContains":query, "DescriptionContains":query])
            .then({(r:FindTechnologiesResponse) -> FindTechnologiesResponse in
                self.filteredTechnologies = r.results
                return r
            })
    }

    var imageCache:[String:UIImage] = [:]
    func loadDefaultImageCaches() {
        imageCache["stacks"] = UIImage(named: "stacks")

        UIGraphicsBeginImageContextWithOptions(CGSizeMake(858, 689), false, 0.0)
        imageCache["blankScreenshot"] = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    public func loadAllImagesAsync(urls:[String]) -> Promise<[String:UIImage?]> {
        var images = [String:UIImage?]()
        return Promise<[String:UIImage?]> { (complete, reject) in
            for url in urls {
                self.loadImageAsync(url)
                    .then({ (img:UIImage?) -> Void in
                        images[url] = img
                        if images.count == urls.count {
                            return complete(images)
                        }
                    })
            }
        }
    }
    
    public func loadImageAsync(url:String) -> Promise<UIImage?> {
        if let image = imageCache[url] {
            return Promise<UIImage?> { (complete, reject) in complete(image) }
        }
        
        return client.getDataAsync(url)
            .then({ (data:NSData) -> UIImage? in
                if let image = UIImage(data:data) {
                    self.imageCache[url] = image
                    return image
                }
                return nil
            })
    }
    
    /* KVO Observable helpers */
    var observedProperties = [NSObject:[String]]()
    var ctx:AnyObject = 1
    
    public func observe(observer: NSObject, properties:[String]) {
        for property in properties {
            self.observe(observer, property: property)
        }
    }
    
    public func observe(observer: NSObject, property:String) {
        self.addObserver(observer, forKeyPath: property, options: [.New , .Old], context: &ctx)
        
        var properties = observedProperties[observer] ?? [String]()
        properties.append(property)
        observedProperties[observer] = properties
    }
    
    public func unobserve(observer: NSObject) {
        if let properties = observedProperties[observer] {
            for property in properties {
                self.removeObserver(observer, forKeyPath: property, context: &ctx)
            }
        }
    }
    
    //Clear caches if we receive memory warning
    func resetCache() {
        imageCache = [:]
        technologyStackCache = [:]
        technologyCache = [:]
        loadDefaultImageCaches()
    }
    
}
