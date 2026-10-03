const BG: string = '#050714'
const SURFACE: string = '#0F172A'
const SURFACE_VARIANT: string = '#1F2937'
const OUTLINE: string = '#334155'
const TEXT: string = '#E2E8F0'
const MUTED: string = '#AAB4C6'
const CYAN: string = '#22D3EE'
const PURPLE: string = '#7C3AED'
const ORANGE: string = '#F97316'

interface ChatThread {
  name: string
  status: string
  unread: number
  snippet: string
  priority: boolean
}

@Entry
@Component
struct Index {
  @State activeFilter: string = 'Live'
  @State draftMessage: string = ''

  private readonly filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private readonly threads: ChatThread[] = [
    {
      name: 'Orbital Finance',
      status: 'Rolling sync',
      unread: 5,
      snippet: 'Need rates for Q4',
      priority: true
    },
    {
      name: 'Beacon Ops',
      status: 'Docked',
      unread: 0,
      snippet: 'Switching to holo feed',
      priority: false
    },
    {
      name: 'Nova Crew',
      status: 'Hotline',
      unread: 2,
      snippet: 'Uploading scan pack now',
      priority: true
    }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.topBar()
        Scroll() {
          Column({ space: 12 }) {
            this.filterRow()
            this.summaryRow()
            ForEach(this.threads, (thread: ChatThread) => {
              this.threadCard(thread)
            })
            this.actionFooter()
            Blank().height(98)
          }
          .padding({ top: 12, bottom: 12 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Button('New')
        .fontSize(16)
        .fontColor('#050714')
        .backgroundColor(PURPLE)
        .borderRadius(20)
        .width(116)
        .height(92)
        .position({ right: 32, bottom: 144 })

      this.bottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BG)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  topBar() {
    Row() {
      Button('Hub', { type: ButtonType.Normal })
        .fontSize(24)
        .fontColor(TEXT)
        .backgroundColor(Color.Transparent)
        .padding(0)
        .layoutWeight(1)

      Column({ space: 1 }) {
        Text('HoloChat Dock')
          .fontSize(32)
          .fontColor(TEXT)
          .fontWeight(FontWeight.Medium)
        Text('Dark neon bridge')
          .fontSize(24)
          .fontColor(MUTED)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(2)

      Button('Status', { type: ButtonType.Normal })
        .fontSize(24)
        .fontColor(CYAN)
        .backgroundColor(Color.Transparent)
        .padding(0)
        .layoutWeight(1)
    }
    .width('100%')
    .height(100)
    .padding({ left: 32, right: 32 })
    .backgroundColor(SURFACE)
  }

  @Builder
  filterRow() {
    Scroll() {
      Row({ space: 15 }) {
        ForEach(this.filters, (filter: string) => {
          Button(filter, { type: ButtonType.Normal })
            .fontSize(24)
            .fontColor(this.activeFilter === filter ? '#011014' : TEXT)
            .backgroundColor(this.activeFilter === filter ? CYAN : SURFACE_VARIANT)
            .borderRadius(25)
            .border({
              width: this.activeFilter === filter ? 0 : 1,
              color: OUTLINE
            })
            .width(filter === 'Escalated' ? 178 : filter === 'Pinned' ? 145 : 112)
            .height(62)
            .onClick(() => {
              this.activeFilter = filter
            })
        })
      }
      .padding({ left: 32, right: 32 })
    }
    .width('100%')
    .scrollable(ScrollDirection.Horizontal)
    .scrollBar(BarState.Off)
  }

  @Builder
  summaryRow() {
    Row({ space: 16 }) {
      this.summaryBlock('LIVE DOCKS', '12', CYAN)
      this.summaryBlock('ESCALATIONS', '3', ORANGE)
      this.summaryBlock('QUEUED', '5', PURPLE)
    }
    .width('100%')
    .padding({ left: 32, right: 32 })
  }

  @Builder
  summaryBlock(title: string, value: string, accent: string) {
    Column({ space: 9 }) {
      Row()
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(accent)
      Text(title)
        .fontSize(23)
        .fontColor(MUTED)
        .fontWeight(FontWeight.Medium)
      Text(value)
        .fontSize(56)
        .fontColor(accent)
        .fontWeight(FontWeight.Bold)
    }
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)
    .height(184)
    .padding({ left: 24, top: 24, bottom: 15 })
    .backgroundColor(SURFACE)
    .borderRadius(32)
  }

  @Builder
  threadCard(thread: ChatThread) {
    Column({ space: 12 }) {
      Row() {
        Column({ space: 4 }) {
          Text(thread.name)
            .fontSize(42)
            .fontColor(TEXT)
            .fontWeight(FontWeight.Medium)
          Text(thread.status)
            .fontSize(24)
            .fontColor(thread.priority ? CYAN : MUTED)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(thread.unread > 0 ? '+' + thread.unread : '✓')
          .fontSize(23)
          .fontColor(TEXT)
          .textAlign(TextAlign.Center)
          .width(thread.unread > 0 ? 62 : 54)
          .height(46)
          .padding({ top: 8 })
          .backgroundColor(SURFACE_VARIANT)
          .borderRadius(24)
      }
      .width('100%')

      Text(thread.snippet)
        .fontSize(28)
        .fontColor('#CBD5E1')
        .width('100%')

      Row({ space: 16 }) {
        Text(thread.priority ? 'Priority' : 'Standard')
          .fontSize(23)
          .fontColor(TEXT)
          .textAlign(TextAlign.Center)
          .height(46)
          .padding({ left: 16, right: 16, top: 8 })
          .backgroundColor(SURFACE_VARIANT)
          .borderRadius(23)

        Button('Open', { type: ButtonType.Normal })
          .fontSize(24)
          .fontColor(CYAN)
          .backgroundColor(Color.Transparent)
          .padding(0)
      }
    }
    .width('calc(100% - 64vp)')
    .padding({ left: 24, right: 24, top: 26, bottom: 24 })
    .backgroundColor(SURFACE)
    .borderRadius(44)
    .border({ width: 2, color: OUTLINE })
  }

  @Builder
  actionFooter() {
    Column({ space: 14 }) {
      Text('Dock filters')
        .fontSize(22)
        .fontColor(TEXT)
        .fontWeight(FontWeight.Medium)
      Row({ space: 12 }) {
        Button('Calm')
          .fontSize(18)
          .fontColor('#050714')
          .backgroundColor(PURPLE)
          .borderRadius(16)
          .height(48)
        Button('Fire')
          .fontSize(18)
          .fontColor('#110200')
          .backgroundColor(ORANGE)
          .borderRadius(16)
          .height(48)
      }
    }
    .width('calc(100% - 64vp)')
    .padding(20)
    .backgroundColor(SURFACE_VARIANT)
    .borderRadius(28)
  }

  @Builder
  bottomBar() {
    Row({ space: 16 }) {
      TextInput({ placeholder: 'Message dock...', text: this.draftMessage })
        .fontSize(22)
        .fontColor(TEXT)
        .placeholderColor('#8F9AAC')
        .backgroundColor(SURFACE)
        .borderRadius(28)
        .height(96)
        .layoutWeight(1)
        .padding({ left: 24, right: 24 })
        .onChange((value: string) => {
          this.draftMessage = value
        })

      Button('Send')
        .fontSize(22)
        .fontColor('#050714')
        .backgroundColor(PURPLE)
        .borderRadius(28)
        .width(140)
        .height(96)
        .onClick(() => {
          this.draftMessage = ''
        })
    }
    .width('100%')
    .height(128)
    .padding({ left: 32, right: 32, top: 16, bottom: 16 })
    .backgroundColor('#1B2638')
  }
}
