class AppColors {
  static readonly primary: string = '#0F172A'
  static readonly secondary: string = '#475569'
  static readonly tertiary: string = '#94A3B8'
  static readonly background: string = '#F8FAFC'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F1F5F9'
  static readonly outline: string = '#E2E8F0'
  static readonly success: string = '#22C55E'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#0F172A'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#0F172A'
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 16
  static readonly lg: number = 24
  static readonly xl: number = 32
  static readonly xxl: number = 48
}

class AppShapes {
  static readonly smallCornerRadius: number = 8
  static readonly mediumCornerRadius: number = 12
  static readonly largeCornerRadius: number = 16
}

class ShadowSpec {
  radius: number
  dy: number
  opacityColor: string

  constructor(radius: number, dy: number, opacityColor: string) {
    this.radius = radius
    this.dy = dy
    this.opacityColor = opacityColor
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(3, 1, '#1A000000')
  static readonly level2: ShadowSpec = new ShadowSpec(6, 2, '#1A000000')
  static readonly level3: ShadowSpec = new ShadowSpec(10, 4, '#1A000000')
}

class ProductivityItem {
  id: number
  title: string
  status: string
  progress: number
  statusColor: string

  constructor(id: number, title: string, status: string, progress: number, statusColor: string) {
    this.id = id
    this.title = title
    this.status = status
    this.progress = progress
    this.statusColor = statusColor
  }
}

class ChartData {
  label: string
  value: number

  constructor(label: string, value: number) {
    this.label = label
    this.value = value
  }
}

@Component
struct FilterChip {
  title: string = ''
  isSelected: boolean = false
  onChipClick: () => void = () => {
  }

  build() {
    Row() {
      Text(this.title)
        .fontSize(14)
        .fontWeight(FontWeight.Medium)
        .lineHeight(18)
        .letterSpacing(0.5)
        .fontColor(this.isSelected ? AppColors.onPrimary : AppColors.onSurface)
    }
    .padding({
      left: AppSpacing.md,
      right: AppSpacing.md,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .backgroundColor(this.isSelected ? AppColors.primary : AppColors.surface)
    .borderRadius(AppShapes.smallCornerRadius)
    .border({
      width: 1,
      color: AppColors.outline
    })
    .onClick(() => {
      this.onChipClick()
    })
  }
}

@Component
struct CustomLinearProgressIndicator {
  progress: number = 0
  color: string = AppColors.primary
  trackColor: string = AppColors.surfaceVariant
  barHeight: number = 8

  private percent(): string {
    const value: number = Math.max(0, Math.min(1, this.progress))
    return `${value * 100}%`
  }

  build() {
    Row() {
      Column()
        .width(this.percent())
        .height(this.barHeight)
        .backgroundColor(this.color)
        .borderRadius(this.barHeight / 2)
    }
    .justifyContent(FlexAlign.Start)
    .width('100%')
    .height(this.barHeight)
    .backgroundColor(this.trackColor)
    .borderRadius(this.barHeight / 2)
    .clip(true)
  }
}

@Component
struct ChartCard {
  chartData: ChartData[] = []

  build() {
    Column() {
      Text('Weekly Throughput')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .lineHeight(24)
        .letterSpacing(0.15)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .margin({ bottom: AppSpacing.md })

      Column({ space: AppSpacing.sm }) {
        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Column() {
              Column()
                .width(54)
                .height(150 * data.value)
                .backgroundColor(AppColors.primary)
                .borderRadius(AppShapes.smallCornerRadius)
            }
            .height(150)
            .layoutWeight(1)
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.End)
          }, (data: ChartData) => data.label)
        }
        .width('100%')
        .height(150)
        .alignItems(VerticalAlign.Bottom)

        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Text(data.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .lineHeight(18)
              .letterSpacing(0.5)
              .fontColor(AppColors.secondary)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
          }, (data: ChartData) => data.label)
        }
        .width('100%')
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.largeCornerRadius)
    .shadow({
      radius: AppElevation.level1.radius,
      color: AppElevation.level1.opacityColor,
      offsetX: 0,
      offsetY: AppElevation.level1.dy
    })
  }
}

@Component
struct ProductivityCard {
  item: ProductivityItem = new ProductivityItem(0, '', '', 0, AppColors.primary)

  build() {
    Column() {
      Row() {
        Text(this.item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .lineHeight(24)
          .letterSpacing(0.15)
          .fontColor(AppColors.onSurface)
          .maxLines(1)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .layoutWeight(1)

        Row({ space: AppSpacing.sm }) {
          Circle()
            .width(10)
            .height(10)
            .fill(this.item.statusColor)

          Text(this.item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .lineHeight(18)
            .letterSpacing(0.5)
            .fontColor(this.item.statusColor)
            .maxLines(1)
        }
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppSpacing.md })

      Row({ space: AppSpacing.sm }) {
        CustomLinearProgressIndicator({
          progress: this.item.progress,
          color: this.item.statusColor,
          trackColor: AppColors.surfaceVariant,
          barHeight: 8
        })
          .layoutWeight(1)

        Text(`${Math.floor(this.item.progress * 100)}%`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .lineHeight(18)
          .letterSpacing(0.5)
          .fontColor(AppColors.secondary)
          .textAlign(TextAlign.End)
          .width(40)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.mediumCornerRadius)
    .border({
      width: 1,
      color: AppColors.outline
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = 'Weekly'

  private filters: string[] = ['Daily', 'Weekly', 'Monthly']

  private productivityItems: ProductivityItem[] = [
    new ProductivityItem(1, 'Form Batch #A-102', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(2, 'Invoice Set #B-231', 'In Progress', 0.75, AppColors.warning),
    new ProductivityItem(3, 'Document Scan #C-456', 'Pending', 0.1, AppColors.secondary),
    new ProductivityItem(4, 'Form Batch #A-103', 'Completed', 1.0, AppColors.success),
    new ProductivityItem(5, 'Data Entry #D-789', 'Failed', 0.4, AppColors.error)
  ]

  private chartData: ChartData[] = [
    new ChartData('Mon', 0.6),
    new ChartData('Tue', 0.8),
    new ChartData('Wed', 0.5),
    new ChartData('Thu', 1.0),
    new ChartData('Fri', 0.7),
    new ChartData('Sat', 0.4),
    new ChartData('Sun', 0.2)
  ]

  private topBarHeight: number = 56
  private bottomBarButtonHeight: number = 56
  private bottomBarPadding: number = AppSpacing.md

  build() {
    Column() {
      Row() {
        Circle()
          .width(24)
          .height(24)
          .fill(AppColors.outline)
          .margin({ left: AppSpacing.md })
          .onClick(() => {
          })

        Blank()
          .layoutWeight(1)

        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .lineHeight(32)
          .fontColor(AppColors.onSurface)
          .maxLines(1)

        Blank()
          .layoutWeight(1)

        Circle()
          .width(24)
          .height(24)
          .fill(AppColors.outline)
          .margin({ right: AppSpacing.md })
          .onClick(() => {
          })
      }
      .width('100%')
      .height(this.topBarHeight)
      .backgroundColor(AppColors.surface)
      .alignItems(VerticalAlign.Center)
      .shadow({
        radius: AppElevation.level3.radius,
        color: AppElevation.level3.opacityColor,
        offsetX: 0,
        offsetY: AppElevation.level3.dy
      })

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Row({ space: AppSpacing.sm }) {
            ForEach(this.filters, (filter: string) => {
              FilterChip({
                title: filter,
                isSelected: this.selectedFilter === filter,
                onChipClick: () => {
                  this.selectedFilter = filter
                }
              })
            }, (filter: string) => filter)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
          .padding({ left: AppSpacing.md, right: AppSpacing.md })

          ChartCard({ chartData: this.chartData })
            .margin({ left: AppSpacing.md, right: AppSpacing.md })

          ForEach(this.productivityItems, (item: ProductivityItem) => {
            ProductivityCard({ item: item })
              .margin({ left: AppSpacing.md, right: AppSpacing.md })
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .padding({
          top: AppSpacing.md,
          bottom: this.bottomBarButtonHeight + this.bottomBarPadding * 2
        })
      }
      .layoutWeight(1)
      .width('100%')
      .backgroundColor(AppColors.background)
      .scrollBar(BarState.Off)

      Column() {
        Row() {
          Text('Submit New Form')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .lineHeight(24)
            .letterSpacing(0.15)
            .fontColor(AppColors.onPrimary)
        }
        .width('100%')
        .height(this.bottomBarButtonHeight)
        .justifyContent(FlexAlign.Center)
        .alignItems(VerticalAlign.Center)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.mediumCornerRadius)
        .onClick(() => {
        })
      }
      .width('100%')
      .padding(AppSpacing.md)
      .backgroundColor(AppColors.surface)
      .shadow({
        radius: AppElevation.level3.radius,
        color: AppElevation.level3.opacityColor,
        offsetX: 0,
        offsetY: -AppElevation.level3.dy
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}