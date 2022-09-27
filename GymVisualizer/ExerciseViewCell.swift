import SwiftUI

struct ExerciseViewCell: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var exercise: Exercise

    @State var editToggle = false

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Text(exercise.descriptions ?? "")
                            .italic()
                    }

                    Section {
                        Text(exercise.observations ?? "")
                            .italic()
                    }

                    HStack {
                        Button {
                            editToggle.toggle()
                        } label: {
                            Spacer()
                            Text("Update")
                                .multilineTextAlignment(.center)
                            Spacer()
                        }.buttonStyle(.borderless)

                        Divider()
                        // PRECISA DE UM ALERT PARA DELETAR
                        Button {
                            deleteExercise()
                        } label: {
                            Spacer()
                            Text("Delete")
                                .multilineTextAlignment(.center)
                                .tint(.red)
                            Spacer()
                        }.buttonStyle(.borderless)
                    }
                }
            }
            .sheet(isPresented: $editToggle) {
                UpdateExerciseView(exercise: exercise, editToggle: $editToggle)
            }
            .navigationTitle(Text(exercise.name ?? ""))
        }
            .onChange(of: editToggle) { _ in

            }
    }

    private func deleteExercise() {
        viewContext.delete(exercise)
        PersistenceController.saveState(viewContext)
    }
}
