
import SwiftUI


struct UnlockNotesView_Preview: View {
    @ObservedObject var viewModel: NotesListViewModel

    var body: some View {
        VStack {
            Image(systemName: "lock.circle.fill")
                .foregroundStyle(.accent.gradient)
                .font(.system(size: 50))
                .padding()

            Text("Private notes are protected")
                .font(.title2)
                .bold()

            Text("Unlock to enable access")
                .foregroundStyle(.secondary)

            Button("Unlock") {
                viewModel.authenticate(for: .viewNotes) {  }
            }
            .padding()
        }
        .accessibilityElement()
    }
}

extension UnlockNotesView_Preview {
    var accessibilityUnlockNotesView: some View {
        Button {
            viewModel.authenticate(for: .viewNotes) {  }
        } label: {
            UnlockNotesView_Preview(viewModel: viewModel)
        }
        .accessibilityLabel("Private notes are protected. Tap to enable access.")
    }
}

#Preview {
    UnlockNotesView_Preview(viewModel: NotesListViewModel())

}
