const AppColors = {
  primary: '#0F172A',
  secondary: '#475569',
  tertiary: '#94A3B8',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#F1F5F9',
  outline: '#E2E8F0',
  success: '#22C55E',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#0F172A',
  onBackground: '#0F172A',
  onSurface: '#0F172A'
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48
}

interface ProductivityItem {
  id: number
  title: string
  status: string
  progress: number
  statusColor: string
}

interface ChartData {
  label: string
  value: number
}

@Component
struct ProductivityCard {
  private item: ProductivityItem = { id: 0, title: '', status: '', progress: 0, statusColor: '' }

  build() {
    Column() {
      Row() {
        Text(this.item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
        Row({ space: AppSpacing.sm }) {
          Column()
            .width(10)
            .height(10)
            .backgroundColor(this.item.statusColor)
            .borderRadius(5)
          Text(this.item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.item.statusColor)
        }
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Blank().height(AppSpacing.md)

      Row({ space: AppSpacing.sm }) {
        Progress({
          value: this.item.progress,
          total: 1,
          type: ProgressType.Linear
        })
          .layoutWeight(1)
          .height(8)
          .color(this.item.statusColor)
          .backgroundColor(AppColors.surfaceVariant)
        Text(`${Math.floor(this.item.progress * 100)}%`)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .width(40)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: 12 })
  }
}

@Entry
@Component
struct Index {
  @State selectedFilter: string = 'Weekly'
  private filters: string[] = ['Daily', 'Weekly', 'Monthly']
  private productivityItems: ProductivityItem[] = [
    { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: '#22C55E' },
    { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: '#F59E0B' },
    { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: '#475569' },
    { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: '#22C55E' },
    { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: '#EF4444' }
  ]
  private chartData: ChartData[] = [
    { label: 'Mon', value: 0.6 }, { label: 'Tue', value: 0.8 }, { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 }, { label: 'Fri', value: 0.7 }, { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 }
  ]

  build() {
    Column() {
      Row() {
        Column().width(24).height(24).backgroundColor(AppColors.outline).borderRadius(12).margin({ left: AppSpacing.md })
        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Column().width(24).height(24).backgroundColor(AppColors.outline).borderRadius(12).margin({ right: AppSpacing.md })
      }
      .width('100%')
      .padding({ top: 12, bottom: 12 })
      .backgroundColor(AppColors.surface)
      .alignItems(VerticalAlign.Center)

      List({ space: AppSpacing.lg }) {
        ListItem() {
          Row() {
            ForEach(this.filters, (filter: string) => {
              Text(filter)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.selectedFilter === filter ? AppColors.onPrimary : AppColors.onSurface)
                .backgroundColor(this.selectedFilter === filter ? AppColors.primary : AppColors.surface)
                .border({ width: 1, color: AppColors.outline, radius: 8 })
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .margin({ right: AppSpacing.sm })
                .onClick(() => { this.selectedFilter = filter })
            }, (filter: string) => filter)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)
        }

        ListItem() {
          this.ChartCard()
        }

        ForEach(this.productivityItems, (item: ProductivityItem) => {
          ListItem() {
            ProductivityCard({ item: item })
          }
        }, (item: ProductivityItem) => item.id.toString())

        ListItem() {
          Blank().height(AppSpacing.lg)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.md)
      .scrollBar(BarState.Off)

      Button('Submit New Form')
        .type(ButtonType.Normal)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(12)
        .width('100%')
        .height(56)
        .margin({ left: AppSpacing.md, right: AppSpacing.md, bottom: AppSpacing.md })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  ChartCard() {
    Column() {
      Text('Weekly Throughput')
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Blank().height(AppSpacing.md)

      Column() {
        Row() {
          ForEach(this.chartData, (data: ChartData, index: number) => {
            Column()
              .width('8%')
              .height(data.value * 130)
              .backgroundColor(AppColors.primary)
              .borderRadius(4)
              .margin({ left: 4, right: 4 })
          }, (data: ChartData, index: number) => index.toString())
        }
        .width('100%')
        .height(130)
        .alignItems(VerticalAlign.Bottom)
        .justifyContent(FlexAlign.SpaceEvenly)

        Blank().height(AppSpacing.sm)

        Row() {
          ForEach(this.chartData, (data: ChartData, index: number) => {
            Text(data.label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.secondary)
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
          }, (data: ChartData, index: number) => index.toString())
        }
        .width('100%')
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
  }
}