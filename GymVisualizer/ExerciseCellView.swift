import SwiftUI

struct ExerciseCellView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State var exercise: Exercise

    @State var editToggle = false

    @State var deleteAlert = false

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
                            deleteAlert.toggle()
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
            .alert(isPresented: $deleteAlert) {
                Alert(title: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                    deleteExercise()
                }, secondaryButton: .cancel())
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
