

import SwiftUI


struct NoteCategorySelectionView_Preview: View {
    @Binding var note: Note
    @Binding var creatingNewNote: Bool

    @ObservedObject var viewModel: NotesListViewModel
    @ObservedObject var sheetsViewModel: SheetsViewModel

    @Environment(\.dismiss) var dismiss

    @State var triggerHapticFeedback: Bool = false

    @State var isAlertPresented: Bool = false

    var body: some View {
        VStack {
            dismissTopView

            CustomTopTitle(text: "Change Note Category")
                .padding(.horizontal)

            categoriesGridView
        }
        .padding(.top)
        .presentationDragIndicator(.visible)
        .presentationBackground(.regularMaterial)
        .presentationCornerRadius(Constants.roundedRectCornerRadius)
        .presentationDetents([.fraction(0.6)])
        .successToast(title: "Category created!", subtitle: "And assigned to your note", isPresented: $isAlertPresented)
    }
}


extension NoteCategorySelectionView_Preview {
    var dismissTopView: some View {
        HStack {
            Spacer()
            DismissViewButton()
        }
        .padding([.horizontal, .bottom])
    }


    var categoriesGridView: some View {
        let layout = [
            GridItem(
                .adaptive(minimum: viewModel.idiom == .pad ? 200 : 160)
            )
        ]

        return ZStack {
            ScrollView {
                LazyVGrid(columns: layout) {
                    ForEach(viewModel.categories) { category in
                        PreviewNoteCategoryButton(
                            note: $note,
                            category: category,
                            creatingNewNote: $creatingNewNote,
                            triggerHapticFeedback: $triggerHapticFeedback,
                            viewModel: viewModel
                        )
                        .padding(5)
                    }
                }
                .padding()
                .padding(.bottom, 100)
            }
            .overlay(alignment: .bottom) {
                VariableBlurView(
                    maxBlurRadius: 6,
                    direction: .blurredBottomClearTop
                )
                .ignoresSafeArea()
                .frame(height: 120)
                .allowsHitTesting(true)
            }

            VStack {
                Spacer()
                PreviewCreateAndAssignNoteCategoryButton(
                    viewModel: viewModel,
                    sheetsViewModel: sheetsViewModel,
                    note: $note,
                    isAlertPresented: $isAlertPresented
                )
                .padding()
            }
        }
    }
}


struct PreviewNoteCategoryButton: View {
    @Binding var note: Note
    var category: Category

    @Binding var creatingNewNote: Bool
    @Binding var triggerHapticFeedback: Bool

    @ObservedObject var viewModel: NotesListViewModel
    @Environment(\.dismiss) var dismiss

    var strokeColorGradient: AnyGradient {
        (note.category?.id == category.id) ? category.color.gradient : Color.gray.gradient
    }

    var body: some View {
        Button {
            note.category = category
            if !creatingNewNote { viewModel.update(note: note, updatingDate: false) }
            HapticManager.instance.impact(style: .soft)
            dismiss()
        } label: {
            HStack {
                Text(category.displayName)
                    .foregroundStyle(category.name.isEmpty ? .secondary : .primary)
                    .lineLimit(1)

                Spacer()

                dynamicIndicator
            }
            .contentShape(Rectangle())
            .contentTransition(.symbolEffect(.automatic))
            .onLongPressGesture(perform: { triggerHapticFeedback.toggle() } )
        }
        .buttonStyle(
            GradientButtonStyle(
                startColor: .gridLabelBackground,
                endColor: category.color,
                startColorOpacity: Constants.gradientStartColorOpacity,
                endColorOpacity: Constants.gradientEndColorOpacity
            )
        )
        .overlay { adaptableOverlay }
        .sensoryFeedback(.error, trigger: triggerHapticFeedback)
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("\(category.displayName) Category")
    }

    var dynamicIndicator: some View {
        Image(
            systemName: (note.category?.id == category.id) ? "circle.fill" : "circle"
        )
        .foregroundStyle(category.color)
        .bold()
        .subtleShadow(color: .black.opacity(0.2))
    }

    var adaptableOverlay: some View {
        RoundedRectangle(cornerRadius: Constants.materialButtonCornerRadius)
            .stroke(
                strokeColorGradient.opacity(
                    (note.category?.id == category.id) ? 0.5 : 0.1
                ),
                lineWidth: 4
            )
    }
}


struct PreviewCreateAndAssignNoteCategoryButton: View {
    @ObservedObject var viewModel: NotesListViewModel
    @ObservedObject var sheetsViewModel: SheetsViewModel

    @Binding var note: Note
    @State private var category: Category?

    @State private var showingAlert = false
    @State private var categoryName: String = ""

    @Binding var isAlertPresented: Bool

    @Environment(\.dismiss) var dismiss

    var body: some View {
        Button {
            HapticManager.instance.impact(style: .soft)
            showingAlert.toggle()
        } label: {
            Text("Create and assign new category")
                .foregroundStyle(Color(.label).gradient)
                .frame(minWidth: 200, maxHeight: 16)
        }
        .padding()
        .fontWeight(.medium)
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: Constants.materialButtonCornerRadius))
        .largeShadow(color: .black.opacity(0.3))
        .overlay {
            RoundedRectangle(cornerRadius: Constants.materialButtonCornerRadius)
                .stroke(Color.gray.gradient.opacity(0.1), lineWidth: 4)
        }
        .alert("Create a new category", isPresented: $showingAlert) {
            Group {
                TextField("Enter your category name", text: $categoryName)
                Button("Save and Assign") {
                    createAndAssignCategory()
                    categoryName = ""
                }
                Button("Cancel", role: .cancel) { }
            }
            .tint(.accent)
        } message: {
            Text(
                """
                Your category will be created and assigned to your note.
                \nYou can further personalize it by tapping the Category Selection button in your Dock.
                """
            )
        }
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("Create a new category and assign it to this note.")
    }

    func createAndAssignCategory() {
        withAnimation {
            category = Category(id: UUID(), name: categoryName, color: .gray)
            viewModel.add(
                category: category ?? Category(id: UUID(), name: "Unnamed Category", color: .gray)
            )

            note.category = viewModel.categories[
                viewModel.getCategoryIndexFromCategoriesArray(category: category!)!
            ]
        }

        HapticManager.instance.notification(type: .success)
        isAlertPresented.toggle()
    }
}

#if DEBUG
#Preview("NoteCategorySelectionView") {
    NoteCategorySelectionView_Preview(
        note: .constant(.example),
        creatingNewNote: .constant(false),
        viewModel: NotesListViewModel(),
        sheetsViewModel: SheetsViewModel()
    )

}
#endif
