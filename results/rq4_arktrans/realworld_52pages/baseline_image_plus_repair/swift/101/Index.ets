import { BusinessError } from '@kit.BasicServicesKit';
import { window } from '@kit.ArkUI';
import { router } from '@kit.ArkUI';

// Mock ViewModel and Category class for compilation context
class NotesListViewModel {
  add(category: Category) {
    console.info("Category added");
  }
  update(category: Category) {
    console.info("Category updated");
  }
}

class Category {
  name: string;
  color: Color;
  
  constructor(name: string, color: Color) {
    this.name = name;
    this.color = color;
  }
}

@Entry
@Component
struct CategoryEditView {
  @State category: Category = new Category("Thoughts", Color.Blue);
  @State isCreatingNew: boolean = false; // Set to true for "Create New" mode
  @State showDeleteDialog: boolean = false;
  @State isTextFieldFocused: boolean = false;
  
  private viewModel: NotesListViewModel = new NotesListViewModel();

  build() {
    Column() {
      // Main Content Area
      Column() {
        // Title
        Text(this.isCreatingNew ? "Create New Category" : "Edit Category")
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 40, bottom: 30 })

        // Input Row
        Row() {
          // Custom Gradient TextField
          Stack({ alignContent: Alignment.Start }) {
            // Background Gradient Shape
            Capsule()
              .fill(new LinearGradient({
                angle: 90,
                colors: [
                  { color: 'rgba(173, 216, 230, 0.8)', offset: 0.0 }, // Light blue start
                  { color: this.category.color.toString(), offset: 1.0 } // Dynamic end color
                ] as ColorStop[]
              }))
              .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
              .width('100%')
              .height(50)

            // Actual Input Field
            TextInput({ text: this.category.name, placeholder: "Name your category..." })
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
              .padding({ left: 20 })
              .height('100%')
              .type(InputType.Normal)
              .onChange((value: string) => {
                this.category.name = value;
              })
              .onFocus(() => {
                this.isTextFieldFocused = true;
              })
              .onBlur(() => {
                this.isTextFieldFocused = false;
              })
          }
          .layoutWeight(1)

          // Color Picker Button (Simulated with Image/Icon)
          Image($r('app.media.ic_color_palette')) // Placeholder for system icon
            .width(36)
            .height(36)
            .margin({ left: 15 })
            .onClick(() => {
              // In a real app, open a color picker sheet here
              // For now, we just toggle a random color for demonstration
              const colors: Color[] = [Color.Red, Color.Green, Color.Blue, Color.Purple];
              const randomIndex = Math.floor(Math.random() * colors.length);
              this.category.color = colors[randomIndex];
            })
        }
        .width('100%')
        .padding({ left: 20, right: 20 })
        
        Spacer()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)
      
      // Delete Confirmation Dialog
      if (this.showDeleteDialog) {
        AlertDialog({
          title: 'Confirm Category Deletion',
          message: `Are you sure you want to delete this category? All notes in the "${this.category.name}" category will be moved to the General category.`,
          primaryButton: {
            value: 'Cancel',
            action: () => {
              this.showDeleteDialog = false;
            }
          },
          secondaryButton: {
            value: 'Delete',
            fontColor: Color.Red,
            action: () => {
              this.showDeleteDialog = false;
              // Logic to delete category would go here
              this.closePage();
            }
          }
        })
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    
    // Navigation Bar Simulation removed as it's not valid on Column directly without NavContext
    
    .onBackPress(() => {
      this.closePage();
      return true;
    })
  }

  aboutToAppear() {
    // Setup Navigation Bar programmatically to match screenshot exactly
    // Note: getNavDestinationAttribute is typically used within NavDestination context
    // This logic might need adjustment depending on exact navigation structure
  }

  private closePage(): void {
    try {
      router.back();
    } catch (e) {
      console.error(`Failed to go back, error: ${(e as BusinessError).code}`);
    }
  }
}

// Helper component for the Top Bar overlay to match the screenshot perfectly
@Component
struct CustomTopBar {
  @Link isTextFieldFocused: boolean;
  @Link isCreatingNew: boolean;
  @Link showDeleteDialog: boolean;
  @Prop category: Category;
  onSave?: () => void;
  onCancel?: () => void;

  build() {
    Row() {
      // Cancel Button
      Text("Cancel")
        .fontColor('#A67C52') // Brownish tone from screenshot
        .fontSize(17)
        .fontWeight(FontWeight.Medium)
        .onClick(() => {
          if (this.onCancel) {
            this.onCancel();
          }
        })
        .visibility(this.isTextFieldFocused ? Visibility.None : Visibility.Visible)

      Spacer()

      // Right Side Actions
      Row() {
        // Trash Icon (Only visible when not editing)
        if (!this.isTextFieldFocused && !this.isCreatingNew) {
          Image($r('app.media.ic_trash')) // Placeholder resource
            .width(24)
            .height(24)
            .fillColor('#A67C52')
            .onClick(() => {
              this.showDeleteDialog = true;
            })
        }

        // Save / OK Button
        Text(this.isTextFieldFocused ? "OK" : "Save")
          .fontColor('#A67C52')
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .margin({ left: this.isTextFieldFocused ? 0 : 15 })
          .onClick(() => {
            if (this.onSave) {
              this.onSave();
            }
          })
      }
    }
    .width('100%')
    .padding({ left: 20, right: 20, top: 50, bottom: 10 }) // Adjusted for status bar area
    .position({ x: 0, y: 0 })
    .zIndex(100)
  }
}

// Wrapper to combine the main view and the custom top bar
@Entry
@Component
struct CategoryEditWrapper {
  @State category: Category = new Category("Thoughts", Color.Blue);
  @State isCreatingNew: boolean = false;
  @State showDeleteDialog: boolean = false;
  @State isTextFieldFocused: boolean = false;
  private viewModel: NotesListViewModel = new NotesListViewModel();

  build() {
    Stack() {
      // The actual content logic
      Column() {
        Text(this.isCreatingNew ? "Create New Category" : "Edit Category")
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Black)
          .margin({ top: 100, bottom: 30 }) // Pushed down to make room for custom header

        Row() {
          Stack({ alignContent: Alignment.Start }) {
            Capsule()
              .fill(new LinearGradient({
                angle: 90,
                colors: [
                  { color: 'rgba(173, 216, 230, 0.8)', offset: 0.0 },
                  { color: this.category.color.toString(), offset: 1.0 }
                ] as ColorStop[]
              }))
              .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
              .width('100%')
              .height(50)

            TextInput({ text: this.category.name, placeholder: "Name your category..." })
              .backgroundColor(Color.Transparent)
              .borderWidth(0)
              .padding({ left: 20 })
              .height('100%')
              .type(InputType.Normal)
              .onChange((value: string) => {
                this.category.name = value;
              })
              .onFocus(() => {
                this.isTextFieldFocused = true;
              })
              .onBlur(() => {
                this.isTextFieldFocused = false;
              })
          }
          .layoutWeight(1)

          Image($r('app.media.ic_color_palette'))
            .width(36)
            .height(36)
            .margin({ left: 15 })
            .onClick(() => {
               const colors: Color[] = [Color.Red, Color.Green, Color.Blue, Color.Purple];
               const randomIndex = Math.floor(Math.random() * colors.length);
               this.category.color = colors[randomIndex];
            })
        }
        .width('100%')
        .padding({ left: 20, right: 20 })
        
        Spacer()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Color.White)

      // Overlay Header
      CustomTopBar(
        isTextFieldFocused=$isTextFieldFocused, 
        isCreatingNew=$isCreatingNew, 
        showDeleteDialog=$showDeleteDialog,
        category=this.category,
        onSave: () => {
           if (this.isTextFieldFocused) {
             // Just dismiss keyboard logic essentially
           } else {
             this.viewModel.update(this.category);
             // Haptic feedback simulation
             try {
               // Note: Vibration API might require specific permissions or imports depending on OS version
               // import vibrator from '@ohos.vibrator';
               // vibrator.vibrate(...)
             } catch(e) {}
           }
        },
        onCancel: () => {
          try { router.back(); } catch(e) {}
        }
      )

      // Dialog
      if (this.showDeleteDialog) {
        AlertDialog({
          title: 'Confirm Category Deletion',
          message: `Are you sure you want to delete this category? All notes in the "${this.category.name}" category will be moved to the General category.`,
          primaryButton: {
            value: 'Cancel',
            action: () => { this.showDeleteDialog = false; }
          },
          secondaryButton: {
            value: 'Delete',
            fontColor: Color.Red,
            action: () => {
              this.showDeleteDialog = false;
              try { router.back(); } catch(e) {}
            }
          }
        })
      }
    }
    .width('100%')
    .height('100%')
    .onBackPress(() => {
      try { router.back(); } catch(e) {}
      return true;
    })
  }
}