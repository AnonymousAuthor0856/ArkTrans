const NAME: string = '029_OCRCheckProductivityForm_en'
const UI_TYPE: string = 'Dashboard'
const STYLE_THEME: string = 'Monochrome Comfortable'
const LANG: string = 'en'
const BASELINE_SIZE: string = '720x1280'

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

class AppRadius {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 3, 1, 0.10)
  static readonly level2: ShadowSpec = new ShadowSpec(3, 6, 2, 0.10)
  static readonly level3: ShadowSpec = new ShadowSpec(6, 10, 4, 0.10)
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
struct AppText {
  text: string = ''
  type: string = 'body'
  color: string = AppColors.onSurface
  textAlign: TextAlign = TextAlign.Start

  build() {
    Text(this.text)
      .fontColor(this.color)
      .textAlign(this.textAlign)
      .fontSize(this.getFontSize())
      .fontWeight(this.getFontWeight())
      .lineHeight(this.getLineHeight())
  }

  private getFontSize(): number {
    if (this.type === 'display') {
      return 32
    }
    if (this.type === 'headline') {
      return 24
    }
    if (this.type === 'title') {
      return 18
    }
    if (this.type === 'label') {
      return 14
    }
    return 16
  }

  private getLineHeight(): number {
    if (this.type === 'display') {
      return 40
    }
    if (this.type === 'headline') {
      return 32
    }
    if (this.type === 'title') {
      return 24
    }
    if (this.type === 'label') {
      return 18
    }
    return 22
  }

  private getFontWeight(): FontWeight {
    if (this.type === 'display') {
      return FontWeight.Bold
    }
    if (this.type === 'headline') {
      return FontWeight.SemiBold
    }
    if (this.type === 'title' || this.type === 'label') {
      return FontWeight.Medium
    }
    return FontWeight.Normal
  }
}

@Component
struct FilterChipView {
  label: string = ''
  selected: boolean = false
  onTapAction: () => void = () => {
  }

  build() {
    Text(this.label)
      .fontSize(14)
      .fontWeight(FontWeight.Medium)
      .lineHeight(18)
      .fontColor(this.selected ? AppColors.onPrimary : AppColors.onSurface)
      .padding({ left: 14, right: 14, top: 8, bottom: 8 })
      .backgroundColor(this.selected ? AppColors.primary : AppColors.surface)
      .borderRadius(AppRadius.small)
      .border({
        width: 1,
        color: AppColors.outline
      })
      .onClick(() => {
        this.onTapAction()
      })
  }
}

@Component
struct WeeklyThroughputCard {
  chartData: ChartData[] = []

  build() {
    Column() {
      AppText({
        text: 'Weekly Throughput',
        type: 'title',
        color: AppColors.onSurface
      })

      Column() {
        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Column() {
              Blank()
                .layoutWeight(1)

              Column()
                .width('60%')
                .height(120 * data.value)
                .backgroundColor(AppColors.primary)
                .borderRadius(AppRadius.small)
            }
            .layoutWeight(1)
            .height('100%')
            .alignItems(HorizontalAlign.Center)
            .justifyContent(FlexAlign.End)
          }, (data: ChartData) => data.label)
        }
        .width('100%')
        .height(120)
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.SpaceBetween)

        Row() {
          ForEach(this.chartData, (data: ChartData) => {
            Text(data.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .lineHeight(18)
              .fontColor(AppColors.secondary)
              .textAlign(TextAlign.Center)
              .layoutWeight(1)
          }, (data: ChartData) => data.label)
        }
        .width('100%')
        .margin({ top: AppSpacing.sm })
      }
      .width('100%')
      .height(150)
      .margin({ top: AppSpacing.md })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.large)
    .shadow({
      radius: AppElevation.level1.radius,
      color: '#1A000000',
      offsetX: 0,
      offsetY: AppElevation.level1.dy
    })
  }
}

@Component
struct ProductivityCard {
  item: ProductivityItem = new ProductivityItem(0, '', '', 0, AppColors.secondary)

  build() {
    Column() {
      Row() {
        AppText({
          text: this.item.title,
          type: 'title',
          color: AppColors.onSurface
        })

        Row() {
          Circle()
            .width(10)
            .height(10)
            .fill(this.item.statusColor)

          AppText({
            text: this.item.status,
            type: 'label',
            color: this.item.statusColor
          })
        }
        .alignItems(VerticalAlign.Center)
        .gap(AppSpacing.sm)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)

      Row() {
        Stack({ alignContent: Alignment.Start }) {
          Row()
            .width('100%')
            .height(8)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(999)

          Row()
            .width(`${this.item.progress * 100}%`)
            .height(8)
            .backgroundColor(this.item.statusColor)
            .borderRadius(999)
        }
        .height(8)
        .layoutWeight(1)

        Text(`${Math.floor(this.item.progress * 100)}%`)
          .width(40)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .lineHeight(18)
          .fontColor(AppColors.secondary)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .gap(AppSpacing.sm)
      .margin({ top: AppSpacing.md })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppRadius.medium)
    .border({
      width: 1,
      color: AppColors.outline
    })
  }
}

@Component
struct TopBar {
  build() {
    Row() {
      Button() {
        Circle()
          .width(24)
          .height(24)
          .fill(AppColors.outline)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .padding(0)

      Text('Productivity Check')
        .fontSize(24)
        .fontWeight(FontWeight.SemiBold)
        .lineHeight(32)
        .fontColor(AppColors.onSurface)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)

      Button() {
        Circle()
          .width(24)
          .height(24)
          .fill(AppColors.outline)
      }
      .width(48)
      .height(48)
      .backgroundColor(Color.Transparent)
      .padding(0)
    }
    .width('100%')
    .height(64)
    .padding({ left: 4, right: 4 })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct BottomBar {
  build() {
    Column() {
      Button('Submit New Form')
        .width('100%')
        .height(56)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppRadius.medium)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .shadow({
      radius: AppElevation.level3.radius,
      color: '#1A000000',
      offsetX: 0,
      offsetY: -AppElevation.level3.dy
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

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        TopBar()

        List({ space: AppSpacing.lg }) {
          ListItem() {
            Row() {
              ForEach(this.filters, (filter: string) => {
                FilterChipView({
                  label: filter,
                  selected: this.selectedFilter === filter,
                  onTapAction: () => {
                    this.selectedFilter = filter
                  }
                })
                  .margin({ right: AppSpacing.sm })
              }, (filter: string) => filter)
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
          }

          ListItem() {
            WeeklyThroughputCard({
              chartData: this.chartData
            })
          }

          ForEach(this.productivityItems, (item: ProductivityItem) => {
            ListItem() {
              ProductivityCard({
                item: item
              })
            }
          }, (item: ProductivityItem) => item.id.toString())
        }
        .width('100%')
        .layoutWeight(1)
        .padding({
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.md,
          bottom: 104
        })
        .backgroundColor(AppColors.background)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}