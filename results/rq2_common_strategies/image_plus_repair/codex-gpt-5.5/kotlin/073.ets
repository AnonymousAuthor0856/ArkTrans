const BG: ResourceColor = '#050714'
const SURFACE: ResourceColor = '#0F172A'
const SURFACE_VARIANT: ResourceColor = '#1F2937'
const OUTLINE: ResourceColor = '#334155'
const TEXT: ResourceColor = '#E2E8F0'
const MUTED: ResourceColor = '#AAB3C2'
const CYAN: ResourceColor = '#22D3EE'
const PURPLE: ResourceColor = '#7C3AED'
const ORANGE: ResourceColor = '#F97316'

class ThreadInfo {
  name: string
  status: string
  unread: number
  snippet: string
  priority: boolean

  constructor(name: string, status: string, unread: number, snippet: string, priority: boolean) {
    this.name = name
    this.status = status
    this.unread = unread
    this.snippet = snippet
    this.priority = priority
  }
}

@Entry
@Component
struct HoloChatDock {
  @State activeFilter: string = 'Live'
  @State draft: string = ''

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ThreadInfo[] = [
    new ThreadInfo('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ThreadInfo('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ThreadInfo('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ]

  @Builder
  Header() {
    Row() {
      Text('Hub')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT)
        .margin({ left: 12 })

      Column() {
        Text('HoloChat Dock')
          .fontSize(31)
          .lineHeight(36)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT)
        Text('Dark neon bridge')
          .fontSize(23)
          .lineHeight(28)
          .fontWeight(FontWeight.Medium)
          .fontColor(MUTED)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ left: 42 })

      Text('Status')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(CYAN)
        .margin({ right: 10 })
    }
    .width('100%')
    .height(128)
    .padding({ top: 34, left: 22, right: 22 })
    .alignItems(VerticalAlign.Top)
  }

  @Builder
  FilterBar() {
    Row({ space: 16 }) {
      ForEach(this.filters, (filter: string) => {
        Text(filter)
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.activeFilter === filter ? '#011014' : TEXT)
          .textAlign(TextAlign.Center)
          .height(64)
          .width(filter === 'Escalated' ? 170 : 138)
          .padding({ top: 17 })
          .backgroundColor(this.activeFilter === filter ? CYAN : SURFACE_VARIANT)
          .border({
            width: 2,
            color: this.activeFilter === filter ? '#0E7490' : OUTLINE,
            radius: 23
          })
          .onClick(() => {
            this.activeFilter = filter
          })
      }, (filter: string) => filter)
    }
    .width('100%')
    .padding({ left: 0, right: 0 })
  }

  @Builder
  SummaryBlock(title: string, value: string, accent: ResourceColor) {
    Column() {
      Circle()
        .width(24)
        .height(24)
        .fill(accent)
        .margin({ bottom: 10 })

      Text(title.toUpperCase())
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(MUTED)
        .lineHeight(28)

      Text(value)
        .fontSize(56)
        .fontWeight(FontWeight.Bold)
        .fontColor(accent)
        .lineHeight(62)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .height(182)
    .padding({ left: 24, top: 24 })
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(SURFACE)
    .borderRadius(30)
  }

  @Builder
  Summary() {
    Row({ space: 16 }) {
      this.SummaryBlock('Live docks', '12', CYAN)
      this.SummaryBlock('Escalations', '3', ORANGE)
      this.SummaryBlock('Queued', '5', PURPLE)
    }
    .width('100%')
  }

  @Builder
  ThreadCard(thread: ThreadInfo) {
    Column() {
      Row() {
        Column() {
          Text(thread.name)
            .fontSize(43)
            .lineHeight(50)
            .fontWeight(FontWeight.Bold)
            .fontColor(TEXT)
          Text(thread.status)
            .fontSize(24)
            .lineHeight(30)
            .fontWeight(FontWeight.Bold)
            .fontColor(thread.priority ? CYAN : MUTED)
            .margin({ top: 6 })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(thread.unread > 0 ? '+' + thread.unread.toString() : '✓')
          .fontSize(23)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT)
          .textAlign(TextAlign.Center)
          .width(58)
          .height(58)
          .padding({ top: 17 })
          .backgroundColor(SURFACE_VARIANT)
          .borderRadius(30)
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)

      Text(thread.snippet)
        .fontSize(28)
        .lineHeight(35)
        .fontColor(TEXT)
        .margin({ top: 16, bottom: 14 })

      Row() {
        Text(thread.priority ? 'Priority' : 'Standard')
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(TEXT)
          .height(44)
          .padding({ left: 17, right: 17, top: 10 })
          .backgroundColor(SURFACE_VARIANT)
          .borderRadius(23)

        Text('Open')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(CYAN)
          .margin({ left: 46, top: 10 })
          .onClick(() => {})
      }
      .width('100%')
      .alignItems(VerticalAlign.Top)
    }
    .width('100%')
    .height(298)
    .padding({ left: 24, right: 24, top: 25, bottom: 22 })
    .backgroundColor(SURFACE)
    .border({
      width: 2,
      color: OUTLINE,
      radius: 38
    })
  }

  @Builder
  ActionFooter() {
    Column() {
      Text('Dock filters')
        .fontSize(22)
        .fontWeight(FontWeight.Bold)
        .fontColor(TEXT)
      Row({ space: 14 }) {
        Button('Calm')
          .fontSize(20)
          .fontColor('#011014')
          .backgroundColor(CYAN)
          .borderRadius(18)
        Button('Fire')
          .fontSize(20)
          .fontColor('#110200')
          .backgroundColor(ORANGE)
          .borderRadius(18)
      }
      .margin({ top: 14 })
    }
    .width('100%')
    .padding(24)
    .backgroundColor(SURFACE_VARIANT)
    .borderRadius(30)
  }

  @Builder
  Composer() {
    Row({ space: 16 }) {
      TextInput({ text: this.draft, placeholder: 'Message dock...' })
        .layoutWeight(1)
        .height(64)
        .fontSize(22)
        .fontColor(TEXT)
        .placeholderColor('#8B95A7')
        .padding({ left: 24, right: 18 })
        .backgroundColor(SURFACE)
        .borderRadius(32)
        .onChange((value: string) => {
          this.draft = value
        })

      Button('Send')
        .width(150)
        .height(64)
        .fontSize(22)
        .fontColor('#050714')
        .backgroundColor(PURPLE)
        .borderRadius(30)
        .onClick(() => {
          this.draft = ''
        })
    }
    .width('100%')
    .padding({ left: 32, right: 32, top: 16, bottom: 24 })
    .backgroundColor(BG)
  }

  build() {
    Stack() {
      Column() {
        this.Header()

        Scroll() {
          Column({ space: 24 }) {
            this.FilterBar()
            this.Summary()
            ForEach(this.threads, (thread: ThreadInfo) => {
              this.ThreadCard(thread)
            }, (thread: ThreadInfo) => thread.name)
            this.ActionFooter()
          }
          .width('100%')
          .padding({ left: 32, right: 32, bottom: 116 })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        this.Composer()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(BG)

      Button('New')
        .width(112)
        .height(112)
        .fontSize(22)
        .fontColor('#050714')
        .backgroundColor(PURPLE)
        .borderRadius(30)
        .position({ right: 32, bottom: 128 })
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BG)
  }
}
