import Foundation
import CoreData

extension PlayersInfo {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayersInfo> {
        return NSFetchRequest<PlayersInfo>(entityName: "PlayersInfo")
    }

    @NSManaged public var country: String?
    @NSManaged public var fullName: String?
    @NSManaged public var imagePath: String?
    @NSManaged public var id: Int32

}

extension PlayersInfo : Identifiable {

}

