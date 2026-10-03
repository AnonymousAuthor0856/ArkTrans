@Entry
@Component
struct Index {
  @State selectedFilter: string = "Weekly"

  // Mock data to match the screenshot content
  private filters: string[] = ["Daily", "Weekly", "Monthly"]
  
  private chartData: ChartDataItem[] = [
    { label: 'Mon', value: 0.5 },
    { label: 'Tue', value: 0.7 },
    { label: 'Wed', value: 0.4 },
    { label: 'Thu', value: 1.0 },
    { label: 'Fri', value: 0.6 },
    { label: 'Sat', value: 0.3 },
    { label: 'Sun', value: 0.2 }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === LazyColumn (List) ===
      List({ space: 24 }) {
        ListItem() {
          // === Row (Filters) ===
          Row({ space: 8 }) {
            ForEach(this.filters, (filter: string) => {
              Button(filter) {
                Text(filter)
                  .fontColor(this.selectedFilter === filter ? '#FFFFFF' : '#0F172A')
                  .fontSize(16)
              }
              .backgroundColor(this.selectedFilter === filter ? '#0F172A' : '#FFFFFF')
              .borderWidth(this.selectedFilter === filter ? 0 : 1)
              .borderColor('#E2E8F0')
              .borderRadius(8)
              .height(40)
              .padding({ left: 16, right: 16 })
              .onClick(() => {
                this.selectedFilter = filter
              })
            })
          }.width('100%').justifyContent(FlexAlign.Center)
        }

        ListItem() {
          // === Card (Chart) ===
          Column() {
            Column({ space: 16 }) {
              // Title
              Text('Weekly Throughput')
                .fontSize(20)
                .fontWeight(FontWeight.Medium)
                .fontColor('#0F172A')

              // Chart Area
              Column({ space: 8 }) {
                // Bars
                Row({ space: 0 }) {
                  ForEach(this.chartData, (data: ChartDataItem) => {
                    Stack({ alignContent: Alignment.Bottom }) {
                      Column() {
                        // Bar
                        Column()
                          .width('100%')
                          .height(`${data.value * 100}%`)
                          .backgroundColor('#0F172A')
                          .borderRadius(8)
                      }
                      .layoutWeight(1)
                      .alignItems(HorizontalAlign.Center)
                    }.layoutWeight(1)
                  })
                }.width('100%').height(150).alignItems(VerticalAlign.Bottom)

                // Labels
                Row({ space: 0 }) {
                  ForEach(this.chartData, (data: ChartDataItem) => {
                    Text(data.label)
                      .fontSize(14)
                      .fontColor('#475569')
                      .textAlign(TextAlign.Center)
                      .layoutWeight(1)
                  })
                }.width('100%')
              }
            }.padding(16)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
        }

        ListItem() {
          // === Card (Item 1) ===
          Column() {
            Column({ space: 16 }) {
              // Header
              Row({ space: 0 }) {
                Text('Form Batch #A-102')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')
                  .layoutWeight(1)
                
                Row({ space: 8 }) {
                  Circle().width(10).height(10).fill('#22C55E')
                  Text('Completed')
                    .fontSize(14)
                    .fontColor('#22C55E')
                }
              }.width('100%')

              // Progress
              Row({ space: 8 }) {
                Progress({ value: 100, total: 100, type: ProgressType.Linear })
                  .width('100%')
                  .height(8)
                  .color('#22C55E')
                  .trackColor('#F1F5F9')
                  .layoutWeight(1)
                
                Text('100%')
                  .fontSize(14)
                  .fontColor('#475569')
                  .width(40)
                  .textAlign(TextAlign.End)
              }.width('100%')
            }.padding(16)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#E2E8F0' })
        }

        ListItem() {
          // === Card (Item 2) ===
          Column() {
            Column({ space: 16 }) {
              // Header
              Row({ space: 0 }) {
                Text('Invoice Set #B-231')
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#0F172A')
                  .layoutWeight(1)
                
                Row({ space: 8 }) {
                  Circle().width(10).height(10).fill('#F59E0B')
                  Text('In Progress')
                    .fontSize(14)
                    .fontColor('#F59E0B')
                }
              }.width('100%')

              // Progress
              Row({ space: 8 }) {
                Progress({ value: 65, total: 100, type: ProgressType.Linear })
                  .width('100%')
                  .height(8)
                  .color('#F59E0B')
                  .trackColor('#F1F5F9')
                  .layoutWeight(1)
                
                Text('65%')
                  .fontSize(14)
                  .fontColor('#475569')
                  .width(40)
                  .textAlign(TextAlign.End)
              }.width('100%')
            }.padding(16)
          }
          .width('100%')
          .backgroundColor('#FFFFFF')
          .borderRadius(16)
          .border({ width: 1, color: '#E2E8F0' })
        }
        
        // Spacer for bottom button overlap
        ListItem() {
          Column().height(80)
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: 16, right: 16, top: 16 })
      .backgroundColor('#F8FAFC')

      // === Top App Bar ===
      Row({ space: 0 }) {
        // Left Icon Placeholder
        Button() {
          Circle().width(24).height(24).fill('#E2E8F0')
        }
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)

        // Title
        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#0F172A')
          .textAlign(TextAlign.Center)

        // Right Icon Placeholder
        Button() {
          Circle().width(24).height(24).fill('#E2E8F0')
        }
        .backgroundColor(Color.Transparent)
        .layoutWeight(1)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .position({ x: 0, y: 0 })

      // === Bottom Action Button ===
      Column() {
        Button() {
          Text('Submit New Form')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
        }
        .width('100%')
        .height(56)
        .backgroundColor('#0F172A')
        .borderRadius(16)
        .margin({ left: 16, right: 16, bottom: 16 })
      }
      .width('100%')
      .alignSelf(ItemAlign.End)
      .position({ x: 0, y: 0 }) // Position relative to stack bottom via alignment
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F8FAFC')
  }
}

interface ChartDataItem {
  label: string;
  value: number;
}