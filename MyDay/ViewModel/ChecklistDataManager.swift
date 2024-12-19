
//  MyDay

import Foundation

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var isCompleted: Bool
}
