import SwiftUI

struct AddNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: NotesViewModel
    @State private var noteContent: String = ""

    var body: some View {
        NavigationView {
            VStack() {
                TextArea(placeholder: "Enter your note here...", text: $noteContent)
                    .padding()
                Spacer()
            }
            .navigationTitle("New Note")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss() // Close the screen when tapped
            }, trailing: Button("Save") {
                let newNote = Note(content: noteContent)
                viewModel.add(note: newNote)
                presentationMode.wrappedValue.dismiss()
            }.disabled(noteContent.isEmpty)
            )
             // Add padding around the entire view
        }
    }
}

struct TextArea: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        VStack {
            TextEditor(text: $text)
                .padding(0)
                .frame(maxHeight: 100)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .foregroundColor(text.isEmpty ? Color.gray : Color.black)
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.gray)
                    .padding(.leading, 8)
                    .padding(.top, 8)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}

#if DEBUG
struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(viewModel: MockNotesViewModel()) // Provide a mock view model for the preview
    }
}

// Create a mock NotesViewModel for preview
class MockNotesViewModel: NotesViewModel {
    override init() {
        super.init()
        // You can add any mock data if necessary
        self.notes = [Note(content: "Sample Note 1"), Note(content: "Sample Note 2")]
    }
}
#endif
