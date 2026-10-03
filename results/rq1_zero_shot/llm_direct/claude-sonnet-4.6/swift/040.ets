import { curves } from '@kit.ArkUI';

// MARK: - AppTokens
class AppColors {
  static readonly primary: string = '#FFFF7B00';
  static readonly secondary: string = '#FFFFD166';
  static readonly background: string = '#FFFFF6E5';
  static readonly surface: string = '#FFFFFFFF';
  static readonly surfaceVariant: string = '#FFFFF0C1';
  static readonly outline: string = '#FFE0C080';
  static readonly onPrimary: string = '#FFFFFFFF';
  static readonly onSecondary: string = '#FF3E2723';
  static readonly onBackground: string = '#FF3E2723';
  static readonly onSurface: string = '#FF3E2723';
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 14;
  static readonly labelSize: number = 12;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class ElevationLevel2 {
  static readonly radius: number = 8;
  static readonly dy: number = 4;
  static readonly opacity: number = 0.12;
}

// MARK: - ResultItem
class ResultItem {
  id: number;
  title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

// MARK: - CardView Component
@Component
struct CardView {
  item: ResultItem = new ResultItem(0, '');

  build() {
    Column({ space: AppSpacing.sm }) {
      // Image placeholder
      RoundedRect()
        .width(96)
        .height(96)
        .radiusWidth(AppShapes.medium)
        .radiusHeight(AppShapes.medium)
        .fill(AppColors.surfaceVariant)

      Text(this.item.title)
        .fontSize(AppTypography.titleSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      // Add button
      Button('Add')
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .width('100%')
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
    }
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: ElevationLevel2.radius,
      color: `rgba(0,0,0,${ElevationLevel2.opacity})`,
      offsetX: 0,
      offsetY: ElevationLevel2.dy
    })
  }
}

// MARK: - RootScreen
@Entry
@Component
struct RootScreen {
  @State private query: string = '';
  @State private knobX: number = 144;
  @State private knobY: number = 104;
  @State private isTextFieldFocused: boolean = false;

  private results: ResultItem[] = Array.from({ length: 6 }, (_, i) => new ResultItem(i, `Result ${i + 1}`));

  private filterTags: string[] = ['Popular', 'New', 'Discount', 'Premium'];

  build() {
    Stack() {
      // Background
      Column() {}
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // Main content
      Scroll() {
        Column({ space: AppSpacing.md }) {
          // Title
          Text('Retro Filter Search')
            .fontSize(AppTypography.displaySize)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.onBackground)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Search TextField
          Stack({ alignContent: Alignment.Start }) {
            if (this.query.length === 0) {
              Text('Search products')
                .fontSize(AppTypography.bodySize)
                .fontWeight(FontWeight.Normal)
                .fontColor('#66' + AppColors.onSurface.substring(2))
                .padding({ left: AppSpacing.lg })
                .width('100%')
                .height(56)
            }
            TextInput({ text: this.query, placeholder: '' })
              .fontSize(AppTypography.bodySize)
              .fontWeight(FontWeight.Normal)
              .fontColor(AppColors.onSurface)
              .placeholderColor('transparent')
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
              .height(56)
              .width('100%')
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.medium)
              .border({
                width: 1,
                color: this.isTextFieldFocused ? AppColors.primary : AppColors.outline,
                radius: AppShapes.medium
              })
              .onChange((value: string) => {
                this.query = value;
              })
              .onFocus(() => {
                this.isTextFieldFocused = true;
              })
              .onBlur(() => {
                this.isTextFieldFocused = false;
              })
          }
          .width('100%')
          .height(56)

          // Filter buttons row
          Row({ space: AppSpacing.sm }) {
            ForEach(this.filterTags, (tag: string) => {
              Button(tag)
                .fontSize(AppTypography.labelSize)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSecondary)
                .height(36)
                .padding({ left: AppSpacing.md, right: AppSpacing.md })
                .backgroundColor(AppColors.secondary)
                .borderRadius(AppShapes.small)
            }, (tag: string) => tag)
          }
          .width('100%')
          .justifyContent(FlexAlign.Start)

          // Canvas area
          Stack() {
            // Background
            Column() {}
            .width('100%')
            .height('100%')
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.large)

            Canvas(this.canvasContext)
              .width('100%')
              .height('100%')
              .borderRadius(AppShapes.large)
              .onReady(() => {
                this.drawCanvas();
              })
              .gesture(
                PanGesture()
                  .onActionUpdate((event: GestureEvent) => {
                    const padding = AppSpacing.lg;
                    const newX = event.offsetX + 144;
                    const newY = event.offsetY + 104;
                    this.knobX = Math.max(padding, Math.min(newX, 300 - padding));
                    this.knobY = Math.max(padding, Math.min(newY, 148 - padding));
                    this.drawCanvas();
                  })
              )
          }
          .width('100%')
          .height(180)
          .borderRadius(AppShapes.large)
          .clip(true)

          // Results grid
          Grid() {
            ForEach(this.results, (item: ResultItem) => {
              GridItem() {
                CardView({ item: item })
              }
            }, (item: ResultItem) => item.id.toString())
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(AppSpacing.lg)
          .rowsGap(AppSpacing.lg)
          .width('100%')
          .padding({ bottom: 24 })
        }
        .padding(AppSpacing.lg)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
  }

  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(
    new RenderingContextSettings(true)
  );

  private drawCanvas(): void {
    const ctx = this.canvasContext;
    const width = ctx.width;
    const height = ctx.height;

    if (width === 0 || height === 0) return;

    // Clear
    ctx.clearRect(0, 0, width, height);

    // Draw background rect
    ctx.fillStyle = AppColors.surfaceVariant;
    ctx.fillRect(0, 0, width, height);

    // Draw radial gradient circle
    const centerX = width / 2;
    const centerY = height / 2;
    const gradient = ctx.createRadialGradient(centerX, centerY, 0, centerX, centerY, 60);
    gradient.addColorStop(0, AppColors.secondary);
    gradient.addColorStop(1, AppColors.primary);
    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.arc(centerX, centerY, 60, 0, Math.PI * 2);
    ctx.fill();

    // Draw draggable knob
    ctx.fillStyle = AppColors.primary;
    ctx.beginPath();
    ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    ctx.fill();
  }
}