/* Options:
Date: 2015-09-25 22:11:55
SwiftVersion: 2.0
Version: 4.046
BaseUrl: http://techstacks.io

BaseClass: NSObject
//AddModelExtensions: True
//AddServiceStackTypes: True
//IncludeTypes:
//ExcludeTypes:
ExcludeGenericBaseTypes: False
//AddResponseStatus: False
//AddImplicitVersion:
//InitializeCollections: True
//DefaultImports: Foundation
*/

import Foundation;

// @Route("/admin/technology/{TechnologyId}/logo")
public class LogoUrlApproval : NSObject, IReturn
{
    public typealias Return = LogoUrlApprovalResponse
    
    required public override init(){}
    public var technologyId:Int64?
    public var approved:Bool?
}

// @Route("/admin/techstacks/{TechnologyStackId}/lock")
public class LockTechStack : NSObject, IReturn
{
    public typealias Return = LockStackResponse
    
    required public override init(){}
    public var technologyStackId:Int64?
    public var isLocked:Bool?
}

// @Route("/admin/technology/{TechnologyId}/lock")
public class LockTech : NSObject, IReturn
{
    public typealias Return = LockStackResponse
    
    required public override init(){}
    public var technologyId:Int64?
    public var isLocked:Bool?
}

// @Route("/ping")
public class Ping : NSObject
{
    required public override init(){}
}

// @Route("/{PathInfo*}")
public class FallbackForClientRoutes : NSObject
{
    required public override init(){}
    public var pathInfo:String?
}

// @Route("/stacks")
public class ClientAllTechnologyStacks : NSObject
{
    required public override init(){}
}

// @Route("/tech")
public class ClientAllTechnologies : NSObject
{
    required public override init(){}
}

// @Route("/tech/{Slug}")
public class ClientTechnology : NSObject
{
    required public override init(){}
    public var slug:String?
}

// @Route("/users/{UserName}")
public class ClientUser : NSObject
{
    required public override init(){}
    public var userName:String?
}

// @Route("/my-session")
public class SessionInfo : NSObject
{
    required public override init(){}
}

// @Route("/technology", "POST")
public class CreateTechnology : NSObject, IReturn
{
    public typealias Return = CreateTechnologyResponse
    
    required public override init(){}
    public var name:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var Description:String?
    public var isLocked:Bool?
    public var tier:TechnologyTier?
}

// @Route("/technology/{Id}", "PUT")
public class UpdateTechnology : NSObject, IReturn
{
    public typealias Return = UpdateTechnologyResponse
    
    required public override init(){}
    public var id:Int64?
    public var name:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var Description:String?
    public var isLocked:Bool?
    public var tier:TechnologyTier?
}

// @Route("/technology/{Id}", "DELETE")
public class DeleteTechnology : NSObject, IReturn
{
    public typealias Return = DeleteTechnologyResponse
    
    required public override init(){}
    public var id:Int64?
}

// @Route("/technology/{Slug}")
public class GetTechnology : NSObject, IReturn
{
    public typealias Return = GetTechnologyResponse
    
    required public override init(){}
    public var reload:Bool?
    public var slug:String?
}

// @Route("/technology/{Slug}/previous-versions", "GET")
public class GetTechnologyPreviousVersions : NSObject, IReturn
{
    public typealias Return = GetTechnologyPreviousVersionsResponse
    
    required public override init(){}
    public var slug:String?
}

// @Route("/technology/{Slug}/favorites")
public class GetTechnologyFavoriteDetails : NSObject, IReturn
{
    public typealias Return = GetTechnologyFavoriteDetailsResponse
    
    required public override init(){}
    public var slug:String?
    public var reload:Bool?
}

// @Route("/technology", "GET")
public class GetAllTechnologies : NSObject, IReturn
{
    public typealias Return = GetAllTechnologiesResponse
    
    required public override init(){}
}

//** MJC START
// @Route("/technology/search")
// @AutoQueryViewer(Title="Find Technologies", Description="Explore different Technologies", IconUrl="/img/app/tech-white-75.png", DefaultSearchField="Tier", DefaultSearchType="=", DefaultSearchText="Data")
public class FindTechnologies : NSObject, IReturn
{
    //public typealias Return = QueryResponse<Technology>
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

public class FindTechnologiesResponse : NSObject
{
    required public override init(){}
    
    public var offset:Int?
    public var total:Int?
    public var results:[Technology] = []
    public var meta:[String:String] = [:]
    public var responseStatus:ResponseStatus?
}

extension FindTechnologiesResponse : JsonSerializable
{
    public static var typeName:String { return "FindTechnologiesResponse" }
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
//** MJC END


// @Route("/techstacks", "POST")
public class CreateTechnologyStack : NSObject, IReturn
{
    public typealias Return = CreateTechnologyStackResponse
    
    required public override init(){}
    public var name:String?
    public var vendorName:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var Description:String?
    public var details:String?
    public var isLocked:Bool?
    public var technologyIds:[Int64] = []
}

// @Route("/techstacks/{Id}", "PUT")
public class UpdateTechnologyStack : NSObject, IReturn
{
    public typealias Return = UpdateTechnologyStackResponse
    
    required public override init(){}
    public var id:Int64?
    public var name:String?
    public var vendorName:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var Description:String?
    public var details:String?
    public var isLocked:Bool?
    public var technologyIds:[Int64] = []
}

// @Route("/techstacks/{Id}", "DELETE")
public class DeleteTechnologyStack : NSObject, IReturn
{
    public typealias Return = DeleteTechnologyStackResponse
    
    required public override init(){}
    public var id:Int64?
}

// @Route("/techstacks", "GET")
public class GetAllTechnologyStacks : NSObject, IReturn
{
    public typealias Return = GetAllTechnologyStacksResponse
    
    required public override init(){}
}

// @Route("/techstacks/{Slug}", "GET")
public class GetTechnologyStack : NSObject, IReturn
{
    public typealias Return = GetTechnologyStackResponse
    
    required public override init(){}
    public var reload:Bool?
    public var slug:String?
}

// @Route("/techstacks/{Slug}/previous-versions", "GET")
public class GetTechnologyStackPreviousVersions : NSObject, IReturn
{
    public typealias Return = GetTechnologyStackPreviousVersionsResponse
    
    required public override init(){}
    public var slug:String?
}

// @Route("/techstacks/{Slug}/favorites")
public class GetTechnologyStackFavoriteDetails : NSObject, IReturn
{
    public typealias Return = GetTechnologyStackFavoriteDetailsResponse
    
    required public override init(){}
    public var slug:String?
    public var reload:Bool?
}

// @Route("/config")
public class GetConfig : NSObject, IReturn
{
    public typealias Return = GetConfigResponse
    
    required public override init(){}
}

// @Route("/overview")
public class Overview : NSObject, IReturn
{
    public typealias Return = OverviewResponse
    
    required public override init(){}
    public var reload:Bool?
}

// @Route("/app-overview")
public class AppOverview : NSObject, IReturn
{
    public typealias Return = AppOverviewResponse
    
    required public override init(){}
    public var reload:Bool?
}

//** MJC START
// @Route("/techstacks/search")
// @AutoQueryViewer(Title="Find Technology Stacks", Description="Explore different Technology Stacks", IconUrl="/img/app/stacks-white-75.png", DefaultSearchField="Description", DefaultSearchType="Contains", DefaultSearchText="ServiceStack")
public class FindTechStacks : NSObject, IReturn
{
    //public typealias Return = QueryResponse<TechnologyStack>
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

public class FindTechStacksResponse : NSObject
{
    required public override init(){}
    
    public var offset:Int?
    public var total:Int?
    public var results:[TechnologyStack] = []
    public var meta:[String:String] = [:]
    public var responseStatus:ResponseStatus?
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
//** MJC END

// @Route("/favorites/techtacks", "GET")
public class GetFavoriteTechStack : NSObject, IReturn
{
    public typealias Return = GetFavoriteTechStackResponse
    
    required public override init(){}
    public var technologyStackId:Int?
}

// @Route("/favorites/techtacks/{TechnologyStackId}", "PUT")
public class AddFavoriteTechStack : NSObject, IReturn
{
    public typealias Return = FavoriteTechStackResponse
    
    required public override init(){}
    public var technologyStackId:Int?
}

// @Route("/favorites/techtacks/{TechnologyStackId}", "DELETE")
public class RemoveFavoriteTechStack : NSObject, IReturn
{
    public typealias Return = FavoriteTechStackResponse
    
    required public override init(){}
    public var technologyStackId:Int?
}

// @Route("/favorites/technology", "GET")
public class GetFavoriteTechnologies : NSObject, IReturn
{
    public typealias Return = GetFavoriteTechnologiesResponse
    
    required public override init(){}
    public var technologyId:Int?
}

// @Route("/favorites/technology/{TechnologyId}", "PUT")
public class AddFavoriteTechnology : NSObject, IReturn
{
    public typealias Return = FavoriteTechnologyResponse
    
    required public override init(){}
    public var technologyId:Int?
}

// @Route("/favorites/technology/{TechnologyId}", "DELETE")
public class RemoveFavoriteTechnology : NSObject, IReturn
{
    public typealias Return = FavoriteTechnologyResponse
    
    required public override init(){}
    public var technologyId:Int?
}

// @Route("/my-feed")
public class GetUserFeed : NSObject, IReturn
{
    public typealias Return = GetUserFeedResponse
    
    required public override init(){}
}

// @Route("/userinfo/{UserName}")
public class GetUserInfo : NSObject, IReturn
{
    public typealias Return = GetUserInfoResponse
    
    required public override init(){}
    public var reload:Bool?
    public var userName:String?
}

// @Route("/auth")
// @Route("/auth/{provider}")
// @Route("/authenticate")
// @Route("/authenticate/{provider}")
// @DataContract
public class Authenticate : NSObject, IReturn
{
    public typealias Return = AuthenticateResponse
    
    required public override init(){}
    // @DataMember(Order=1)
    public var provider:String?
    
    // @DataMember(Order=2)
    public var state:String?
    
    // @DataMember(Order=3)
    public var oauth_token:String?
    
    // @DataMember(Order=4)
    public var oauth_verifier:String?
    
    // @DataMember(Order=5)
    public var userName:String?
    
    // @DataMember(Order=6)
    public var password:String?
    
    // @DataMember(Order=7)
    public var rememberMe:Bool?
    
    // @DataMember(Order=8)
    public var `continue`:String?
    
    // @DataMember(Order=9)
    public var nonce:String?
    
    // @DataMember(Order=10)
    public var uri:String?
    
    // @DataMember(Order=11)
    public var response:String?
    
    // @DataMember(Order=12)
    public var qop:String?
    
    // @DataMember(Order=13)
    public var nc:String?
    
    // @DataMember(Order=14)
    public var cnonce:String?
    
    // @DataMember(Order=15)
    public var meta:[String:String] = [:]
}

// @Route("/assignroles")
// @DataContract
public class AssignRoles : NSObject, IReturn
{
    public typealias Return = AssignRolesResponse
    
    required public override init(){}
    // @DataMember(Order=1)
    public var userName:String?
    
    // @DataMember(Order=2)
    public var permissions:[String] = []
    
    // @DataMember(Order=3)
    public var roles:[String] = []
}

// @Route("/unassignroles")
// @DataContract
public class UnAssignRoles : NSObject, IReturn
{
    public typealias Return = UnAssignRolesResponse
    
    required public override init(){}
    // @DataMember(Order=1)
    public var userName:String?
    
    // @DataMember(Order=2)
    public var permissions:[String] = []
    
    // @DataMember(Order=3)
    public var roles:[String] = []
}

// @Route("/posts")
public class QueryPosts : NSObject, IReturn
{
    public typealias Return = QueryResponse<Post>
    
    required public override init(){}

    public var skip:Int?
    public var take:Int?
    public var orderBy:String?
    public var orderByDesc:String?
    public var include:String?
    public var meta:[String:String] = [:]

}

public class LogoUrlApprovalResponse : NSObject
{
    required public override init(){}
    public var result:Technology?
}

public class LockStackResponse : NSObject
{
    required public override init(){}
}

public class CreateTechnologyResponse : NSObject
{
    required public override init(){}
    public var result:Technology?
    public var responseStatus:ResponseStatus?
}

public class UpdateTechnologyResponse : NSObject
{
    required public override init(){}
    public var result:Technology?
    public var responseStatus:ResponseStatus?
}

public class DeleteTechnologyResponse : NSObject
{
    required public override init(){}
    public var result:Technology?
    public var responseStatus:ResponseStatus?
}

public class GetTechnologyResponse : NSObject
{
    required public override init(){}
    public var created:NSDate?
    public var technology:Technology?
    public var technologyStacks:[TechnologyStack] = []
    public var responseStatus:ResponseStatus?
}

public class GetTechnologyPreviousVersionsResponse : NSObject
{
    required public override init(){}
    public var results:[TechnologyHistory] = []
}

public class GetTechnologyFavoriteDetailsResponse : NSObject
{
    required public override init(){}
    public var users:[String] = []
    public var favoriteCount:Int?
}

public class GetAllTechnologiesResponse : NSObject
{
    required public override init(){}
    public var results:[Technology] = []
}

// @DataContract
public class QueryResponse<T : JsonSerializable> : NSObject
{
    required public override init(){}
    // @DataMember(Order=1)
    public var offset:Int?
    
    // @DataMember(Order=2)
    public var total:Int?
    
    // @DataMember(Order=3)
    public var results:[T] = []
    
    // @DataMember(Order=4)
    public var meta:[String:String] = [:]
    
    // @DataMember(Order=5)
    public var responseStatus:ResponseStatus?
}

public class CreateTechnologyStackResponse : NSObject
{
    required public override init(){}
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?
}

public class UpdateTechnologyStackResponse : NSObject
{
    required public override init(){}
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?
}

public class DeleteTechnologyStackResponse : NSObject
{
    required public override init(){}
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?
}

public class GetAllTechnologyStacksResponse : NSObject
{
    required public override init(){}
    public var results:[TechnologyStack] = []
}

public class GetTechnologyStackResponse : NSObject
{
    required public override init(){}
    public var created:NSDate?
    public var result:TechStackDetails?
    public var responseStatus:ResponseStatus?
}

public class GetTechnologyStackPreviousVersionsResponse : NSObject
{
    required public override init(){}
    public var results:[TechnologyStackHistory] = []
}

public class GetTechnologyStackFavoriteDetailsResponse : NSObject
{
    required public override init(){}
    public var users:[String] = []
    public var favoriteCount:Int?
}

public class GetConfigResponse : NSObject
{
    required public override init(){}
    public var allTiers:[Option] = []
}

public class OverviewResponse : NSObject
{
    required public override init(){}
    public var created:NSDate?
    public var topUsers:[UserInfo] = []
    public var topTechnologies:[TechnologyInfo] = []
    public var latestTechStacks:[TechStackDetails] = []
    public var topTechnologiesByTier:[TechnologyTier:[TechnologyInfo]] = [:]
    public var responseStatus:ResponseStatus?
}

public class AppOverviewResponse : NSObject
{
    required public override init(){}
    public var created:NSDate?
    public var allTiers:[Option] = []
    public var topTechnologies:[TechnologyInfo] = []
    public var responseStatus:ResponseStatus?
}

public class GetFavoriteTechStackResponse : NSObject
{
    required public override init(){}
    public var results:[TechnologyStack] = []
}

public class FavoriteTechStackResponse : NSObject
{
    required public override init(){}
    public var result:TechnologyStack?
}

public class GetFavoriteTechnologiesResponse : NSObject
{
    required public override init(){}
    public var results:[Technology] = []
}

public class FavoriteTechnologyResponse : NSObject
{
    required public override init(){}
    public var result:Technology?
}

public class GetUserFeedResponse : NSObject
{
    required public override init(){}
    public var results:[TechStackDetails] = []
}

public class GetUserInfoResponse : NSObject
{
    required public override init(){}
    public var userName:String?
    public var created:NSDate?
    public var avatarUrl:String?
    public var techStacks:[TechnologyStack] = []
    public var favoriteTechStacks:[TechnologyStack] = []
    public var favoriteTechnologies:[Technology] = []
}

// @DataContract
public class AuthenticateResponse : NSObject
{
    required public override init(){}
    // @DataMember(Order=1)
    public var userId:String?
    
    // @DataMember(Order=2)
    public var sessionId:String?
    
    // @DataMember(Order=3)
    public var userName:String?
    
    // @DataMember(Order=4)
    public var displayName:String?
    
    // @DataMember(Order=5)
    public var referrerUrl:String?
    
    // @DataMember(Order=6)
    public var responseStatus:ResponseStatus?
    
    // @DataMember(Order=7)
    public var meta:[String:String] = [:]
}

// @DataContract
public class AssignRolesResponse : NSObject
{
    required public override init(){}
    // @DataMember(Order=1)
    public var allRoles:[String] = []
    
    // @DataMember(Order=2)
    public var allPermissions:[String] = []
    
    // @DataMember(Order=3)
    public var responseStatus:ResponseStatus?
}

// @DataContract
public class UnAssignRolesResponse : NSObject
{
    required public override init(){}
    // @DataMember(Order=1)
    public var allRoles:[String] = []
    
    // @DataMember(Order=2)
    public var allPermissions:[String] = []
    
    // @DataMember(Order=3)
    public var responseStatus:ResponseStatus?
}

public class Technology : TechnologyBase
{
    required public init(){}
}

public enum TechnologyTier : Int
{
    case ProgrammingLanguage
    case Client
    case Http
    case Server
    case Data
    case SoftwareInfrastructure
    case OperatingSystem
    case HardwareInfrastructure
    case ThirdPartyServices
}

public class TechnologyStack : TechnologyStackBase
{
    required public init(){}
}

public class TechnologyHistory : TechnologyBase
{
    required public init(){}
    public var technologyId:Int64?
    public var operation:String?
}

public class QueryBase_1<T : JsonSerializable> : QueryBase
{
    required public init(){}
}

public class TechStackDetails : TechnologyStackBase
{
    required public init(){}
    public var detailsHtml:String?
    public var technologyChoices:[TechnologyInStack] = []
}

public class TechnologyStackHistory : TechnologyStackBase
{
    required public init(){}
    public var technologyStackId:Int64?
    public var operation:String?
    public var technologyIds:[Int64] = []
}

// @DataContract
public class Option : NSObject
{
    required public override init(){}
    // @DataMember(Name="name")
    public var name:String?
    
    // @DataMember(Name="title")
    public var title:String?
    
    // @DataMember(Name="value")
    public var value:TechnologyTier?
}

public class UserInfo : NSObject
{
    required public override init(){}
    public var userName:String?
    public var avatarUrl:String?
    public var stacksCount:Int?
}

public class TechnologyInfo : NSObject
{
    required public override init(){}
    public var tier:TechnologyTier?
    public var slug:String?
    public var name:String?
    public var logoUrl:String?
    public var stacksCount:Int?
}

public class Post : NSObject
{
    required public override init(){}
    public var id:Int?
    public var userId:String?
    public var userName:String?
    public var date:String?
    public var shortDate:String?
    public var textHtml:String?
    public var comments:[PostComment] = []
}

public class TechnologyBase : NSObject
{
    required public override init(){}
    public var id:Int64?
    public var name:String?
    public var vendorName:String?
    public var vendorUrl:String?
    public var productUrl:String?
    public var logoUrl:String?
    public var Description:String?
    public var created:NSDate?
    public var createdBy:String?
    public var lastModified:NSDate?
    public var lastModifiedBy:String?
    public var ownerId:String?
    public var slug:String?
    public var logoApproved:Bool?
    public var isLocked:Bool?
    public var tier:TechnologyTier?
    public var lastStatusUpdate:NSDate?
}

public class TechnologyStackBase : NSObject
{
    required public override init(){}
    public var id:Int64?
    public var name:String?
    public var vendorName:String?
    public var Description:String?
    public var appUrl:String?
    public var screenshotUrl:String?
    public var created:NSDate?
    public var createdBy:String?
    public var lastModified:NSDate?
    public var lastModifiedBy:String?
    public var isLocked:Bool?
    public var ownerId:String?
    public var slug:String?
    public var details:String?
    public var lastStatusUpdate:NSDate?
}

public class QueryBase : NSObject
{
    required public override init(){}
    // @DataMember(Order=1)
    public var skip:Int?
    
    // @DataMember(Order=2)
    public var take:Int?
    
    // @DataMember(Order=3)
    public var orderBy:String?
    
    // @DataMember(Order=4)
    public var orderByDesc:String?
    
    // @DataMember(Order=5)
    public var include:String?
    
    // @DataMember(Order=6)
    public var meta:[String:String] = [:]
}

public class TechnologyInStack : TechnologyBase
{
    required public init(){}
    public var technologyId:Int64?
    public var technologyStackId:Int64?
    public var justification:String?
}

public class PostComment : NSObject
{
    required public override init(){}
    public var id:Int?
    public var postId:Int?
    public var userId:String?
    public var userName:String?
    public var date:String?
    public var shortDate:String?
    public var textHtml:String?
}


extension LogoUrlApproval : JsonSerializable
{
    public static var typeName:String { return "LogoUrlApproval" }
    public static var metadata = Metadata.create([
        Type<LogoUrlApproval>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
        Type<LogoUrlApproval>.optionalProperty("approved", get: { $0.approved }, set: { $0.approved = $1 }),
        ])
}

extension LockTechStack : JsonSerializable
{
    public static var typeName:String { return "LockTechStack" }
    public static var metadata = Metadata.create([
        Type<LockTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
        Type<LockTechStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        ])
}

extension LockTech : JsonSerializable
{
    public static var typeName:String { return "LockTech" }
    public static var metadata = Metadata.create([
        Type<LockTech>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
        Type<LockTech>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        ])
}

extension Ping : JsonSerializable
{
    public static var typeName:String { return "Ping" }
    public static var metadata = Metadata.create([
        ])
}

extension FallbackForClientRoutes : JsonSerializable
{
    public static var typeName:String { return "FallbackForClientRoutes" }
    public static var metadata = Metadata.create([
        Type<FallbackForClientRoutes>.optionalProperty("pathInfo", get: { $0.pathInfo }, set: { $0.pathInfo = $1 }),
        ])
}

extension ClientAllTechnologyStacks : JsonSerializable
{
    public static var typeName:String { return "ClientAllTechnologyStacks" }
    public static var metadata = Metadata.create([
        ])
}

extension ClientAllTechnologies : JsonSerializable
{
    public static var typeName:String { return "ClientAllTechnologies" }
    public static var metadata = Metadata.create([
        ])
}

extension ClientTechnology : JsonSerializable
{
    public static var typeName:String { return "ClientTechnology" }
    public static var metadata = Metadata.create([
        Type<ClientTechnology>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension ClientUser : JsonSerializable
{
    public static var typeName:String { return "ClientUser" }
    public static var metadata = Metadata.create([
        Type<ClientUser>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        ])
}

extension SessionInfo : JsonSerializable
{
    public static var typeName:String { return "SessionInfo" }
    public static var metadata = Metadata.create([
        ])
}

extension CreateTechnology : JsonSerializable
{
    public static var typeName:String { return "CreateTechnology" }
    public static var metadata = Metadata.create([
        Type<CreateTechnology>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<CreateTechnology>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
        Type<CreateTechnology>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
        Type<CreateTechnology>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
        Type<CreateTechnology>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
        Type<CreateTechnology>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<CreateTechnology>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        Type<CreateTechnology>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
        ])
}

extension UpdateTechnology : JsonSerializable
{
    public static var typeName:String { return "UpdateTechnology" }
    public static var metadata = Metadata.create([
        Type<UpdateTechnology>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<UpdateTechnology>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<UpdateTechnology>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
        Type<UpdateTechnology>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
        Type<UpdateTechnology>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
        Type<UpdateTechnology>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
        Type<UpdateTechnology>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<UpdateTechnology>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        Type<UpdateTechnology>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
        ])
}

extension DeleteTechnology : JsonSerializable
{
    public static var typeName:String { return "DeleteTechnology" }
    public static var metadata = Metadata.create([
        Type<DeleteTechnology>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension GetTechnology : JsonSerializable
{
    public static var typeName:String { return "GetTechnology" }
    public static var metadata = Metadata.create([
        Type<GetTechnology>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        Type<GetTechnology>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension GetTechnologyPreviousVersions : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyPreviousVersions" }
    public static var metadata = Metadata.create([
        Type<GetTechnologyPreviousVersions>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension GetTechnologyFavoriteDetails : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyFavoriteDetails" }
    public static var metadata = Metadata.create([
        Type<GetTechnologyFavoriteDetails>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        Type<GetTechnologyFavoriteDetails>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        ])
}

extension GetAllTechnologies : JsonSerializable
{
    public static var typeName:String { return "GetAllTechnologies" }
    public static var metadata = Metadata.create([
        ])
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

extension CreateTechnologyStack : JsonSerializable
{
    public static var typeName:String { return "CreateTechnologyStack" }
    public static var metadata = Metadata.create([
        Type<CreateTechnologyStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<CreateTechnologyStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
        Type<CreateTechnologyStack>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
        Type<CreateTechnologyStack>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
        Type<CreateTechnologyStack>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<CreateTechnologyStack>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
        Type<CreateTechnologyStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        Type<CreateTechnologyStack>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
        ])
}

extension UpdateTechnologyStack : JsonSerializable
{
    public static var typeName:String { return "UpdateTechnologyStack" }
    public static var metadata = Metadata.create([
        Type<UpdateTechnologyStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<UpdateTechnologyStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<UpdateTechnologyStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
        Type<UpdateTechnologyStack>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
        Type<UpdateTechnologyStack>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
        Type<UpdateTechnologyStack>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<UpdateTechnologyStack>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
        Type<UpdateTechnologyStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        Type<UpdateTechnologyStack>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
        ])
}

extension DeleteTechnologyStack : JsonSerializable
{
    public static var typeName:String { return "DeleteTechnologyStack" }
    public static var metadata = Metadata.create([
        Type<DeleteTechnologyStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        ])
}

extension GetAllTechnologyStacks : JsonSerializable
{
    public static var typeName:String { return "GetAllTechnologyStacks" }
    public static var metadata = Metadata.create([
        ])
}

extension GetTechnologyStack : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStack" }
    public static var metadata = Metadata.create([
        Type<GetTechnologyStack>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        Type<GetTechnologyStack>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension GetTechnologyStackPreviousVersions : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStackPreviousVersions" }
    public static var metadata = Metadata.create([
        Type<GetTechnologyStackPreviousVersions>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        ])
}

extension GetTechnologyStackFavoriteDetails : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStackFavoriteDetails" }
    public static var metadata = Metadata.create([
        Type<GetTechnologyStackFavoriteDetails>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        Type<GetTechnologyStackFavoriteDetails>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        ])
}

extension GetConfig : JsonSerializable
{
    public static var typeName:String { return "GetConfig" }
    public static var metadata = Metadata.create([
        ])
}

extension Overview : JsonSerializable
{
    public static var typeName:String { return "Overview" }
    public static var metadata = Metadata.create([
        Type<Overview>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        ])
}

extension AppOverview : JsonSerializable
{
    public static var typeName:String { return "AppOverview" }
    public static var metadata = Metadata.create([
        Type<AppOverview>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        ])
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

extension GetFavoriteTechStack : JsonSerializable
{
    public static var typeName:String { return "GetFavoriteTechStack" }
    public static var metadata = Metadata.create([
        Type<GetFavoriteTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
        ])
}

extension AddFavoriteTechStack : JsonSerializable
{
    public static var typeName:String { return "AddFavoriteTechStack" }
    public static var metadata = Metadata.create([
        Type<AddFavoriteTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
        ])
}

extension RemoveFavoriteTechStack : JsonSerializable
{
    public static var typeName:String { return "RemoveFavoriteTechStack" }
    public static var metadata = Metadata.create([
        Type<RemoveFavoriteTechStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
        ])
}

extension GetFavoriteTechnologies : JsonSerializable
{
    public static var typeName:String { return "GetFavoriteTechnologies" }
    public static var metadata = Metadata.create([
        Type<GetFavoriteTechnologies>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
        ])
}

extension AddFavoriteTechnology : JsonSerializable
{
    public static var typeName:String { return "AddFavoriteTechnology" }
    public static var metadata = Metadata.create([
        Type<AddFavoriteTechnology>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
        ])
}

extension RemoveFavoriteTechnology : JsonSerializable
{
    public static var typeName:String { return "RemoveFavoriteTechnology" }
    public static var metadata = Metadata.create([
        Type<RemoveFavoriteTechnology>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
        ])
}

extension GetUserFeed : JsonSerializable
{
    public static var typeName:String { return "GetUserFeed" }
    public static var metadata = Metadata.create([
        ])
}

extension GetUserInfo : JsonSerializable
{
    public static var typeName:String { return "GetUserInfo" }
    public static var metadata = Metadata.create([
        Type<GetUserInfo>.optionalProperty("reload", get: { $0.reload }, set: { $0.reload = $1 }),
        Type<GetUserInfo>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        ])
}

extension Authenticate : JsonSerializable
{
    public static var typeName:String { return "Authenticate" }
    public static var metadata = Metadata.create([
        Type<Authenticate>.optionalProperty("provider", get: { $0.provider }, set: { $0.provider = $1 }),
        Type<Authenticate>.optionalProperty("state", get: { $0.state }, set: { $0.state = $1 }),
        Type<Authenticate>.optionalProperty("oauth_token", get: { $0.oauth_token }, set: { $0.oauth_token = $1 }),
        Type<Authenticate>.optionalProperty("oauth_verifier", get: { $0.oauth_verifier }, set: { $0.oauth_verifier = $1 }),
        Type<Authenticate>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<Authenticate>.optionalProperty("password", get: { $0.password }, set: { $0.password = $1 }),
        Type<Authenticate>.optionalProperty("rememberMe", get: { $0.rememberMe }, set: { $0.rememberMe = $1 }),
        Type<Authenticate>.optionalProperty("`continue`", get: { $0.`continue` }, set: { $0.`continue` = $1 }),
        Type<Authenticate>.optionalProperty("nonce", get: { $0.nonce }, set: { $0.nonce = $1 }),
        Type<Authenticate>.optionalProperty("uri", get: { $0.uri }, set: { $0.uri = $1 }),
        Type<Authenticate>.optionalProperty("response", get: { $0.response }, set: { $0.response = $1 }),
        Type<Authenticate>.optionalProperty("qop", get: { $0.qop }, set: { $0.qop = $1 }),
        Type<Authenticate>.optionalProperty("nc", get: { $0.nc }, set: { $0.nc = $1 }),
        Type<Authenticate>.optionalProperty("cnonce", get: { $0.cnonce }, set: { $0.cnonce = $1 }),
        Type<Authenticate>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension AssignRoles : JsonSerializable
{
    public static var typeName:String { return "AssignRoles" }
    public static var metadata = Metadata.create([
        Type<AssignRoles>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<AssignRoles>.arrayProperty("permissions", get: { $0.permissions }, set: { $0.permissions = $1 }),
        Type<AssignRoles>.arrayProperty("roles", get: { $0.roles }, set: { $0.roles = $1 }),
        ])
}

extension UnAssignRoles : JsonSerializable
{
    public static var typeName:String { return "UnAssignRoles" }
    public static var metadata = Metadata.create([
        Type<UnAssignRoles>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<UnAssignRoles>.arrayProperty("permissions", get: { $0.permissions }, set: { $0.permissions = $1 }),
        Type<UnAssignRoles>.arrayProperty("roles", get: { $0.roles }, set: { $0.roles = $1 }),
        ])
}

extension QueryPosts : JsonSerializable
{
    public static var typeName:String { return "QueryPosts" }
    public static var metadata = Metadata.create([
        Type<QueryPosts>.optionalProperty("skip", get: { $0.skip }, set: { $0.skip = $1 }),
        Type<QueryPosts>.optionalProperty("take", get: { $0.take }, set: { $0.take = $1 }),
        Type<QueryPosts>.optionalProperty("orderBy", get: { $0.orderBy }, set: { $0.orderBy = $1 }),
        Type<QueryPosts>.optionalProperty("orderByDesc", get: { $0.orderByDesc }, set: { $0.orderByDesc = $1 }),
        Type<QueryPosts>.optionalProperty("include", get: { $0.include }, set: { $0.include = $1 }),
        Type<QueryPosts>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension LogoUrlApprovalResponse : JsonSerializable
{
    public static var typeName:String { return "LogoUrlApprovalResponse" }
    public static var metadata = Metadata.create([
        Type<LogoUrlApprovalResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension LockStackResponse : JsonSerializable
{
    public static var typeName:String { return "LockStackResponse" }
    public static var metadata = Metadata.create([
        ])
}

extension CreateTechnologyResponse : JsonSerializable
{
    public static var typeName:String { return "CreateTechnologyResponse" }
    public static var metadata = Metadata.create([
        Type<CreateTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        Type<CreateTechnologyResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UpdateTechnologyResponse : JsonSerializable
{
    public static var typeName:String { return "UpdateTechnologyResponse" }
    public static var metadata = Metadata.create([
        Type<UpdateTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        Type<UpdateTechnologyResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension DeleteTechnologyResponse : JsonSerializable
{
    public static var typeName:String { return "DeleteTechnologyResponse" }
    public static var metadata = Metadata.create([
        Type<DeleteTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        Type<DeleteTechnologyResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetTechnologyResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyResponse" }
    public static var metadata = Metadata.create([
        Type<GetTechnologyResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<GetTechnologyResponse>.optionalObjectProperty("technology", get: { $0.technology }, set: { $0.technology = $1 }),
        Type<GetTechnologyResponse>.arrayProperty("technologyStacks", get: { $0.technologyStacks }, set: { $0.technologyStacks = $1 }),
        Type<GetTechnologyResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetTechnologyPreviousVersionsResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyPreviousVersionsResponse" }
    public static var metadata = Metadata.create([
        Type<GetTechnologyPreviousVersionsResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension GetTechnologyFavoriteDetailsResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyFavoriteDetailsResponse" }
    public static var metadata = Metadata.create([
        Type<GetTechnologyFavoriteDetailsResponse>.arrayProperty("users", get: { $0.users }, set: { $0.users = $1 }),
        Type<GetTechnologyFavoriteDetailsResponse>.optionalProperty("favoriteCount", get: { $0.favoriteCount }, set: { $0.favoriteCount = $1 }),
        ])
}

extension GetAllTechnologiesResponse : JsonSerializable
{
    public static var typeName:String { return "GetAllTechnologiesResponse" }
    public static var metadata = Metadata.create([
        Type<GetAllTechnologiesResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension QueryResponse : JsonSerializable
{
    public static var typeName:String { return "QueryResponse<T>" }
    public static var metadata:Metadata {
        return Metadata.create([
            Type<QueryResponse<T>>.optionalProperty("offset", get: { $0.offset }, set: { $0.offset = $1 }),
            Type<QueryResponse<T>>.optionalProperty("total", get: { $0.total }, set: { $0.total = $1 }),
            Type<QueryResponse<T>>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
            Type<QueryResponse<T>>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
            Type<QueryResponse<T>>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
            ])
    }
}

extension CreateTechnologyStackResponse : JsonSerializable
{
    public static var typeName:String { return "CreateTechnologyStackResponse" }
    public static var metadata = Metadata.create([
        Type<CreateTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        Type<CreateTechnologyStackResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UpdateTechnologyStackResponse : JsonSerializable
{
    public static var typeName:String { return "UpdateTechnologyStackResponse" }
    public static var metadata = Metadata.create([
        Type<UpdateTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        Type<UpdateTechnologyStackResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension DeleteTechnologyStackResponse : JsonSerializable
{
    public static var typeName:String { return "DeleteTechnologyStackResponse" }
    public static var metadata = Metadata.create([
        Type<DeleteTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        Type<DeleteTechnologyStackResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetAllTechnologyStacksResponse : JsonSerializable
{
    public static var typeName:String { return "GetAllTechnologyStacksResponse" }
    public static var metadata = Metadata.create([
        Type<GetAllTechnologyStacksResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension GetTechnologyStackResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStackResponse" }
    public static var metadata = Metadata.create([
        Type<GetTechnologyStackResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<GetTechnologyStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        Type<GetTechnologyStackResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetTechnologyStackPreviousVersionsResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStackPreviousVersionsResponse" }
    public static var metadata = Metadata.create([
        Type<GetTechnologyStackPreviousVersionsResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension GetTechnologyStackFavoriteDetailsResponse : JsonSerializable
{
    public static var typeName:String { return "GetTechnologyStackFavoriteDetailsResponse" }
    public static var metadata = Metadata.create([
        Type<GetTechnologyStackFavoriteDetailsResponse>.arrayProperty("users", get: { $0.users }, set: { $0.users = $1 }),
        Type<GetTechnologyStackFavoriteDetailsResponse>.optionalProperty("favoriteCount", get: { $0.favoriteCount }, set: { $0.favoriteCount = $1 }),
        ])
}

extension GetConfigResponse : JsonSerializable
{
    public static var typeName:String { return "GetConfigResponse" }
    public static var metadata = Metadata.create([
        Type<GetConfigResponse>.arrayProperty("allTiers", get: { $0.allTiers }, set: { $0.allTiers = $1 }),
        ])
}

extension OverviewResponse : JsonSerializable
{
    public static var typeName:String { return "OverviewResponse" }
    public static var metadata = Metadata.create([
        Type<OverviewResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<OverviewResponse>.arrayProperty("topUsers", get: { $0.topUsers }, set: { $0.topUsers = $1 }),
        Type<OverviewResponse>.arrayProperty("topTechnologies", get: { $0.topTechnologies }, set: { $0.topTechnologies = $1 }),
        Type<OverviewResponse>.arrayProperty("latestTechStacks", get: { $0.latestTechStacks }, set: { $0.latestTechStacks = $1 }),
        Type<OverviewResponse>.objectProperty("topTechnologiesByTier", get: { $0.topTechnologiesByTier }, set: { $0.topTechnologiesByTier = $1 }),
        Type<OverviewResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension AppOverviewResponse : JsonSerializable
{
    public static var typeName:String { return "AppOverviewResponse" }
    public static var metadata = Metadata.create([
        Type<AppOverviewResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<AppOverviewResponse>.arrayProperty("allTiers", get: { $0.allTiers }, set: { $0.allTiers = $1 }),
        Type<AppOverviewResponse>.arrayProperty("topTechnologies", get: { $0.topTechnologies }, set: { $0.topTechnologies = $1 }),
        Type<AppOverviewResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension GetFavoriteTechStackResponse : JsonSerializable
{
    public static var typeName:String { return "GetFavoriteTechStackResponse" }
    public static var metadata = Metadata.create([
        Type<GetFavoriteTechStackResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension FavoriteTechStackResponse : JsonSerializable
{
    public static var typeName:String { return "FavoriteTechStackResponse" }
    public static var metadata = Metadata.create([
        Type<FavoriteTechStackResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension GetFavoriteTechnologiesResponse : JsonSerializable
{
    public static var typeName:String { return "GetFavoriteTechnologiesResponse" }
    public static var metadata = Metadata.create([
        Type<GetFavoriteTechnologiesResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension FavoriteTechnologyResponse : JsonSerializable
{
    public static var typeName:String { return "FavoriteTechnologyResponse" }
    public static var metadata = Metadata.create([
        Type<FavoriteTechnologyResponse>.optionalObjectProperty("result", get: { $0.result }, set: { $0.result = $1 }),
        ])
}

extension GetUserFeedResponse : JsonSerializable
{
    public static var typeName:String { return "GetUserFeedResponse" }
    public static var metadata = Metadata.create([
        Type<GetUserFeedResponse>.arrayProperty("results", get: { $0.results }, set: { $0.results = $1 }),
        ])
}

extension GetUserInfoResponse : JsonSerializable
{
    public static var typeName:String { return "GetUserInfoResponse" }
    public static var metadata = Metadata.create([
        Type<GetUserInfoResponse>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<GetUserInfoResponse>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<GetUserInfoResponse>.optionalProperty("avatarUrl", get: { $0.avatarUrl }, set: { $0.avatarUrl = $1 }),
        Type<GetUserInfoResponse>.arrayProperty("techStacks", get: { $0.techStacks }, set: { $0.techStacks = $1 }),
        Type<GetUserInfoResponse>.arrayProperty("favoriteTechStacks", get: { $0.favoriteTechStacks }, set: { $0.favoriteTechStacks = $1 }),
        Type<GetUserInfoResponse>.arrayProperty("favoriteTechnologies", get: { $0.favoriteTechnologies }, set: { $0.favoriteTechnologies = $1 }),
        ])
}

extension AuthenticateResponse : JsonSerializable
{
    public static var typeName:String { return "AuthenticateResponse" }
    public static var metadata = Metadata.create([
        Type<AuthenticateResponse>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
        Type<AuthenticateResponse>.optionalProperty("sessionId", get: { $0.sessionId }, set: { $0.sessionId = $1 }),
        Type<AuthenticateResponse>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<AuthenticateResponse>.optionalProperty("displayName", get: { $0.displayName }, set: { $0.displayName = $1 }),
        Type<AuthenticateResponse>.optionalProperty("referrerUrl", get: { $0.referrerUrl }, set: { $0.referrerUrl = $1 }),
        Type<AuthenticateResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        Type<AuthenticateResponse>.objectProperty("meta", get: { $0.meta }, set: { $0.meta = $1 }),
        ])
}

extension AssignRolesResponse : JsonSerializable
{
    public static var typeName:String { return "AssignRolesResponse" }
    public static var metadata = Metadata.create([
        Type<AssignRolesResponse>.arrayProperty("allRoles", get: { $0.allRoles }, set: { $0.allRoles = $1 }),
        Type<AssignRolesResponse>.arrayProperty("allPermissions", get: { $0.allPermissions }, set: { $0.allPermissions = $1 }),
        Type<AssignRolesResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension UnAssignRolesResponse : JsonSerializable
{
    public static var typeName:String { return "UnAssignRolesResponse" }
    public static var metadata = Metadata.create([
        Type<UnAssignRolesResponse>.arrayProperty("allRoles", get: { $0.allRoles }, set: { $0.allRoles = $1 }),
        Type<UnAssignRolesResponse>.arrayProperty("allPermissions", get: { $0.allPermissions }, set: { $0.allPermissions = $1 }),
        Type<UnAssignRolesResponse>.optionalProperty("responseStatus", get: { $0.responseStatus }, set: { $0.responseStatus = $1 }),
        ])
}

extension Technology : JsonSerializable
{
    public static var typeName:String { return "Technology" }
    public static var metadata = Metadata.create([
        Type<Technology>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<Technology>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<Technology>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
        Type<Technology>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
        Type<Technology>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
        Type<Technology>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
        Type<Technology>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<Technology>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<Technology>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
        Type<Technology>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
        Type<Technology>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
        Type<Technology>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
        Type<Technology>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        Type<Technology>.optionalProperty("logoApproved", get: { $0.logoApproved }, set: { $0.logoApproved = $1 }),
        Type<Technology>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        Type<Technology>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
        Type<Technology>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
        ])
}

extension TechnologyTier : StringSerializable
{
    public static var typeName:String { return "TechnologyTier" }
    public func toJson() -> String {
        return jsonStringRaw(toString())
    }
    public func toString() -> String {
        switch self {
        case .ProgrammingLanguage: return "ProgrammingLanguage"
        case .Client: return "Client"
        case .Http: return "Http"
        case .Server: return "Server"
        case .Data: return "Data"
        case .SoftwareInfrastructure: return "SoftwareInfrastructure"
        case .OperatingSystem: return "OperatingSystem"
        case .HardwareInfrastructure: return "HardwareInfrastructure"
        case .ThirdPartyServices: return "ThirdPartyServices"
        }
    }
    public static func fromString(strValue:String) -> TechnologyTier? {
        switch strValue {
        case "ProgrammingLanguage": return .ProgrammingLanguage
        case "Client": return .Client
        case "Http": return .Http
        case "Server": return .Server
        case "Data": return .Data
        case "SoftwareInfrastructure": return .SoftwareInfrastructure
        case "OperatingSystem": return .OperatingSystem
        case "HardwareInfrastructure": return .HardwareInfrastructure
        case "ThirdPartyServices": return .ThirdPartyServices
        default: return nil
        }
    }
    public static func fromObject(any:AnyObject) -> TechnologyTier? {
        switch any {
        case let i as Int: return TechnologyTier(rawValue: i)
        case let s as String: return fromString(s)
        default: return nil
        }
    }
}

extension TechnologyStack : JsonSerializable
{
    public static var typeName:String { return "TechnologyStack" }
    public static var metadata = Metadata.create([
        Type<TechnologyStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<TechnologyStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<TechnologyStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
        Type<TechnologyStack>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<TechnologyStack>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
        Type<TechnologyStack>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
        Type<TechnologyStack>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<TechnologyStack>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
        Type<TechnologyStack>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
        Type<TechnologyStack>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
        Type<TechnologyStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        Type<TechnologyStack>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
        Type<TechnologyStack>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        Type<TechnologyStack>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
        Type<TechnologyStack>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
        ])
}

extension TechnologyHistory : JsonSerializable
{
    public static var typeName:String { return "TechnologyHistory" }
    public static var metadata = Metadata.create([
        Type<TechnologyHistory>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
        Type<TechnologyHistory>.optionalProperty("operation", get: { $0.operation }, set: { $0.operation = $1 }),
        Type<TechnologyHistory>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<TechnologyHistory>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<TechnologyHistory>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
        Type<TechnologyHistory>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
        Type<TechnologyHistory>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
        Type<TechnologyHistory>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
        Type<TechnologyHistory>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<TechnologyHistory>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<TechnologyHistory>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
        Type<TechnologyHistory>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
        Type<TechnologyHistory>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
        Type<TechnologyHistory>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
        Type<TechnologyHistory>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        Type<TechnologyHistory>.optionalProperty("logoApproved", get: { $0.logoApproved }, set: { $0.logoApproved = $1 }),
        Type<TechnologyHistory>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        Type<TechnologyHistory>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
        Type<TechnologyHistory>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
        ])
}

extension TechStackDetails : JsonSerializable
{
    public static var typeName:String { return "TechStackDetails" }
    public static var metadata = Metadata.create([
        Type<TechStackDetails>.optionalProperty("detailsHtml", get: { $0.detailsHtml }, set: { $0.detailsHtml = $1 }),
        Type<TechStackDetails>.arrayProperty("technologyChoices", get: { $0.technologyChoices }, set: { $0.technologyChoices = $1 }),
        Type<TechStackDetails>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<TechStackDetails>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<TechStackDetails>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
        Type<TechStackDetails>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<TechStackDetails>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
        Type<TechStackDetails>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
        Type<TechStackDetails>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<TechStackDetails>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
        Type<TechStackDetails>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
        Type<TechStackDetails>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
        Type<TechStackDetails>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        Type<TechStackDetails>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
        Type<TechStackDetails>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        Type<TechStackDetails>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
        Type<TechStackDetails>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
        ])
}

extension TechnologyStackHistory : JsonSerializable
{
    public static var typeName:String { return "TechnologyStackHistory" }
    public static var metadata = Metadata.create([
        Type<TechnologyStackHistory>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("operation", get: { $0.operation }, set: { $0.operation = $1 }),
        Type<TechnologyStackHistory>.arrayProperty("technologyIds", get: { $0.technologyIds }, set: { $0.technologyIds = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("appUrl", get: { $0.appUrl }, set: { $0.appUrl = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("screenshotUrl", get: { $0.screenshotUrl }, set: { $0.screenshotUrl = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("details", get: { $0.details }, set: { $0.details = $1 }),
        Type<TechnologyStackHistory>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
        ])
}

extension Option : JsonSerializable
{
    public static var typeName:String { return "Option" }
    public static var metadata = Metadata.create([
        Type<Option>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<Option>.optionalProperty("title", get: { $0.title }, set: { $0.title = $1 }),
        Type<Option>.optionalProperty("value", get: { $0.value }, set: { $0.value = $1 }),
        ])
}

extension UserInfo : JsonSerializable
{
    public static var typeName:String { return "UserInfo" }
    public static var metadata = Metadata.create([
        Type<UserInfo>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<UserInfo>.optionalProperty("avatarUrl", get: { $0.avatarUrl }, set: { $0.avatarUrl = $1 }),
        Type<UserInfo>.optionalProperty("stacksCount", get: { $0.stacksCount }, set: { $0.stacksCount = $1 }),
        ])
}

extension TechnologyInfo : JsonSerializable
{
    public static var typeName:String { return "TechnologyInfo" }
    public static var metadata = Metadata.create([
        Type<TechnologyInfo>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
        Type<TechnologyInfo>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        Type<TechnologyInfo>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<TechnologyInfo>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
        Type<TechnologyInfo>.optionalProperty("stacksCount", get: { $0.stacksCount }, set: { $0.stacksCount = $1 }),
        ])
}

extension Post : JsonSerializable
{
    public static var typeName:String { return "Post" }
    public static var metadata = Metadata.create([
        Type<Post>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<Post>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
        Type<Post>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<Post>.optionalProperty("date", get: { $0.date }, set: { $0.date = $1 }),
        Type<Post>.optionalProperty("shortDate", get: { $0.shortDate }, set: { $0.shortDate = $1 }),
        Type<Post>.optionalProperty("textHtml", get: { $0.textHtml }, set: { $0.textHtml = $1 }),
        Type<Post>.arrayProperty("comments", get: { $0.comments }, set: { $0.comments = $1 }),
        ])
}

extension TechnologyInStack : JsonSerializable
{
    public static var typeName:String { return "TechnologyInStack" }
    public static var metadata = Metadata.create([
        Type<TechnologyInStack>.optionalProperty("technologyId", get: { $0.technologyId }, set: { $0.technologyId = $1 }),
        Type<TechnologyInStack>.optionalProperty("technologyStackId", get: { $0.technologyStackId }, set: { $0.technologyStackId = $1 }),
        Type<TechnologyInStack>.optionalProperty("justification", get: { $0.justification }, set: { $0.justification = $1 }),
        Type<TechnologyInStack>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<TechnologyInStack>.optionalProperty("name", get: { $0.name }, set: { $0.name = $1 }),
        Type<TechnologyInStack>.optionalProperty("vendorName", get: { $0.vendorName }, set: { $0.vendorName = $1 }),
        Type<TechnologyInStack>.optionalProperty("vendorUrl", get: { $0.vendorUrl }, set: { $0.vendorUrl = $1 }),
        Type<TechnologyInStack>.optionalProperty("productUrl", get: { $0.productUrl }, set: { $0.productUrl = $1 }),
        Type<TechnologyInStack>.optionalProperty("logoUrl", get: { $0.logoUrl }, set: { $0.logoUrl = $1 }),
        Type<TechnologyInStack>.optionalProperty("Description", get: { $0.Description }, set: { $0.Description = $1 }),
        Type<TechnologyInStack>.optionalProperty("created", get: { $0.created }, set: { $0.created = $1 }),
        Type<TechnologyInStack>.optionalProperty("createdBy", get: { $0.createdBy }, set: { $0.createdBy = $1 }),
        Type<TechnologyInStack>.optionalProperty("lastModified", get: { $0.lastModified }, set: { $0.lastModified = $1 }),
        Type<TechnologyInStack>.optionalProperty("lastModifiedBy", get: { $0.lastModifiedBy }, set: { $0.lastModifiedBy = $1 }),
        Type<TechnologyInStack>.optionalProperty("ownerId", get: { $0.ownerId }, set: { $0.ownerId = $1 }),
        Type<TechnologyInStack>.optionalProperty("slug", get: { $0.slug }, set: { $0.slug = $1 }),
        Type<TechnologyInStack>.optionalProperty("logoApproved", get: { $0.logoApproved }, set: { $0.logoApproved = $1 }),
        Type<TechnologyInStack>.optionalProperty("isLocked", get: { $0.isLocked }, set: { $0.isLocked = $1 }),
        Type<TechnologyInStack>.optionalProperty("tier", get: { $0.tier }, set: { $0.tier = $1 }),
        Type<TechnologyInStack>.optionalProperty("lastStatusUpdate", get: { $0.lastStatusUpdate }, set: { $0.lastStatusUpdate = $1 }),
        ])
}

extension PostComment : JsonSerializable
{
    public static var typeName:String { return "PostComment" }
    public static var metadata = Metadata.create([
        Type<PostComment>.optionalProperty("id", get: { $0.id }, set: { $0.id = $1 }),
        Type<PostComment>.optionalProperty("postId", get: { $0.postId }, set: { $0.postId = $1 }),
        Type<PostComment>.optionalProperty("userId", get: { $0.userId }, set: { $0.userId = $1 }),
        Type<PostComment>.optionalProperty("userName", get: { $0.userName }, set: { $0.userName = $1 }),
        Type<PostComment>.optionalProperty("date", get: { $0.date }, set: { $0.date = $1 }),
        Type<PostComment>.optionalProperty("shortDate", get: { $0.shortDate }, set: { $0.shortDate = $1 }),
        Type<PostComment>.optionalProperty("textHtml", get: { $0.textHtml }, set: { $0.textHtml = $1 }),
        ])
}
