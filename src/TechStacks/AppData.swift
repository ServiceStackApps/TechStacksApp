//
//  AppData.swift
//  TechStacks
//
//  Created by Demis Bellot on 2/3/15.
//  Copyright (c) 2015 ServiceStack LLC. All rights reserved.
//

import UIKit
import Foundation


open class AppData : NSObject
{
    var client = JsonServiceClient(baseUrl: "http://techstacks.io")
    
    struct Property {
        static let TopTechnologies = "topTechnologies"
        static let AllTiers = "allTiers"
        static let AllTechnologies = "allTechnologies"
        static let AllTechnologyStacks = "allTechnologyStacks"
    }
    
    open dynamic var allTiers:[Option] = []
    
    open dynamic var overview:AppOverviewResponse = AppOverviewResponse()
    open dynamic var topTechnologies:[TechnologyInfo] = []
    
    open dynamic var allTechnologies:[Technology] = []
    open dynamic var allTechnologyStacks:[TechnologyStack] = []
    
    open dynamic var search:String?
    open dynamic var filteredTechStacks:[TechnologyStack] = []
    open dynamic var filteredTechnologies:[Technology] = []
    
    open var technologyStackCache:[String:GetTechnologyStackResponse] = [:]
    open var technologyCache:[String:GetTechnologyResponse] = [:]
    
    override init(){
        super.init()
        self.loadDefaultImageCaches()
    }
    
    @discardableResult func loadOverview() -> Promise<AppOverviewResponse> {
        return client.getAsync(AppOverview())
            .then { r -> AppOverviewResponse in
                self.overview = r
                self.allTiers = r.allTiers
                self.topTechnologies = r.topTechnologies
                return r
            }
    }
    
    @discardableResult func loadAllTechnologies() -> Promise<GetAllTechnologiesResponse> {
        return client.getAsync(GetAllTechnologies())
            .then { r -> GetAllTechnologiesResponse in
                self.allTechnologies = r.results
                return r
            }
    }
    
    @discardableResult func loadAllTechStacks() -> Promise<GetAllTechnologyStacksResponse> {
        return client.getAsync(GetAllTechnologyStacks())
            .then { r -> GetAllTechnologyStacksResponse in
                self.allTechnologyStacks = r.results
                return r
            }
    }
    
    func loadTechnologyStack(_ slug:String) -> Promise<GetTechnologyStackResponse> {
        if let response = technologyStackCache[slug] {
            return Promise<GetTechnologyStackResponse> { (complete,reject) in complete(response) }
        }
        
        let request = GetTechnologyStack()
        request.slug = slug
        return client.getAsync(request)
            .then { r -> GetTechnologyStackResponse in
                self.technologyStackCache[r.result!.slug!] = r
                return r
            }
    }
    
    func searchTechStacks(_ query:String) -> Promise<QueryResponse<TechnologyStack>> {
        self.search = query
        
        return client.getAsync(FindTechStacks<TechnologyStack>(), query: ["NameContains":query, "DescriptionContains":query])
            .then { r -> QueryResponse<TechnologyStack> in
                self.filteredTechStacks = r.results
                return r
            }
    }
    
    func loadTechnology(_ slug:String) -> Promise<GetTechnologyResponse> {
        if let response = technologyCache[slug] {
            return Promise<GetTechnologyResponse> { (complete,reject) in complete(response) }
        }
        
        let request = GetTechnology()
        request.slug = slug
        return client.getAsync(request)
            .then { r -> GetTechnologyResponse in
                self.technologyCache[r.technology!.slug!] = r
                return r
            }
    }
    
    func searchTechnologies(_ query:String) -> Promise<QueryResponse<Technology>> {
        self.search = query

        return client.getAsync(FindTechnologies<Technology>(), query:["NameContains":query, "DescriptionContains":query])
            .then { r -> QueryResponse<Technology> in
                self.filteredTechnologies = r.results
                return r
            }
    }

    var imageCache:[String:UIImage] = [:]
    func loadDefaultImageCaches() {
        imageCache["stacks"] = UIImage(named: "stacks")

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 858, height: 689), false, 0.0)
        imageCache["blankScreenshot"] = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    open func loadAllImagesAsync(_ urls:[String]) -> Promise<[String:UIImage?]> {
        var images = [String:UIImage?]()
        return Promise<[String:UIImage?]> { (complete, reject) in
            for url in urls {
                self.loadImageAsync(url)
                    .then { (img:UIImage?) -> Void in
                        images[url] = img
                        if images.count == urls.count {
                            return complete(images)
                        }
                    }
            }
        }
    }
    
    open func loadImageAsync(_ url:String) -> Promise<UIImage?> {
        if let image = imageCache[url] {
            return Promise<UIImage?> { (complete, reject) in complete(image) }
        }
        
        return client.getDataAsync(url)
            .then { (data:Data) -> UIImage? in
                if let image = UIImage(data:data) {
                    self.imageCache[url] = image
                    return image
                }
                return nil
            }
    }
    
    /* KVO Observable helpers */
    var observedProperties = [NSObject:[String]]()
    var ctx:AnyObject = 1 as AnyObject
    
    open func observe(_ observer: NSObject, properties:[String]) {
        for property in properties {
            self.observe(observer, property: property)
        }
    }
    
    open func observe(_ observer: NSObject, property:String) {
        self.addObserver(observer, forKeyPath: property, options: [.new , .old], context: &ctx)
        
        var properties = observedProperties[observer] ?? [String]()
        properties.append(property)
        observedProperties[observer] = properties
    }
    
    open func unobserve(_ observer: NSObject) {
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
