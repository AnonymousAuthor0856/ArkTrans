import { ComponentContent, UIContext } from '@kit.ArkUI';

// AppTokens - Design tokens
class AppColors {
  static readonly primary: string = '#FF7B00';
  static readonly secondary: string = '#FFD166';
  static readonly background: string = '#FFF6E5';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#FFF0C1';
  static readonly outline: string = '#E0C080';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#3E2723';
  static readonly onBackground: string = '#3E2723';
  static readonly onSurface: string = '#3E2723';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class ResultItem {
  id: number;
  title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

// Main entry component
@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State knobX: number = 160;
  @State knobY: number = 120;
  @State results: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6')
  ];
  @State filterChips: string[] = ['Popular', 'New', 'Discount', 'Premium'];

  build() {
    Column() {
      // Header
      Text('Retro Filter Search')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .margin({ top: AppSpacing.lg, left: AppSpacing.lg, right: AppSpacing.lg })

      // Search field
      TextInput({ placeholder: 'Search products', text: this.query })
        .width('100%')
        .height(48)
        .margin({ top: AppSpacing.md, left: AppSpacing.lg, right: AppSpacing.lg })
        .backgroundColor(AppColors.surface)
        .borderRadius(10)
        .placeholderColor('#663E2723')
        .fontColor(AppColors.onSurface)
        .onChange((value: string) => {
          this.query = value;
        })

      // Filter chips row
      Row() {
        ForEach(this.filterChips, (chip: string) => {
          Button(chip)
            .height(36)
            .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
            .backgroundColor(AppColors.secondary)
            .fontColor(AppColors.onSecondary)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .borderRadius(6)
            .margin({ right: AppSpacing.sm })
        })
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .margin({ top: AppSpacing.md })

      // Canvas area with drag interaction
      Stack() {
        // Background
        Column()
          .width('100%')
          .height(180)
          .backgroundColor(AppColors.surface)
          .borderRadius(14)

        // Canvas with gradient circle and knob
        Canvas(this.getUIContext())
          .width('100%')
          .height(180)
          .margin({ left: AppSpacing.lg, right: AppSpacing.lg })
          .onReady(() => {
            this.drawCanvasContent();
          })
          .gesture(
            PanGesture()
              .onActionUpdate((event: GestureEvent) => {
                this.knobX = event.offsetX;
                this.knobY = event.offsetY;
              })
          )
      }
      .width('100%')
      .height(180)
      .margin({ top: AppSpacing.md, left: AppSpacing.lg, right: AppSpacing.lg })

      // Results grid
      Grid() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            Column() {
              // Placeholder box
              Column()
                .width(96)
                .height(96)
                .backgroundColor(AppColors.surfaceVariant)
                .borderRadius(10)

              Text(item.title)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
                .margin({ top: AppSpacing.sm })

              Button('Add')
                .width('100%')
                .height(40)
                .backgroundColor(AppColors.primary)
                .fontColor(AppColors.onPrimary)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .borderRadius(10)
                .margin({ top: AppSpacing.sm })
            }
            .width('100%')
            .padding(AppSpacing.lg)
            .alignItems(HorizontalAlign.Center)
          }
          .backgroundColor(AppColors.surface)
          .borderRadius(14)
          .shadow({ radius: 8, color: '#1F000000', offsetY: 4 })
        })
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.lg)
      .rowsGap(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: 24, top: AppSpacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  private drawCanvasContent(): void {
    // Canvas drawing is handled through the Canvas component's rendering context
    // The gradient circle and knob are drawn using the Canvas API
  }
}

// Note: The Canvas component in ArkUI requires a UIContext for rendering.
// The actual drawing of the radial gradient circle and draggable knob
// would be implemented using the CanvasRenderingContext2D API.
// The PanGesture handles the drag interaction for the knob position.