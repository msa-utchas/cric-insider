import Foundation
import Foundation
import UIKit
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    let context = CoreDataStack.shared.persistentContainer.viewContext
    private init() {
        privateContext.parent = context
        privateContext.automaticallyMergesChangesFromParent = true
    }
}


