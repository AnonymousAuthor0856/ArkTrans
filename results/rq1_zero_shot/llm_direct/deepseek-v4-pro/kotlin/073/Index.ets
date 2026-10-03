@Entry
@Component
struct HoloChatDock {
  @State activeFilter: string = 'Live'
  @State draft: string = ''
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ]

  @Builder
  TopBar() {
    Row() {
      Text('Hub')
        .fontSize(12)
        .fontColor('#E2E8F0')
        .padding({ left: 16, right: 8, top: 12, bottom: 12 })
        .onClick(() => {})

      Column() {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
        Text('Dark neon bridge')
          .fontSize(12)
          .fontColor('#B3E2E8F0')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('Status')
        .fontSize(12)
        .fontColor('#22D3EE')
        .padding({ left: 8, right: 16, top: 12, bottom: 12 })
        .onClick(() => {})
    }
    .width('100%')
    .height(56)
    .backgroundColor('#0F172A')
  }

  @Builder
  FilterChips() {
    Row({ space: 8 }) {
      ForEach(this.filters, (label: string) => {
        Text(label)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.activeFilter === label ? '#011014' : '#E2E8F0')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor(this.activeFilter === label ? '#22D3EE' : '#1F2937')
          .borderRadius(12)
          .onClick(() => {
            this.activeFilter = label
          })
      })
    }
  }

  @Builder
  SummaryBlock(title: string, value: string, accent: string) {
    Column({ space: 4 }) {
      Circle()
        .width(12)
        .height(12)
        .fill(accent)

      Text(title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3E2E8F0')

      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(accent)
    }
    .padding(12)
    .backgroundColor('#0F172A')
    .borderRadius(16)
    .layoutWeight(1)
  }

  @Builder
  StatusSummary() {
    Row({ space: 8 }) {
      this.SummaryBlock('Live docks', '12', '#22D3EE')
      this.SummaryBlock('Escalations', '3', '#F97316')
      this.SummaryBlock('Queued', '5', '#7C3AED')
    }
    .width('100%')
  }

  @Builder
  ChatThreadCard(thread: ChatThread) {
    Column({ space: 8 }) {
      Row() {
        Column({ space: 4 }) {
          Text(thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor('#E2E8F0')
          Text(thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(thread.isPriority ? '#22D3EE' : '#B3E2E8F0')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(thread.unread > 0 ? `+${thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor('#1F2937')
          .borderRadius(12)
      }
      .width('100%')

      Text(thread.snippet)
        .fontSize(14)
        .fontColor('#E6E2E8F0')

      Row({ space: 8 }) {
        Text(thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor('#1F2937')
          .borderRadius(12)

        Text('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#22D3EE')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .onClick(() => {})
      }
    }
    .padding(12)
    .backgroundColor('#0F172A')
    .borderRadius(20)
    .border({ width: 1, color: '#334155' })
    .width('100%')
  }

  @Builder
  ActionFooter() {
    Column({ space: 8 }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E2E8F0')

      Row({ space: 8 }) {
        Text('Calm')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#050714')
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .backgroundColor('#7C3AED')
          .borderRadius(16)
          .onClick(() => {})

        Text('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#110200')
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .backgroundColor('#F97316')
          .borderRadius(16)
          .onClick(() => {})
      }
    }
    .padding(16)
    .backgroundColor('#1F2937')
    .borderRadius(20)
    .width('100%')
  }

  @Builder
  BottomBar() {
    Row({ space: 8 }) {
      Stack() {
        if (this.draft.length === 0) {
          Text('Message dock...')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#99E2E8F0')
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        }
        TextInput({ text: this.draft, placeholder: '' })
          .fontSize(14)
          .fontColor('#E2E8F0')
          .placeholderColor('#99E2E8F0')
          .placeholderFont({ size: 12, weight: FontWeight.Medium })
          .backgroundColor('#0F172A')
          .borderRadius(16)
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .layoutWeight(1)
          .onChange((value: string) => {
            this.draft = value
          })
      }
      .layoutWeight(1)

      Text('Send')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#050714')
        .padding({ left: 16, right: 16, top: 8, bottom: 8 })
        .backgroundColor('#7C3AED')
        .borderRadius(16)
        .onClick(() => {})
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor('#1F2937')
  }

  build() {
    Column() {
      this.TopBar()

      Scroll() {
        Column({ space: 12 }) {
          this.FilterChips()
          this.StatusSummary()

          ForEach(this.threads, (thread: ChatThread) => {
            this.ChatThreadCard(thread)
          })

          this.ActionFooter()
        }
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .width('100%')
      }
      .layoutWeight(1)
      .align(Alignment.Top)

      this.BottomBar()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#050714')
  }
}

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