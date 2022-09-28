import SwiftUI
import CoreData

struct ExerciseView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Exercise.entity(), sortDescriptors: []
    ) private var exercises: FetchedResults<Exercise>

    @State var isPresented = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(exercises, id: \.self) { exercise in
                        NavigationLink(destination: ExerciseCellView(exercise: exercise)) {
                            Text(exercise.name!)
                            }
                            .sheet(isPresented: $isPresented, content: {
                                AddExerciseView(exercise: exercise, isPresented: $isPresented)
                            })
                    }
                }
                .listStyle(.insetGrouped)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Exercises")
                        .font(.largeTitle)
                        .bold()
                }
            }
        }
    }
}
