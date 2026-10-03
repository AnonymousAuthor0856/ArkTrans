// AppTokens.ets
// 统一管理应用程序的颜色、字体、形状、间距和阴影规范，方便修改和维护。

interface IColors {
  primary: ResourceColor;
  secondary: ResourceColor;
  tertiary: ResourceColor;
  background: ResourceColor;
  surface: ResourceColor;
  surfaceVariant: ResourceColor;
  outline: ResourceColor;
  success: ResourceColor;
  warning: ResourceColor;
  error: ResourceColor;
  onPrimary: ResourceColor;
  onSecondary: ResourceColor;
  onTertiary: ResourceColor;
  onBackground: ResourceColor;
  onSurface: ResourceColor;
}

interface ITypographyToken {
  size: number;
  weight: FontWeight;
}

interface ITypographyTokens {
  display: ITypographyToken;
  headline: ITypographyToken;
  title: ITypographyToken;
  body: ITypographyToken;
  label: ITypographyToken;
}

interface IShapes {
  small: number;
  medium: number;
  large: number;
}

interface ISpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
}

class AppTokens {
  static Colors: IColors = {
    primary: '#111111',
    secondary: '#2A2A2A',
    tertiary: '#444444',
    background: '#F7F7F7',
    surface: '#FFFFFF',
    surfaceVariant: '#EDEDED',
    outline: '#D6D6D6',
    success: '#1E7D4C',
    warning: '#B98400',
    error: '#B3261E',
    onPrimary: '#FFFFFF',
    onSecondary: '#FFFFFF',
    onTertiary: '#FFFFFF',
    onBackground: '#0A0A0A',
    onSurface: '#0A0A0A'
  };

  static TypographyTokens: ITypographyTokens = {
    display: { size: 28, weight: FontWeight.Medium },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  };

  static Shapes: IShapes = {
    small: 8,
    medium: 12,
    large: 16
  };

  static Spacing: ISpacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16
  };
}

class ShadowSpec {
  radius: number;
  dy: number;
  color: ResourceColor;
  
  constructor(radius: number, dy: number, color: ResourceColor) {
    this.radius = radius;
    this.dy = dy;
    this.color = color;
  }
}

class ElevationMapping {
  static level1: ShadowSpec = new ShadowSpec(4, 2, `rgba(0,0,0,0.10)`);
  static level2: ShadowSpec = new ShadowSpec(8, 4, `rgba(0,0,0,0.14)`);
  static level3: ShadowSpec = new ShadowSpec(12, 6, `rgba(0,0,0,0.16)`);
}

// 主题数据模型
class AppColorScheme {
  primary: ResourceColor = AppTokens.Colors.primary;
  onPrimary: ResourceColor = AppTokens.Colors.onPrimary;
  secondary: ResourceColor = AppTokens.Colors.secondary;
  onSecondary: ResourceColor = AppTokens.Colors.onSecondary;
  tertiary: ResourceColor = AppTokens.Colors.tertiary;
  onTertiary: ResourceColor = AppTokens.Colors.onTertiary;
  background: ResourceColor = AppTokens.Colors.background;
  onBackground: ResourceColor = AppTokens.Colors.onBackground;
  surface: ResourceColor = AppTokens.Colors.surface;
  onSurface: ResourceColor = AppTokens.Colors.onSurface;
  surfaceVariant: ResourceColor = AppTokens.Colors.surfaceVariant;
  outline: ResourceColor = AppTokens.Colors.outline;
  error: ResourceColor = AppTokens.Colors.error;
  success: ResourceColor = AppTokens.Colors.success;
  warning: ResourceColor = AppTokens.Colors.warning;
}

class AppTypography {
  displayLarge: ITypographyToken = AppTokens.TypographyTokens.display;
  headlineMedium: ITypographyToken = AppTokens.TypographyTokens.headline;
  titleMedium: ITypographyToken = AppTokens.TypographyTokens.title;
  bodyMedium: ITypographyToken = AppTokens.TypographyTokens.body;
  labelMedium: ITypographyToken = AppTokens.TypographyTokens.label;
}

// 数据模型
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

// MARK: - RootScreen (主界面)

@Entry
@Component
struct RootScreen {
  @Provide('appColorScheme') appColorScheme: AppColorScheme = new AppColorScheme();
  @Provide('appTypography') appTypography: AppTypography = new AppTypography();

  @State filters: string[] = ["Pending", "Approved"];
  @State activeFilters: string[] = ["Pending"];
  @State pins: ApprovalPin[] = [
    new ApprovalPin(1, "Purchase Order #1042", "Pending", 0.18, 0.35),
    new ApprovalPin(2, "Travel Request #552", "Approved", 0.52, 0.42),
    new ApprovalPin(3, "Contract #A77", "Pending", 0.76, 0.58),
    new ApprovalPin(4, "Budget Change #09", "Rejected", 0.33, 0.72)
  ];
  @State selectedPinId: number | null = null;

  get filteredPins(): ApprovalPin[] {
    return this.pins.filter(p => {
      switch (p.status) {
        case "Pending": return this.activeFilters.includes("Pending");
        case "Approved": return this.activeFilters.includes("Approved");
        case "Rejected": return true;
        default: return true;
      }
    });
  }

  get selectedPin(): ApprovalPin | null {
    if (this.selectedPinId === null) return null;
    return this.pins.find(p => p.id === this.selectedPinId) || null;
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 背景色
      Column() {
        // 顶部栏
        Column() {
          Text("Approval Flow")
            .fontSize(this.appTypography.displayLarge.size)
            .fontWeight(this.appTypography.displayLarge.weight)
            .fontColor(this.appColorScheme.onSurface)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(this.appColorScheme.surface)

        // 主可滚动内容区域
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // 筛选器
            Scroll() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (f: string) => {
                  FilterChipView({ 
                    text: f, 
                    isSelected: this.activeFilters.includes(f),
                    onTap: () => {
                      if (this.activeFilters.includes(f)) {
                        this.activeFilters = this.activeFilters.filter(item => item !== f);
                      } else {
                        this.activeFilters.push(f);
                      }
                    }
                  })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .padding({ top: AppTokens.Spacing.md })

            // 地图区域
            Stack() {
              MapGridOverlay()

              // 审批 Pin 点
              ForEach(this.filteredPins, (p: ApprovalPin) => {
                MapPinView({
                  pin: p,
                  selected: this.selectedPinId === p.id,
                  onTap: () => {
                    this.selectedPinId = this.selectedPinId === p.id ? null : p.id;
                  }
                })
                .markAnchor({ x: 0, y: 0 }) // 定位 topLeading
                .position({ x: `${p.x * 100}%`, y: `${p.y * 100}%` })
              })

              // 选中 Pin 的详情卡片
              if (this.selectedPin) {
                Column() {
                  Blank() // Spacer 推到底部
                  
                  CardView({
                    elevation: ElevationMapping.level3,
                    cornerRadius: AppTokens.Shapes.large,
                    cardBorderWidth: 1,
                    cardBorderColor: this.appColorScheme.outline
                  }) {
                    Row() {
                      Column() {
                        Text(this.selectedPin.title)
                          .fontSize(this.appTypography.titleMedium.size)
                          .fontWeight(this.appTypography.titleMedium.weight)
                          .fontColor(this.appColorScheme.onSurface)
                        Text(this.selectedPin.status)
                          .fontSize(this.appTypography.labelMedium.size)
                          .fontWeight(this.appTypography.labelMedium.weight)
                          .fontColor(this.appColorScheme.onSurface)
                          .margin({ top: AppTokens.Spacing.xs })
                      }
                      .alignItems(HorizontalAlign.Start)

                      Blank()

                      Button("Details")
                        .fontSize(this.appTypography.labelMedium.size)
                        .fontWeight(this.appTypography.labelMedium.weight)
                        .fontColor(this.appColorScheme.onSurface)
                        .height(40)
                        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                        .backgroundColor(this.appColorScheme.surfaceVariant)
                        .borderRadius(AppTokens.Shapes.medium)
                    }
                    .padding(AppTokens.Spacing.lg)
                    .width('100%')
                  }
                  .padding(AppTokens.Spacing.md)
                }
                .width('100%')
                .height('100%')
              }
            }
            .width('100%')
            .aspectRatio(0.9)
            .borderRadius(AppTokens.Shapes.large)
            .backgroundColor(AppTokens.Colors.surface)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
          }
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // 底部栏
        Column() {
          Row({ space: AppTokens.Spacing.md }) {
            Button("Reject")
              .fontSize(this.appTypography.titleMedium.size)
              .fontWeight(this.appTypography.titleMedium.weight)
              .fontColor(this.appColorScheme.onSurface)
              .layoutWeight(1)
              .height(48)
              .backgroundColor(this.appColorScheme.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .enabled(this.selectedPinId !== null)

            Button("Approve")
              .fontSize(this.appTypography.titleMedium.size)
              .fontWeight(this.appTypography.titleMedium.weight)
              .fontColor(this.appColorScheme.onPrimary)
              .layoutWeight(1)
              .height(48)
              .backgroundColor(this.appColorScheme.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .enabled(this.selectedPinId !== null)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .backgroundColor(this.appColorScheme.surface)
        .shadow({
          radius: ElevationMapping.level2.radius,
          color: ElevationMapping.level2.color,
          offsetY: ElevationMapping.level2.dy
        })
      }
      .width('100%')
      .height('100%')

      // 浮动操作按钮 (FAB)
      Column() {
        Blank()
        Row() {
          Blank()
          Button("+")
            .fontSize(this.appTypography.headlineMedium.size)
            .fontWeight(this.appTypography.headlineMedium.weight)
            .fontColor(this.appColorScheme.onPrimary)
            .width(56)
            .height(56)
            .borderRadius(28) // Circle
            .backgroundColor(this.appColorScheme.primary)
            .margin(AppTokens.Spacing.lg)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.appColorScheme.background)
  }
}

// MARK: - 可复用 UI 组件

@Component
struct FilterChipView {
  @Consume('appColorScheme') appColorScheme: AppColorScheme;
  @Consume('appTypography') appTypography: AppTypography;
  
  @Prop text: string;
  @Prop isSelected: boolean;
  onTap: () => void = () => {};

  build() {
    Button(this.text)
      .type(ButtonType.Normal)
      .fontSize(this.isSelected ? this.appTypography.titleMedium.size : this.appTypography.bodyMedium.size)
      .fontWeight(this.isSelected ? this.appTypography.titleMedium.weight : this.appTypography.bodyMedium.weight)
      .fontColor(this.isSelected ? this.appColorScheme.onPrimary : this.appColorScheme.onSurface)
      .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      .borderRadius(AppTokens.Shapes.small)
      .backgroundColor(this.isSelected ? this.appColorScheme.primary : this.appColorScheme.surface)
      .border({ width: 1, color: this.appColorScheme.outline })
      .onClick(this.onTap)
  }
}

@Component
struct CardView {
  @Consume('appColorScheme') appColorScheme: AppColorScheme;
  
  elevation: ShadowSpec = ElevationMapping.level1;
  cornerRadius: number = AppTokens.Shapes.small;
  cardBorderWidth: number = 1;
  cardBorderColor: ResourceColor = AppTokens.Colors.outline;
  onCardClick: (() => void) | null = null;
  
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content?.()
    }
    .backgroundColor(this.appColorScheme.surface)
    .borderRadius(this.cornerRadius)
    .border({ width: this.cardBorderWidth, color: this.cardBorderColor })
    .shadow({
      radius: this.elevation.radius,
      color: this.elevation.color,
      offsetY: this.elevation.dy
    })
    .onClick(this.onCardClick ? this.onCardClick : () => {})
  }
}

@Component
struct MapPinView {
  @Consume('appColorScheme') appColorScheme: AppColorScheme;
  @Consume('appTypography') appTypography: AppTypography;
  
  pin: ApprovalPin = new ApprovalPin(0, "", "", 0, 0);
  @Prop selected: boolean;
  onTap: () => void = () => {};

  get pinSize(): number {
    return this.selected ? 28 : 22;
  }

  get baseColor(): ResourceColor {
    switch (this.pin.status) {
      case "Approved": return this.appColorScheme.success;
      case "Pending": return this.appColorScheme.warning;
      case "Rejected": return this.appColorScheme.error;
      default: return Color.Gray;
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Pin 圆点
      Column() {
        Text("")
      }
      .width(this.pinSize)
      .height(this.pinSize)
      .borderRadius(this.pinSize / 2)
      .backgroundColor(this.baseColor)
      .border({ width: 2, color: this.selected ? this.appColorScheme.primary : this.appColorScheme.surface })

      // Pin 旁边的信息卡片
      CardView({
        elevation: ElevationMapping.level1,
        cornerRadius: AppTokens.Shapes.small,
        onCardClick: this.onTap
      }) {
        Text(this.pin.title)
          .fontSize(this.appTypography.labelMedium.size)
          .fontWeight(this.appTypography.labelMedium.weight)
          .fontColor(this.appColorScheme.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      }
      .markAnchor({ x: 0, y: 0 })
      .offset({ x: 18, y: -4 })
    }
  }
}

@Component
struct MapGridOverlay {
  @Consume('appColorScheme') appColorScheme: AppColorScheme;

  build() {
    Stack() {
      // 水平网格线
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Blank()
          Column().height(1).backgroundColor(this.appColorScheme.surfaceVariant).width('100%')
        })
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      // 垂直网格线
      Row() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Blank()
          Column().width(1).backgroundColor(this.appColorScheme.surfaceVariant).height('100%')
        })
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
    }
  }
}