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

class TextStyleToken {
  fontSize: number;
  fontWeight: FontWeight | string | number;

  constructor(fontSize: number, fontWeight: FontWeight | string | number) {
    this.fontSize = fontSize;
    this.fontWeight = fontWeight;
  }
}

class AppTypographyTokens {
  static readonly display: TextStyleToken = new TextStyleToken(28, FontWeight.Bold);
  static readonly headline: TextStyleToken = new TextStyleToken(20, '600');
  static readonly title: TextStyleToken = new TextStyleToken(16, FontWeight.Medium);
  static readonly body: TextStyleToken = new TextStyleToken(14, FontWeight.Normal);
  static readonly label: TextStyleToken = new TextStyleToken(12, FontWeight.Medium);
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

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppElevationMapping {
  static readonly level2: ShadowSpec = new ShadowSpec(4, 8, 4, 0.12);
}

class ResultItem {
  id: number;
  title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

@Entry
@Component
struct RootScreen {
  @State private query: string = '';
  @State private knobX: number = 160;
  @State private knobY: number = 120;

  private results: ResultItem[] = [
    new ResultItem(0, 'Result 1'),
    new ResultItem(1, 'Result 2'),
    new ResultItem(2, 'Result 3'),
    new ResultItem(3, 'Result 4'),
    new ResultItem(4, 'Result 5'),
    new ResultItem(5, 'Result 6')
  ];

  private filterLabels: string[] = ['Popular', 'New', 'Discount', 'Premium'];
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(new RenderingContextSettings(true));

  private drawFilterCanvas(): void {
    const width: number = this.canvasContext.width;
    const height: number = this.canvasContext.height;

    this.canvasContext.clearRect(0, 0, width, height);

    this.canvasContext.fillStyle = AppColors.surfaceVariant;
    this.canvasContext.fillRect(0, 0, width, height);

    const gradient: CanvasGradient = this.canvasContext.createRadialGradient(
      width / 2,
      height / 2,
      0,
      width / 2,
      height / 2,
      80
    );
    gradient.addColorStop(0, AppColors.secondary);
    gradient.addColorStop(1, AppColors.primary);

    this.canvasContext.fillStyle = gradient;
    this.canvasContext.beginPath();
    this.canvasContext.arc(width / 2, height / 2, 80, 0, Math.PI * 2);
    this.canvasContext.fill();

    this.canvasContext.fillStyle = AppColors.primary;
    this.canvasContext.beginPath();
    this.canvasContext.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    this.canvasContext.fill();
  }

  @Builder
  private FilterButton(label: string) {
    Button(label, { type: ButtonType.Normal })
      .height(36)
      .padding({ left: 12, right: 12 })
      .backgroundColor(AppColors.secondary)
      .borderRadius(AppShapes.small)
      .fontSize(AppTypographyTokens.label.fontSize)
      .fontWeight(AppTypographyTokens.label.fontWeight)
      .fontColor(AppColors.onSecondary)
  }

  @Builder
  private ProductCard(item: ResultItem) {
    Column({ space: AppSpacing.sm }) {
      Stack()
        .width(96)
        .height(96)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(AppShapes.medium)

      Text(item.title)
        .fontSize(AppTypographyTokens.title.fontSize)
        .fontWeight(AppTypographyTokens.title.fontWeight)
        .fontColor(AppColors.onSurface)

      Button('Add', { type: ButtonType.Normal })
        .width('100%')
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .fontSize(AppTypographyTokens.label.fontSize)
        .fontWeight(AppTypographyTokens.label.fontWeight)
        .fontColor(AppColors.onPrimary)
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .shadow({
      radius: AppElevationMapping.level2.radius,
      color: 'rgba(0, 0, 0, 0.12)',
      offsetX: 0,
      offsetY: AppElevationMapping.level2.dy
    })
  }

  build() {
    Column({ space: AppSpacing.md }) {
      Text('Retro Filter Search')
        .fontSize(AppTypographyTokens.display.fontSize)
        .fontWeight(AppTypographyTokens.display.fontWeight)
        .fontColor(AppColors.onBackground)

      TextInput({
        text: this.query,
        placeholder: 'Search products'
      })
        .width('100%')
        .height(52)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .border({
          width: 1,
          color: AppColors.outline
        })
        .fontSize(AppTypographyTokens.body.fontSize)
        .fontWeight(AppTypographyTokens.body.fontWeight)
        .fontColor(AppColors.onSurface)
        .placeholderColor('rgba(62, 39, 35, 0.4)')
        .caretColor(AppColors.primary)
        .padding({ left: 12, right: 12 })
        .onChange((value: string) => {
          this.query = value;
        })

      Row({ space: AppSpacing.sm }) {
        ForEach(this.filterLabels, (label: string) => {
          this.FilterButton(label);
        }, (label: string) => label)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Stack() {
        Canvas(this.canvasContext)
          .width('100%')
          .height('100%')
          .onReady(() => {
            this.drawFilterCanvas();
          })
          .onAreaChange(() => {
            this.drawFilterCanvas();
          })
          .onTouch((event: TouchEvent) => {
            if (event.type === TouchType.Down || event.type === TouchType.Move) {
              if (event.touches.length > 0) {
                this.knobX = event.touches[0].x;
                this.knobY = event.touches[0].y;
                this.drawFilterCanvas();
              }
            }
          })
      }
      .width('100%')
      .height(180)
      .padding(16)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.large)

      Grid() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            this.ProductCard(item);
          }
        }, (item: ResultItem) => item.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .columnsTemplate('1fr 1fr')
      .columnsGap(AppSpacing.lg)
      .rowsGap(AppSpacing.lg)
      .padding({ bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.background)
  }
}