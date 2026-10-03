

import SwiftUI

fileprivate enum FocusField: Hashable {
    case titleTextField
    case textEditorField
}

struct NoteEditView_Preview: View {
    @State private var noteCopy: Note

    private let originalNote: Note

    @ObservedObject var viewModel: NotesListViewModel
    @ObservedObject var sheetsViewModel: SheetsViewModel

    @State var creatingNewNote: Bool

    @State var editingAToggledNote: Bool = false

    @State var isAlertPresented: Bool = false

    @FocusState private var focusedField: FocusField?

    @Environment(\.dismiss) var dismiss

    @Environment(\.accessibilityVoiceOverEnabled) var voiceOverEnabled

    @Environment(\.scenePhase) private var scenePhase

    @State private var willDateBeUpdated = false

    @State private var randomPlaceholder: String = ""

    init(
        note: Note,
        viewModel: NotesListViewModel,
        sheetsViewModel: SheetsViewModel,
        creatingNewNote: Bool
    ) {
        _noteCopy = State(initialValue: note)
        self.originalNote = note

        self.viewModel = viewModel
        self.sheetsViewModel = sheetsViewModel
        self.creatingNewNote = creatingNewNote
    }

    var body: some View {
        NavigationStack {
            
            if ( 
                !viewModel.isUnlocked && (noteCopy.isLocked == true) && !creatingNewNote && !editingAToggledNote
            ) {
                Group {
                    if voiceOverEnabled {
                        UnlockNotesView(viewModel: viewModel).accessibilityUnlockNotesView
                    } else {
                        UnlockNotesView(viewModel: viewModel)
                    }
                }
                .padding(.bottom, 80)
            } else {
                VStack(spacing: .zero) {
                    titleTextFieldView
                        .padding(.vertical)

                    Divider()
                    textContentTextEditorView
                    Divider()

                    changeNoteCategoryView
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        if creatingNewNote {
                            Button("Cancel") { dismiss() }
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        HStack {
                            if !(focusedField == .none) {
                                Button("OK") { focusedField = .none }
                            } else {
                                Menu {
                                    isLockedToggleButtonView
                                    if !creatingNewNote {
                                        ShareLink(item: "\(noteCopy.noteTitle)\n\(noteCopy.noteContent)")
                                        DeleteNoteButton(
                                            note: noteCopy,
                                            viewModel: viewModel,
                                            dismissView: true
                                        )
                                    }

                                } label: {
                                    Label("More options", systemImage: "ellipsis.circle")
                                }
                                if creatingNewNote {
                                    saveNoteButtonView
                                }
                            }
                        }
                    }
                }
                .sheet(isPresented: $sheetsViewModel.showNoteCategorySheet) {
                    NoteCategorySelectionView(
                        note: $noteCopy,
                        creatingNewNote: $creatingNewNote,
                        viewModel: viewModel,
                        sheetsViewModel: sheetsViewModel
                    )
                }
                .blurWhenAppNotActive(isBlurActive: noteCopy.isLocked) 
            }
        }
        .onAppear {
            
            if randomPlaceholder.isEmpty {
                randomPlaceholder = NoteEditView_Preview.untitledNotePlaceholders.randomElement() ?? "Title your note..."
            }
        }
        .onDisappear {
            
            if !creatingNewNote {
                viewModel.update(
                    note: noteCopy,
                    
                    updatingDate: willDateBeUpdated
                )
            }
        }
        .onChange(of: scenePhase) { phase, _ in
            if (phase == ScenePhase.background) { 
                editingAToggledNote = false 

                if !creatingNewNote { 
                    viewModel.update(
                        note: noteCopy,
                        updatingDate: willDateBeUpdated
                    )
                }
            }
        }
        .onChange(of: noteCopy) {
            if willDateBeUpdated {
                return
            } else {
                if (noteCopy.noteTitle != originalNote.noteTitle) || (noteCopy.noteContent != originalNote.noteContent) {
                    willDateBeUpdated = true
                }
            }

            if ProcessInfo.processInfo.isiOSAppOnMac || viewModel.idiom == .pad {
                Task {
                    try await Task.sleep(nanoseconds: 500_000_000) 

                    viewModel.update(
                        note: noteCopy,
                        updatingDate: willDateBeUpdated
                    )
                }
            }
        }
        .presentationCornerRadius(Constants.roundedRectCornerRadius)
        .successToast(title: "Note created!", isPresented: $isAlertPresented)
        .alert("Authentication error", isPresented: $viewModel.isShowingAuthenticationErrorWhenEditing) {
            Button("OK") { }
        } message: { Text(viewModel.authenticationError) }
    }
}


extension NoteEditView_Preview {
    var titleTextFieldView: some View {
        TextField(
            noteCopy.noteTitle,
            text: $noteCopy.noteTitle,
            prompt: Text(randomPlaceholder)
        )
        .font(.title2).bold()
        .padding(.leading)
        .focused($focusedField, equals: .titleTextField)
        .onAppear {
            if creatingNewNote { focusedField = .titleTextField }
        }
        .onSubmit { focusedField = .textEditorField }
        .submitLabel(.next)
    }

    var textContentTextEditorView: some View {
        TextEditor(text: $noteCopy.noteContent)
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .padding(.horizontal)
            .focused($focusedField, equals: .textEditorField)
    }


    var isLockedToggleButtonView: some View {
        Button {
            viewModel.authenticate(for: .changeLockStatus) {
                noteCopy.isLocked.toggle()
                editingAToggledNote = true 
            }
        } label: {
            Label(
                !noteCopy.isLocked ? "Move to private space" : "Remove from private space",
                systemImage: !noteCopy.isLocked ? "lock.fill" : "lock.slash.fill"
            )
        }
    }


    var saveNoteButtonView: some View {
        Button("Save") {
            viewModel.add(note: noteCopy)
            dismiss()

            HapticManager.instance.notification(type: .success)
            isAlertPresented.toggle()
        }
    }


    var changeNoteCategoryView: some View {
        HStack {
            HStack {
                Circle()
                    .fill((noteCopy.category?.color ?? .gray).gradient)
                    .frame(width: 10, height: 10)

                Text(noteCopy.category?.displayName ?? "No Category Selected")
                    .bold(noteCopy.category == nil ? false : true)
                    .foregroundStyle(noteCopy.category == nil ? .gray : Color(.label))
                    .lineLimit(1)
            }
            .accessibilityElement()
            .accessibilityLabel("Category: \(noteCopy.category?.displayName ?? "Unassigned").")

            Spacer()

            Button("Change Category") {
                sheetsViewModel.showNoteCategorySheet.toggle()
                HapticManager.instance.impact(style: .light)
            }
            .padding(.vertical)
        }
        .padding(.horizontal)
    }
}


extension NoteEditView_Preview {

    static let untitledNotePlaceholders = [
        "Title your note...",
        "Title your imagination...",
        "Title your inspiration..."
    ]
}

#if DEBUG
#Preview("NoteEditView - New Note") {
    NoteEditView_Preview(
        note: Note(category: .thoughts),
        viewModel: NotesListViewModel(),
        sheetsViewModel: SheetsViewModel(),
        creatingNewNote: true
    )

}
#endif
