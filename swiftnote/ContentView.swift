import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NotesViewModel()
    @State private var showingAddNote = false
    @State private var noteToEdit: Note? = nil

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.notes) { note in
                    Button(action: {
                        noteToEdit = note
                    }) {
                        Text(note.content)
                    }
                    .sheet(item: $noteToEdit) { note in
                        EditNoteView(viewModel: viewModel, note: note)
                    }
                }
                .onDelete(perform: deleteNote) // Add this line
            }
            .navigationTitle("Notes")
            .navigationBarItems(trailing: Button(action: {
                showingAddNote = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingAddNote) {
                AddNoteView(viewModel: viewModel)
            }
        }
    }
    
    private func deleteNote(at offsets: IndexSet) {
        viewModel.delete(at: offsets)
    }
}
