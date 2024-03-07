

import Foundation
import SwiftUI

struct Task: Identifiable, Codable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
    
}

struct TaskMetaData: Identifiable, Codable {
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

func getSampleDate(offset: Int)->Date{
    let calendar = Calendar.current
    
    let date = calendar.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

var tasks: [TaskMetaData] = {
    let loadedTasks = try? [TaskMetaData].load(from: "tasks")
    return loadedTasks ?? []
}()


