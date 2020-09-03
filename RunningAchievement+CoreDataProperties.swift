//
//  RunningAchievement+CoreDataProperties.swift
//  Achievements
//
//  Created by James Cosgrove on 03/09/2020.
//
//

import Foundation
import CoreData


extension RunningAchievement {
    
    func makeTestAchivement(name: String = "You Can’t Catch Me!", description: String = "Complete 25 runs! 😯", value: Int = 25, progress: Float = 0.1) -> RunningAchievement {
        let achievement = RunningAchievement(context: PersistenceController.preview.container.viewContext)
        achievement.runningName = "You Can’t Catch Me!"
        achievement.runningDescription = "Complete 25 runs! 😯"
        achievement.runningValue = 25
        achievement.runningProgress = 0.1
        return achievement
    }
    
    func makeRealAchivement(name: String = "You Can’t Catch Me!", description: String = "Complete 25 runs! 😯", value: Int = 25, progress: Float = 0.1) -> RunningAchievement {
        let achievement = RunningAchievement(context: PersistenceController.shared.container.viewContext)
        achievement.runningName = "You Can’t Catch Me!"
        achievement.runningDescription = "Complete 25 runs! 😯"
        achievement.runningValue = 25
        achievement.runningProgress = 0.1
        return achievement
    }

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RunningAchievement> {
        return NSFetchRequest<RunningAchievement>(entityName: "RunningAchievement")
    }

    @NSManaged public var runningProgress: Float
    @NSManaged public var runningName: String?
    @NSManaged public var runningDescription: String?
    @NSManaged public var runningValue: Int16
    
    public var wrappedProgress: String {
        return String(runningProgress)
    }
    public var wrappedValue: String {
        return String(runningValue)
    }
    public var wrappedName: String {
        return runningName ?? "No name"
    }
    public var wrappedDescription: String {
        return runningDescription ?? "No description"
    }

}

extension RunningAchievement : Identifiable {

}
