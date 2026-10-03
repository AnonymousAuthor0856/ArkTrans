// Colors
const ColPrimary: string = '#7C3AED';
const ColSecondary: string = '#22D3EE';
const ColTertiary: string = '#F97316';
const ColBackground: string = '#050714';
const ColSurface: string = '#0F172A';
const ColSurfaceVariant: string = '#1F2937';
const ColOutline: string = '#334155';
const ColOnPrimary: string = '#050714';
const ColOnSecondary: string = '#011014';
const ColOnTertiary: string = '#110200';
const ColOnSurface: string = '#E2E8F0';
const ColOnSurfaceDim: string = '#8899AA';

class ChatThread {
  id: number = 0;
  name: string = '';
  status: string = '';
  unread: number = 0;
  snippet: string = '';
  isPriority: boolean = false;
}

const threads: ChatThread[] = [
  { id: 1, name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
  { id: 2, name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
  { id: 3, name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true },
]

const filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']

@Entry
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live'
  @State draftMessage: string = ''

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        TopBar()

        Scroll() {
          Column({ space: 12 }) {
            Scroll() {
              Row({ space: 8 }) {
                ForEach(filters, (filter: string) => {
                  AssistChip({
                    label: filter,
                    isSelected: this.activeFilter === filter,
                    onAction: () => {
                      this.activeFilter = filter
                    }
                  })
                }, (filter: string) => filter)
              }
              .padding({ left: 16, right: 16 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .align(Alignment.Start)

            StatusSummary()
              .padding({ left: 16, right: 16 })

            ForEach(threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
                .padding({ left: 16, right: 16 })
            }, (thread: ChatThread) => thread.id.toString())

            ActionFooter()
              .padding({ left: 16, right: 16 })

            Column().height(120)
          }
          .padding({ top: 12, bottom: 12 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ColBackground)

      Row() {
        Blank()
        Button('New')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColOnPrimary)
          .backgroundColor(ColPrimary)
          .borderRadius(16)
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
          .margin({ right: 16, bottom: 80 })
          .shadow({ radius: 4, color: '#00000066', offsetX: 0, offsetY: 2 })
      }
      .width('100%')

      BottomInputBar({ text: $draftMessage })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct TopBar {
  build() {
    Row() {
      Button('Hub')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColOnSurface)
        .backgroundColor(Color.Transparent)
        .padding(0)

      Blank()

      Column({ space: 2 }) {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColOnSurface)
        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColOnSurfaceDim)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Status')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColSecondary)
        .backgroundColor(Color.Transparent)
        .padding(0)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(ColSurface)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct AssistChip {
  label: string = ''
  isSelected: boolean = false
  onAction: () => void = () => {}

  build() {
    Button(this.label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? ColOnSecondary : ColOnSurface)
      .backgroundColor(this.isSelected ? ColSecondary : ColSurfaceVariant)
      .borderRadius(12)
      .border(this.isSelected ?
        { width: 0, color: Color.Transparent } :
        { width: 1, color: ColOutline })
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .onClick(() => this.onAction())
  }
}

@Component
struct StatusSummary {
  build() {
    Row({ space: 8 }) {
      SummaryBlock({ title: 'Live docks', value: '12', accent: ColSecondary })
      SummaryBlock({ title: 'Escalations', value: '3', accent: ColTertiary })
      SummaryBlock({ title: 'Queued', value: '5', accent: ColPrimary })
    }
    .width('100%')
  }
}

@Component
struct SummaryBlock {
  title: string = ''
  value: string = ''
  accent: string = ''

  build() {
    Column({ space: 4 }) {
      Circle()
        .fill(this.accent)
        .width(12)
        .height(12)

      Text(this.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColOnSurfaceDim)

      Text(this.value)
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .layoutWeight(1)
    .backgroundColor(ColSurface)
    .borderRadius(16)
  }
}

@Component
struct ChatThreadCard {
  thread: ChatThread = new ChatThread()

  build() {
    Column({ space: 8 }) {
      Row() {
        Column({ space: 4 }) {
          Text(this.thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColOnSurface)

          Text(this.thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.thread.isPriority ? ColSecondary : ColOnSurfaceDim)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColOnSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(ColSurfaceVariant)
          .borderRadius(12)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.thread.snippet)
        .fontSize(14)
        .fontColor(ColOnSurface)
        .opacity(0.9)
        .width('100%')

      Row({ space: 8 }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColOnSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(ColSurfaceVariant)
          .borderRadius(12)

        Button('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColSecondary)
          .backgroundColor(Color.Transparent)
          .padding(0)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .width('100%')
    .backgroundColor(ColSurface)
    .borderRadius(20)
    .border({ width: 1, color: ColOutline })
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: 8 }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColOnSurface)

      Row({ space: 8 }) {
        Button('Calm')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColOnPrimary)
          .backgroundColor(ColPrimary)
          .borderRadius(16)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })

        Button('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ColOnTertiary)
          .backgroundColor(ColTertiary)
          .borderRadius(16)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .backgroundColor(ColSurfaceVariant)
    .borderRadius(20)
  }
}

@Component
struct BottomInputBar {
  @Link text: string

  build() {
    Row({ space: 8 }) {
      Stack({ alignContent: Alignment.Start }) {
        if (this.text.length === 0) {
          Text('Message dock...')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(ColOnSurfaceDim)
            .padding({ left: 12, right: 12 })
            .zIndex(1)
        }
        TextInput({ text: $$this.text })
          .fontSize(14)
          .fontColor(ColOnSurface)
          .backgroundColor(Color.Transparent)
          .padding({ left: 12, right: 12, top: 8, bottom: 8 })
          .caretColor(ColSecondary)
          .placeholderColor(Color.Transparent)
          .width('100%')
          .zIndex(2)
      }
      .height(48)
      .layoutWeight(1)
      .backgroundColor(ColSurface)
      .borderRadius(16)

      Button('Send')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(ColOnPrimary)
        .backgroundColor(ColPrimary)
        .borderRadius(16)
        .padding({ left: 20, right: 20 })
        .height(48)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(ColSurfaceVariant)
    .shadow({ radius: 6, color: '#33000000', offsetX: 0, offsetY: -2 })
  }
}