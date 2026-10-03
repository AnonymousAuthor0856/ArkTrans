import { ResourceColor } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  @State selectedFilter: number = 1

  private filters: string[] = ['Daily', 'Weekly', 'Monthly']
  
  private chartData: ChartDataItem[] = [
    { label: 'Mon', value: 0.5 },
    { label: 'Tue', value: 0.7 },
    { label: 'Wed', value: 0.4 },
    { label: 'Thu', value: 1.0 },
    { label: 'Fri', value: 0.6 },
    { label: 'Sat', value: 0.3 },
    { label: 'Sun', value: 0.2 }
  ]

  private productivityItems: ProductivityItem[] = [
    { title: 'Form Batch #A-102', status: 'Completed', statusColor: 0x22C55E as ResourceColor, progress: 1.0 },
    { title: 'Invoice Set #B-231', status: 'In Progress', statusColor: 0xF59E0B as ResourceColor, progress: 0.75 }
  ]

  build() {
    Stack() {
      Column() {
        // Top Bar
        Row() {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#E2E8F0')
          }.padding({ left: 16 })

          Blank()

          Text('Productivity Check')
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#0F172A')

          Blank()

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#E2E8F0')
          }.padding({ right: 16 })
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 10, color: '#0D000000', offsetY: 4 })
        .zIndex(1)

        // Scrollable Content
        Scroll() {
          Column() {
            // Filter Tabs
            Row() {
              ForEach(this.filters, (item: string, index: number) => {
                this.buildFilterTab(item, index)
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .margin({ top: 16, bottom: 16 })

            // Weekly Throughput Card
            Column() {
              Text('Weekly Throughput')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#0F172A')
                .alignSelf(ItemAlign.Start)
                .margin({ bottom: 24 })

              Column() {
                // Bars
                Row() {
                  ForEach(this.chartData, (data: ChartDataItem) => {
                    this.buildChartBar(data)
                  })
                }
                .width('100%')
                .height(180)
                .alignItems(VerticalAlign.Bottom)
              }
            }
            .width('100%')
            .padding(24)
            .backgroundColor('#FFFFFF')
            .borderRadius(24)
            .shadow({ radius: 10, color: '#0D000000', offsetY: 4 })

            // Productivity Items
            ForEach(this.productivityItems, (item: ProductivityItem) => {
              this.buildProductivityItem(item)
            })
            
            Blank().height(100) // Spacer for bottom bar
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
        }
        .backgroundColor('#F8FAFC')
        .layoutWeight(1)

        // Bottom Bar
        Column() {
          Button('Submit New Form')
            .width('100%')
            .height(56)
            .backgroundColor('#0F172A')
            .fontColor('#FFFFFF')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .borderRadius(16)
        }
        .width('100%')
        .padding(16)
        .backgroundColor('#FFFFFF')
        .shadow({ radius: 10, color: '#0D000000', offsetY: -4 })
        .zIndex(1)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  buildFilterTab(item: string, index: number) {
    Column() {
      Text(item)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(index === this.selectedFilter ? '#FFFFFF' : '#0F172A')
        .padding({ left: 24, right: 24, top: 10, bottom: 10 })
        .borderRadius(8)
        .backgroundColor(index === this.selectedFilter ? '#0F172A' : '#FFFFFF')
        .border({ width: 1, color: '#E2E8F0', radius: 8 })
        .onClick(() => {
          this.selectedFilter = index
        })
    }
    if (index < this.filters.length - 1) {
      Blank().width(8)
    }
  }

  @Builder
  buildChartBar(data: ChartDataItem) {
    Column() {
      Rect()
        .width(24)
        .height(150 * data.value)
        .fill('#0F172A')
        .borderRadius(12)
        .margin({ bottom: 8 })
      
      Text(data.label)
        .fontSize(14)
        .fontColor('#64748B')
    }
    .layoutWeight(1)
    .justifyContent(FlexAlign.End)
  }

  @Builder
  buildProductivityItem(item: ProductivityItem) {
    Column() {
      Row() {
        Text(item.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
        
        Blank()

        Row() {
          Circle()
            .width(10)
            .height(10)
            .fill(item.statusColor)
          
          Text(item.status)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(item.statusColor)
            .margin({ left: 8 })
        }
      }
      .width('100%')
      .margin({ bottom: 16 })

      Row() {
        Stack({ alignContent: Alignment.Start }) {
          Rect()
            .width('100%')
            .height(8)
            .fill('#F1F5F9')
            .borderRadius(4)
          
          Rect()
            .width(`${item.progress * 100}%`)
            .height(8)
            .fill(item.statusColor)
            .borderRadius(4)
        }
        .layoutWeight(1)

        Text(`${Math.round(item.progress * 100)}%`)
          .fontSize(14)
          .fontColor('#64748B')
          .textAlign(TextAlign.End)
          .width(40)
          .margin({ left: 12 })
      }
      .width('100%')
    }
    .width('100%')
    .padding(24)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#E2E8F0', radius: 16 })
    .margin({ bottom: 16 })
  }
}

interface ChartDataItem {
  label: string;
  value: number;
}

interface ProductivityItem {
  title: string;
  status: string;
  statusColor: ResourceColor;
  progress: number;
}