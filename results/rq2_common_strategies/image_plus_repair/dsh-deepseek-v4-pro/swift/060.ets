// MARK: - AppTokens (原子级对应 Kotlin 的 AppTokens)
// 定义应用所需的颜色、字体、形状和间距，方便统一管理和修改。

// 字体样式描述：size 对应 Kotlin 的 sp，weight 对应 FontWeight 数值（700=Bold, 600=SemiBold, 500=Medium, 400=Normal）
interface TextStyleToken {
  size: number;
  weight: number;
}

// 颜色令牌：Kotlin 的 Color(0xFF2563EB) 对应 ArkTS 的 '#2563EB'
interface ColorTokens {
  readonly primary: string;
  readonly secondary: string;
  readonly tertiary: string;
  readonly background: string;
  readonly surface: string;
  readonly surfaceVariant: string;
  readonly outline: string;
  readonly onPrimary: string;
  readonly onSecondary: string;
  readonly onTertiary: string;
  readonly onBackground: string;
  readonly onSurface: string;
}

interface TypographyTokens {
  readonly display: TextStyleToken;
  readonly headline: TextStyleToken;
  readonly title: TextStyleToken;
  readonly body: TextStyleToken;
}

interface ShapeTokens {
  readonly small: number;
  readonly medium: number;
  readonly large: number;
}

interface SpacingTokens {
  readonly sm: number;
  readonly md: number;
  readonly lg: number;
  readonly xl: number;
  readonly buttonContentHorizontal: number;
  readonly buttonContentVertical: number;
}

class AppTokens {
  static readonly Colors: ColorTokens = {
    primary: '#2563EB',
    secondary: '#38BDF8',
    tertiary: '#60A5FA',
    background: '#F8FAFC',
    surface: '#FFFFFF',
    surfaceVariant: '#E2E8F0',
    outline: '#CBD5E1',
    onPrimary: '#FFFFFF',
    onSecondary: '#0F172A',
    onTertiary: '#FFFFFF',
    onBackground: '#0F172A',
    onSurface: '#1E293B'
  };

  // Kotlin: TextStyle(fontSize = 24.sp, fontWeight = FontWeight.Bold) -> ArkTS: size 24, weight 700
  static readonly TypographyTokens: TypographyTokens = {
    display: { size: 24, weight: 700 },
    headline: { size: 18, weight: 600 },
    title: { size: 14, weight: 500 },
    // Kotlin's FontWeight.Normal 对应 weight 400
    body: { size: 12, weight: 400 }
  };

  // Kotlin: RoundedCornerShape(6.dp) -> ArkTS: 6
  static readonly Shapes: ShapeTokens = {
    small: 6,
    medium: 10,
    large: 14
  };

  // Kotlin: 6.dp -> ArkTS: 6
  static readonly Spacing: SpacingTokens = {
    sm: 6,
    md: 10,
    lg: 14,
    xl: 20,
    // Kotlin Compose Material3 Button 的默认内容内边距为 horizontal = 16.dp, vertical = 8.dp
    buttonContentHorizontal: 16,
    buttonContentVertical: 8
  };
}

// MARK: - CustomUnitButton (自定义按钮样式，实现原子级对应)
// 这个自定义按钮样式模仿了 Compose Button 的条件颜色和形状。
@Component
struct CustomUnitButton {
  @Prop isActive: boolean = false;
  label: string = '';
  onAction: () => void = () => {};
  @State isPressed: boolean = false;

  build() {
    Button(this.label)
      // 应用 AppTokens 中定义的字体样式
      .fontSize(AppTokens.TypographyTokens.title.size)
      .fontWeight(AppTokens.TypographyTokens.title.weight)
      // 匹配 Compose Button 的默认水平/垂直内边距
      .padding({
        left: AppTokens.Spacing.buttonContentHorizontal,
        right: AppTokens.Spacing.buttonContentHorizontal,
        top: AppTokens.Spacing.buttonContentVertical,
        bottom: AppTokens.Spacing.buttonContentVertical
      })
      .backgroundColor(this.isActive ? AppTokens.Colors.primary : AppTokens.Colors.surfaceVariant)
      .fontColor(this.isActive ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      // 按钮通常使用 small 形状的圆角
      .borderRadius(AppTokens.Shapes.small)
      // 按下时的缩放效果
      .scale({ x: this.isPressed ? 0.95 : 1.0, y: this.isPressed ? 0.95 : 1.0 })
      // 动画效果（对应 easeOut(duration: 0.1)）
      .animation({ duration: 100, curve: Curve.EaseOut })
      .onTouch((event: TouchEvent) => {
        if (event.type === TouchType.Down) {
          this.isPressed = true;
        } else if (event.type === TouchType.Up || event.type === TouchType.Cancel) {
          this.isPressed = false;
        }
      })
      .onClick(() => {
        this.onAction();
      });
  }
}

// MARK: - MarkerBox (对应 Kotlin 的 MarkerBox Composable)
@Component
struct MarkerBox {
  @Prop unit: string = '';
  @Prop value: string = '';
  @Prop active: boolean = false;

  build() {
    // 对应 Compose 的 Column，alignment 为 Start
    Column() {
      Text(this.unit)
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface);
      Text(this.value)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface);
    }
    .alignItems(HorizontalAlign.Start)
    // 对应 padding(AppTokens.Spacing.md)
    .padding(AppTokens.Spacing.md)
    // 对应 fillMaxWidth() 和 contentAlignment = Alignment.CenterStart
    .width('100%')
    // 对应 height(80.dp)
    .height(80)
    // active 时使用 secondary.opacity(0.3)（即 #4D38BDF8），否则使用 surface
    .backgroundColor(this.active ? '#4D38BDF8' : AppTokens.Colors.surface)
    // 对应 AppTokens.Shapes.medium
    .borderRadius(AppTokens.Shapes.medium)
    // 对应 border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.medium)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.medium });
  }
}

// MARK: - MapArea (对应 Kotlin 的 MapArea Composable)
@Component
struct MapArea {
  @Prop selected: string = '';

  build() {
    // 对应 Compose Column 中的 Text 和 Spacer
    Column({ space: AppTokens.Spacing.md }) {
      Text('Unit Map Visualization')
        .fontSize(AppTokens.TypographyTokens.headline.size)
        .fontWeight(AppTokens.TypographyTokens.headline.weight)
        .fontColor(AppTokens.Colors.onSurface);
      Text('Active Unit: ' + this.selected)
        .fontSize(AppTokens.TypographyTokens.body.size)
        .fontWeight(AppTokens.TypographyTokens.body.weight)
        .fontColor(AppTokens.Colors.onSurface);
    }
    // VStack 默认居中对齐，匹配 horizontalAlignment = CenterHorizontally 和 verticalArrangement = Center
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    // 对应 fillMaxWidth() 和 height(240.dp)
    .width('100%')
    .height(240)
    // 对应 background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.large)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    // 应用圆角
    .borderRadius(AppTokens.Shapes.large)
    // 对应 border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline, radius: AppTokens.Shapes.large })
    // 对应 padding(AppTokens.Spacing.lg)
    .padding(AppTokens.Spacing.lg);
  }
}

// MARK: - RootScreen (对应 Kotlin 的 RootScreen Composable)
@Component
struct RootScreen {
  private markers: string[] = ['Length', 'Weight', 'Temperature', 'Speed'];
  // 对应 remember { mutableStateOf(markers.first()) }
  @State active: string = 'Length';

  build() {
    // 对应 Column with verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
    Column({ space: AppTokens.Spacing.lg }) {
      Text('Unit Converter')
        .fontSize(AppTokens.TypographyTokens.display.size)
        .fontWeight(AppTokens.TypographyTokens.display.weight)
        .fontColor(AppTokens.Colors.onBackground);

      MapArea({ selected: this.active });

      // 对应 Swift 的 ForEach(markers, id: \.self)
      MarkerBox({ unit: this.markers[0], value: 'Tap to convert', active: this.active === this.markers[0] });
      MarkerBox({ unit: this.markers[1], value: 'Tap to convert', active: this.active === this.markers[1] });
      MarkerBox({ unit: this.markers[2], value: 'Tap to convert', active: this.active === this.markers[2] });
      MarkerBox({ unit: this.markers[3], value: 'Tap to convert', active: this.active === this.markers[3] });

      // 此 Blank 对应 Kotlin 中的 Spacer(Modifier.height(AppTokens.Spacing.md))。
      // Column 的 space: AppTokens.Spacing.lg 会在其所有直接子视图之间添加 lg 间距。
      Blank().height(AppTokens.Spacing.md);

      // 对应 Row with horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
      Row({ space: AppTokens.Spacing.md }) {
        CustomUnitButton({
          label: this.markers[0],
          isActive: this.active === this.markers[0],
          onAction: () => { this.active = this.markers[0]; }
        });
        CustomUnitButton({
          label: this.markers[1],
          isActive: this.active === this.markers[1],
          onAction: () => { this.active = this.markers[1]; }
        });
        CustomUnitButton({
          label: this.markers[2],
          isActive: this.active === this.markers[2],
          onAction: () => { this.active = this.markers[2]; }
        });
        CustomUnitButton({
          label: this.markers[3],
          isActive: this.active === this.markers[3],
          onAction: () => { this.active = this.markers[3]; }
        });
      }
    }
    // 对应 padding(AppTokens.Spacing.lg)
    .padding(AppTokens.Spacing.lg)
    // 对应 fillMaxSize()
    .width('100%')
    .height('100%')
    // 对应 Brush.verticalGradient(...)
    // secondary.opacity(0.15) -> #2638BDF8, primary.opacity(0.15) -> #262563EB
    .linearGradient({
      angle: 180,
      colors: [['#2638BDF8', 0.0], ['#262563EB', 1.0]]
    })
    // 确保应用全屏显示，包括状态栏和导航栏区域
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM, SafeAreaEdge.START, SafeAreaEdge.END]);
    // 隐藏顶部状态栏（ArkUI 声明式 UI 无 statusBarHidden 修饰符，通过 expandSafeArea 忽略系统安全区实现全屏）
  }
}

// MARK: - App Entry Point (应用入口)
// 对应 Kotlin 的 MainActivity，但以 ArkUI 的方式实现全屏和状态栏隐藏。
@Entry
@Component
struct UnitConverterApp {
  build() {
    Column() {
      RootScreen();
    }
    .width('100%')
    .height('100%');
  }
}
