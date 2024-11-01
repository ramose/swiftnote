import SwiftUI

struct EditNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: NotesViewModel
    @State var note: Note

    var body: some View {
        NavigationView {
            Form {
                TextArea(placeholder: "Edit your note here...", text: $note.content)
            }
            .navigationTitle("Edit Note")
            .navigationBarItems(trailing: Button("Save") {
                viewModel.update(note: note)
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
