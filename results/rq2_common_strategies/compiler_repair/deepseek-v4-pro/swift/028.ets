@Entry
@Component
struct RootScreen {
  @State selectedFilter: string = "Weekly"
  private filters: string[] = ["Daily", "Weekly", "Monthly"]
  private productivityItems: ProductivityItem[] = [
    { id: 1, title: "Form Batch #A-102", status: "Completed", progress: 1.0, statusColor: '#FF22C55E' },
    { id: 2, title: "Invoice Set #B-231", status: "In Progress", progress: 0.75, statusColor: '#FFF59E0B' },
    { id: 3, title: "Document Scan #C-456", status: "Pending", progress: 0.1, statusColor: '#FF475569' },
    { id: 4, title: "Form Batch #A-103", status: "Completed", progress: 1.0, statusColor: '#FF22C55E' },
    { id: 5, title: "Data Entry #D-789", status: "Failed", progress: 0.4, statusColor: '#FFEF4444' }
  ]
  private chartData: ChartData[] = [
    { label: "Mon", value: 0.6 }, { label: "Tue", value: 0.8 }, { label: "Wed", value: 0.5 },
    { label: "Thu", value: 1.0 }, { label: "Fri", value: 0.7 }, { label: "Sat", value: 0.4 },
    { label: "Sun", value: 0.2 }
  ]

  build() {
    Column({ space: 0 }) {
      // Top Bar
      Row({ space: 0 }) {
        Button() {
          Text('').width(24).height(24).backgroundColor('#FFE2E8F0').borderRadius(12)
        }.width(24).height(24).margin({ left: 16 })

        Blank()

        Text('Productivity Check')
          .fontSize(24)
          .fontWeight(FontWeight.Medium) // Semibold not available
          .foregroundColor('#FF0F172A')

        Blank()

        Button() {
          Text('').width(24).height(24).backgroundColor('#FFE2E8F0').borderRadius(12)
        }.width(24).height(24).margin({ right: 16 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFFFFFFF')
      .shadow({ radius: 10, color: 'rgba(0,0,0,0.10)', offsetX: 0, offsetY: 4 }) // level3

      // Scrollable content using List
      List({ space: 24 }) {
        // Filter Chips Row
        ListItem() {
          Row({ space: 8 }) {
            ForEach(this.filters, (filter: string) => {
              Button() {
                Text(filter)
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor(this.selectedFilter === filter ? '#FFFFFFFF' : '#FF0F172A')
                  .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              }
              .height(36)
              .backgroundColor(this.selectedFilter === filter ? '#FF0F172A' : '#FFFFFFFF')
              .borderRadius(8)
              .border({ width: 1, color: '#FFE2E8F0' })
              .onClick(() => {
                this.selectedFilter = filter
              })
            })
          }
          .width('100%')
          .padding({ left: 16, right: 16 })
        }

        // Weekly Throughput Card
        ListItem() {
          Column({ space: 16 }) {
            Text('Weekly Throughput')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#FF0F172A')

            // Chart bars
            Row({ space: 0 }) {
              ForEach(this.chartData, (data: ChartData) => {
                Column({ space: 8 }) {
                  // Bar
                  Row()
                    .width('60%')
                    .height(150 * data.value)
                    .backgroundColor('#FF0F172A')
                    .borderRadius(8)
                    .alignSelf(ItemAlign.End) // push to bottom? Actually we need bottom alignment; we'll use marginTop
                    .margin({ top: 150 * (1 - data.value) })
                  // Label
                  Text(data.label)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#FF475569')
                    .textAlign(TextAlign.Center)
                }
                .layoutWeight(1)
                .alignItems(HorizontalAlign.Center)
              })
            }
            .width('100%')
            .height(170) // bar height + label
          }
          .width('100%')
          .padding(16)
          .backgroundColor('#FFFFFFFF')
          .borderRadius(16)
          .shadow({ radius: 3, color: 'rgba(0,0,0,0.10)', offsetX: 0, offsetY: 1 }) // level1
          .padding({ left: 16, right: 16 })
        }

        // Productivity Items
        ForEach(this.productivityItems, (item: ProductivityItem) => {
          ListItem() {
            Column({ space: 16 }) {
              Row({ space: 0 }) {
                Text(item.title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF0F172A')

                Blank()

                Row({ space: 8 }) {
                  // Status indicator circle
                  Text('')
                    .width(10)
                    .height(10)
                    .backgroundColor(item.statusColor)
                    .borderRadius(5)
                  Text(item.status)
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor(item.statusColor)
                }
              }
              .width('100%')

              Row({ space: 8 }) {
                // Progress bar using Progress component
                Progress({ value: item.progress, total: 1, type: ProgressType.Linear })
                  .layoutWeight(1)
                  .height(8)
                  .color(item.statusColor)
                  .backgroundColor('#FFF1F5F9')
                  .borderRadius(4)

                Text((item.progress * 100).toFixed(0) + '%')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .foregroundColor('#FF475569')
                  .width(40)
                  .textAlign(TextAlign.End)
              }
              .width('100%')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FFFFFFFF')
            .borderRadius(12)
            .border({ width: 1, color: '#FFE2E8F0' })
            .padding({ left: 16, right: 16 })
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#FFF8FAFC')

      // Bottom Bar
      Row({ space: 0 }) {
        Button() {
          Text('Submit New Form')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#FFFFFFFF')
        }
        .width('100%')
        .height(56)
        .backgroundColor('#FF0F172A')
        .borderRadius(12)
        .margin({ left: 16, right: 16, bottom: 16, top: 16 })
      }
      .width('100%')
      .backgroundColor('#FFFFFFFF')
      .shadow({ radius: 10, color: 'rgba(0,0,0,0.10)', offsetX: 0, offsetY: -4 }) // level3
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF8FAFC')
  }
}

// Define interfaces for data
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