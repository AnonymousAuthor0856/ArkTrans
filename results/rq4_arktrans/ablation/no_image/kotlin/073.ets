@Entry
@Component
struct Index {
  @State activeFilter: string = 'Open'
  @State filters: string[] = ['Open', 'Dock filters', 'Calm', 'Fire']
  @State threads: ThreadData[] = [
    { name: 'HoloChat Dock', status: 'Active', unread: 2, snippet: 'Dark neon bridge connection established.', isPriority: true },
    { name: 'System Hub', status: 'Idle', unread: 0, snippet: 'Waiting for input...', isPriority: false }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content (Column) ===
      Column({ space: 16 }) {
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        .width('100%')
        .height('100%')
        .backgroundColor('#050714')
        .scrollable(ScrollDirection.Vertical)

        // === Filter Chips Row ===
        Row({ space: 8 }) {
          ForEach(this.filters, (label: string) => {
            Button(label)
              .backgroundColor(this.activeFilter === label ? '#22D3EE' : '#1F2937')
              .borderRadius(16)
              .onClick(() => {
                this.activeFilter = label
              })
          })
        }

        // === Status Summary Row ===
        Row({ space: 8 }) {
          .width('100%')

          // Live docks
          Column({ space: 4 }) {
            .layoutWeight(1)
            .backgroundColor('#1F2937')
            .borderRadius(12)
            .padding(16)
            
            Stack({ alignContent: Alignment.Start }) {
              Circle({ width: 12, height: 12 }).fill('#22D3EE')
            }
            Text('LIVE DOCKS').fontSize(12).fontColor('#E2E8F0')
            Text('12').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#22D3EE')
          }

          // Escalations
          Column({ space: 4 }) {
            .layoutWeight(1)
            .backgroundColor('#1F2937')
            .borderRadius(12)
            .padding(16)
            
            Stack({ alignContent: Alignment.Start }) {
              Circle({ width: 12, height: 12 }).fill('#F97316')
            }
            Text('ESCALATIONS').fontSize(12).fontColor('#E2E8F0')
            Text('3').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#F97316')
          }

          // Queued
          Column({ space: 4 }) {
            .layoutWeight(1)
            .backgroundColor('#1F2937')
            .borderRadius(12)
            .padding(16)
            
            Stack({ alignContent: Alignment.Start }) {
              Circle({ width: 12, height: 12 }).fill('#7C3AED')
            }
            Text('QUEUED').fontSize(12).fontColor('#E2E8F0')
            Text('5').fontSize(24).fontWeight(FontWeight.Bold).fontColor('#7C3AED')
          }
        }

        // === Threads List ===
        ForEach(this.threads, (thread: ThreadData) => {
          Column() {
            .width('100%')
            .backgroundColor('#1F2937')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .padding(16)
            .margin({ bottom: 12 })

            Column({ space: 8 }) {
              // Header Row
              Row() {
                .width('100%')
                .alignItems(VerticalAlign.Center)
                
                Column({ space: 4 }) {
                  Text(thread.name).fontSize(18).fontWeight(FontWeight.Medium).fontColor('#E2E8F0')
                  Text(thread.status)
                    .fontSize(12)
                    .fontColor(thread.isPriority ? '#22D3EE' : '#9CA3AF')
                }

                Blank()

                // Badge
                Stack({ alignContent: Alignment.Center }) {
                  Text(thread.unread > 0 ? `+${thread.unread}` : '✓')
                    .fontSize(12)
                    .fontColor('#E2E8F0')
                }
                .backgroundColor('#374151')
                .borderRadius(8)
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })
              }

              // Snippet
              Text(thread.snippet)
                .fontSize(14)
                .fontColor('#E2E8F0')
                .maxLines(2)
                .textOverflow({ overflow: TextOverflow.Ellipsis })

              // Footer Row
              Row({ space: 8 }) {
                // Priority Tag
                Column() {
                  Text(thread.isPriority ? 'Priority' : 'Standard')
                    .fontSize(12)
                    .fontColor('#E2E8F0')
                }
                .backgroundColor('#374151')
                .borderRadius(8)
                .padding({ left: 8, right: 8, top: 4, bottom: 4 })

                // Open Button
                Button('Open')
                  .backgroundColor(Color.Transparent)
                  .borderWidth(1)
                  .borderColor('#22D3EE')
                  .borderRadius(8)
              }
            }
          }
        })

        // === Action Footer Card ===
        Column() {
          .width('100%')
          .backgroundColor('#1F2937')
          .borderRadius(12)
          .shadow({ radius: 4, color: '#1A000000' })
          .padding(24)

          Column({ space: 12 }) {
            Text('Dock filters').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#E2E8F0')
            
            Row({ space: 8 }) {
              Button('Calm')
                .backgroundColor('#374151')
                .borderRadius(8)

              Button('Fire')
                .backgroundColor('#7C3AED')
                .borderRadius(8)
            }
          }
        }
      }

      // === Top App Bar ===
      Column() {
        .width('100%')
        .backgroundColor('#1F2937')
        .padding({ left: 24, right: 24, top: 16, bottom: 16 })
        
        Row() {
          .width('100%')
          .alignItems(VerticalAlign.Center)
          
          Column({ space: 4 }) {
            Text('HoloChat Dock').fontSize(18).fontWeight(FontWeight.Medium).fontColor('#E2E8F0')
            Text('Dark neon bridge').fontSize(12).fontColor('#9CA3AF')
          }

          Blank()

          Button('Hub')
            .backgroundColor(Color.Transparent)

          Button('Status')
            .backgroundColor(Color.Transparent)
        }
      }

      // === Floating Action Button ===
      Button('New')
        .width(56)
        .height(56)
        .backgroundColor('#7C3AED')
        .borderRadius(12)
        .position({ x: 'calc(100% - 80px)', y: 'calc(100% - 140px)' })

      // === Bottom Input Surface ===
      Column() {
        .width('100%')
        .backgroundColor('#1F2937')
        .shadow({ radius: 4, color: '#1A000000' })
        .padding({ left: 24, right: 24, top: 12, bottom: 12 })
        .position({ x: 0, y: 'calc(100% - 80px)' })

        Row({ space: 8 }) {
          .width('100%')
          .alignItems(VerticalAlign.Center)

          TextInput({ placeholder: 'Message dock...' })
            .width('100%')
            .layoutWeight(1)
            .backgroundColor('#374151')
            .borderRadius(8)
            .padding({ left: 16, right: 16, top: 8, bottom: 8 })
            .fontColor('#E2E8F0')
            .placeholderColor('#9CA3AF')

          Button('Send')
            .backgroundColor('#22D3EE')
            .borderRadius(8)
        }
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#050714')
  }
}

interface ThreadData {
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean
}