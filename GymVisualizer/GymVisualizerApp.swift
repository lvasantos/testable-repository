import SwiftUI

@main
struct GymVisualizerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ExerciseView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
