// Index.ets - HoloChat Dock

const colorPrimary: string = '#7C3AED'
const colorSecondary: string = '#22D3EE'
const colorTertiary: string = '#F97316'
const colorBackground: string = '#050714'
const colorSurface: string = '#0F172A'
const colorSurfaceVariant: string = '#1F2937'
const colorOutline: string = '#334155'
const colorOnSurface: string = '#E2E8F0'
const colorOnSecondary: string = '#011014'
const colorOnTertiary: string = '#110200'
const colorOnPrimary: string = '#050714'

interface ChatThreadData {
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean
}

@Component
struct SummaryBlock {
  title: string = ''
  value: string = ''
  accent: string = '#FFFFFF'

  build() {
    Column({ space: 4 }) {
      Circle({ width: 12, height: 12 })
        .fill(this.accent)
      Text(this.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B0BEC5')
      Text(this.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(colorSurface)
    .borderRadius(16)
    .padding(12)
    .layoutWeight(1)
  }
}

@Component
struct ChatThreadCard {
  thread: ChatThreadData = { name: '', status: '', unread: 0, snippet: '', isPriority: false }

  build() {
    Column({ space: 8 }) {
      Row() {
        Column({ space: 4 }) {
          Text(this.thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnSurface)
          Text(this.thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.thread.isPriority ? colorSecondary : '#99A8B8')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSurface)
          .backgroundColor(colorSurfaceVariant)
          .borderRadius(12)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(this.thread.snippet)
        .fontSize(14)
        .fontColor('#D0D8E4')
        .width('100%')

      Row({ space: 8 }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSurface)
          .backgroundColor(colorSurfaceVariant)
          .borderRadius(12)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })

        Text('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorSecondary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .width('100%')
    .backgroundColor(colorSurface)
    .borderRadius(20)
    .border({ width: 1, color: colorOutline })
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: 8 }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(colorOnSurface)

      Row({ space: 8 }) {
        Button('Calm')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(colorPrimary)
          .fontColor(colorOnPrimary)
          .borderRadius(16)
          .height(36)

        Button('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(colorTertiary)
          .fontColor(colorOnTertiary)
          .borderRadius(16)
          .height(36)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .backgroundColor(colorSurfaceVariant)
    .borderRadius(20)
  }
}

@Entry
@Component
struct Index {
  @State activeFilter: string = 'Live'
  @State draft: string = ''
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThreadData[] = [
    { name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
    { name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
    { name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true }
  ]

  build() {
    Column() {
      // TopAppBar
      Row() {
        Text('Hub')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorOnSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })

        Column({ space: 2 }) {
          Text('HoloChat Dock')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(colorOnSurface)
          Text('Dark neon bridge')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#99A8B8')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .padding({ left: 8 })

        Text('Status')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(colorSecondary)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      .backgroundColor(colorSurface)
      .alignItems(VerticalAlign.Center)

      // Main scrollable content
      Stack({ alignContent: Alignment.BottomEnd }) {
        Scroll() {
          Column({ space: 12 }) {
            // Filter chips
            Row({ space: 8 }) {
              ForEach(this.filters, (label: string) => {
                Text(label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.activeFilter === label ? colorOnSecondary : colorOnSurface)
                  .backgroundColor(this.activeFilter === label ? colorSecondary : colorSurfaceVariant)
                  .borderRadius(12)
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
                  .onClick(() => {
                    this.activeFilter = label
                  })
              })
            }
            .width('100%')

            // Status Summary
            Row({ space: 8 }) {
              SummaryBlock({ title: 'Live docks', value: '12', accent: colorSecondary })
              SummaryBlock({ title: 'Escalations', value: '3', accent: colorTertiary })
              SummaryBlock({ title: 'Queued', value: '5', accent: colorPrimary })
            }
            .width('100%')

            // Chat Thread Cards
            ForEach(this.threads, (thread: ChatThreadData) => {
              ChatThreadCard({ thread: thread })
            })

            // Action Footer
            ActionFooter()

            // Bottom padding for bottom bar
            Column()
              .height(80)
          }
          .padding({ left: 16, right: 16, top: 12, bottom: 12 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)

        // FAB
        Button('New')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(colorPrimary)
          .fontColor(colorOnPrimary)
          .borderRadius(16)
          .width(64)
          .height(56)
          .margin({ right: 16, bottom: 80 })
      }
      .layoutWeight(1)
      .width('100%')

      // Bottom Bar
      Row({ space: 8 }) {
        Stack({ alignContent: Alignment.TopStart }) {
          TextInput({ placeholder: 'Message dock...', text: this.draft })
            .fontSize(14)
            .fontColor(colorOnSurface)
            .placeholderColor('#99A8B8')
            .backgroundColor(colorSurface)
            .borderRadius(16)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .layoutWeight(1)
            .onChange((value: string) => {
              this.draft = value
            })
        }
        .layoutWeight(1)

        Button('Send')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(colorPrimary)
          .fontColor(colorOnPrimary)
          .borderRadius(16)
          .height(44)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(colorSurfaceVariant)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(colorBackground)
  }
}