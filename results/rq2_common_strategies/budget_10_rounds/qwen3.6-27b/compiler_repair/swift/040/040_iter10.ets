import { window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

// MARK: - AppTokens
// 统一的 UI 令牌，方便管理颜色、字体、形状、间距和阴影，实现原子级设计

interface ColorToken {
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

interface TypographyToken {
  size: number;
  weight: FontWeight;
}

interface TypographyTokens {
  display: TypographyToken;
  headline: TypographyToken;
  title: TypographyToken;
  body: TypographyToken;
  label: TypographyToken;
  labelFontSize: number;
}

interface ShapeToken {
  small: number;
  medium: number;
  large: number;
}

interface SpacingToken {
  sm: number;
  md: number;
  lg: number;
}

interface ElevationLevel {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;
}

interface ElevationMapping {
  level2: ElevationLevel;
}

class AppTokens {
  static Colors: ColorToken = {
    primary: '#FF7B00',
    secondary: '#FFD166',
    background: '#FFF6E5',
    surface: '#FFFFFF',
    surfaceVariant: '#FFF0C1',
    outline: '#E0C080',
    onPrimary: '#FFFFFF',
    onSecondary: '#3E2723',
    onBackground: '#3E2723',
    onSurface: '#3E2723'
  };

  static TypographyTokens: TypographyTokens = {
    display: { size: 28, weight: FontWeight.Bold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium },
    labelFontSize: 12.0
  };

  static Shapes: ShapeToken = {
    small: 6.0,
    medium: 10.0,
    large: 14.0
  };

  static Spacing: SpacingToken = {
    sm: 8.0,
    md: 12.0,
    lg: 16.0
  };

  static ElevationMapping: ElevationMapping = {
    level2: {
      elevation: 4.0,
      radius: 8.0,
      dy: 4.0,
      opacity: 0.12
    }
  };
}

// MARK: - ResultItem
// 数据模型
interface ResultItem {
  id: number;
  title: string;
}

interface KnobOffset {
  x: number;
  y: number;
}

@Entry
@Component
struct RootScreen {
  // 状态管理
  @State query: string = '';
  // 拖动旋钮的初始位置
  @State knobOffset: KnobOffset = { x: 144, y: 104 };
  
  // 列表数据
  results: ResultItem[] = [];
  
  // 用于 TextField 的焦点状态
  @State isTextFieldFocused: boolean = false;

  aboutToAppear() {
    this.results = Array.from({ length: 6 }, (_, i) => ({
      id: i,
      title: `Result ${i + 1}`
    }));
  }

  build() {
    Column() {
      Text("Retro Filter Search")
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Start)

      // 搜索输入框
      TextInput({ placeholder: 'Search products', text: this.query })
        .type(InputType.Normal)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .placeholderColor(Color.Gray)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .height(56)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .border({ width: 1, color: this.isTextFieldFocused ? Color.Orange : Color.Gray, radius: AppTokens.Shapes.medium })
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
            .backgroundColor(AppTokens.Colors.secondary)
            .borderRadius(AppTokens.Shapes.small)
            .height(36)
            .margin({ right: AppTokens.Spacing.sm })
        })
      }
      .width('100%')
      .alignItems(FlexAlign.Top)

      // Canvas 区域
      Stack() {
        // 背景矩形
        Rect()
          .fill(new Color(AppTokens.Colors.surfaceVariant))
          .borderRadius(AppTokens.Shapes.large)
        
        // 径向渐变圆
        Circle()
          .width(120)
          .height(120)
          .fill(new RadialGradient([
            { offset: 0, color: AppTokens.Colors.secondary },
            { offset: 1, color: AppTokens.Colors.primary }
          ]))
          .position({ x: '50%', y: '50%' })
          .translate({ x: -60, y: -60 })

        // 可拖动旋钮
        Circle()
          .width(32)
          .height(32)
          .fill(new Color(AppTokens.Colors.primary))
          .position({ x: this.knobOffset.x, y: this.knobOffset.y })
          .translate({ x: -16, y: -16 })
          .gesture(
            PanGesture()
              .onActionUpdate((event?: GestureEvent) => {
                if (event) {
                  let newX = event.offsetX + 144; // Initial X
                  let newY = event.offsetY + 104; // Initial Y
                  
                  // Clamp values within canvas bounds (approximate based on SwiftUI logic)
                  const minX = 8;
                  const maxX = 280; // Assuming a standard width minus padding
                  const minY = 8;
                  const maxY = 148; // Height 180 - padding 16 - knob radius 16

                  this.knobOffset.x = Math.max(minX, Math.min(newX, maxX));
                  this.knobOffset.y = Math.max(minY, Math.min(newY, maxY));
                }
              })
          )
      }
      .width('100%')
      .height(180)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.large)
      .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: Color.Black, offsetY: AppTokens.ElevationMapping.level2.dy })

      // 结果网格
      GridContainer() {
        ForEach(this.results, (item: ResultItem) => {
          GridItem() {
            CardView({ item: item })
          }
        })
      }
      .columnsTemplate('1fr 1fr')
      .rowsTemplate('auto auto auto')
      .gridItemLayout(GridItemLayout.FixedRow(2))
      .gap({ row: AppTokens.Spacing.lg, column: AppTokens.Spacing.lg })
      .width('100%')
      .padding({ bottom: 24 })
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%')
  }
}

@Component
struct CardView {
  private item: ResultItem = { id: 0, title: '' };

  build() {
    Column() {
      // 图片占位符
      Rect()
        .width(96)
        .height(96)
        .fill(new Color(AppTokens.Colors.surfaceVariant))
        .borderRadius(AppTokens.Shapes.medium)

      Text(this.item.title)
        .fontSize(AppTokens.TypographyTokens.title.size)
        .fontWeight(AppTokens.TypographyTokens.title.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ top: AppTokens.Spacing.sm })

      // 添加按钮
      Button('Add')
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .width('100%')
        .height(48)
        .margin({ top: AppTokens.Spacing.sm })
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .shadow({ radius: AppTokens.ElevationMapping.level2.radius, color: Color.Black, offsetY: AppTokens.ElevationMapping.level2.dy })
  }
}