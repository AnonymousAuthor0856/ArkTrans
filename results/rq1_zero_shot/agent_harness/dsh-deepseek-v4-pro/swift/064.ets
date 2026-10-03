// MARK: - AppTokens
const AppTokens = {
  Colors: {
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
  },
  Typography: {
    display: { size: 28, weight: FontWeight.Semibold },
    headline: { size: 20, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Regular },
    label: { size: 12, weight: FontWeight.Medium }
  },
  Shapes: {
    small: 8,
    medium: 12,
    large: 16
  },
  Spacing: {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16
  },
  Shadow: {
    level1: { radius: 4, dy: 2, color: '#1A000000' },
    level2: { radius: 8, dy: 4, color: '#24000000' },
    level3: { radius: 12, dy: 6, color: '#29000000' }
  }
};

// 模拟 MaterialTheme.colorScheme 的全局颜色方案
const colorScheme = {
  primary: AppTokens.Colors.primary,
  onPrimary: AppTokens.Colors.onPrimary,
  secondary: AppTokens.Colors.secondary,
  onSecondary: AppTokens.Colors.onSecondary,
  tertiary: AppTokens.Colors.tertiary,
  onTertiary: AppTokens.Colors.onTertiary,
  background: AppTokens.Colors.background,
  onBackground: AppTokens.Colors.onBackground,
  surface: AppTokens.Colors.surface,
  onSurface: AppTokens.Colors.onSurface,
  surfaceVariant: AppTokens.Colors.surfaceVariant,
  outline: AppTokens.Colors.outline,
  error: AppTokens.Colors.error,
  success: AppTokens.Colors.success,
  warning: AppTokens.Colors.warning
};

// 模拟 MaterialTheme.typography 的全局字体方案
const typography = {
  displayLarge: AppTokens.Typography.display,
  headlineMedium: AppTokens.Typography.headline,
  titleMedium: AppTokens.Typography.title,
  bodyMedium: AppTokens.Typography.body,
  labelMedium: AppTokens.Typography.label
};

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

// MARK: - FilterChipView
@Component
struct FilterChipView {
  @Prop text: string = '';
  @Prop isSelected: boolean = false;
  onTap: () => void = () => {};

  build() {
    Button() {
      Text(this.text)
        .fontSize(this.isSelected ? typography.titleMedium.size : typography.bodyMedium.size)
        .fontWeight(this.isSelected ? typography.titleMedium.weight : typography.bodyMedium.weight)
        .fontColor(this.isSelected ? colorScheme.onPrimary : colorScheme.onSurface)
        .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
        .backgroundColor(this.isSelected ? colorScheme.primary : colorScheme.surface)
        .borderRadius(AppTokens.Shapes.small)
        .border({ width: 1, color: colorScheme.outline })
    }
    .onClick(() => {
      this.onTap();
    })
  }
}

// MARK: - MapPinView
@Component
struct MapPinView {
  @Prop title: string = '';
  @Prop status: string = '';
  @Prop selected: boolean = false;
  onClick: () => void = () => {};

  private pinColor(): string {
    if (this.status === 'Approved') return colorScheme.success;
    if (this.status === 'Pending') return colorScheme.warning;
    if (this.status === 'Rejected') return colorScheme.error;
    return '#808080';
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Row()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .backgroundColor(this.pinColor())
        .borderRadius(this.selected ? 14 : 11)
        .border({ width: 2, color: this.selected ? colorScheme.primary : colorScheme.surface })

      Button() {
        Text(this.title)
          .fontSize(typography.labelMedium.size)
          .fontWeight(typography.labelMedium.weight)
          .fontColor(colorScheme.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(colorScheme.surface)
          .borderRadius(AppTokens.Shapes.small)
          .border({ width: 1, color: colorScheme.outline })
          .shadow({ radius: AppTokens.Shadow.level1.radius, color: AppTokens.Shadow.level1.color, offsetX: 0, offsetY: AppTokens.Shadow.level1.dy })
      }
      .onClick(() => {
        this.onClick();
      })
      .margin({ left: 18, top: -4 })
    }
  }
}

// MARK: - MapGridOverlay
@Component
struct MapGridOverlay {
  private lines: number[] = [1, 2, 3, 4, 5, 6];

  build() {
    Stack() {
      Column() {
        ForEach(this.lines, () => {
          Blank().layoutWeight(1)
          Row()
            .width('100%')
            .height(1)
            .backgroundColor(colorScheme.surfaceVariant)
        })
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

      Row() {
        ForEach(this.lines, () => {
          Blank().layoutWeight(1)
          Column()
            .width(1)
            .height('100%')
            .backgroundColor(colorScheme.surfaceVariant)
        })
        Blank().layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - RootScreen
@Component
struct RootScreen {
  @State filters: string[] = ['Pending', 'Approved'];
  @State activeFilters: string[] = ['Pending'];
  @State pins: ApprovalPin[] = [
    new ApprovalPin(1, 'Purchase Order #1042', 'Pending', 0.18, 0.35),
    new ApprovalPin(2, 'Travel Request #552', 'Approved', 0.52, 0.42),
    new ApprovalPin(3, 'Contract #A77', 'Pending', 0.76, 0.58),
    new ApprovalPin(4, 'Budget Change #09', 'Rejected', 0.33, 0.72)
  ];
  @State selectedPinId: number | null = null;

  private filteredPins(): ApprovalPin[] {
    return this.pins.filter((p: ApprovalPin) => {
      if (p.status === 'Pending') return this.activeFilters.includes('Pending');
      if (p.status === 'Approved') return this.activeFilters.includes('Approved');
      return true;
    });
  }

  private selectedPin(): ApprovalPin | null {
    if (this.selectedPinId === null) return null;
    const found = this.pins.find((p: ApprovalPin) => p.id === this.selectedPinId);
    return found === undefined ? null : found;
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: 0 }) {
        // 顶部栏
        Column() {
          Text('Approval Flow')
            .fontSize(typography.displayLarge.size)
            .fontWeight(typography.displayLarge.weight)
            .fontColor(colorScheme.onSurface)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(colorScheme.surface)

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
                        this.activeFilters = this.activeFilters.filter((x: string) => x !== f);
                      } else {
                        this.activeFilters = this.activeFilters.concat([f]);
                      }
                    }
                  })
                }, (f: string) => f)
              }
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md })

            // 地图区域
            Stack({ alignContent: Alignment.BottomStart }) {
              MapGridOverlay()

              ForEach(this.filteredPins(), (p: ApprovalPin) => {
                MapPinView({
                  title: p.title,
                  status: p.status,
                  selected: this.selectedPinId === p.id,
                  onClick: () => {
                    this.selectedPinId = this.selectedPinId === p.id ? null : p.id;
                  }
                })
                .position({ x: (p.x * 100).toString() + '%', y: (p.y * 100).toString() + '%' })
              }, (p: ApprovalPin) => p.id.toString())

              // 选中 Pin 的详情卡片
              if (this.selectedPin() !== null) {
                Row() {
                  Column({ space: AppTokens.Spacing.xs }) {
                    Text(this.selectedPin()!.title)
                      .fontSize(typography.titleMedium.size)
                      .fontWeight(typography.titleMedium.weight)
                      .fontColor(colorScheme.onSurface)
                    Text(this.selectedPin()!.status)
                      .fontSize(typography.labelMedium.size)
                      .fontWeight(typography.labelMedium.weight)
                      .fontColor(colorScheme.onSurface)
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Button() {
                    Text('Details')
                      .fontSize(typography.labelMedium.size)
                      .fontWeight(typography.labelMedium.weight)
                      .fontColor(colorScheme.onSurface)
                      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                      .height(40)
                      .backgroundColor(colorScheme.surfaceVariant)
                      .borderRadius(AppTokens.Shapes.medium)
                  }
                  .onClick(() => {})
                }
                .alignItems(VerticalAlign.Center)
                .width('100%')
                .padding(AppTokens.Spacing.lg)
                .backgroundColor(colorScheme.surface)
                .borderRadius(AppTokens.Shapes.large)
                .border({ width: 1, color: colorScheme.outline })
                .shadow({ radius: AppTokens.Shadow.level3.radius, color: AppTokens.Shadow.level3.color, offsetX: 0, offsetY: AppTokens.Shadow.level3.dy })
                .margin(AppTokens.Spacing.md)
              }
            }
            .width('100%')
            .height(360)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
          }
        }
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)
        .layoutWeight(1)

        // 底部栏
        Column() {
          Row({ space: AppTokens.Spacing.md }) {
            Button() {
              Text('Reject')
                .fontSize(typography.titleMedium.size)
                .fontWeight(typography.titleMedium.weight)
                .fontColor(colorScheme.onSurface)
                .width('100%')
                .height(48)
                .backgroundColor(colorScheme.surfaceVariant)
                .borderRadius(AppTokens.Shapes.medium)
            }
            .layoutWeight(1)
            .enabled(this.selectedPinId !== null)
            .onClick(() => {})

            Button() {
              Text('Approve')
                .fontSize(typography.titleMedium.size)
                .fontWeight(typography.titleMedium.weight)
                .fontColor(colorScheme.onPrimary)
                .width('100%')
                .height(48)
                .backgroundColor(colorScheme.primary)
                .borderRadius(AppTokens.Shapes.medium)
            }
            .layoutWeight(1)
            .enabled(this.selectedPinId !== null)
            .onClick(() => {})
          }
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .backgroundColor(colorScheme.surface)
        .shadow({ radius: AppTokens.Shadow.level2.radius, color: AppTokens.Shadow.level2.color, offsetX: 0, offsetY: -AppTokens.Shadow.level2.dy })
      }
      .width('100%')
      .height('100%')

      // 浮动操作按钮
      Button() {
        Text('+')
          .fontSize(typography.headlineMedium.size)
          .fontWeight(typography.headlineMedium.weight)
          .fontColor(colorScheme.onPrimary)
          .width(56)
          .height(56)
          .backgroundColor(colorScheme.primary)
          .borderRadius(28)
      }
      .onClick(() => {})
      .margin({ right: AppTokens.Spacing.lg, bottom: 90 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorScheme.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.ALL])
  }
}

// MARK: - ApprovalFlowApp
@Entry
@Component
struct ApprovalFlowApp {
  build() {
    RootScreen()
  }
}
