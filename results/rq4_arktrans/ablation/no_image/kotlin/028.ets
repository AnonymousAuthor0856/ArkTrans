import { Alignment } from '@kit.ArkUI'

interface ChartDataItem {
  label: string
  value: number
}

interface MockItem {
  title: string
  status: string
  statusColor: string
  progress: number
}

@Entry
@Component
struct Index {
  @State selectedFilter: string = "Weekly"
  @State filter: number = 0
  @State WeeklyThroughput: number = 0
  @State dataLabel: string = ""
  @State itemTitle: string = ""
  @State itemStatus: string = ""
  @State syncProgress: number = 0.3
  @State ProductivityCheck: number = 0
  @State SubmitNewForm: number = 0

  // Mock data to satisfy compilation requirements for forEach
  private filters: string[] = ["Weekly", "Monthly", "Yearly"]
  private chartData: ChartDataItem[] = [
    { label: 'Mon', value: 0.5 },
    { label: 'Tue', value: 0.8 },
    { label: 'Wed', value: 0.6 },
    { label: 'Thu', value: 0.9 },
    { label: 'Fri', value: 0.7 }
  ]
  
  // Mock item object for the second card
  private mockItem: MockItem = {
    title: "Task Item",
    status: "In Progress",
    statusColor: "#10B981",
    progress: 0.75
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {
      List({ space: 24 }) {
        ListItem() {
          Row({ space: 0 }) {
            ForEach(this.filters, (it: string) => {
              Button(it)
                .backgroundColor(this.selectedFilter === it ? '#0F172A' : '#F8FAFC')
                .borderRadius(16)
                .border({ width: 1, color: '#CBD5E1' })
                .onClick(() => {
                  this.selectedFilter = it
                })
              
              Blank().width(8)
            })
          }.width('100%').justifyContent(FlexAlign.Center)
        }

        ListItem() {
          Column() {
            Column({ space: 0 }) {
              Text('Weekly Throughput').fontSize(16).fontWeight(FontWeight.Medium)
              Blank().height(16)
              
              Column({ space: 0 }) {
                Row({ space: 0 }) {
                  ForEach(this.chartData, (it: ChartDataItem) => {
                    Stack({ alignContent: Alignment.Bottom }) {
                      Column() {
                        // Simulating bar height based on value
                        Column()
                          .width('100%')
                          .height(`${it.value * 100}%`)
                          .backgroundColor('#0F172A')
                          .borderRadius(4)
                      }.width('100%').height('100%')
                    }.layoutWeight(1)
                  })
                }.alignItems(VerticalAlign.Bottom).width('100%')
                
                Blank().height(8)
                
                Row({ space: 0 }) {
                  ForEach(this.chartData, (it: ChartDataItem) => {
                    Text(it.label)
                      .fontSize(12)
                      .fontColor('#475569')
                      .textAlign(TextAlign.Center)
                      .layoutWeight(1)
                  })
                }.width('100%')
              }.width('100%').height(150)
            }.padding(16)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
          .width('100%')
        }

        ListItem() {
          Column() {
            Column({ space: 0 }) {
              Row({ space: 0 }) {
                Text(this.mockItem.title).fontSize(16).fontWeight(FontWeight.Medium)
                Blank().layoutWeight(1)
                Row({ space: 8 }) {
                  Circle({})
                    .width(10)
                    .height(10)
                    .fill(this.mockItem.statusColor)
                  Text(this.mockItem.status)
                    .fontSize(12)
                    .fontColor(this.mockItem.statusColor)
                }.alignItems(VerticalAlign.Center)
              }.alignItems(VerticalAlign.Center).width('100%')
              
              Blank().height(16)
              
              Row({ space: 8 }) {
                Progress({
                  value: this.mockItem.progress,
                  total: 1,
                  type: ProgressType.Linear
                })
                .color(this.mockItem.statusColor)
                .backgroundColor('#F1F5F9')
                .height(8)
                .layoutWeight(1)
                
                Text(`${Math.round(this.mockItem.progress * 100)}%`)
                  .fontSize(12)
                  .fontColor('#475569')
                  .textAlign(TextAlign.End)
                  .width(40)
              }.alignItems(VerticalAlign.Center)
            }.padding(16)
          }
          .backgroundColor('#FFFFFF')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
          .width('100%')
        }
      }
      .padding(16)
      .width('100%')
      .layoutWeight(1)

      // Top App Bar Simulation
      Row() {
        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Medium)
          .layoutWeight(1)
        
        Button() {
          Circle({}).width(24).height(24).fill('#E2E8F0')
        }
        .backgroundColor(Color.Transparent)
        .borderRadius(12)
        
        Button() {
          Circle({}).width(24).height(24).fill('#E2E8F0')
        }
        .backgroundColor(Color.Transparent)
        .borderRadius(12)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // Bottom Surface / FAB Area
      Column() {
        Button() {
          Text('Submit New Form').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFFFFF')
        }
        .backgroundColor('#0F172A')
        .borderRadius(8)
        .height(56)
        .width('100%')
        .margin({ bottom: 16 })
      }
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000' })
      .position({ x: 0, y: -100 }) // Adjusted position relative to stack if needed, but here stacked at bottom
      .width('100%')
      
    }.width('100%').height('100%').backgroundColor('#F8FAFC')
  }
}