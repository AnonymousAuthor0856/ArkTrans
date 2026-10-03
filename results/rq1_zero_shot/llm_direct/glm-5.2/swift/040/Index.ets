// AppTokens.ets
// 统一的 UI 令牌，方便管理颜色、字体、形状、间距和阴影，实现原子级设计
export class AppTokens {
  static Colors = {
    primary: '#FF7B00',
    secondary: '#FFD166',
    background: '#FFF6E5',
    surface: '#FFFFFF',
    surfaceVariant: '#FFF0C1',
    outline: '#E0C080',
    onPrimary: '#FFFFFF',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723',
  };

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
    labelFontSize: 12.0,
  };

  static Shapes = {
    small: 6.0,
    medium: 10.0,
    large: 14.0,
  };

  static Spacing = {
    sm: 8.0,
    md: 12.0,
    lg: 16.0,
  };

  static ElevationMapping = {
    level2: {
      elevation: 4.0,
      radius: 8.0,
      dy: 4.0,
      opacity: 0.12,
    },
  };
}

// 数据模型
export class ResultItem {
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
  // 状态管理
  @State query: string = '';
  @State knobOffsetX: number = 144; // (160 - 16)
  @State knobOffsetY: number = 104; // (120 - 16)
  @State isTextFieldFocused: boolean = false;

  // 列表数据
  private results: ResultItem[] = Array.from({ length: 6 }, (_, i) => new ResultItem(i, `Result ${i + 1}`));
  private filters: string[] = ['Popular', 'New', 'Discount', 'Premium'];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 背景色并忽略安全区域以实现全屏
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // 主内容区域
      Column({ space: AppTokens.Spacing.md }) {
        Text('Retro Filter Search')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // 搜索输入框
        Stack({ alignContent: Alignment.Start }) {
          // 自定义占位符视图
          if (this.query === '') {
            Text('Search products')
              .fontSize(AppTokens.TypographyTokens.body.size)
              .fontWeight(AppTokens.TypographyTokens.body.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .opacity(0.4)
              .margin({ left: AppTokens.Spacing.lg })
          }

          TextInput({ text: this.query, controller: undefined })
            .type(InputType.Normal)
            .fontSize(AppTokens.TypographyTokens.body.size)
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.medium)
            .borderWidth(1)
            .borderColor(this.isTextFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline)
            .height(56)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            .onFocus(() => { this.isTextFieldFocused = true; })
            .onBlur(() => { this.isTextFieldFocused = false; })
            .onChange((value) => { this.query = value; })
        }
        .width('100%')
        .height(56)

        // 筛选按钮行
        Row({ space: AppTokens.Spacing.sm }) {
          ForEach(this.filters, (text: string) => {
            Button(text)
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.small)
              .height(36)
              .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          })
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

          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
            .onReady(() => this.drawCanvas())
            .gesture(
              PanGesture()
                .onActionStart((event: GestureEvent) => {
                  // 限制旋钮在 Canvas 绘制区域内移动
                  // Note: In a real app, you'd calculate bounds based on canvas size
                  this.knobOffsetX = event.fingerList[0].localX;
                  this.knobOffsetY = event.fingerList[0].localY;
                  this.drawCanvas();
                })
                .onActionUpdate((event: GestureEvent) => {
                  this.knobOffsetX = event.fingerList[0].localX;
                  this.knobOffsetY = event.fingerList[0].localY;
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
          })
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppTokens.Spacing.lg)
        .rowsGap(AppTokens.Spacing.lg)
        .padding({ bottom: 24 })
        .layoutWeight(1) // Fill remaining space

      }
      .width('100%')
      .height('100%')
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }

  private canvasContext: RenderingContextSettings = new RenderingContextSettings(true);
  private canvas: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasContext);

  private drawCanvas() {
    const ctx = this.canvas;
    // Note: In ArkTS Canvas, dimensions are usually set explicitly or via the component's onAreaChange.
    // For this example, we assume a fixed size matching the SwiftUI logic for simplicity.
    const width = 160; // Approximate based on SwiftUI logic
    const height = 120; // Approximate based on SwiftUI logic

    // Clear previous drawing
    ctx.clearRect(0, 0, width, height);

    // 绘制背景矩形
    ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    ctx.fillRect(0, 0, width, height);

    // 绘制径向渐变圆
    const centerX = width / 2;
    const centerY = height / 2;
    const radius = 60;
    const gradient = ctx.createRadialGradient(centerX, centerY, 0, centerX, centerY, radius);
    gradient.addColorStop(0, AppTokens.Colors.secondary);
    gradient.addColorStop(1, AppTokens.Colors.primary);
    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.arc(centerX, centerY, radius, 0, Math.PI * 2);
    ctx.fill();

    // 绘制可拖动旋钮
    ctx.fillStyle = AppTokens.Colors.primary;
    ctx.beginPath();
    ctx.arc(this.knobOffsetX, this.knobOffsetY, 16, 0, Math.PI * 2);
    ctx.fill();
  }
}

// 单个卡片视图
@Component
struct CardView {
  private item: ResultItem;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // 图片占位符
      Column()
        .width(96)
        .height(96)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      // 添加按钮
      Button('Add')
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .width('100%')
        .height(36)
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0,0,0,${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }
}