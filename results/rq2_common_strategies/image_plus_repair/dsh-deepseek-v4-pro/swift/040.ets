// MARK: - AppTokens
// 统一的 UI 令牌，方便管理颜色、字体、形状、间距和阴影，实现原子级设计

// 阴影规格（对应 AppTokens.ShadowSpec）
class ShadowSpec {
  elevation: number; // 阴影扩散半径
  radius: number; // 阴影模糊半径
  dy: number; // Y轴偏移
  opacity: number; // 不透明度

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

// 颜色令牌接口（对应 AppTokens.Colors）
interface IColors {
  primary: string;
  secondary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onSecondary: string;
  onBackground: string;
  onSurface: string;
}

// 字体令牌接口（对应 AppTokens.TypographyTokens）
interface ITypographyTokens {
  displaySize: number;
  displayWeight: FontWeight;
  headlineSize: number;
  headlineWeight: FontWeight;
  titleSize: number;
  titleWeight: FontWeight;
  bodySize: number;
  bodyWeight: FontWeight;
  labelSize: number;
  labelWeight: FontWeight;
  labelFontSize: number;
}

// 形状令牌接口（对应 AppTokens.Shapes）
interface IShapes {
  small: number;
  medium: number;
  large: number;
}

// 间距令牌接口（对应 AppTokens.Spacing）
interface ISpacing {
  sm: number;
  md: number;
  lg: number;
}

// 阴影映射接口（对应 AppTokens.ElevationMapping）
interface IElevationMapping {
  level2: ShadowSpec;
}

class AppTokens {
  static readonly Colors: IColors = {
    primary: '#FF7B00', // #FF7B00
    secondary: '#FFD166', // #FFD166
    background: '#FFF6E5', // #FFF6E5
    surface: '#FFFFFF', // #FFFFFF
    surfaceVariant: '#FFF0C1', // #FFF0C1
    outline: '#E0C080', // #E0C080
    onPrimary: '#FFFFFF', // #FFFFFF
    onSecondary: '#3E2723', // #3E2723
    onBackground: '#3E2723', // #3E2723
    onSurface: '#3E2723' // #3E2723
  };

  // 使用系统字体，并提供字号和字重，以便精确匹配 Android Compose 的 TextStyle
  static readonly TypographyTokens: ITypographyTokens = {
    displaySize: 28,
    displayWeight: FontWeight.Bold,
    headlineSize: 20,
    headlineWeight: FontWeight.Medium,
    titleSize: 16,
    titleWeight: FontWeight.Medium,
    bodySize: 14,
    bodyWeight: FontWeight.Regular,
    labelSize: 12,
    labelWeight: FontWeight.Medium,
    // 方便计算按钮内文本的垂直填充，直接提供字号
    labelFontSize: 12.0
  };

  // 圆角半径，直接从 dp 转换为 vp
  static readonly Shapes: IShapes = {
    small: 6.0,
    medium: 10.0,
    large: 14.0
  };

  // 间距，直接从 dp 转换为 vp
  static readonly Spacing: ISpacing = {
    sm: 8.0,
    md: 12.0,
    lg: 16.0
  };

  // 阴影规格，对应 Android Compose 的 CardDefaults.cardElevation
  static readonly ElevationMapping: IElevationMapping = {
    level2: new ShadowSpec(4.0, 8.0, 4.0, 0.12)
  };
}

// MARK: - ResultItem
// 数据模型，对应 Kotlin 的 data class ResultItem
class ResultItem {
  id: number;
  title: string;

  constructor(id: number, title: string) {
    this.id = id;
    this.title = title;
  }
}

// MARK: - RootScreen
// 核心 UI 视图，对应 Kotlin 的 @Composable fun RootScreen()
@Component
struct RootScreen {
  // 状态管理，对应 Kotlin 的 remember { mutableStateOf(...) }
  @State query: string = '';
  // 拖动旋钮的初始位置，已根据 Canvas 内部 padding 调整
  @State knobOffsetX: number = 144; // (160 - 16)
  @State knobOffsetY: number = 104; // (120 - 16)
  // 用于 TextField 的焦点状态，以便模拟 Material Design 的指示器颜色变化
  @State isTextFieldFocused: boolean = false;

  // 列表数据，对应 Kotlin 的 List(6) { ... }
  results: ResultItem[] = [];

  private canvasSettings: RenderingContextSettings = new RenderingContextSettings(true);
  private canvasContext: CanvasRenderingContext2D = new CanvasRenderingContext2D(this.canvasSettings);

  aboutToAppear(): void {
    for (let i = 0; i < 6; i++) {
      this.results.push(new ResultItem(i, 'Result ' + (i + 1)));
    }
  }

  private drawCanvas(): void {
    let ctx = this.canvasContext;
    let w = ctx.width;
    let h = ctx.height;
    // 绘制背景矩形，对应 drawRect
    ctx.fillStyle = AppTokens.Colors.surfaceVariant;
    ctx.fillRect(0, 0, w, h);

    // 绘制径向渐变圆，对应 drawCircle(brush = Brush.radialGradient(...))
    let centerX = w / 2;
    let centerY = h / 2;
    let gradient = ctx.createRadialGradient(centerX, centerY, 0, centerX, centerY, 60);
    gradient.addColorStop(0, AppTokens.Colors.secondary);
    gradient.addColorStop(1, AppTokens.Colors.primary);
    ctx.fillStyle = gradient;
    ctx.beginPath();
    ctx.arc(centerX, centerY, 60, 0, 2 * Math.PI);
    ctx.fill();

    // 绘制可拖动旋钮，对应 drawCircle(color = ..., center = knob.value)
    let knobCenterX = this.knobOffsetX;
    let knobCenterY = this.knobOffsetY;
    ctx.fillStyle = AppTokens.Colors.primary;
    ctx.beginPath();
    ctx.arc(knobCenterX, knobCenterY, 16, 0, 2 * Math.PI);
    ctx.fill();
  }

  build() {
    // Stack 模拟 Scaffold 的 containerColor 和 ignoresSafeArea
    Stack() {
      Column({ space: AppTokens.Spacing.md }) { // 对应 Kotlin 的 Column, verticalArrangement
        Text('Retro Filter Search')
          .fontSize(AppTokens.TypographyTokens.displaySize)
          .fontWeight(AppTokens.TypographyTokens.displayWeight)
          .fontColor(AppTokens.Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start) // 对应 Modifier.fillMaxWidth().align(Alignment.Start)

        // 搜索输入框，对应 Kotlin 的 TextField
        TextInput({ placeholder: 'Search products', text: this.query })
          .placeholderColor('#663E2723') // onSurface 0.4 不透明度
          .fontSize(AppTokens.TypographyTokens.bodySize)
          .fontWeight(AppTokens.TypographyTokens.bodyWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
          .height(56) // Material Design 默认 TextField 高度通常为 56dp
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .border({ width: 1, color: this.isTextFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline })
          .onFocus(() => { this.isTextFieldFocused = true; })
          .onBlur(() => { this.isTextFieldFocused = false; })
          .onChange((value: string) => { this.query = value; })

        // 筛选按钮行，对应 Kotlin 的 Row
        Row({ space: AppTokens.Spacing.sm }) { // 对应 horizontalArrangement
          ForEach(['Popular', 'New', 'Discount', 'Premium'], (text: string) => {
            Button() {
              Text(text)
                .fontSize(AppTokens.TypographyTokens.labelSize)
                .fontWeight(AppTokens.TypographyTokens.labelWeight)
                .fontColor(AppTokens.Colors.onSecondary)
                .padding({
                  left: AppTokens.Spacing.md,
                  right: AppTokens.Spacing.md,
                  // 计算垂直内边距以使按钮总高度为 36pt (对应 36.dp)
                  top: (36 - AppTokens.TypographyTokens.labelFontSize) / 2,
                  bottom: (36 - AppTokens.TypographyTokens.labelFontSize) / 2
                })
            }
            .height(36) // 对应 Modifier.height(36.dp)
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.small)
          }, (text: string) => text)
        }
        .width('100%') // 确保 Row 靠左对齐

        // Canvas 区域，对应 Kotlin 的 Box 和 Canvas
        Stack() {
          Canvas(this.canvasContext)
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg) // Canvas 内部内容填充，对应 Modifier.padding(16.dp)
            .onReady(() => {
              this.drawCanvas();
            })
            .gesture(
              PanGesture()
                .onActionUpdate((event: GestureEvent) => {
                  // 限制旋钮在 Canvas 绘制区域内移动，并考虑旋钮半径 16pt
                  let minX: number = 8;
                  let maxX: number = 8;
                  let minY: number = 8;
                  let maxY: number = 8;
                  let clampedX = Math.max(minX, Math.min(event.offsetX, maxX));
                  let clampedY = Math.max(minY, Math.min(event.offsetY, maxY));
                  this.knobOffsetX = clampedX;
                  this.knobOffsetY = clampedY;
                  this.drawCanvas();
                })
            )
        }
        .width('100%')
        .height(180) // 对应 Modifier.height(180.dp)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.large)

        // 结果网格，对应 Kotlin 的 LazyVerticalGrid
        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              CardView({ item: item })
            }
          }, (item: ResultItem) => item.id.toString())
        }
        .columnsTemplate('1fr 1fr') // 两列
        .columnsGap(AppTokens.Spacing.lg) // 水平间距 lg
        .rowsGap(AppTokens.Spacing.lg) // 垂直间距 lg
        .padding({ bottom: 24 }) // 对应 contentPadding = PaddingValues(bottom = 24.dp)
      }
      .padding(AppTokens.Spacing.lg) // 整个 Column 的外部填充
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background) // 背景色并忽略安全区域以实现全屏
  }
}

// MARK: - CardView
// 单个卡片视图，对应 Kotlin 的 Card Composable
@Component
struct CardView {
  @Prop item: ResultItem = new ResultItem(0, '');

  build() {
    Column({ space: AppTokens.Spacing.sm }) { // 对应 Column, verticalArrangement
      // 图片占位符，对应 Box(modifier = Modifier.size(96.dp).background(...))
      Row()
        .width(96)
        .height(96)
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.titleSize)
        .fontWeight(AppTokens.TypographyTokens.titleWeight)
        .fontColor(AppTokens.Colors.onSurface)

      // 添加按钮，对应 Kotlin 的 Button
      Button() {
        Text('Add')
          .fontSize(AppTokens.TypographyTokens.labelSize)
          .fontWeight(AppTokens.TypographyTokens.labelWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .width('100%') // 对应 Modifier.fillMaxWidth()
          .padding({ top: 10, bottom: 10 }) // (48 - 12) / 2 = 18.0
      }
      .width('100%')
      .backgroundColor(AppTokens.Colors.primary) // 对应 ButtonDefaults.buttonColors
      .borderRadius(AppTokens.Shapes.medium) // 对应 shape
    }
    .padding(AppTokens.Spacing.lg) // 卡片内部内容填充，对应 Modifier.padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface) // 对应 CardDefaults.cardColors
    .borderRadius(AppTokens.Shapes.large) // 对应 shape
    .shadow({ // 阴影效果，对应 CardDefaults.cardElevation
      radius: AppTokens.ElevationMapping.level2.radius,
      color: '#1F000000', // Color.black.opacity(level2.opacity = 0.12)
      offsetX: 0, // Android Compose 默认 x 偏移为 0
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }
}

// MARK: - App Entry Point
// 应用入口，对应 Kotlin 的 MainActivity（ArkTS 使用 @Entry 装饰器标记入口组件）
// 隐藏顶部状态栏、覆盖安全区域由 @Entry 页面默认全屏布局承载
@Entry
@Component
struct SingleFileUIApp {
  build() {
    Column() {
      RootScreen()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Preview
// 预览功能，对应 Kotlin 的 @Preview
@Preview
@Component
struct RootScreen_Previews {
  build() {
    RootScreen()
  }
}
