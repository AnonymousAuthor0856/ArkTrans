// 073.kt -> 073.ets
// HoloChat Dock - Dark Neon Glow social messenger

const C_PRIMARY: string = '#7C3AED'
const C_SECONDARY: string = '#22D3EE'
const C_TERTIARY: string = '#F97316'
const C_BACKGROUND: string = '#050714'
const C_SURFACE: string = '#0F172A'
const C_SURFACE_VARIANT: string = '#1F2937'
const C_OUTLINE: string = '#334155'
const C_ON_PRIMARY: string = '#050714'
const C_ON_SECONDARY: string = '#011014'
const C_ON_TERTIARY: string = '#110200'
const C_ON_SURFACE: string = '#E2E8F0'
const C_ON_SURFACE_70: string = '#B2E2E8F0'
const C_ON_SURFACE_60: string = '#99E2E8F0'
const C_ON_SURFACE_90: string = '#E6E2E8F0'

interface ChatThread {
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean
}

const FILTERS: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']

const THREADS: ChatThread[] = [
  { name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
  { name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
  { name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true }
]

@Entry
@Component
struct HoloChatDock {
  @State activeFilter: string = 'Live'
  @State draft: string = ''

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column({ space: 12 }) {
            this.FilterRow()
            this.StatusSummary()
            ForEach(THREADS, (t: ChatThread) => {
              this.ChatThreadCard(t)
            }, (t: ChatThread) => t.name)
            this.ActionFooter()
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        }
        .width('100%')
        .layoutWeight(1)
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(C_BACKGROUND)

      Button('New')
        .fontSize(12)
        .fontWeight(500)
        .fontColor(C_ON_PRIMARY)
        .backgroundColor(C_PRIMARY)
        .borderRadius(16)
        .margin({ right: 20, bottom: 80 })
        .onClick(() => {})
    }
    .width('100%')
    .height('100%')
    .backgroundColor(C_BACKGROUND)
  }

  @Builder
  TopBar() {
    Row() {
      Text('Hub')
        .fontSize(12)
        .fontWeight(500)
        .lineHeight(16)
        .fontColor(C_ON_SURFACE)
        .padding({ left: 16, right: 8, top: 8, bottom: 8 })
        .onClick(() => {})
      Column({ space: 2 }) {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(500)
          .lineHeight(22)
          .fontColor(C_ON_SURFACE)
        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(500)
          .lineHeight(16)
          .fontColor(C_ON_SURFACE_70)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      Text('Status')
        .fontSize(12)
        .fontWeight(500)
        .lineHeight(16)
        .fontColor(C_SECONDARY)
        .padding({ left: 8, right: 16, top: 8, bottom: 8 })
        .onClick(() => {})
    }
    .width('100%')
    .height(64)
    .backgroundColor(C_SURFACE)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  FilterRow() {
    Row({ space: 8 }) {
      ForEach(FILTERS, (label: string) => {
        this.FilterChip(label)
      }, (label: string) => label)
    }
    .width('100%')
  }

  @Builder
  FilterChip(label: string) {
    Button(label)
      .fontSize(12)
      .fontWeight(500)
      .fontColor(this.activeFilter === label ? C_ON_SECONDARY : C_ON_SURFACE)
      .backgroundColor(this.activeFilter === label ? C_SECONDARY : C_SURFACE_VARIANT)
      .borderRadius(12)
      .height(36)
      .onClick(() => {
        this.activeFilter = label
      })
  }

  @Builder
  StatusSummary() {
    Row({ space: 8 }) {
      this.SummaryBlock('Live docks', '12', C_SECONDARY)
      this.SummaryBlock('Escalations', '3', C_TERTIARY)
      this.SummaryBlock('Queued', '5', C_PRIMARY)
    }
    .width('100%')
  }

  @Builder
  SummaryBlock(title: string, value: string, accent: string) {
    Column({ space: 4 }) {
      Circle({ width: 12, height: 12 }).fill(accent)
      Text(title.toUpperCase())
        .fontSize(12)
        .fontWeight(500)
        .lineHeight(16)
        .fontColor(C_ON_SURFACE_70)
      Text(value)
        .fontSize(28)
        .fontWeight(600)
        .lineHeight(34)
        .fontColor(accent)
    }
    .alignItems(HorizontalAlign.Start)
    .layoutWeight(1)
    .backgroundColor(C_SURFACE)
    .borderRadius(16)
    .padding(12)
  }

  @Builder
  ChatThreadCard(t: ChatThread) {
    Column({ space: 8 }) {
      Row() {
        Column({ space: 4 }) {
          Text(t.name)
            .fontSize(22)
            .fontWeight(500)
            .lineHeight(28)
            .fontColor(C_ON_SURFACE)
          Text(t.status)
            .fontSize(12)
            .fontWeight(500)
            .lineHeight(16)
            .fontColor(t.isPriority ? C_SECONDARY : C_ON_SURFACE_70)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(t.unread > 0 ? '+' + t.unread.toString() : '✓')
          .fontSize(12)
          .fontWeight(500)
          .lineHeight(16)
          .fontColor(C_ON_SURFACE)
          .backgroundColor(C_SURFACE_VARIANT)
          .borderRadius(12)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(t.snippet)
        .fontSize(14)
        .fontWeight(400)
        .lineHeight(20)
        .fontColor(C_ON_SURFACE_90)

      Row({ space: 8 }) {
        Text(t.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(500)
          .lineHeight(16)
          .fontColor(C_ON_SURFACE)
          .backgroundColor(C_SURFACE_VARIANT)
          .borderRadius(12)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
        Text('Open')
          .fontSize(12)
          .fontWeight(500)
          .lineHeight(16)
          .fontColor(C_SECONDARY)
          .onClick(() => {})
      }
    }
    .width('100%')
    .backgroundColor(C_SURFACE)
    .borderRadius(20)
    .border({ width: 1, color: C_OUTLINE })
    .padding(12)
  }

  @Builder
  ActionFooter() {
    Column({ space: 8 }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(500)
        .lineHeight(22)
        .fontColor(C_ON_SURFACE)
      Row({ space: 8 }) {
        Button('Calm')
          .fontSize(12)
          .fontWeight(500)
          .fontColor(C_ON_PRIMARY)
          .backgroundColor(C_PRIMARY)
          .borderRadius(16)
          .onClick(() => {})
        Button('Fire')
          .fontSize(12)
          .fontWeight(500)
          .fontColor(C_ON_TERTIARY)
          .backgroundColor(C_TERTIARY)
          .borderRadius(16)
          .onClick(() => {})
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .backgroundColor(C_SURFACE_VARIANT)
    .borderRadius(20)
    .padding(16)
  }

  @Builder
  BottomBar() {
    Row({ space: 8 }) {
      TextInput({ placeholder: 'Message dock...', text: this.draft })
        .fontSize(14)
        .fontWeight(400)
        .fontColor(C_ON_SURFACE)
        .placeholderColor(C_ON_SURFACE_60)
        .backgroundColor(C_SURFACE)
        .borderRadius(16)
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .layoutWeight(1)
        .onChange((value: string) => {
          this.draft = value
        })
      Button('Send')
        .fontSize(12)
        .fontWeight(500)
        .fontColor(C_ON_PRIMARY)
        .backgroundColor(C_PRIMARY)
        .borderRadius(16)
        .onClick(() => {})
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(C_SURFACE_VARIANT)
    .alignItems(VerticalAlign.Center)
  }
}
