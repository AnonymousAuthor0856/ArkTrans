// Index.ets

const COLOR_PRIMARY = '#FF7C3AED'
const COLOR_SECONDARY = '#FF22D3EE'
const COLOR_TERTIARY = '#FFF97316'
const COLOR_BACKGROUND = '#FF050714'
const COLOR_SURFACE = '#FF0F172A'
const COLOR_SURFACE_VARIANT = '#FF1F2937'
const COLOR_OUTLINE = '#FF334155'
const COLOR_ON_PRIMARY = '#FF050714'
const COLOR_ON_SECONDARY = '#FF011014'
const COLOR_ON_TERTIARY = '#FF110200'
const COLOR_ON_BACKGROUND = '#FFF8FAFC'
const COLOR_ON_SURFACE = '#FFE2E8F0'
const COLOR_ON_SURFACE_DIM = '#99E2E8F0'
const COLOR_ON_SURFACE_DIM2 = '#B3E2E8F0'

class ChatThread {
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean

  constructor(name: string, status: string, unread: number, snippet: string, isPriority: boolean) {
    this.name = name
    this.status = status
    this.unread = unread
    this.snippet = snippet
    this.isPriority = isPriority
  }
}

@Entry
@Component
struct RootScreen {
  @State activeFilter: string = 'Live'
  @State draft: string = ''
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Button({ type: ButtonType.Normal }) {
          Text('Hub')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
        }
        .backgroundColor(Color.Transparent)
        .borderRadius(12)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })

        Column() {
          Text('HoloChat Dock')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)
          Text('Dark neon bridge')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE_DIM)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .margin({ left: 8 })

        Button({ type: ButtonType.Normal }) {
          Text('Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_SECONDARY)
        }
        .backgroundColor(Color.Transparent)
        .borderRadius(12)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .padding({ left: 8, right: 8, top: 12, bottom: 12 })
      .backgroundColor(COLOR_SURFACE)
      .alignItems(VerticalAlign.Center)

      // Scrollable content
      Scroll() {
        Column({ space: 12 }) {
          // Filter chips row
          Row({ space: 8 }) {
            ForEach(this.filters, (label: string) => {
              Button({ type: ButtonType.Normal }) {
                Text(label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.activeFilter === label ? COLOR_ON_SECONDARY : COLOR_ON_SURFACE)
              }
              .backgroundColor(this.activeFilter === label ? COLOR_SECONDARY : COLOR_SURFACE_VARIANT)
              .borderRadius(12)
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .onClick(() => {
                this.activeFilter = label
              })
            })
          }
          .width('100%')

          // Status Summary
          StatusSummary()

          // Chat threads
          ForEach(this.threads, (thread: ChatThread) => {
            ChatThreadCard({ thread: thread })
          })

          // Action Footer
          ActionFooter()

          // Spacer for FAB
          Column().height(80)
        }
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Row({ space: 8 }) {
        Stack({ alignContent: Alignment.Start }) {
          TextInput({ placeholder: 'Message dock...', text: this.draft })
            .onChange((value: string) => {
              this.draft = value
            })
            .fontSize(14)
            .fontColor(COLOR_ON_SURFACE)
            .placeholderColor(COLOR_ON_SURFACE_DIM)
            .backgroundColor(COLOR_SURFACE)
            .borderRadius(16)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .layoutWeight(1)
            .caretColor(COLOR_SECONDARY)
        }
        .layoutWeight(1)

        Button({ type: ButtonType.Normal }) {
          Text('Send')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_PRIMARY)
        }
        .backgroundColor(COLOR_PRIMARY)
        .borderRadius(16)
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(COLOR_SURFACE_VARIANT)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLOR_BACKGROUND)
  }
}

@Component
struct StatusSummary {
  build() {
    Row({ space: 8 }) {
      SummaryBlock({ title: 'Live docks', value: '12', accent: COLOR_SECONDARY })
      SummaryBlock({ title: 'Escalations', value: '3', accent: COLOR_TERTIARY })
      SummaryBlock({ title: 'Queued', value: '5', accent: COLOR_PRIMARY })
    }
    .width('100%')
  }
}

@Component
struct SummaryBlock {
  title: string = ''
  value: string = ''
  accent: string = COLOR_SECONDARY

  build() {
    Column({ space: 4 }) {
      Circle({ width: 12, height: 12 })
        .fill(this.accent)

      Text(this.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE_DIM)

      Text(this.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.accent)
    }
    .layoutWeight(1)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(16)
    .padding(12)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChatThreadCard {
  thread: ChatThread = new ChatThread('', '', 0, '', false)

  build() {
    Column({ space: 8 }) {
      Row() {
        Column({ space: 4 }) {
          Text(this.thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_SURFACE)

          Text(this.thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.thread.isPriority ? COLOR_SECONDARY : COLOR_ON_SURFACE_DIM)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.thread.unread > 0 ? '+' + this.thread.unread.toString() : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(12)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(this.thread.snippet)
        .fontSize(14)
        .fontColor(COLOR_ON_SURFACE_DIM2)
        .width('100%')

      Row({ space: 8 }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(COLOR_ON_SURFACE)
          .backgroundColor(COLOR_SURFACE_VARIANT)
          .borderRadius(12)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })

        Button({ type: ButtonType.Normal }) {
          Text('Open')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_SECONDARY)
        }
        .backgroundColor(Color.Transparent)
        .borderRadius(12)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
    }
    .width('100%')
    .padding(12)
    .backgroundColor(COLOR_SURFACE)
    .borderRadius(20)
    .border({ width: 1, color: COLOR_OUTLINE })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: 8 }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(COLOR_ON_SURFACE)

      Row({ space: 8 }) {
        Button({ type: ButtonType.Normal }) {
          Text('Calm')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_PRIMARY)
        }
        .backgroundColor(COLOR_PRIMARY)
        .borderRadius(16)
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })

        Button({ type: ButtonType.Normal }) {
          Text('Fire')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLOR_ON_TERTIARY)
        }
        .backgroundColor(COLOR_TERTIARY)
        .borderRadius(16)
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      }
    }
    .width('100%')
    .padding(16)
    .backgroundColor(COLOR_SURFACE_VARIANT)
    .borderRadius(20)
    .alignItems(HorizontalAlign.Start)
  }
}