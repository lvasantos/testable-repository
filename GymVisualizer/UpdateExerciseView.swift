import SwiftUI

struct UpdateExerciseView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @State var exercise: Exercise

    @State var name: String = ""
    @State var observations: String = ""
    @State var descriptions: String = ""

    @Binding var editToggle: Bool

    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Exercise Name", text: $name)
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
                    updateExercise()
                    editToggle.toggle()
                } label: {
                    Spacer()
                    Text("Update")
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .buttonStyle(.borderless)
            }
        }
        .onAppear {
            self.name = exercise.name!
            self.observations = exercise.observations ?? "Vazio"
            self.descriptions = exercise.descriptions ?? "Vazio"
        }
    }

    private func updateExercise() {
        exercise.name = self.name
        exercise.observations = self.observations
        exercise.descriptions = self.descriptions

        PersistenceController.saveState(viewContext)
    }


}
