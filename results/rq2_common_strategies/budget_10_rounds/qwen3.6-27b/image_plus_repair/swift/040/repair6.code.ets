import { FontWeight } from '@kit.ArkUI';

/**
 * 统一的 UI 令牌，方便管理颜色、字体、形状、间距和阴影，实现原子级设计
 */
export class AppTokens {
  static Colors = {
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
  }

  static TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium },
    labelFontSize: 12.0
  }

  static Shapes = {
    small: 6.0,
    medium: 10.0,
    large: 14.0
  }

  static Spacing = {
    sm: 8.0,
    md: 12.0,
    lg: 16.0
  }

  static ElevationMapping = {
    level2: { elevation: 4.0, radius: 8.0, dy: 4.0, opacity: 0.12 }
  }
}

/**
 * 数据模型，对应 Kotlin 的 data class ResultItem
 */
export interface ResultItem {
  id: number;
  title: string;
}

/**
 * 单个卡片视图，对应 Kotlin 的 Card Composable
 */
@Component
export struct CardView {
  @Prop item: ResultItem;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // 图片占位符
      Row()
        .width(96)
        .height(96)
        .borderRadius(AppTokens.Shapes.medium)
        .backgroundColor(AppTokens.Colors.surfaceVariant)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      // 添加按钮
      Button('Add')
        .type(ButtonType.Capsule)
        .width('100%')
        .height(48)
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({
      radius: AppTokens.ElevationMapping.level2.radius,
      color: `rgba(0, 0, 0, ${AppTokens.ElevationMapping.level2.opacity})`,
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.dy
    })
  }
}

interface KnobOffset {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State knobOffset: KnobOffset = { x: 144, y: 104 };
  @State isTextFieldFocused: boolean = false;

  private results: ResultItem[] = Array.from({ length: 6 }, (_, i) => ({
    id: i,
    title: `Result ${i + 1}`
  }));

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 背景色并忽略安全区域以实现全屏
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      Column({ space: AppTokens.Spacing.md }) {
        Text('Retro Filter Search')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .textAlign(TextAlign.Start)
          .width('100%')

        // 搜索输入框
        TextInput({ placeholder: 'Search products', text: this.query })
          .type(InputType.Normal)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor(Color('#3E2723').withOpacity(0.4))
          .padding({ left: AppTokens.Spacing.lg })
          .height(56)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .borderWidth(1)
          .borderColor(this.isTextFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline)
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
        Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
          ForEach(['Popular', 'New', 'Discount', 'Premium'], (text: string) => {
            Button(text)
              .fontSize(AppTokens.TypographyTokens.label.size)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
              .fontColor(AppTokens.Colors.onSecondary)
              .height(36)
              .margin({ right: AppTokens.Spacing.sm })
              .backgroundColor(AppTokens.Colors.secondary)
              .borderRadius(AppTokens.Shapes.small)
          })
        }
        .width('100%')

        // Canvas 区域
        Stack() {
          // Box 的背景和圆角
          Rect()
            .width('100%')
            .height('100%')
            .fill(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)

          DrawingCanvas({ parent: this })
            .width('100%')
            .height('100%')
            .gesture(
              PanGesture()
                .onActionUpdate((event?: GestureEvent) => {
                  if (event) {
                    const minX = 8;
                    const maxX = 8;
                    const minY = 8;
                    const maxY = 8;
                    const clampedX = Math.max(minX, Math.min(event.offsetX, maxX));
                    const clampedY = Math.max(minY, Math.min(event.offsetY, maxY));
                    this.knobOffset = { x: clampedX, y: clampedY };
                  }
                })
            )
        }
        .padding(AppTokens.Spacing.lg)
        .height(180)
        .width('100%')

        // 结果网格
        Grid() {
          ForEach(this.results, (item: ResultItem) => {
            GridItem() {
              CardView({ item: item })
            }
          })
        }
        .columnsTemplate('1fr 1fr')
        .rowsGap(AppTokens.Spacing.lg)
        .columnsGap(AppTokens.Spacing.lg)
        .padding({ bottom: 24 })
      }
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct DrawingCanvas {
  @Prop parent: RootScreen;

  build() {
    Canvas()
      .draw((context: CanvasRenderingContext2D, size: Size) => {
        // 绘制背景矩形
        context.fillStyle = AppTokens.Colors.surfaceVariant;
        context.fillRect(0, 0, size.width, size.height);

        // 绘制径向渐变圆
        const center = { x: size.width / 2, y: size.height / 2 };
        const gradient = context.createRadialGradient(center.x, center.y, 0, center.x, center.y, 60);
        gradient.addColorStop(0, AppTokens.Colors.secondary);
        gradient.addColorStop(1, AppTokens.Colors.primary);
        context.fillStyle = gradient;
        context.beginPath();
        context.arc(center.x, center.y, 60, 0, Math.PI * 2);
        context.fill();

        // 绘制可拖动旋钮
        context.fillStyle = AppTokens.Colors.primary;
        context.beginPath();
        context.arc(this.parent.knobOffset.x, this.parent.knobOffset.y, 16, 0, Math.PI * 2);
        context.fill();
      })
  }
}