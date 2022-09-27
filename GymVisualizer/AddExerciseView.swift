import SwiftUI

struct AddExerciseView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @State var exercise: Exercise

    @State private var name: String = ""
    @State private var descriptions: String = ""
    @State private var observations: String = ""

    @Binding var isPresented: Bool

    var body: some View {
        Form {
            Section {
                TextField("Name your Exercise", text: $name)
            } header: {
                Text("Exercise")
                    .bold()
            }.multilineTextAlignment(.center)
                .textFieldStyle(.plain)
            Section {
                TextEditor(text: $descriptions)
            } header: {
                Text("Description")
                    .bold()
            }.multilineTextAlignment(.center)
                .textFieldStyle(.plain)
            Section {
                TextEditor(text: $observations)
            } header: {
                Text("Observation")
                    .bold()
            }.multilineTextAlignment(.center)
                .textFieldStyle(.plain)
            Button {
                addExercise()
                isPresented.toggle()
            } label: {
                Spacer()
                Text("Save")
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .buttonStyle(.borderless)
        }
    }

    private func addExercise() {
        withAnimation {
            let newExercise = Exercise(context: viewContext)
            newExercise.name = name
            newExercise.observations = observations
            newExercise.descriptions = descriptions
            PersistenceController.saveState(viewContext)
        }
    }
}
