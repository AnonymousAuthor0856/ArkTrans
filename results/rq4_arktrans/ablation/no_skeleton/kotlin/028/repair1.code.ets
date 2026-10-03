@Entry
@Component
struct ProductivityCheck {
  @State selectedFilter: string = 'Weekly'

  private readonly filters: string[] = ['Daily', 'Weekly', 'Monthly']
  
  private readonly chartData: ChartDataItem[] = [
    { label: 'Mon', value: 0.6 },
    { label: 'Tue', value: 0.8 },
    { label: 'Wed', value: 0.5 },
    { label: 'Thu', value: 1.0 },
    { label: 'Fri', value: 0.7 },
    { label: 'Sat', value: 0.4 },
    { label: 'Sun', value: 0.2 }
  ]

  private readonly productivityItems: ProductivityItem[] = [
    { id: 1, title: 'Form Batch #A-102', status: 'Completed', progress: 1.0, color: '#22C55E' },
    { id: 2, title: 'Invoice Set #B-231', status: 'In Progress', progress: 0.75, color: '#F59E0B' },
    { id: 3, title: 'Document Scan #C-456', status: 'Pending', progress: 0.1, color: '#475569' },
    { id: 4, title: 'Form Batch #A-103', status: 'Completed', progress: 1.0, color: '#22C55E' },
    { id: 5, title: 'Data Entry #D-789', status: 'Failed', progress: 0.4, color: '#EF4444' }
  ]

  build() {
    Column() {
      // Header
      Row() {
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor('#E2E8F0')
        
        Blank()
        
        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.SemiBold)
          .fontColor('#0F172A')
        
        Blank()
        
        Image($r('app.media.startIcon'))
          .width(24)
          .height(24)
          .borderRadius(12)
          .backgroundColor('#E2E8F0')
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .backgroundColor('#FFFFFF')

      // Filters
      Row() {
        ForEach(this.filters, (filter: string) => {
          Button() {
            Text(filter)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedFilter === filter ? '#FFFFFF' : '#0F172A')
          }
          .width('auto')
          .height(36)
          .margin({ right: 8 })
          .backgroundColor(this.selectedFilter === filter ? '#0F172A' : '#FFFFFF')
          .borderWidth(1)
          .borderColor('#E2E8F0')
          .borderRadius(8)
          .onClick(() => {
            this.selectedFilter = filter
          })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ top: 16, bottom: 16 })

      // Content List
      List({ space: 16 }) {
        // Weekly Throughput Card
        ListItem() {
          Column() {
            Text('Weekly Throughput')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#0F172A')
            
            Column() {
              Row() {
                ForEach(this.chartData, (data: ChartDataItem) => {
                  Column() {
                    Blank()
                    Column() {
                      // Bar
                      Column() {
                        Text(data.label)
                          .fontSize(14)
                          .fontWeight(FontWeight.Medium)
                          .fontColor('#475569')
                          .textAlign(TextAlign.Center)
                      }
                      .width('100%')
                      .height(24)
                      
                      // Spacer for bar height calculation
                      Column() {
                        // The bar itself
                        Column() {
                          // Empty container to act as the bar
                        }
                        .width('60%')
                        .height(`${data.value * 100}%`)
                        .backgroundColor('#0F172A')
                        .borderRadius(8)
                      }
                      .layoutWeight(1)
                      .justifyContent(FlexAlign.End)
                    }
                    .layoutWeight(1)
                  }
                  .layoutWeight(1)
                  .justifyContent(FlexAlign.End)
                })
              }
              .height(150)
              
              Row() {
                ForEach(this.chartData, (data: ChartDataItem) => {
                  Text(data.label)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#475569')
                    .textAlign(TextAlign.Center)
                    .layoutWeight(1)
                })
              }
              .width('100%')
              .margin({ top: 8 })
            }
            .width('100%')
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 3, color: '#1A000000', offsetY: 1 })
        }

        // Productivity Items
        ForEach(this.productivityItems, (item: ProductivityItem) => {
          ListItem() {
            Column() {
              Row() {
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')
                
                Blank()
                
                Row() {
                  Circle()
                    .width(10)
                    .height(10)
                    .fill(item.color)
                  
                  Text(item.status)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(item.color)
                    .margin({ left: 4 })
                }
                .alignItems(VerticalAlign.Center)
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
              
              Row() {
                Progress({ value: item.progress * 100, total: 100, type: ProgressType.Linear })
                  .width('100%')
                  .height(8)
                  .color(item.color)
                  .trackColor('#F1F5F9')
                  .borderRadius(4)
                  .layoutWeight(1)
                
                Text(`${Math.round(item.progress * 100)}%`)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#475569')
                  .textAlign(TextAlign.End)
                  .width(40)
                  .margin({ left: 8 })
              }
              .width('100%')
              .alignItems(VerticalAlign.Center)
              .margin({ top: 16 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .border({ width: 1, color: '#E2E8F0' })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: 16, right: 16 })

      // Bottom Button
      Button() {
        Text('Submit New Form')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FFFFFF')
      }
      .width('100%')
      .height(56)
      .margin({ left: 16, right: 16, bottom: 16 })
      .backgroundColor('#0F172A')
      .borderRadius(12)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}

interface ChartDataItem {
  label: string
  value: number
}

interface ProductivityItem {
  id: number
  title: string
  status: string
  progress: number
  color: string
}