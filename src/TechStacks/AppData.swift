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
            .then(body:{(r:AppOverviewResponse) -> AppOverviewResponse in
                self.overview = r
                self.allTiers = r.allTiers
                self.topTechnologies = r.topTechnologies
                return r
            })
    }
    
    func loadAllTechnologies() -> Promise<GetAllTechnologiesResponse> {
        return client.getAsync(GetAllTechnologies())
            .then(body:{(r:GetAllTechnologiesResponse) -> GetAllTechnologiesResponse in
                self.allTechnologies = r.results
                return r
            })
    }
    
    func loadAllTechStacks() -> Promise<GetAllTechnologyStacksResponse> {
        return client.getAsync(GetAllTechnologyStacks())
            .then(body:{(r:GetAllTechnologyStacksResponse) -> GetAllTechnologyStacksResponse in
                self.allTechnologyStacks = r.results
                return r
            })
    }
    
    func loadTechnologyStack(slug:String) -> Promise<GetTechnologyStackResponse> {
        if let response = technologyStackCache[slug] {
            return Promise<GetTechnologyStackResponse> { (complete,reject) in complete(response) }
        }
        
        var request = GetTechnologyStack()
        request.slug = slug
        return client.getAsync(request)
            .then(body:{ (r:GetTechnologyStackResponse) -> GetTechnologyStackResponse in
                self.technologyStackCache[r.result!.slug!] = r
                return r
            })
    }
    
    func searchTechStacks(query:String) -> Promise<QueryResponse<TechnologyStack>> {
        self.search = query
        
        let request = FindTechStacks<TechnologyStack>()
        return client.getAsync(request, query:["NameContains":query, "DescriptionContains":query])
            .then(body:{(r:QueryResponse<TechnologyStack>) -> QueryResponse<TechnologyStack> in
                self.filteredTechStacks = r.results
                return r
            })
    }
    
    func loadTechnology(slug:String) -> Promise<GetTechnologyResponse> {
        if let response = technologyCache[slug] {
            return Promise<GetTechnologyResponse> { (complete,reject) in complete(response) }
        }
        
        var request = GetTechnology()
        request.slug = slug
        return client.getAsync(request)
            .then(body:{ (r:GetTechnologyResponse) -> GetTechnologyResponse in
                self.technologyCache[r.technology!.slug!] = r
                return r
            })
    }
    
    func searchTechnologies(query:String) -> Promise<QueryResponse<Technology>> {
        self.search = query
        
        let request = FindTechnologies<Technology>()
        return client.getAsync(request, query:["NameContains":query, "DescriptionContains":query])
            .then(body:{(r:QueryResponse<Technology>) -> QueryResponse<Technology> in
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
                    .then(body: { (img:UIImage?) -> Void in
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
            .then(body: { (data:NSData) -> UIImage? in
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
        self.addObserver(observer, forKeyPath: property, options: .New | .Old, context: &ctx)
        
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
