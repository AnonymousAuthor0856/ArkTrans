@Entry
@Component
struct Index {
  @State activeFilter: string = 'Live'
  @State filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  @State threads: ThreadData[] = [
    { name: 'Orbital Finance', status: 'Rolling sync', snippet: 'Need rates for Q4', unread: 5, isPriority: true },
    { name: 'Beacon Ops', status: 'Docked', snippet: 'Switching to holo feed', unread: 0, isPriority: false }
  ]

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === TopAppBar ===
      Column() {
        Row() {
          Text('Hub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
            .margin({ right: 16 })

          Column() {
            Text('HoloChat Dock')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#E2E8F0')
            Text('Dark neon bridge')
              .fontSize(14)
              .fontColor('#94A3B8')
          }

          Blank()

          Text('Status')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor('#22D3EE')
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 40, bottom: 20 })
        .alignItems(VerticalAlign.Center)
      }

      // === Main Content Scrollable Area ===
      Scroll() {
        Column({ space: 16 }) {
          // === Filter Chips ===
          Flex({ wrap: FlexWrap.Wrap, justifyContent: FlexAlign.Start }) {
            ForEach(this.filters, (label: string) => {
              Button(label)
                .backgroundColor(this.activeFilter === label ? '#22D3EE' : '#1F2937')
                .fontColor(this.activeFilter === label ? '#050714' : '#E2E8F0')
                .borderRadius(20)
                .height(40)
                .margin({ right: 10, bottom: 10 })
                .onClick(() => { this.activeFilter = label })
            })
          }
          .width('100%')
          .padding({ left: 20, right: 20 })

          // === Status Summary Blocks ===
          Flex({ justifyContent: FlexAlign.SpaceBetween }) {
            this.createSummaryBlock('LIVE DOCKS', '12', '#22D3EE')
            this.createSummaryBlock('ESCALATIONS', '3', '#F97316')
            this.createSummaryBlock('QUEUED', '5', '#7C3AED')
          }
          .width('100%')
          .padding({ left: 20, right: 20 })

          // === Thread List ===
          Column({ space: 16 }) {
            ForEach(this.threads, (thread: ThreadData) => {
              Column() {
                Column({ space: 12 }) {
                  Row() {
                    Column({ space: 4 }) {
                      Text(thread.name)
                        .fontSize(24)
                        .fontWeight(FontWeight.Bold)
                        .fontColor('#E2E8F0')
                      Text(thread.status)
                        .fontSize(14)
                        .fontColor(thread.isPriority ? '#22D3EE' : '#94A3B8')
                    }
                    Blank()
                    Text(thread.unread > 0 ? `+${thread.unread}` : '✓')
                      .fontSize(14)
                      .fontColor('#E2E8F0')
                      .backgroundColor('#1F2937')
                      .borderRadius(16)
                      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                  }
                  .width('100%')

                  Text(thread.snippet)
                    .fontSize(16)
                    .fontColor('#CBD5E1')

                  Row({ space: 12 }) {
                    Text(thread.isPriority ? 'Priority' : 'Standard')
                      .fontSize(14)
                      .fontColor('#E2E8F0')
                      .backgroundColor('#1F2937')
                      .borderRadius(16)
                      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                    
                    Text('Open')
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor('#22D3EE')
                  }
                }
                .padding(20)
              }
              .width('100%')
              .backgroundColor('#0F172A')
              .borderRadius(24)
              .border({ width: 1, color: '#334155' })
            })
          }
          .width('100%')
          .padding({ left: 20, right: 20 })
          
          // Spacer for FAB clearance
          Column().height(80)
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ top: 10 })
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // === Floating Action Button ===
      Button('New')
        .backgroundColor('#7C3AED')
        .fontColor('#050714')
        .fontWeight(FontWeight.Bold)
        .width(80)
        .height(80)
        .borderRadius(24)
        .position({ x: 'calc(100% - 100px)', y: 'calc(100% - 140px)' })

      // === Bottom Input Bar ===
      Column() {
        Row({ space: 12 }) {
          TextInput({ placeholder: 'Message dock...' })
            .placeholderColor('#94A3B8')
            .backgroundColor('#0F172A')
            .borderRadius(24)
            .height(48)
            .layoutWeight(1)
            .padding({ left: 20 })
            .border({ width: 0 })
          
          Button('Send')
            .backgroundColor('#7C3AED')
            .fontColor('#050714')
            .fontWeight(FontWeight.Bold)
            .borderRadius(24)
            .height(48)
            .width(100)
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 16, bottom: 30 })
      }
      .width('100%')
      .backgroundColor('#1F2937')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#050714')
  }

  @Builder
  createSummaryBlock(title: string, value: string, accent: string) {
    Column({ space: 8 }) {
      Row({ space: 8 }) {
        Circle({ width: 12, height: 12 }).fill(accent)
        Text(title)
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#94A3B8')
          .letterSpacing(1)
      }
      Text(value)
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .fontColor(accent)
    }
    .width('30%')
    .backgroundColor('#0F172A')
    .borderRadius(20)
    .padding(16)
  }
}

interface ThreadData {
  name: string;
  status: string;
  snippet: string;
  unread: number;
  isPriority: boolean;
}