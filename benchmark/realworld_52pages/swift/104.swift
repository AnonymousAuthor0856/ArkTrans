

import SwiftUI


struct CategorySelectionView_Preview: View {
    @ObservedObject var viewModel: NotesListViewModel
    @ObservedObject var sheetsViewModel: SheetsViewModel

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            editAndDismissTopView

            CustomTopTitle(text: viewModel.isEditModeActive ? "Edit your Categories" : "Select a Category")
                .padding(.horizontal)

            categoriesGridView
        }
        .padding(.top)
        .presentationDragIndicator(.visible)
        .presentationBackground(.regularMaterial)
        .presentationCornerRadius(Constants.roundedRectCornerRadius)
        .presentationDetents(
            viewModel.idiom == .pad ? [.fraction(0.8)] : [.fraction(0.6)]
        )
    }
}


extension CategorySelectionView_Preview {
    var editAndDismissTopView: some View {
        HStack {
            editCategoriesButton
            Spacer()
            DismissViewButton()
        }
        .padding([.horizontal, .bottom])
    }

    var editCategoriesButton: some View {
        Button(viewModel.isEditModeActive ? "Done" : "Edit") {
            HapticManager.instance.impact(style: .light)

            withAnimation(.bouncy) {
                viewModel.isEditModeActive.toggle()
            }
        }
        .accessibilityLabel(viewModel.isEditModeActive ? "Done Editing" : "Edit Categories")
    }

    @ViewBuilder
    var bottomSheetButton: some View {
        if viewModel.isEditModeActive {
            PreviewCreateCategoryButton(
                viewModel: viewModel,
                sheetsViewModel: sheetsViewModel
            )
        } else {
            PreviewNoCategoryButton(viewModel: viewModel, sheetsViewModel: sheetsViewModel)
        }
    }
}


extension CategorySelectionView_Preview {
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
                        PreviewCategoryButton(
                            viewModel: viewModel,
                            sheetsViewModel: sheetsViewModel,
                            category: category,
                            role: viewModel.isEditModeActive ? .edition : .selection,
                            isButtonDisabled: viewModel.isEditModeActive && (category.id == Category.general.id)
                        ) {
                            editOrSelectCategory(category)
                        }
                        .contextMenu {
                            Group {
                                Button(
                                    viewModel.isCategorySelected(category) ? "Unselect Category" : "Select Category",
                                    systemImage: viewModel.isCategorySelected(category) ? "xmark.circle" : "checkmark.circle"
                                ) {
                                    withAnimation(.bouncy) {
                                        viewModel.changeSelectedCategory(
                                            with: (viewModel.isCategorySelected(category) ? .noSelection : category)
                                        )
                                    }
                                }

                                if !(category.id == Category.general.id) {
                                    Button("Edit Category", systemImage: "pencil") {
                                        viewModel.changeCurrentEditableCategory(with: category)
                                        sheetsViewModel.showCategoryEditSheet.toggle()
                                    }
                                }
                            }
                        }
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
                .allowsHitTesting(false)
            }

            VStack {
                Spacer()
                bottomSheetButton
                    .padding()
            }
        }
    }

    func editOrSelectCategory(_ category: Category) {
        if viewModel.isEditModeActive {
            viewModel.changeCurrentEditableCategory(with: category)
            sheetsViewModel.showCategoryEditSheet.toggle()
        } else {
            withAnimation(.bouncy) {
                viewModel.changeSelectedCategory(with: category)
            }
            HapticManager.instance.impact(style: .soft)

            dismiss()
            viewModel.dockGlow()
        }
    }
}


struct PreviewCategoryButton: View {
    @ObservedObject var viewModel: NotesListViewModel
    @ObservedObject var sheetsViewModel: SheetsViewModel

    var category: Category
    var role: CategoryButtonRole
    var isButtonDisabled: Bool = false
    var gradientStartColorOpacity = Constants.gradientStartColorOpacity
    var gradientEndColorOpacity = Constants.gradientEndColorOpacity
    var buttonActions: () -> Void

    enum CategoryButtonRole {
        case selection
        case edition
    }

    var strokeColorGradient: AnyGradient {
        viewModel.selectedCategory == category ? category.color.gradient : Color.gray.gradient
    }

    var body: some View {
        Button {
            isButtonDisabled ? HapticManager.instance.notification(type: .error) : buttonActions()
        } label: {
            HStack {
                Text(category.displayName)
                    .foregroundStyle(category.name.isEmpty ? .secondary : .primary)
                    .lineLimit(role == .selection ? 1 : 2)

                Spacer()

                dynamicIndicator
            }
            .contentTransition(.symbolEffect(.automatic))
        }
        .buttonStyle(
            GradientButtonStyle(
                startColor: .gridLabelBackground,
                endColor: category.color,
                startColorOpacity: gradientStartColorOpacity,
                endColorOpacity: gradientEndColorOpacity
            )
        )
        .overlay { roleDependentOverlay }
        .sheet(isPresented: $sheetsViewModel.showCategoryEditSheet) {
            CategoryEditView(
                category: viewModel.currentEditableCategory,
                viewModel: viewModel,
                creatingNewCategory: false
            )
        }
        .sheet(isPresented: $sheetsViewModel.showCategoryCreationSheet) {
            CategoryEditView(
                category: Category(id: UUID(), name: "", color: .gray),
                viewModel: viewModel,
                creatingNewCategory: true
            )
        }
        .opacity(isButtonDisabled ? 0.3 : 1.0)
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("\(category.displayName) Category")
    }

    var roleDependentOverlay: some View {
        if role == .selection {
            RoundedRectangle(cornerRadius: Constants.materialButtonCornerRadius)
                .stroke(
                    strokeColorGradient.opacity(
                        viewModel.selectedCategory == category ? 0.5 : 0.1
                    ),
                    lineWidth: 4
                )
        } else {
            RoundedRectangle(cornerRadius: Constants.materialButtonCornerRadius)
                .stroke(Color.gray.gradient.opacity(0.1), lineWidth: 3)
        }
    }

    var dynamicIndicator: some View {
        Image(
            systemName:
                (role == .selection && viewModel.selectedCategory == category) ? "circle.fill" :
            (role == .edition ? "chevron.right" : "circle")
        )
        .foregroundStyle(category.color)
        .bold()
        .subtleShadow(color: .black.opacity(0.2))
    }
}


struct PreviewNoCategoryButton: View {
    @ObservedObject var viewModel: NotesListViewModel
    @ObservedObject var sheetsViewModel: SheetsViewModel

    @Environment(\.dismiss) var dismiss

    var strokeColorGradient: AnyGradient {
        viewModel.selectedCategory == Category.noSelection ? Color(.label).gradient : Color.gray.gradient
    }

    var body: some View {
        Button {
            withAnimation(.bouncy) {
                viewModel.changeSelectedCategory(with: .noSelection)
            }
            HapticManager.instance.impact(style: .soft)

            dismiss()
            viewModel.dockGlow()
        } label: {
            Text("All notes")
                .foregroundStyle(Color(.label).gradient)
                .frame(width: 100, height: 16)
        }
        .padding()
        .fontWeight(.medium)
        .background(.thinMaterial)
        .clipShape(.rect(cornerRadius: Constants.materialButtonCornerRadius))
        .largeShadow(color: .black.opacity(0.3))
        .overlay { adaptableOverlay }
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("Show all notes")
    }

    var adaptableOverlay: some View {
        RoundedRectangle(cornerRadius: Constants.materialButtonCornerRadius)
            .stroke(
                strokeColorGradient.opacity(
                    viewModel.selectedCategory == Category.noSelection ? 0.4 : 0.1
                ),
                lineWidth: 4
            )
    }
}


struct PreviewCreateCategoryButton: View {
    @ObservedObject var viewModel: NotesListViewModel
    @ObservedObject var sheetsViewModel: SheetsViewModel

    var body: some View {
        Button {
            sheetsViewModel.showCategoryCreationSheet.toggle()
            HapticManager.instance.impact(style: .light)
        } label: {
            Image(systemName: "plus")
                .bold()
                .foregroundStyle(.accent.gradient)
                .padding(5)
        }
        .buttonStyle(MaterialCircleButtonStyle())
        .overlay {
            Circle()
                .stroke(Color.gray.gradient.opacity(0.1), lineWidth: 4)
        }
        .accessibilityElement()
        .accessibilityAddTraits(.isButton)
        .accessibilityLabel("Create a Category")
    }
}

#if DEBUG
#Preview("CategorySelectionView") {
    CategorySelectionView_Preview(viewModel: NotesListViewModel(), sheetsViewModel: SheetsViewModel())

}
#endif
