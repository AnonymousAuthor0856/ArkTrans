const Colors = {
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
};

const Spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48
};

interface ProductivityItem {
  id: number;
  title: string;
  status: string;
  progress: number;
  statusColor: string;
}

interface ChartData {
  label: string;
  value: number;
}

@Entry
@Component
struct Index {
  @State filters: string[] = ['Daily', 'Weekly', 'Monthly'];
  @State selectedFilter: string = 'Weekly';
  @State productivityItems: ProductivityItem[] = [
    { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, statusColor: Colors.success },
    { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, statusColor: Colors.warning },
    { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, statusColor: Colors.secondary },
    { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, statusColor: Colors.success },
    { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, statusColor: Colors.error }
  ];
  @State chartData: ChartData[] = [
    { label: 'Mon', value: 0.6 },
    { label: 'Tue', value: 0.8 },
    { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 },
    { label: 'Fri', value: 0.7 },
    { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 }
  ];

  build() {
    Column() {
      Row() {
        Column()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(Colors.outline)
        Blank().layoutWeight(1)
        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
        Blank().layoutWeight(1)
        Column()
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor(Colors.outline)
      }
      .width('100%')
      .height(64)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surface)

      Scroll() {
        Column({ space: Spacing.lg }) {
          Row() {
            ForEach(this.filters, (filter: string) => {
              Button(filter)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .letterSpacing(0.5)
                .backgroundColor(this.selectedFilter === filter ? Colors.primary : Colors.surface)
                .fontColor(this.selectedFilter === filter ? Colors.onPrimary : Colors.onSurface)
                .borderRadius(8)
                .border({ width: 1, color: Colors.outline })
                .onClick(() => {
                  this.selectedFilter = filter;
                })
              Blank().width(Spacing.sm)
            }, (filter: string) => filter)
          }
          .width('100%')
          .justifyContent(FlexAlign.Center)

          Column() {
            Text('Weekly Throughput')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .lineHeight(24)
              .letterSpacing(0.15)
              .fontColor(Colors.onSurface)
            Blank().height(Spacing.md)
            Column() {
              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Stack({ alignContent: Alignment.Bottom }) {
                    Column()
                      .width('60%')
                      .height(Math.round(data.value * 100) + '%')
                      .backgroundColor(Colors.primary)
                      .borderRadius(8)
                  }
                  .width('100%')
                  .layoutWeight(1)
                  .height('100%')
                }, (data: ChartData) => data.label)
              }
              .width('100%')
              .layoutWeight(1)

              Blank().height(Spacing.sm)

              Row() {
                ForEach(this.chartData, (data: ChartData) => {
                  Text(data.label)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .letterSpacing(0.5)
                    .fontColor(Colors.secondary)
                    .textAlign(TextAlign.Center)
                    .width('100%')
                    .layoutWeight(1)
                }, (data: ChartData) => data.label)
              }
              .width('100%')
            }
            .width('100%')
            .height(150)
          }
          .width('100%')
          .padding(Spacing.md)
          .backgroundColor(Colors.surface)
          .borderRadius(16)
          .shadow({ radius: 3, color: 'rgba(0, 0, 0, 0.10)', offsetY: 1 })

          ForEach(this.productivityItems, (item: ProductivityItem) => {
            Column() {
              Row() {
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)
                Row({ space: Spacing.sm }) {
                  Column()
                    .width(10)
                    .height(10)
                    .borderRadius(5)
                    .backgroundColor(item.statusColor)
                  Text(item.status)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .letterSpacing(0.5)
                    .fontColor(item.statusColor)
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)

              Blank().height(Spacing.md)

              Row({ space: Spacing.sm }) {
                Progress({ value: Math.round(item.progress * 100), total: 100, type: ProgressType.Linear })
                  .layoutWeight(1)
                  .height(8)
                  .color(item.statusColor)
                  .backgroundColor(Colors.surfaceVariant)
                Text(Math.floor(item.progress * 100) + '%')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .letterSpacing(0.5)
                  .fontColor(Colors.secondary)
                  .textAlign(TextAlign.End)
                  .width(40)
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
            }
            .width('100%')
            .padding(Spacing.md)
            .backgroundColor(Colors.surface)
            .borderRadius(12)
            .border({ width: 1, color: Colors.outline })
          }, (item: ProductivityItem) => item.id.toString())
        }
        .padding(Spacing.md)
      }
      .scrollBar(BarState.Off)
      .layoutWeight(1)

      Column() {
        Button('Submit New Form')
          .width('100%')
          .height(56)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(18)
          .borderRadius(12)
          .onClick(() => {})
          .margin(Spacing.md)
      }
      .width('100%')
      .backgroundColor(Colors.surface)
      .shadow({ radius: 10, color: 'rgba(0, 0, 0, 0.10)', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
