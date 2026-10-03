// MARK: - AppTokens
// 严格对应 Kotlin 中的 AppTokens 定义，使用 number 替代 Dp，使用 ArkUI 的颜色字符串和 FontWeight
class FontSpec {
  readonly size: number;
  readonly weight: FontWeight;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

// MARK: - Color Extension for Hex Initialization
// 方便地从十六进制值创建颜色字符串（对应 Swift 的 Color(hex:) 扩展）
function colorFromHex(hex: number, alpha: number = 1.0): string {
  const r: number = (hex >> 16) & 0xFF;
  const g: number = (hex >> 8) & 0xFF;
  const b: number = hex & 0xFF;
  const a: number = Math.round(alpha * 255);

  const toHex2 = (value: number): string => {
    const s: string = value.toString(16).toUpperCase();
    return s.length < 2 ? '0' + s : s;
  };

  return '#' + toHex2(a) + toHex2(r) + toHex2(g) + toHex2(b);
}

class ColorsTokens {
  readonly primary: string = colorFromHex(0x00FF66);
  readonly secondary: string = colorFromHex(0xCCCCCC);
  readonly tertiary: string = colorFromHex(0x999999);
  readonly background: string = colorFromHex(0x000000);
  readonly surface: string = colorFromHex(0x0A0A0A);
  readonly surfaceVariant: string = colorFromHex(0x111111);
  readonly outline: string = colorFromHex(0x1F1F1F);
  readonly success: string = colorFromHex(0x16A34A);
  readonly warning: string = colorFromHex(0xF59E0B);
  readonly error: string = colorFromHex(0xFF4444);
  readonly onPrimary: string = colorFromHex(0x000000);
  readonly onSecondary: string = colorFromHex(0xFFFFFFFF);
  readonly onTertiary: string = colorFromHex(0xFFFFFFFF);
  readonly onBackground: string = colorFromHex(0xE0E0E0);
  readonly onSurface: string = colorFromHex(0xE0E0E0);
}

class FontTokens {
  readonly display: FontSpec = new FontSpec(28, FontWeight.Bold);
  readonly headline: FontSpec = new FontSpec(20, FontWeight.Medium);
  readonly title: FontSpec = new FontSpec(16, FontWeight.Medium);
  readonly body: FontSpec = new FontSpec(13, FontWeight.Regular); // Normal -> regular
  readonly label: FontSpec = new FontSpec(11, FontWeight.Medium);
}

class ShapesTokens {
  readonly small: number = 6;
  readonly medium: number = 10;
  readonly large: number = 14;
}

class SpacingTokens {
  readonly xs: number = 4;
  readonly sm: number = 8;
  readonly md: number = 12;
  readonly lg: number = 16;
  readonly xl: number = 24;
  readonly xxl: number = 32;
}

class ShadowSpec {
  // Kotlin elevation is 0.dp, radius 4.dp, dy 2.dp, opacity 0.12f
  // ArkUI shadow takes radius (blur), x/y offset, and color opacity.
  // Mapping Compose radius to ArkUI blur radius, Compose dy to ArkUI y offset.
  readonly radius: number; // Blur radius
  readonly y: number;      // Y offset
  readonly opacity: number;

  constructor(radius: number, y: number, opacity: number) {
    this.radius = radius;
    this.y = y;
    this.opacity = opacity;
  }
}

class ElevationTokens {
  readonly level1: ShadowSpec = new ShadowSpec(0, 0, 0);
  // Kotlin: elevation = 2.dp, radius = 4.dp, dy = 2.dp, opacity = 0.12f
  readonly level2: ShadowSpec = new ShadowSpec(4, 2, 0.12);
}

class AppTokens {
  static readonly Colors: ColorsTokens = new ColorsTokens();
  static readonly TypographyTokens: FontTokens = new FontTokens();
  static readonly Shapes: ShapesTokens = new ShapesTokens();
  static readonly Spacing: SpacingTokens = new SpacingTokens();
  static readonly ElevationMapping: ElevationTokens = new ElevationTokens();
}

// MARK: - Data Model
// 对应 Kotlin 的 MapMarker data class
class MapMarker {
  readonly id: string; // ForEach 需要稳定的 key（对应 SwiftUI 的 Identifiable）
  readonly name: string;
  readonly distance: string;
  private static nextId: number = 0;

  constructor(name: string, distance: string) {
    this.name = name;
    this.distance = distance;
    MapMarker.nextId++;
    this.id = 'marker_' + MapMarker.nextId.toString();
  }
}

// MARK: - CardView
// 对应 Kotlin 中的 Card 及其内容
@Component
struct CardView {
  @Prop marker: MapMarker;

  build() {
    Row({ space: 0 }) { // 对应 Kotlin Row 的 horizontalArrangement.SpaceBetween 和 verticalAlignment.CenterVertically
      Column({ space: 0 }) { // 对应 Kotlin Column
        Text(this.marker.name)
          .fontSize(AppTokens.TypographyTokens.title.size)
          .fontWeight(AppTokens.TypographyTokens.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text(this.marker.distance)
          .fontSize(AppTokens.TypographyTokens.body.size)
          .fontWeight(AppTokens.TypographyTokens.body.weight)
          .fontColor(AppTokens.Colors.secondary)
      }
      .alignItems(HorizontalAlign.Start)

      Blank() // 将按钮推到右侧

      Button('View')
        .fontSize(AppTokens.TypographyTokens.label.size)
        .fontWeight(AppTokens.TypographyTokens.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        // 按钮内部填充，模拟 Compose Button 的默认填充
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.small)
        .onClick(() => {
          // 处理 View 按钮操作
          console.info('View ' + this.marker.name + ' Tapped');
        })
    }
    .alignItems(VerticalAlign.Center)
    .padding(AppTokens.Spacing.md) // 对应 Kotlin Card 内部的 .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface) // 对应 Kotlin Card 的 containerColor
    .borderRadius(AppTokens.Shapes.medium) // 圆角
    .shadow({ // 阴影颜色和透明度
      radius: AppTokens.ElevationMapping.level2.radius, // 阴影模糊半径
      color: colorFromHex(0x000000, AppTokens.ElevationMapping.level2.opacity),
      offsetX: 0,
      offsetY: AppTokens.ElevationMapping.level2.y // 阴影 Y 轴偏移
    })
    .width('100%') // 填充宽度
  }
}

// MARK: - RootScreen View
// MARK: - App Entry Point
// 对应 Kotlin 的 MainActivity 和 setContent
// 在 ArkUI 中，@Entry 装饰的 RootScreen 即页面入口，等价于 SwiftUI 的 @main App
@Entry
@Component
struct RootScreen {
  @State query: string = '';
  @State isSearchFieldFocused: boolean = false; // 用于 OutlinedTextField 的焦点状态

  // 对应 Kotlin 中的 markers 列表
  private markers: MapMarker[] = [
    new MapMarker('Central Plaza', '1.2 km'),
    new MapMarker('Museum District', '3.4 km'),
    new MapMarker('Tech Park', '5.6 km'),
    new MapMarker('Old Town Gate', '7.8 km')
  ];

  build() {
    Stack() { // 使用 Stack 作为根容器，以便设置背景色并忽略安全区
      Column({ space: 0 }) { // 主 Column 布局，space: 0 避免 Column 自身添加间距
        // Top Bar (对应 Kotlin 的 CenterAlignedTopAppBar)
        Text('Explore Map')
          .fontSize(AppTokens.TypographyTokens.display.size)
          .fontWeight(AppTokens.TypographyTokens.display.weight)
          .fontColor(AppTokens.Colors.primary)
          .width('100%') // 填充宽度
          .textAlign(TextAlign.Center)
          .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg }) // 垂直内边距，模拟 TopAppBar 默认高度
          .backgroundColor(AppTokens.Colors.background)

        // 主内容区域
        Column({ space: AppTokens.Spacing.lg }) { // 对应 Kotlin Column 的 verticalArrangement.spacedBy(AppTokens.Spacing.lg)
          // Search Field (对应 Kotlin 的 OutlinedTextField)
          TextInput({ text: this.query, placeholder: 'Search destination' })
            .onChange((value: string) => {
              this.query = value;
            })
            .onFocus(() => {
              this.isSearchFieldFocused = true; // 绑定焦点状态
            })
            .onBlur(() => {
              this.isSearchFieldFocused = false;
            })
            .fontSize(AppTokens.TypographyTokens.body.size) // 文本和占位符字体
            .fontWeight(AppTokens.TypographyTokens.body.weight)
            .placeholderFont({ size: AppTokens.TypographyTokens.body.size, weight: AppTokens.TypographyTokens.body.weight })
            .fontColor(AppTokens.Colors.onSurface) // 文本颜色
            .caretColor(AppTokens.Colors.primary) // 光标颜色
            .padding(AppTokens.Spacing.md) // 内部文本内边距
            .backgroundColor(AppTokens.Colors.surfaceVariant) // 对应 Kotlin OutlinedTextField 的背景色
            .borderRadius(AppTokens.Shapes.medium) // 圆角
            .border({ width: 1, color: this.isSearchFieldFocused ? AppTokens.Colors.primary : AppTokens.Colors.outline, radius: AppTokens.Shapes.medium }) // 边框
            .width('100%') // 填充宽度

          // Markers List (对应 Kotlin 的 Column 包含 Card 列表)
          Column({ space: AppTokens.Spacing.md }) { // 对应 Kotlin Column 的 verticalArrangement.spacedBy(AppTokens.Spacing.md)
            ForEach(this.markers, (marker: MapMarker) => {
              CardView({ marker: marker })
            }, (marker: MapMarker) => marker.id)
          }
          .width('100%') // 填充宽度

          Blank() // 将底部的按钮推到底部

          // Refresh Map Button (对应 Kotlin 的 Button)
          Button('Refresh Map')
            .fontSize(AppTokens.TypographyTokens.title.size)
            .fontWeight(AppTokens.TypographyTokens.title.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width('100%') // 填充宽度
            .height(48) // 固定高度
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.large) // 圆角
            .onClick(() => {
              // 处理刷新地图操作
              console.info('Refresh Map Tapped');
            })
        }
        .layoutWeight(1)
        .width('100%')
        .padding(AppTokens.Spacing.lg) // 对应 Kotlin Column 的 .padding(AppTokens.Spacing.lg)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background) // 确保背景色覆盖整个屏幕，包括安全区（statusBarHidden(true) 在 ArkUI 中通过窗口系统栏接口实现）
  }
}
