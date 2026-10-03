import { BusinessError } from '@kit.BasicServicesKit';

// Mock data structures to replace SwiftUI models
interface Category {
  id: string;
  name: string;
  displayName: string;
  color: string; // Using hex string for simplicity in ArkTS
}

interface Note {
  id: string;
  title: string;
  category?: Category;
}

// Constants matching the original code's intent
const CONSTANTS = {
  roundedRectCornerRadius: 20,
  materialButtonCornerRadius: 16,
  gradientStartColorOpacity: 0.1,
  gradientEndColorOpacity: 0.8
};

@Entry
@Component
struct NoteCategorySelectionView {
  @State note: Note = {
    id: 'note-1',
    title: 'My Note',
    category: undefined
  };
  
  @State creatingNewNote: boolean = false;
  @State isAlertPresented: boolean = false;
  @State triggerHapticFeedback: boolean = false;
  
  // Mock ViewModel data
  private categories: Category[] = [
    { id: 'cat-1', name: 'General', displayName: 'General', color: '#D7CCC8' },
    { id: 'cat-2', name: 'Work', displayName: 'Work', color: '#90CAF9' },
    { id: 'cat-3', name: 'Personal', displayName: 'Personal', color: '#A5D6A7' },
    { id: 'cat-4', name: 'Ideas', displayName: 'Ideas', color: '#FFCC80' }
  ];

  aboutToAppear() {
    if (this.categories.length > 0) {
      this.note.category = this.categories[0];
    }
  }

  build() {
    Column() {
      // Top Bar with Dismiss Button
      Row() {
        Flex({ justifyContent: FlexAlign.End }) {
          Button() {
            // Dismiss logic would go here (e.g., router.back())
          }
          .type(ButtonType.Circle)
          .backgroundColor(Color.Gray.withAlpha(0.5))
          .width(32)
          .height(32)
          .fontColor(Color.White)
          .borderRadius(16)
          .margin({ right: 20, top: 20 })
        }
        .width('100%')
      }
      .width('100%')

      // Title
      Text("Change Note Category")
        .fontSize(32)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1C1C1E')
        .margin({ top: 20, left: 20, right: 20 })

      // Categories Grid
      Scroll() {
        GridContainer() {
          ForEach(this.categories, (category: Category) => {
            GridItem() {
              PreviewNoteCategoryButton({
                note: $note,
                category: category,
                creatingNewNote: $creatingNewNote,
                triggerHapticFeedback: $triggerHapticFeedback,
                onSelect: (selectedCategory: Category) => {
                  this.note.category = selectedCategory;
                  // In a real app, update viewModel and dismiss
                }
              })
            }
          })
        }
        .columnsTemplate('1fr 1fr') // 2 columns like adaptive grid on mobile
        .rowsGap(10)
        .columnsGap(10)
        .padding(20)
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Create Button
      Column() {
        PreviewCreateAndAssignNoteCategoryButton({
          onCreate: () => {
            // Logic to create new category
            this.isAlertPresented = true;
          }
        })
      }
      .alignItems(HorizontalAlign.Center)
      .padding({ bottom: 40 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F2F2F7') // Light gray background typical of iOS sheets
    .borderRadius({ topLeft: CONSTANTS.roundedRectCornerRadius, topRight: CONSTANTS.roundedRectCornerRadius })
    .margin({ top: 20 }) // Simulate sheet inset
  }
}

@Component
struct PreviewNoteCategoryButton {
  @Link note: Note;
  @Prop category: Category;
  @Link creatingNewNote: boolean;
  @Link triggerHapticFeedback: boolean;
  @Prop onSelect: (category: Category) => void;

  get isSelected(): boolean {
    return this.note.category?.id === this.category.id;
  }

  build() {
    Button() {
      Row() {
        Text(this.category.displayName)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.isSelected ? '#1C1C1E' : '#8E8E93')
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
        
        Flex({ justifyContent: FlexAlign.End }) {
          // Indicator Circle
          Circle()
            .width(16)
            .height(16)
            .fill(this.category.color)
            .opacity(this.isSelected ? 1 : 0.5)
            .stroke(this.category.color)
            .strokeWidth(2)
            .shadow({ radius: 2, color: 'rgba(0,0,0,0.2)', offsetY: 1 })
        }
        .width('100%')
      }
      .width('100%')
      .padding({ left: 16, right: 16 })
    }
    .onClick(() => {
      this.onSelect(this.category);
    })
    .type(ButtonType.Normal)
    .width('100%')
    .height(60)
    .borderRadius(CONSTANTS.materialButtonCornerRadius)
    .linearGradient({
      angle: 90,
      colors: [['#FFFFFF', CONSTANTS.gradientStartColorOpacity], [this.category.color, CONSTANTS.gradientEndColorOpacity]]
    })
    .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetY: 4 })
    // Overlay stroke for selected state
    .border({
      width: this.isSelected ? 2 : 0,
      color: this.category.color,
      style: BorderStyle.Solid,
      radius: CONSTANTS.materialButtonCornerRadius
    })
  }
}

@Component
struct PreviewCreateAndAssignNoteCategoryButton {
  @Prop onCreate: () => void;

  build() {
    Button() {
      Text("Create and assign new category")
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1C1C1E')
    }
    .onClick(() => {
      this.onCreate();
    })
    .type(ButtonType.Normal)
    .width('80%')
    .height(50)
    .borderRadius(CONSTANTS.materialButtonCornerRadius)
    .backgroundColor('#FFFFFF')
    .shadow({ radius: 12, color: 'rgba(0,0,0,0.15)', offsetY: 6 })
    .border({
      width: 1,
      color: 'rgba(0,0,0,0.05)',
      style: BorderStyle.Solid,
      radius: CONSTANTS.materialButtonCornerRadius
    })
  }
}