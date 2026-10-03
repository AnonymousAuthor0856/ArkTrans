// AppTokens.ets
// 统一管理应用程序的颜色、字体、形状、间距和阴影规范，方便修改和维护。

export class AppTokens {
  static readonly Colors = {
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
  }

  static readonly Typography = {
    display: { size: 28, weight: FontWeight.Medium },
    headline: { size: 20, weight: FontWeight.Normal },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static readonly Shapes = {
    small: 8,
    medium: 12,
    large: 16
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16
  }

  static readonly Elevation = {
    level1: { radius: 4, color: '#1A000000', offsetX: 0, offsetY: 2 },
    level2: { radius: 8, color: '#24000000', offsetX: 0, offsetY: 4 },
    level3: { radius: 12, color: '#29000000', offsetX: 0, offsetY: 6 }
  }
}

// MARK: - 数据模型
export class ApprovalPin {
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
  @State filters: string[] = ["Pending", "Approved"];
  @State activeFilters: string[] = ["Pending"];
  @State pins: ApprovalPin[] = [
    new ApprovalPin(1, "Purchase Order #1042", "Pending", 0.18, 0.35),
    new ApprovalPin(2, "Travel Request #552", "Approved", 0.52, 0.42),
    new ApprovalPin(3, "Contract #A77", "Pending", 0.76, 0.58),
    new ApprovalPin(4, "Budget Change #09", "Rejected", 0.33, 0.72)
  ];
  @State selectedPinId: number | null = null;

  toggleFilter(filter: string) {
    if (this.activeFilters.includes(filter)) {
      this.activeFilters = this.activeFilters.filter(f => f !== filter);
    } else {
      this.activeFilters.push(filter);
    }
  }

  getPinColor(status: string): string {
    switch (status) {
      case "Approved": return AppTokens.Colors.success;
      case "Pending": return AppTokens.Colors.warning;
      case "Rejected": return AppTokens.Colors.error;
      default: return '#808080';
    }
  }

  getFilteredPins(): ApprovalPin[] {
    return this.pins.filter(p => {
      switch (p.status) {
        case "Pending": return this.activeFilters.includes("Pending");
        case "Approved": return this.activeFilters.includes("Approved");
        case "Rejected": return true;
        default: return true;
      }
    });
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 背景色
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)
        .position({ x: 0, y: 0 })

      // 主内容列
      Column() {
        // 顶部栏
        Column() {
          Text("Approval Flow")
            .fontSize(AppTokens.Typography.display.size)
            .fontWeight(AppTokens.Typography.display.weight)
            .fontColor(AppTokens.Colors.onSurface)
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        .backgroundColor(AppTokens.Colors.surface)

        // 可滚动内容区域
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // 筛选器
            Scroll({ scrollable: ScrollDirection.Horizontal, scrollbar: BarState.Off }) {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (f: string) => {
                  FilterChipView({
                    text: f,
                    isSelected: this.activeFilters.includes(f),
                    onTap: () => this.toggleFilter(f)
                  })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .width('100%')
            .padding({ top: AppTokens.Spacing.md })

            // 地图区域
            Stack() {
              MapGridOverlay()

              // 审批 Pin 点
              ForEach(this.getFilteredPins(), (p: ApprovalPin) => {
                MapPinView({
                  pin: p,
                  selected: this.selectedPinId === p.id,
                  onClick: () => {
                    this.selectedPinId = this.selectedPinId === p.id ? null : p.id;
                  }
                })
                .markAnchor({ x: 0, y: 0 }) // 对应 topLeading
                .position({ x: '100%' * p.x, y: '100%' * p.y }) // 相对父容器百分比定位
              }, (p: ApprovalPin) => p.id.toString())

              // 选中 Pin 的详情卡片
              if (this.selectedPinId !== null) {
                const sel = this.pins.find(p => p.id === this.selectedPinId);
                if (sel) {
                  Column() {
                    Blank()
                    CardView({
                      elevation: AppTokens.Elevation.level3,
                      cornerRadius: AppTokens.Shapes.large,
                      borderWidth: 1,
                      borderColor: AppTokens.Colors.outline
                    }) {
                      Row() {
                        Column() {
                          Text(sel.title)
                            .fontSize(AppTokens.Typography.title.size)
                            .fontWeight(AppTokens.Typography.title.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                          Text(sel.status)
                            .fontSize(AppTokens.Typography.label.size)
                            .fontWeight(AppTokens.Typography.label.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                            .margin({ top: AppTokens.Spacing.xs })
                        }
                        .alignItems(HorizontalAlign.Start)

                        Blank()

                        Row({ space: AppTokens.Spacing.sm }) {
                          Button("Details") {}
                            .fontSize(AppTokens.Typography.label.size)
                            .fontWeight(AppTokens.Typography.label.weight)
                            .fontColor(AppTokens.Colors.onSurface)
                            .height(40)
                            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
                            .backgroundColor(AppTokens.Colors.surfaceVariant)
                            .borderRadius(AppTokens.Shapes.medium)
                        }
                      }
                      .width('100%')
                      .padding(AppTokens.Spacing.lg)
                    }
                    .width('100%')
                    .padding(AppTokens.Spacing.md)
                  }
                  .width('100%')
                  .height('100%')
                }
              }
            }
            .width('100%')
            .aspectRatio(0.9)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.large)
            .border({ width: 1, color: AppTokens.Colors.outline })
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.md })
          }
        }
        .layoutWeight(1)
        .scrollable(ScrollDirection.Vertical)
        .scrollBar(BarState.Off)

        // 底部栏
        Column() {
          Row({ space: AppTokens.Spacing.md }) {
            Button("Reject") {}
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onSurface)
              .layoutWeight(1)
              .height(48)
              .backgroundColor(AppTokens.Colors.surfaceVariant)
              .borderRadius(AppTokens.Shapes.medium)
              .enabled(this.selectedPinId !== null)

            Button("Approve") {}
              .fontSize(AppTokens.Typography.title.size)
              .fontWeight(AppTokens.Typography.title.weight)
              .fontColor(AppTokens.Colors.onPrimary)
              .layoutWeight(1)
              .height(48)
              .backgroundColor(AppTokens.Colors.primary)
              .borderRadius(AppTokens.Shapes.medium)
              .enabled(this.selectedPinId !== null)
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .width('100%')
        .backgroundColor(AppTokens.Colors.surface)
        .shadow({
          radius: AppTokens.Elevation.level2.radius,
          color: AppTokens.Elevation.level2.color,
          offsetX: AppTokens.Elevation.level2.offsetX,
          offsetY: AppTokens.Elevation.level2.offsetY
        })
      }
      .width('100%')
      .height('100%')

      // 浮动操作按钮
      Column() {
        Blank()
        Row() {
          Blank()
          Button("+") {}
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onPrimary)
            .width(56)
            .height(56)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(28)
            .margin(AppTokens.Spacing.lg)
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - 可复用 UI 组件

// FilterChipView
@Component
struct FilterChipView {
  @Prop text: string;
  @Prop isSelected: boolean;
  onTap: () => void = () => {};

  build() {
    Button(this.text, () => this.onTap())
      .fontSize(this.isSelected ? AppTokens.Typography.title.size : AppTokens.Typography.body.size)
      .fontWeight(this.isSelected ? AppTokens.Typography.title.weight : AppTokens.Typography.body.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onPrimary : AppTokens.Colors.onSurface)
      .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      .backgroundColor(this.isSelected ? AppTokens.Colors.primary : AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

// CardView
@Component
struct CardView {
  @Prop elevation: any;
  @Prop cornerRadius: number = AppTokens.Shapes.small;
  @Prop borderWidth: number = 1;
  @Prop borderColor: string = AppTokens.Colors.outline;
  @BuilderParam content: () => void;

  build() {
    Column() {
      this.content()
    }
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(this.cornerRadius)
    .border({ width: this.borderWidth, color: this.borderColor })
    .shadow({
      radius: this.elevation.radius,
      color: this.elevation.color,
      offsetX: this.elevation.offsetX,
      offsetY: this.elevation.offsetY
    })
  }
}

// MapPinView
@Component
struct MapPinView {
  @Prop pin: ApprovalPin;
  @Prop selected: boolean;
  onClick: () => void = () => {};

  getPinColor(): string {
    switch (this.pin.status) {
      case "Approved": return AppTokens.Colors.success;
      case "Pending": return AppTokens.Colors.warning;
      case "Rejected": return AppTokens.Colors.error;
      default: return '#808080';
    }
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Pin 圆点
      Circle()
        .width(this.selected ? 28 : 22)
        .height(this.selected ? 28 : 22)
        .fill(this.getPinColor())
        .border({ width: 2, color: this.selected ? AppTokens.Colors.primary : AppTokens.Colors.surface })

      // Pin 旁边的信息卡片
      CardView({
        elevation: AppTokens.Elevation.level1,
        cornerRadius: AppTokens.Shapes.small,
        borderWidth: 1,
        borderColor: AppTokens.Colors.outline
      }) {
        Text(this.pin.title)
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
      }
      .markAnchor({ x: 0, y: 0 })
      .offset({ x: 18, y: -4 })
    }
    .markAnchor({ x: 0, y: 0 })
  }
}

// MapGridOverlay
@Component
struct MapGridOverlay {
  build() {
    Stack() {
      // 水平网格线
      Column() {
        ForEach([0, 1, 2, 3, 4, 5], () => {
          Blank()
          Rect()
            .width('100%')
            .height(1)
            .fill(AppTokens.Colors.surfaceVariant)
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
          Rect()
            .width(1)
            .height('100%')
            .fill(AppTokens.Colors.surfaceVariant)
        })
        Blank()
      }
      .width('100%')
      .height('100%')
      .padding({ top: AppTokens.Spacing.lg, bottom: AppTokens.Spacing.lg })
    }
    .width('100%')
    .height('100%')
  }
}