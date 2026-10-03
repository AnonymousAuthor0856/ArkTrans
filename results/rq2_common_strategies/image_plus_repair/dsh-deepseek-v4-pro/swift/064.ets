// ArkTS 翻译自 SwiftUI 源文件 064.swift
// SwiftUI (View/struct/extension) 使用 ArkUI 声明式语法 (struct/@Component) 等价实现。

// MARK: - AppTokens
// 统一管理应用程序的颜色、字体、形状、间距和阴影规范，方便修改和维护。
// 注：SwiftUI 的嵌套 struct 在 ArkTS 中平铺为顶层 class（ArkTS 不支持 struct 与嵌套类型）。

// AppTokens.Colors —— 颜色规范
class AppTokensColors {
  static readonly primary: string = '#111111';
  static readonly secondary: string = '#2A2A2A';
  static readonly tertiary: string = '#444444';
  static readonly background: string = '#F7F7F7';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#EDEDED';
  static readonly outline: string = '#D6D6D6';
  static readonly success: string = '#1E7D4C';
  static readonly warning: string = '#B98400';
  static readonly error: string = '#B3261E';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0A0A0A';
  static readonly onSurface: string = '#0A0A0A';
}

// 文本样式：SwiftUI Font 不直接支持 lineHeight 和 letterSpacing，这里映射为基础字体大小和粗细。
// 如需更精细控制，可使用 ArkUI 的 lineHeight() 和 letterSpacing() 属性。
interface AppTextStyle {
  fontSize: number;
  fontWeight: number;
}

// AppTokens.TypographyTokens —— 字体规范
class TypographyTokens {
  static readonly display: AppTextStyle = { fontSize: 28, fontWeight: 600 };
  static readonly headline: AppTextStyle = { fontSize: 20, fontWeight: 500 };
  static readonly title: AppTextStyle = { fontSize: 16, fontWeight: 500 };
  static readonly body: AppTextStyle = { fontSize: 14, fontWeight: 400 };
  static readonly label: AppTextStyle = { fontSize: 12, fontWeight: 500 };
}

// AppTokens.Shapes —— 形状（圆角）规范
class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

// AppTokens.Spacing —— 间距规范
class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

// AppTokens.ShadowSpec —— 阴影规范
class ShadowSpec {
  elevation: number; // Compose 中的 z-offset，在阴影中不直接使用
  radius: number;    // Compose 中的模糊半径，映射到阴影的模糊量
  dy: number;        // y-轴偏移
  opacity: number;   // 阴影不透明度

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

// AppTokens.ElevationMapping —— 将 Compose 的阴影规范映射到 ArkUI 的 shadow 属性。
// ArkUI 的 shadow 参数为 radius (模糊量), offsetX (x-offset), offsetY (y-offset), color (含不透明度)。
class ElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 4, 2, 0.10);
  static readonly level2: ShadowSpec = new ShadowSpec(3, 8, 4, 0.14);
  static readonly level3: ShadowSpec = new ShadowSpec(6, 12, 6, 0.16);
}

// MARK: - 自定义 View 修饰符和辅助函数

// SwiftUI 的 View extension 修饰符 appShadow / appBorder / if / ifLet 在 ArkUI 中没有
// 等价的链式修饰符。这里将 appShadow 转换为内联的 .shadow(...) 属性，
// appBorder 转换为内联的 .border(...) 属性，if / ifLet 转换为 build() 中的条件渲染。
// 辅助函数：根据 ShadowSpec 生成含不透明度的阴影颜色。
function shadowColor(spec: ShadowSpec): string {
  return `rgba(0, 0, 0, ${spec.opacity})`;
}

// MARK: - 应用程序主题环境

// AppColorScheme 对应于 Kotlin 的 MaterialTheme.colorScheme。
// SwiftUI 通过 EnvironmentValues 注入；ArkTS 使用 @Provide/@Consume 实现等价的环境注入。
class AppColorScheme {
  primary: string = AppTokensColors.primary;
  onPrimary: string = AppTokensColors.onPrimary;
  secondary: string = AppTokensColors.secondary;
  onSecondary: string = AppTokensColors.onSecondary;
  tertiary: string = AppTokensColors.tertiary;
  onTertiary: string = AppTokensColors.onTertiary;
  background: string = AppTokensColors.background;
  onBackground: string = AppTokensColors.onBackground;
  surface: string = AppTokensColors.surface;
  onSurface: string = AppTokensColors.onSurface;
  surfaceVariant: string = AppTokensColors.surfaceVariant;
  outline: string = AppTokensColors.outline;
  error: string = AppTokensColors.error;
  success: string = AppTokensColors.success;
  warning: string = AppTokensColors.warning;
}

// AppTypography 对应于 Kotlin 的 MaterialTheme.typography，同样通过 @Provide/@Consume 注入
class AppTypography {
  displayLarge: AppTextStyle = TypographyTokens.display;
  headlineMedium: AppTextStyle = TypographyTokens.headline;
  titleMedium: AppTextStyle = TypographyTokens.title;
  bodyMedium: AppTextStyle = TypographyTokens.body;
  labelMedium: AppTextStyle = TypographyTokens.label;
}

// AppThemeModifier 将自定义颜色和字体注入环境：在 ArkTS 中由 RootScreen 通过 @Provide 实现，
// 其作用等价于 SwiftUI 的 .environment(\.appColorScheme) 与 .environment(\.appTypography)。

// MARK: - 数据模型

class ApprovalPin {
  id: number;
  title: string;
  status: string;
  x: number;
  y: number;

  constructor(id: number, title: string, status: string, x: number, y: number) {
    this.id = id;
    this.title = title;
    this.status = status;
    this.x = x;
    this.y = y;
  }
}

// MARK: - 可复用 UI 组件

@Component
struct FilterChipView {
  @Consume('appColorScheme') colorScheme: AppColorScheme;
  @Consume('appTypography') typography: AppTypography;
  @Prop text: string = '';
  @Prop isSelected: boolean = false;
  onTap: () => void = () => {};

  build() {
    Button(this.text, { type: ButtonType.Normal })
      .fontSize(this.isSelected ? this.typography.titleMedium.fontSize : this.typography.bodyMedium.fontSize)
      .fontWeight(this.isSelected ? this.typography.titleMedium.fontWeight : this.typography.bodyMedium.fontWeight)
      .fontColor(this.isSelected ? this.colorScheme.onPrimary : this.colorScheme.onSurface)
      .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
      .backgroundColor(this.isSelected ? this.colorScheme.primary : this.colorScheme.surface)
      .borderRadius(AppShapes.small)
      .border({ width: 1, color: this.colorScheme.outline, radius: AppShapes.small })
      .onClick(() => {
        this.onTap();
      })
  }
}

@Component
struct CardView {
  @Consume('appColorScheme') colorScheme: AppColorScheme;
  elevation: ShadowSpec = ElevationMapping.level1;
  @Prop cornerRadius: number = AppShapes.small;
  @Prop hasBorder: boolean = true;
  @Prop lineWidth: number = 1;
  lineColor: string = AppTokensColors.outline;
  onTap?: () => void;

  @Builder
  defaultContent() {
  }

  @BuilderParam content: () => void = this.defaultContent;

  build() {
    Column() {
      this.content()
    }
    .backgroundColor(this.colorScheme.surface)
    .borderRadius(this.cornerRadius)
    .shadow({ radius: this.elevation.radius, color: shadowColor(this.elevation), offsetX: 0, offsetY: this.elevation.dy })
    .border({ width: this.hasBorder ? this.lineWidth : 0, color: this.lineColor, radius: this.cornerRadius })
    .onClick(() => {
      if (this.onTap) {
        this.onTap();
      }
    })
  }
}

@Component
struct MapPinView {
  @Consume('appColorScheme') colorScheme: AppColorScheme;
  @Consume('appTypography') typography: AppTypography;
  pin: ApprovalPin = new ApprovalPin(0, '', '', 0, 0);
  @Prop selected: boolean = false;
  onTap: () => void = () => {};

  private baseColor(): string {
    if (this.pin.status === 'Approved') {
      return this.colorScheme.success;
    } else if (this.pin.status === 'Pending') {
      return this.colorScheme.warning;
    } else if (this.pin.status === 'Rejected') {
      return this.colorScheme.error;
    }
    return '#808080';
  }

  @Builder
  pinLabel() {
    Text(this.pin.title)
      .fontSize(this.typography.labelMedium.fontSize)
      .fontWeight(this.typography.labelMedium.fontWeight)
      .fontColor(this.colorScheme.onSurface)
      .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
  }

  build() {
    // Stack 的 TopStart 作为 MapPinView 的定位点
    Stack({ alignContent: Alignment.TopStart }) {
      // Pin 圆点
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.baseColor())
        .stroke(this.selected ? this.colorScheme.primary : this.colorScheme.surface)
        .strokeWidth(2)

      // Pin 旁边的信息卡片
      CardView({
        elevation: ElevationMapping.level1,
        cornerRadius: AppShapes.small,
        onTap: this.onTap,
        content: this.pinLabel
      })
      // 卡片相对于 Pin 圆点顶部的偏移
      .offset({ x: 18, y: -4 })
    }
  }
}

const GRID_INDEXES: number[] = [0, 1, 2, 3, 4, 5];

@Component
struct MapGridOverlay {
  @Consume('appColorScheme') colorScheme: AppColorScheme;

  build() {
    Stack() {
      // 水平网格线
      Column() {
        ForEach(GRID_INDEXES, (item: number) => {
          Blank()
          Rect()
            .width('100%')
            .height(1)
            .fill(this.colorScheme.surfaceVariant)
        }, (item: number) => item.toString())
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg }) // 网格线左右内边距

      // 垂直网格线
      Row() {
        ForEach(GRID_INDEXES, (item: number) => {
          Blank()
          Rect()
            .width(1)
            .height('100%')
            .fill(this.colorScheme.surfaceVariant)
        }, (item: number) => item.toString())
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppSpacing.lg, bottom: AppSpacing.lg }) // 网格线上下内边距
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - RootScreen (主界面)

@Entry
@Component
struct RootScreen {
  @Provide('appColorScheme') colorScheme: AppColorScheme = new AppColorScheme();
  @Provide('appTypography') typography: AppTypography = new AppTypography();

  @State filters: string[] = ['Pending', 'Approved'];
  @State activeFilters: string[] = ['Pending'];
  @State pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', 0.18, 0.35),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', 0.52, 0.42),
    new ApprovalPin(3, 'Contract #A77', 'Pending', 0.76, 0.58),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', 0.33, 0.72)
  ];
  @State selectedPinId: number = -1; // Swift 的 Int? = nil，这里用 -1 表示未选中
  @State mapWidth: number = 0;
  @State mapHeight: number = 0;

  private filteredPins(): ApprovalPin[] {
    return this.pins.filter((p: ApprovalPin) => {
      if (p.status === 'Pending') {
        return this.activeFilters.includes('Pending');
      }
      if (p.status === 'Approved') {
        return this.activeFilters.includes('Approved');
      }
      // Kotlin 代码中 Rejected 状态的 Pin 总是显示
      return true;
    });
  }

  private selectedPinTitle(): string {
    const found = this.pins.find((item: ApprovalPin) => item.id === this.selectedPinId);
    return found ? found.title : '';
  }

  private selectedPinStatus(): string {
    const found = this.pins.find((item: ApprovalPin) => item.id === this.selectedPinId);
    return found ? found.status : '';
  }

  @Builder
  detailCardContent() {
    Row() {
      Column({ space: AppSpacing.xs }) {
        Text(this.selectedPinTitle())
          .fontSize(this.typography.titleMedium.fontSize)
          .fontWeight(this.typography.titleMedium.fontWeight)
          .fontColor(this.colorScheme.onSurface)
        Text(this.selectedPinStatus())
          .fontSize(this.typography.labelMedium.fontSize)
          .fontWeight(this.typography.labelMedium.fontWeight)
          .fontColor(this.colorScheme.onSurface)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Row({ space: AppSpacing.sm }) {
        Button('Details', { type: ButtonType.Normal })
          .fontSize(this.typography.labelMedium.fontSize)
          .fontWeight(this.typography.labelMedium.fontWeight)
          .fontColor(this.colorScheme.onSurface)
          .padding({ left: AppSpacing.md, right: AppSpacing.md })
          .height(40)
          .backgroundColor(this.colorScheme.surfaceVariant)
          .borderRadius(AppShapes.medium)
      }
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  detailCard() {
    if (this.selectedPinId !== -1) {
      // 使用 Column + Blank 将卡片推到底部居中
      Column() {
        Blank()
        CardView({
          elevation: ElevationMapping.level3,
          cornerRadius: AppShapes.large,
          hasBorder: true,
          lineWidth: 1,
          lineColor: this.colorScheme.outline,
          content: this.detailCardContent
        })
        .padding(AppSpacing.md) // 卡片周围的内边距
      }
      .width('100%')
      .height('100%')
    }
  }

  build() {
    Stack() {
      // 主内容列：顶部栏、可滚动内容、底部栏
      Column() {
        // 顶部栏 (CenterAlignedTopAppBar 模拟)
        Column() {
          Text('Approval Flow')
            .fontSize(this.typography.displayLarge.fontSize)
            .fontWeight(this.typography.displayLarge.fontWeight)
            .fontColor(this.colorScheme.onSurface)
        }
        .width('100%')
        .padding({ top: AppSpacing.md, bottom: AppSpacing.md }) // 模拟顶部栏的垂直内边距
        .backgroundColor(this.colorScheme.surface)

        // 主可滚动内容区域
        Scroll() {
          Column({ space: AppSpacing.md }) { // 对应 Kotlin 的 Column 内容
            // 筛选器 LazyRow
            Scroll() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (f: string) => {
                  FilterChipView({
                    text: f,
                    isSelected: this.activeFilters.includes(f),
                    onTap: () => {
                      if (this.activeFilters.includes(f)) {
                        this.activeFilters = this.activeFilters.filter((item: string) => item !== f);
                      } else {
                        this.activeFilters = this.activeFilters.concat(f);
                      }
                    }
                  })
                }, (f: string) => f)
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md })

            // 地图区域 (BoxWithConstraints 模拟)
            Stack({ alignContent: Alignment.TopStart }) {
              MapGridOverlay()
                .width('100%')
                .height('100%')

              // 审批 Pin 点
              ForEach(this.filteredPins(), (p: ApprovalPin) => {
                MapPinView({
                  pin: p,
                  selected: this.selectedPinId === p.id,
                  onTap: () => {
                    this.selectedPinId = (this.selectedPinId === p.id) ? -1 : p.id;
                  }
                })
                // 定位 MapPinView 的 TopStart 角
                .offset({ x: this.mapWidth * p.x, y: this.mapHeight * p.y })
              }, (p: ApprovalPin) => p.id.toString())

              // 选中 Pin 的详情卡片
              this.detailCard()
            }
            .width('100%')
            .aspectRatio(0.9) // 保持宽高比
            .backgroundColor(AppTokensColors.surface)
            .borderRadius(AppShapes.large)
            .border({ width: 1, color: AppTokensColors.outline, radius: AppShapes.large })
            .onAreaChange((oldValue: Area, newValue: Area) => {
              this.mapWidth = newValue.width as number;
              this.mapHeight = newValue.height as number;
            })
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg, bottom: AppSpacing.md })
          }
          .width('100%')
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1) // ScrollView 填充剩余空间

        // 底部栏 (BottomAppBar 模拟)
        Column() {
          Row({ space: AppSpacing.md }) {
            Button('Reject', { type: ButtonType.Normal })
              .fontSize(this.typography.titleMedium.fontSize)
              .fontWeight(this.typography.titleMedium.fontWeight)
              .fontColor(this.colorScheme.onSurface)
              .layoutWeight(1) // weight(1f) 效果
              .height(48)
              .backgroundColor(this.colorScheme.surfaceVariant)
              .borderRadius(AppShapes.medium)
              .enabled(this.selectedPinId !== -1)

            Button('Approve', { type: ButtonType.Normal })
              .fontSize(this.typography.titleMedium.fontSize)
              .fontWeight(this.typography.titleMedium.fontWeight)
              .fontColor(this.colorScheme.onPrimary)
              .layoutWeight(1) // weight(1f) 效果
              .height(48)
              .backgroundColor(this.colorScheme.primary)
              .borderRadius(AppShapes.medium)
              .enabled(this.selectedPinId !== -1)
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
        }
        .width('100%')
        .backgroundColor(this.colorScheme.surface)
        .shadow({ radius: ElevationMapping.level2.radius, color: shadowColor(ElevationMapping.level2), offsetX: 0, offsetY: ElevationMapping.level2.dy }) // 底部栏阴影
      }
      .width('100%')
      .height('100%')

      // 浮动操作按钮 (FloatingActionButton 模拟)
      Column() {
        Blank()
        Row() {
          Blank()
          Button('+', { type: ButtonType.Circle })
            .fontSize(this.typography.headlineMedium.fontSize)
            .fontWeight(this.typography.headlineMedium.fontWeight)
            .fontColor(this.colorScheme.onPrimary)
            .width(56)
            .height(56) // 标准 FAB 尺寸
            .backgroundColor(this.colorScheme.primary)
            .margin(AppSpacing.lg) // FAB 的内边距
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colorScheme.background) // 设置背景色
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]) // 忽略安全区域，实现全屏
  }
}

// MARK: - App 入口点
// @main 标记定义了应用程序的入口点。
// ArkTS/ArkUI 中 @Entry @Component 的 RootScreen 即页面入口，等价于 SwiftUI 的 App/Scene。
