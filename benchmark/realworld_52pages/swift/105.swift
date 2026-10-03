
import SwiftUI


struct EmptyListView_Preview: View {
    @ObservedObject var viewModel: NotesListViewModel
    @ObservedObject var sheetsViewModel: SheetsViewModel
    @Binding var showNoteEditViewSheet: Bool

    var imageSystemName: String = "questionmark"
    var label: String = "No Items"
    var buttonLabel: String = "Add item"

    @State private var newNote = Note()
    @State private var randomDescription: String = ""

    var buttonActions: () -> Void

    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: imageSystemName)
                .foregroundStyle(.secondary)
                .font(.system(size: 50))
                .padding(.bottom)

            Text(label)
                .font(.title2)
                .bold()
                .padding(.bottom, 3)

            Text(randomDescription)
                .foregroundStyle(.secondary)
                .padding(.bottom, 15)

            Button(buttonLabel) {
                newNote = (viewModel.isNonLockedNotesTabSelected)
                    ? Note(category: viewModel.categories[0])
                    : Note(isLocked: true, category: viewModel.categories[0])

                buttonActions()
            }
        }
        .sheet(isPresented: $showNoteEditViewSheet) {
            NoteEditView(
                note: newNote,
                viewModel: viewModel,
                sheetsViewModel: sheetsViewModel,
                creatingNewNote: true
            )
            .interactiveDismissDisabled()
        }
        .onAppear {
            if randomDescription.isEmpty {
                randomDescription = EmptyListView_Preview.placeholders.randomElement() ?? "Start writing..."
            }
        }
    }
}

extension EmptyListView_Preview {
    var accessibilityEmptyListButton: some View {
        Button {
            newNote = (viewModel.isNonLockedNotesTabSelected)
                ? Note(category: viewModel.categories[0])
                : Note(isLocked: true, category: viewModel.categories[0])
            showNoteEditViewSheet.toggle()
        } label: {
            EmptyListView_Preview(
                viewModel: viewModel,
                sheetsViewModel: sheetsViewModel,
                showNoteEditViewSheet: $showNoteEditViewSheet,
                imageSystemName: "note.text",
                label: "This looks a little empty...",
                buttonLabel: "Create a note!"
            ) { }
        }
        .accessibilityLabel("Empty list. Tap to create a note.")
    }

    static let placeholders = [
        "What's on your mind?",
        "How's been your day?",
        "How are you feeling right now?",
        "It's OK. Write it down.",
        "Make today a little bit better.",
        "Let the words flow.",
        "Capture the moment.",
        "Start the symphony of thoughts."
    ]
}

#if DEBUG
#Preview("EmptyListView") {
    EmptyListView_Preview(
        viewModel: NotesListViewModel(),
        sheetsViewModel: SheetsViewModel(),
        showNoteEditViewSheet: .constant(false)
    ) { }

}
#endif
