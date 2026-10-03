@Entry
@Component
struct HoloChatApp {
  @State activeFilter: string = 'Live'
  @State draftMessage: string = ''
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThread[] = [
    { name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
    { name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
    { name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true }
  ]

  build() {
    Stack({ alignContent: Alignment.BottomStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#050714')

      // Main column
      Column({ space: 0 }) {
        // Top bar
        Row({ space: 0 }) {
          Button() {
            Text('Hub')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#E2E8F0')
          }
          Blank()
          Column({ space: 0 }) {
            Text('HoloChat Dock')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#E2E8F0')
            Text('Dark neon bridge')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#E2E8F0')
              .opacity(0.7)
          }
          .alignItems(HorizontalAlign.Center)
          Blank()
          Button() {
            Text('Status')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .foregroundColor('#22D3EE')
          }
        }
        .width('100%')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor('#0F172A')

        // Content using List
        List({ space: 12 }) {
          // Filter chips
          ListItem() {
            Row({ space: 8 }) {
              ForEach(this.filters, (filter: string) => {
                Button() {
                  Text(filter)
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor(this.activeFilter === filter ? '#011014' : '#E2E8F0')
                    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
                }
                .backgroundColor(this.activeFilter === filter ? '#22D3EE' : '#1F2937')
                .borderRadius(12)
                .border({ width: this.activeFilter === filter ? 0 : 1, color: '#334155', radius: 12 })
                .onClick(() => {
                  this.activeFilter = filter
                })
              })
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
          }

          // Status summary
          ListItem() {
            Row({ space: 8 }) {
              this.buildSummaryBlock('Live docks', '12', '#22D3EE')
              this.buildSummaryBlock('Escalations', '3', '#F97316')
              this.buildSummaryBlock('Queued', '5', '#7C3AED')
            }
            .width('100%')
            .padding({ left: 16, right: 16 })
          }

          // Thread cards
          ForEach(this.threads, (thread: ChatThread) => {
            ListItem() {
              Column({ space: 8 }) {
                Row({ space: 0 }) {
                  Column({ space: 4 }) {
                    Text(thread.name)
                      .fontSize(22)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#E2E8F0')
                    Text(thread.status)
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor(thread.isPriority ? '#22D3EE' : '#E2E8F0')
                      .opacity(0.7)
                  }
                  .alignItems(HorizontalAlign.Start)

                  Blank()

                  Text(thread.unread > 0 ? '+' + thread.unread : '✓')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#E2E8F0')
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .backgroundColor('#1F2937')
                    .borderRadius(12)
                }
                .width('100%')

                Text(thread.snippet)
                  .fontSize(14)
                  .foregroundColor('#E2E8F0')
                  .opacity(0.9)
                  .width('100%')

                Row({ space: 8 }) {
                  Text(thread.isPriority ? 'Priority' : 'Standard')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#E2E8F0')
                    .padding({ left: 8, right: 8, top: 4, bottom: 4 })
                    .backgroundColor('#1F2937')
                    .borderRadius(12)

                  Button() {
                    Text('Open')
                      .fontSize(12)
                      .fontWeight(FontWeight.Medium)
                      .foregroundColor('#22D3EE')
                  }
                }
                .width('100%')
              }
              .padding(12)
              .backgroundColor('#0F172A')
              .borderRadius(20)
              .border({ width: 1, color: '#334155', radius: 20 })
              .padding({ left: 16, right: 16 })
            }
          })

          // Action footer
          ListItem() {
            Column({ space: 8 }) {
              Text('Dock filters')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .foregroundColor('#E2E8F0')
                .width('100%')

              Row({ space: 8 }) {
                Button() {
                  Text('Calm')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#050714')
                    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                }
                .backgroundColor('#7C3AED')
                .borderRadius(16)

                Button() {
                  Text('Fire')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .foregroundColor('#110200')
                    .padding({ left: 16, right: 16, top: 10, bottom: 10 })
                }
                .backgroundColor('#F97316')
                .borderRadius(16)
              }
              .width('100%')
            }
            .padding(16)
            .width('100%')
            .backgroundColor('#1F2937')
            .borderRadius(20)
            .padding({ left: 16, right: 16 })
          }

          // Spacer for bottom bar (replacing Blank with Column)
          ListItem() {
            Column()
              .height(100)
              .width('100%')
          }
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ top: 12, bottom: 0 })
      }
      .width('100%')
      .height('100%')

      // FAB
      Button() {
        Text('New')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .foregroundColor('#050714')
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      }
      .backgroundColor('#7C3AED')
      .borderRadius(16)
      .shadow({ radius: 4, color: '#000000' })
      .margin({ right: 16, bottom: 96 })
      .alignSelf(ItemAlign.End)

      // Bottom input bar
      Row({ space: 8 }) {
        TextInput({ placeholder: 'Message dock...', text: this.draftMessage })
          .fontSize(14)
          .foregroundColor('#E2E8F0')
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .height(48)
          .backgroundColor('#0F172A')
          .borderRadius(16)
          .layoutWeight(1)
          .onChange((val: string) => { this.draftMessage = val })

        Button() {
          Text('Send')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .foregroundColor('#050714')
            .padding({ left: 20, right: 20 })
            .height(48)
            .textAlign(TextAlign.Center)
        }
        .height(48)
        .backgroundColor('#7C3AED')
        .borderRadius(16)
        .onClick(() => {
          // send action
        })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor('#1F2937')
      .shadow({ radius: 6, color: '#33000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#050714')
  }

  @Builder
  buildSummaryBlock(title: string, value: string, accent: string) {
    Column({ space: 4 }) {
      Circle()
        .width(12)
        .height(12)
        .fill(accent)
      Text(title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .foregroundColor('#E2E8F0')
        .opacity(0.7)
      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .foregroundColor(accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .layoutWeight(1)
    .backgroundColor('#0F172A')
    .borderRadius(16)
  }
}

interface ChatThread {
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean
}