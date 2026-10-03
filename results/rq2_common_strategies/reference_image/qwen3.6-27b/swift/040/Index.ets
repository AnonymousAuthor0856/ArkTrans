// src/main/ets/components/AppTokens.ets
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
    headline: { size: 20, weight: FontWeight.SemiBold },
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

// src/main/ets/models/ResultItem.ets
/**
 * 数据模型，对应 Kotlin 的 data class ResultItem
 */
export interface ResultItem {
  id: number;
  title: string;
}

// src/main/ets/components/CardView.ets
import { AppTokens } from './AppTokens';
import { ResultItem } from '../models/ResultItem';

/**
 * 单个卡片视图，对应 Kotlin 的 Card Composable
 */
@Component
export struct CardView {
  @Prop item: ResultItem;

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      // 图片占位符
      RoundedRectangle({ width: '100%', height: '100%' })
        .fill(AppTokens.Colors.surfaceVariant)
        .width(96)
        .height(96)
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .font-size(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Button('Add')
        .type(ButtonType.Capsule)
        .backgroundColor(AppTokens.Colors.primary)
        .fontColor(AppTokens.Colors.onPrimary)
        .font-size(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .width('100%')
        .height(48)
    }
    .padding(AppTokens.Spacing.lg)
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

// src/main/ets/pages/RootScreen.ets
import { AppTokens } from '../components/AppTokens';
import { ResultItem } from '../models/ResultItem';
import { CardView } from '../components/CardView';

@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State knobOffset: { x: number, y: number } = { x: 144, y: 104 };
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
        Text("Retro Filter Search")
          .font-size(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.onBackground)
          .alignSelf(ItemAlign.Start)

        // 搜索输入框
        TextInput({ placeholder: 'Search products', text: this.query })
          .type(InputType.Normal)
          .font-size(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .placeholderColor(Color(AppTokens.Colors.onSurface).withOpacity(0.4))
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
              .type(ButtonType.Capsule)
              .backgroundColor(AppTokens.Colors.secondary)
              .fontColor(AppTokens.Colors.onSecondary)
              .font-size(AppTokens.TypographyTokens.label.size)
              .fontWeight(AppTokens.TypographyTokens.label.weight)
              .height(36)
              .margin({ right: AppTokens.Spacing.sm })
          })
        }
        .width('100%')

        // Canvas 区域
        Stack({ alignContent: Alignment.Center }) {
          // Box 的背景和圆角
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)

          // Canvas 绘制内容
          CustomPainter({
            painter: new CanvasPainter(this.knobOffset.x, this.knobOffset.y),
            option: { renderOnInit: true }
          })
            .width('100%')
            .height('100%')
            .padding(AppTokens.Spacing.lg)
            .gesture(
              PanGesture()
                .onActionUpdate((event?: GestureEvent) => {
                  if (event) {
                    const offset = event.offsetX;
                    const offsetY = event.offsetY;
                    // 限制旋钮在 Canvas 绘制区域内移动，并考虑旋钮半径 16pt
                    const minX = 8;
                    const maxX = 8;
                    const minY = 8;
                    const maxY = 8;
                    const clampedX = Math.max(minX, Math.min(offset, maxX));
                    const clampedY = Math.max(minY, Math.min(offsetY, maxY));
                    this.knobOffset = { x: clampedX, y: clampedY };
                  }
                })
            )
        }
        .height(180)
        .width('100%')

        // 结果网格
        GridContainer()
          .columnsTemplate('1fr 1fr')
          .rowsTemplate('auto auto auto')
          .gridGap(AppTokens.Spacing.lg)
          .childLayout({
            childBuilder: () => {
              ForEach(this.results, (item: ResultItem) => {
                CardView({ item: item })
              })
            }
          })
          .padding({ bottom: 24 })
      }
      .padding(AppTokens.Spacing.lg)
    }
    .width('100%')
    .height('100%')
  }
}

class CanvasPainter implements CustomPainter {
  private knobX: number;
  private knobY: number;

  constructor(knobX: number, knobY: number) {
    this.knobX = knobX;
    this.knobY = knobY;
  }

  onDraw(canvas: Canvas, arRect: Rect) {
    // 绘制背景矩形
    canvas.beginPath();
    canvas.rect(0, 0, arRect.width, arRect.height);
    canvas.fillStyle = AppTokens.Colors.surfaceVariant;
    canvas.fill();

    // 绘制径向渐变圆
    const centerX = arRect.width / 2;
    const centerY = arRect.height / 2;
    const gradient = canvas.createRadialGradient(centerX, centerY, 0, centerX, centerY, 60);
    gradient.addColorStop(0, AppTokens.Colors.secondary);
    gradient.addColorStop(1, AppTokens.Colors.primary);
    
    canvas.beginPath();
    canvas.arc(centerX, centerY, 60, 0, 2 * Math.PI);
    canvas.fillStyle = gradient;
    canvas.fill();

    // 绘制可拖动旋钮
    canvas.beginPath();
    canvas.arc(this.knobX, this.knobY, 16, 0, 2 * Math.PI);
    canvas.fillStyle = AppTokens.Colors.primary;
    canvas.fill();
  }
}