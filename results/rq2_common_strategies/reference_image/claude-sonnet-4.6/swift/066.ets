// ============================================================================
// Stock Calendar — SwiftUI ➜ ArkTS (ArkUI / HarmonyOS)
// 转换说明：SwiftUI 的 EnvironmentValues 主题注入在 ArkTS 中由全局静态 Token
// 类替代；Card / FilterChip 用 @Component + @BuilderParam 自定义组件模拟。
// ============================================================================

// ---------------------------------------------------------------------------
// MARK: - AppTokens (Design System)
// ---------------------------------------------------------------------------

class AppColors {
  static readonly primary: string = '#214E34';
  static readonly secondary: string = '#2D6A4F';
  static readonly tertiary: string = '#6C757D';
  static readonly background: string = '#F8F1E5';
  static readonly surface: string = '#FFFBF0';
  static readonly surfaceVariant: string = '#E9DFC7';
  static readonly outline: string = '#D2C6AA';
  static readonly success: string = '#2B9348';
  static readonly warning: string = '#F4A261';
  static readonly error: string = '#D62828';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#FFFFFF';
  static readonly onTertiary: string = '#1B1F22';
  static readonly onBackground: string = '#1B1F22';
  static readonly onSurface: string = '#1B1F22';
}

class AppTypography {
  // SwiftUI Font.system(size:weight:) 无法携带 lineHeight / letterSpacing，
  // ArkTS 侧同理：字号 + 字重，字距为 0 时无需额外处理。
  static readonly displaySize: number = 26;
  static readonly headlineSize: number = 20;
  static readonly titleSize: number = 16;
  static readonly bodySize: number = 13;
  static readonly labelSize: number = 11;
}

class AppShapes {
  static readonly small: number = 6;
  static readonly medium: number = 10;
  static readonly large: number = 14;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 20;
  static readonly xxl: number = 28;
  static readonly xxxl: number = 40;
}

interface ElevationSpec {
  radius: number;
  dy: number;
  opacity: number;
}

class AppElevation {
  static readonly level1: ElevationSpec = { radius: 3, dy: 1, opacity: 0.10 };
  static readonly level2: ElevationSpec = { radius: 6, dy: 3, opacity: 0.14 };
  static readonly level3: ElevationSpec = { radius: 10, dy: 5, opacity: 0.16 };
  static readonly level4: ElevationSpec = { radius: 14, dy: 7, opacity: 0.18 };
  static readonly level5: ElevationSpec = { radius: 18, dy: 9, opacity: 0.20 };
}

// ---------------------------------------------------------------------------
// MARK: - Data Models
// ---------------------------------------------------------------------------

interface DayTab {
  id: number;
  label: string;
}

interface StockRow {
  code: string;
  name: string;
  price: string;
  change: string;
  positive: boolean;
}

// ---------------------------------------------------------------------------
// MARK: - Custom Components
// ---------------------------------------------------------------------------

/** 模拟 Compose 的 Card：统一容器色 / 圆角 / 阴影 / 描边。 */
@Component
struct CustomCard {
  radius: number = AppShapes.medium;
  containerColor: string = AppColors.surface;
  borderColor: string = AppColors.outline;
  borderWidth: number = 1;
  elevation: ElevationSpec = AppElevation.level1;
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .width('100%')
    .backgroundColor(this.containerColor)
    .borderRadius(this.radius)
    .border({ width: this.borderWidth, color: this.borderColor })
    .shadow({
      radius: this.elevation.radius,
      color: `rgba(0, 0, 0, ${this.elevation.opacity})`,
      offsetX: 0,
      offsetY: this.elevation.dy
    })
  }
}

/** 模拟 Compose 的 FilterChip。 */
@Component
struct CustomFilterChip {
  @Prop selected: boolean = false;
  @Prop label: string = '';
  onChipClick: () => void = () => {};

  build() {
    Row() {
      Text(this.label)
        .fontSize(AppTypography.labelSize)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.selected ? AppColors.onPrimary : AppColors.onSurface)
    }
    .padding({
      left: AppSpacing.md,
      right: AppSpacing.md,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .backgroundColor(this.selected ? AppColors.secondary : AppColors.surface)
    .borderRadius(AppShapes.small)
    .border({ width: 1, color: AppColors.outline })
    .onClick(() => {
      this.onChipClick();
    })
  }
}

// ---------------------------------------------------------------------------
// MARK: - RootScreen
// ---------------------------------------------------------------------------

@Entry
@Component
struct RootScreen {
  @State selectedDayId: number = 1;
  @State currentSector: string = 'All';

  private days: DayTab[] = [
    { id: 1, label: 'Mon' },
    { id: 2, label: 'Tue' },
    { id: 3, label: 'Wed' },
    { id: 4, label: 'Thu' },
    { id: 5, label: 'Fri' }
  ];

  private sectors: string[] = ['All', 'Tech', 'Energy', 'Finance'];

  private items: StockRow[] = [
    { code: '600519', name: 'Kweichow Moutai', price: '1687.3', change: '+1.24%', positive: true },
    { code: '000001', name: 'Ping An Bank', price: '12.54', change: '-0.62%', positive: false },
    { code: '300750', name: 'CATL', price: '192.8', change: '+0.87%', positive: true },
    { code: '601318', name: 'Ping An Ins.', price: '44.2', change: '-1.12%', positive: false },
    { code: '600036', name: 'CMBC', price: '36.9', change: '+0.15%', positive: true },
    { code: '688981', name: 'SMIC', price: '56.4', change: '-0.48%', positive: false }
  ];

  build() {
    Column() {
      // ---------- CenterAlignedTopAppBar ----------
      Row() {
        Text('Stock Calendar')
          .fontSize(AppTypography.displaySize)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.onSurface)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .padding({ top: AppSpacing.xxxl, bottom: AppSpacing.xxxl })
      .backgroundColor(AppColors.background)

      // ---------- 内容区（LazyColumn ➜ Scroll + Column） ----------
      Scroll() {
        Column({ space: AppSpacing.md }) {

          // ===== 日期 + 行业筛选卡片 =====
          CustomCard({
            radius: AppShapes.large,
            containerColor: AppColors.surface,
            elevation: AppElevation.level2
          }) {
            Column({ space: AppSpacing.md }) {
              // 星期选择
              Row({ space: AppSpacing.md }) {
                // 键值中携带选中态，保证状态变化后 ForEach 会重建子组件
                ForEach(this.days, (d: DayTab) => {
                  Row() {
                    Text(d.label)
                      .fontSize(d.id === this.selectedDayId
                        ? AppTypography.titleSize
                        : AppTypography.bodySize)
                      .fontWeight(d.id === this.selectedDayId
                        ? FontWeight.Medium
                        : FontWeight.Normal)
                      .fontColor(d.id === this.selectedDayId
                        ? AppColors.onPrimary
                        : AppColors.onSurface)
                  }
                  .height(36)
                  .layoutWeight(1)
                  .justifyContent(FlexAlign.Center)
                  .backgroundColor(d.id === this.selectedDayId
                    ? AppColors.primary
                    : AppColors.surfaceVariant)
                  .borderRadius(AppShapes.small)
                  .onClick(() => {
                    this.selectedDayId = d.id;
                  })
                }, (d: DayTab) => `${d.id}-${d.id === this.selectedDayId}`)
              }
              .width('100%')

              // 行业筛选
              Row({ space: AppSpacing.sm }) {
                ForEach(this.sectors, (s: string) => {
                  CustomFilterChip({
                    selected: this.currentSector === s,
                    label: s,
                    onChipClick: () => {
                      this.currentSector = s;
                    }
                  })
                }, (s: string) => `${s}-${s === this.currentSector}`)
              }
              .width('100%')
              .justifyContent(FlexAlign.Start)
            }
            .width('100%')
            .padding(AppSpacing.md)
          }

          // ===== 股票列表 =====
          Column({ space: AppSpacing.sm }) {
            ForEach(this.items, (item: StockRow) => {
              CustomCard({
                radius: AppShapes.medium,
                containerColor: AppColors.surface,
                elevation: AppElevation.level1
              }) {
                Row() {
                  // 左：占位方块 + 名称 / 代码
                  Row({ space: AppSpacing.md }) {
                    Row() {
                    }
                    .width(28)
                    .height(28)
                    .backgroundColor(AppColors.surfaceVariant)
                    .borderRadius(AppShapes.small)

                    Column({ space: AppSpacing.xs }) {
                      Text(item.name)
                        .fontSize(AppTypography.titleSize)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppColors.onSurface)
                        .maxLines(2)
                        .textOverflow({ overflow: TextOverflow.Ellipsis })
                      Text(item.code)
                        .fontSize(AppTypography.labelSize)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppColors.onSurface)
                    }
                    .alignItems(HorizontalAlign.Start)
                  }
                  .layoutWeight(1)

                  // 右：价格 / 涨跌 + Detail 按钮
                  Row({ space: AppSpacing.lg }) {
                    Column({ space: AppSpacing.xs }) {
                      Text(item.price)
                        .fontSize(AppTypography.titleSize)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppColors.onSurface)

                      Row({ space: AppSpacing.xs }) {
                        Row() {
                        }
                        .width(8)
                        .height(8)
                        .borderRadius(4)
                        .backgroundColor(item.positive ? AppColors.success : AppColors.error)

                        Text(item.change)
                          .fontSize(AppTypography.labelSize)
                          .fontWeight(FontWeight.Medium)
                          .fontColor(item.positive ? AppColors.success : AppColors.error)
                      }
                      .alignItems(VerticalAlign.Center)
                    }
                    .alignItems(HorizontalAlign.End)

                    Row() {
                      Text('Detail')
                        .fontSize(AppTypography.labelSize)
                        .fontWeight(FontWeight.Medium)
                        .fontColor(AppColors.onPrimary)
                    }
                    .width(76)
                    .height(36)
                    .justifyContent(FlexAlign.Center)
                    .backgroundColor(AppColors.primary)
                    .borderRadius(AppShapes.small)
                    .onClick(() => {
                      // TODO: 跳转个股详情
                    })
                  }
                  .alignItems(VerticalAlign.Center)
                }
                .width('100%')
                .padding(AppSpacing.md)
                .constraintSize({ minHeight: 72 })
                .alignItems(VerticalAlign.Center)
              }
            }, (item: StockRow) => item.code)
          }
          .width('100%')
        }
        .width('100%')
        .alignItems(HorizontalAlign.Start)
        .padding({
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: AppSpacing.xxxl
        })
      }
      .layoutWeight(1)
      .width('100%')
      .align(Alignment.Top)
      .scrollBar(BarState.Off)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    // 隐藏顶部状态栏区域（要求 2）
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}