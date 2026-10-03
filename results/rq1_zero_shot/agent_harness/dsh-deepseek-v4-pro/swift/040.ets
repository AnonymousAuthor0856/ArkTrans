// 040.ets - translated from 040.swift (Retro Filter Search)

// MARK: - AppTokens

const CLEAR: string = '#00000000';

class AppTokensColors {
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

class AppTokensTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 20;
  static readonly headlineWeight: FontWeight = FontWeight.Semibold;
  static readonly titleSize: number = 16;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
  static readonly labelFontSize: number = 12;
}

class AppTokensShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppTokensSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

interface ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

class AppTokensElevation {
  static readonly level2: ShadowSpec = { elevation: 4, radius: 8, dy: 4, opacity: 0.12 };
}

class AppTokens {
  static readonly Colors = AppTokensColors;
  static readonly TypographyTokens = AppTokensTypography;
  static readonly Shapes = AppTokensShapes;
  static readonly Spacing = AppTokensSpacing;
  static readonly ElevationMapping = AppTokensElevation;
}

// MARK: - ResultItem

interface ResultItem {
  id: number;
  title: string;
}

// MARK: - CardView

@Component
struct CardView {
  item: ResultItem;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // 图片占位符
      Column()
        .width(96)
        .height(96)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(AppTokens.TypographyTokens.titleWeight)
        .fontColor(AppTokens.Colors.onSurface)

      // 添加按钮
      Button('Add')
        .fontSize(AppTokens.TypographyTokens.labelSize)
        .fontWeight(AppTokens.TypographyTokens.labelWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .width('100%')
        .padding({ top: 10, bottom: 10 })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .onClick(() => {})
    }
    .alignItems(HorizontalAlign.Center)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: 'rgba(0,0,0,0.12)', offsetX: 0, offsetY: AppTokens.ElevationMapping.level2.dy })
  }
}

// MARK: - RootScreen

@Component
struct RootScreen {
  @State query: string = '';
  @State knobX: number = 144;
  @State knobY: number = 104;
  @State isTextFieldFocused: boolean = false;

  private results: ResultItem[] = [
    { id: 0, title: 'Result 1' },
    { id: 1, title: 'Result 2' },
    { id: 2, title: 'Result 3' },
    { id: 3, title: 'Result 4' },
    { id: 4, title: 'Result 5' },
    { id: 5, title: 'Result 6' }
  ];

  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium'];

  private settings: RenderingContextSettings = new RenderingContextSettings(true);
  private ctx: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.settings);

  drawCanvas() {
    const w = this.ctx.width;
    const h = this.ctx.height;
    // 背景矩形
    this.ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    this.ctx.fillRect(0, 0, w, h);
    // 径向渐变圆
    const cx = w / 2;
    const cy = h / 2;
    const grad = this.ctx.createRadialGradient(cx, cy, 0, cx, cy, 60);
    grad.addColorStop(0, AppTokens.Colors.secondary);
    grad.addColorStop(1, AppTokens.Colors.primary);
    this.ctx.fillStyle = grad;
    this.ctx.beginPath();
    this.ctx.arc(cx, cy, 60, 0, Math.PI * 2);
    this.ctx.fill();
    // 可拖动旋钮
    this.ctx.fillStyle = AppTokens.Colors.primary;
    this.ctx.beginPath();
    this.ctx.arc(this.knobX, this.knobY, 16, 0, Math.PI * 2);
    this.ctx.fill();
  }

  build() {
    Stack() {
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.md }) {
        Text('Retro Filter Search')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // 搜索输入框
        TextInput({ placeholder: 'Search products', text: this.query })
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(AppTokens.TypographyTokens.bodyWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor('rgba(62,39,35,0.4)')
          .caretColor(AppTokens.Colors.primary)
          .height(56)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: this.isTextFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline })
          .onChange((value: string) => {
            this.query = value;
          })
          .onFocus(() => {
            this.isTextFieldFocused = true;
          })
          .onBlur(() => {
            this.isTextFieldFocused = false;
          })

        // 筛选按钮行
        Row({ space: AppTokens.Spacing.sm }) {
          ForEach(this.filters, (text: string) => {
            Button(text)
              .fontSize(AppTokens.TypographyTokens.labelSize)
              .fontWeight(AppTokens.TypographyTokens.labelWeight)
              .fontColor(AppTokens.Colors.onSecondary)
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: (36 - AppTokens.TypographyTokens.labelFontSize) / 2, bottom: (36 - AppTokens.TypographyTokens.labelFontSize) / 2 })
              .height(36)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.small)
              .onClick(() => {})
          }, (text: string) => text)
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        // Canvas 区域
        Stack() {
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)

          Canvas(this.ctx)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
            .onReady(() => {
              this.drawCanvas();
            })
            .gesture(
              PanGesture()
                .onActionUpdate((event: GestureEvent) => {
                  const minX: number = 8;
                  const maxX: number = 8;
                  const minY: number = 8;
                  const maxY: number = 8;
                  const clampedX = Math.max(minX, Math.min(event.offsetX, maxX));
                  const clampedY = Math.max(minY, Math.min(event.offsetY, maxY));
                  this.knobX = clampedX;
                  this.knobY = clampedY;
                  this.drawCanvas();
                })
            )
        }
        .width('100%')
        .height(180)

        // 结果网格
        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              CardView({ item: item })
            }
          }, (item: ResultItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.lg)
        .rowsGap(AppTokens.Spacing.lg)
        .width('100%')
        .padding({ bottom: 24 })
      }
      .width('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - App Entry Point

@Entry
@Component
struct Index {
  build() {
    RootScreen()
  }
}
