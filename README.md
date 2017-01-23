# TechStacks iOS App

The TechStacks Native iOS App provides a fluid and responsive experience for browsing content on http://techstacks.io on iPhones and iPad devices. Get it now free on the AppStore!

[![TechStacks on AppStore](https://raw.githubusercontent.com/ServiceStack/Assets/master/img/release-notes/techstacks-appstore.png)](https://itunes.apple.com/us/app/webstacks/id1176797617?ls=1&mt=8)

This repository contains the complete source code for the TechStacks App which provides a good example to illustrate the ease-of-use and utility of [ServiceStack's new support for Swift and XCode](https://github.com/ServiceStack/ServiceStack/wiki/Swift-Add-ServiceStack-Reference) for quickly building services-rich iOS Apps.

## Technical Overview

All remote Service Calls used by the App are encapsulated into the [AppData.swift](https://github.com/ServiceStackApps/TechStacksApp/blob/master/src/TechStacks/AppData.swift) class and only uses [JsonServiceClient's](https://github.com/ServiceStack/ServiceStack/wiki/Swift-Add-ServiceStack-Reference#jsonserviceclientswift) non-blocking Async API's to ensure a Responsive UI is maintained throughout the App.

Some other useful features and techniquest that helped with development of this App include:

### MVC and Key-Value Observables (KVO)

If you've ever had to implement `INotifyPropertyChanged` in .NET, you'll find the built-in model binding capabilities in iOS/OSX a refreshing alternative thanks to Objective-C's underlying `NSObject` which automatically generates automatic change notifications for its KV-compliant properties. UIKit and Cocoa frameworks both leverage this feature to enable its [Model-View-Controller Pattern](https://developer.apple.com/library/mac/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html). 

As keeping UI's updated with Async API callbacks can get unwieldy, we wanted to go through how we're taking advantage of NSObject's KVO support in Service Responses to simplify maintaining dynamic UI's.

### Enable Key-Value Observing in Swift DTO's

Firstly to enable KVO in your Swift DTO's we'll want to have each DTO inherit from `NSObject` which can be done by uncommenting `BaseObject` option in the header comments as seen below:

```
/* Options:
Date: 2015-02-19 22:43:04
Version: 1
BaseUrl: http://techstacks.io

BaseClass: NSObject
...
*/
```
and click the **Update ServiceStack Reference** Menu Option to fetch the updated DTO's.

Then to [enable Key-Value Observing](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html#//apple_ref/doc/uid/TP40014216-CH7-XID_8) just mark the response DTO variables with the `dynamic` modifier, e.g:

```swift
public dynamic var allTiers:[Option] = []
public dynamic var overview:AppOverviewResponse = AppOverviewResponse()
public dynamic var topTechnologies:[TechnologyInfo] = []
public dynamic var allTechnologies:[Technology] = []
public dynamic var allTechnologyStacks:[TechnologyStack] = []
```

Which is all that's needed to allow properties to be observed as they'll automatically issue change notifications when they're populated in the Service response async callbacks, e.g:

```swift
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
```

### Observing Data Changes

In your [ViewController](https://github.com/ServiceStackApps/TechStacksApp/blob/0fca564e8c06fd1b71f81faee93a2e04c70a219b/src/TechStacks/HomeViewController.swift) have the datasources for your custom views binded to the desired data (which will initially be empty):

```swift
func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return appData.allTiers.count
}
...
func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return appData.topTechnologies.count
}
```

Then in `viewDidLoad()` [start observing the properties](https://github.com/ServiceStack/ServiceStack.Swift/blob/67c5c092b92927702f33b6a0669e3aa1de0e2cdc/apps/TechStacks/TechStacks/HomeViewController.swift#L31) your UI Controls are bound to, e.g:

```swift
override func viewDidLoad() {
    ...
    self.appData.observe(self, properties: ["topTechnologies", "allTiers"])
    self.appData.loadOverview()
}
deinit { self.appData.unobserve(self) }
```

In the example code above we're using some custom [KVO helpers](https://github.com/ServiceStackApps/TechStacksApp/blob/0fca564e8c06fd1b71f81faee93a2e04c70a219b/src/TechStacks/AppData.swift#L159-L183) to keep the code required to a minimum.

With the observable bindings in place, the change notifications of your observed properties can be handled by overriding `observeValueForKeyPath()` which passes the name of the property that's changed in the `keyPath` argument that can be used to determine the UI Controls to refresh, e.g:

```swift
override func observeValueForKeyPath(keyPath:String, ofObject object:AnyObject, change:[NSObject:AnyObject],
  context: UnsafeMutablePointer<Void>) {
    switch keyPath {
    case "allTiers":
        self.technologyPicker.reloadAllComponents()
    case "topTechnologies":
        self.tblView.reloadData()
    default: break
    }
}
```

Now that everything's configured, the observables provide an alternative to manually updating UI elements within async callbacks, instead you can now fire-and-forget your async API's and rely on the pre-configured bindings to automatically update the appropriate UI Controls when their bounded properties are updated, e.g:

```swift
self.appData.loadOverview() //Ignore response and use configured KVO Bindings
```

### Images and Custom Binary Requests

In addition to greatly simplifying Web Service Requests, `JsonServiceClient` also makes it easy to fetch any custom HTTP response like Images and other Binary data using the generic `getData()` and `getDataAsync()` NSData API's. This is used in TechStacks to [maintain a cache of all loaded images](https://github.com/ServiceStackApps/TechStacksApp/blob/0fca564e8c06fd1b71f81faee93a2e04c70a219b/src/TechStacks/AppData.swift#L144), reducing number of HTTP requests and load times when navigating between screens:

```swift
var imageCache:[String:UIImage] = [:]

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
```
