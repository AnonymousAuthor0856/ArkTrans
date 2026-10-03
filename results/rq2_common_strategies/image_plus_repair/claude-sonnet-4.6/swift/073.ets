interface ColorTokens {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

const Colors: ColorTokens = {
  primary: '#7C3AED',
  secondary: '#22D3EE',
  tertiary: '#F97316',
  background: '#050714',
  surface: '#0F172A',
  surfaceVariant: '#1F2937',
  outline: '#334155',
  onPrimary: '#050714',
  onSecondary: '#011014',
  onTertiary: '#110200',
  onBackground: '#F8FAFC',
  onSurface: '#E2E8F0',
}

interface ChatThreadData {
  id: number;
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;
}

@Entry
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live'
  @State draftMessage: string = ''

  filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  threads: ChatThreadData[] = [
    { id: 1, name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
    { id: 2, name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
    { id: 3, name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true },
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: 12 }) {
            Scroll() {
              Row({ space: 8 }) {
                ForEach(this.filters, (filter: string) => {
                  this.AssistChip(filter, this.activeFilter === filter, () => {
                    this.activeFilter = filter
                  })
                })
              }
              .padding({ left: 16, right: 16 })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')
            .align(Alignment.Start)

            Row({ space: 8 }) {
              this.SummaryBlock('Live docks', '12', Colors.secondary)
              this.SummaryBlock('Escalations', '3', Colors.tertiary)
              this.SummaryBlock('Queued', '5', Colors.primary)
            }
            .width('100%')
            .padding({ left: 16, right: 16 })

            ForEach(this.threads, (thread: ChatThreadData) => {
              this.ChatThreadCard(thread)
            })

            this.ActionFooter()

            Column().height(100)
          }
          .padding({ top: 12, bottom: 12 })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
        .backgroundColor(Colors.background)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)

      Column() {
        Row() {
          Blank()
          Button('New')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onPrimary)
            .backgroundColor(Colors.primary)
            .borderRadius(16)
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
            .margin({ right: 16, bottom: 80 })
        }
        .width('100%')
      }
      .width('100%')

      Row({ space: 8 }) {
        Stack({ alignContent: Alignment.Start }) {
          if (this.draftMessage === '') {
            Text('Message dock...')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#99E2E8F0')
              .padding({ left: 12, right: 12 })
          }
          TextInput({ text: this.draftMessage, placeholder: '' })
            .fontSize(14)
            .fontColor(Colors.onSurface)
            .backgroundColor(Colors.surface)
            .borderRadius(16)
            .padding({ left: 12, right: 12, top: 8, bottom: 8 })
            .height(48)
            .onChange((value: string) => {
              this.draftMessage = value
            })
        }
        .height(48)
        .backgroundColor(Colors.surface)
        .borderRadius(16)
        .layoutWeight(1)

        Button('Send')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(16)
          .padding({ left: 20, right: 20 })
          .height(48)
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(Colors.surfaceVariant)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }

  @Builder
  TopBar() {
    Row() {
      Button('Hub')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
        .backgroundColor(Color.Transparent)

      Blank()

      Column({ space: 2 }) {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B2E2E8F0')
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Button('Status')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.secondary)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(Colors.surface)
  }

  @Builder
  AssistChip(label: string, isSelected: boolean, action: () => void) {
    Button(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(isSelected ? Colors.onSecondary : Colors.onSurface)
      .backgroundColor(isSelected ? Colors.secondary : Colors.surfaceVariant)
      .borderRadius(12)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .border({ width: isSelected ? 0 : 1, color: Colors.outline, radius: 12 })
      .onClick(action)
  }

  @Builder
  SummaryBlock(title: string, value: string, accent: string) {
    Column({ space: 4 }) {
      Circle()
        .fill(accent)
        .width(12)
        .height(12)

      Text(title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B2E2E8F0')

      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .layoutWeight(1)
    .backgroundColor(Colors.surface)
    .borderRadius(16)
  }

  @Builder
  ChatThreadCard(thread: ChatThreadData) {
    Column({ space: 8 }) {
      Row() {
        Column({ space: 4 }) {
          Text(thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)

          Text(thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(thread.isPriority ? Colors.secondary : '#B2E2E8F0')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(thread.unread > 0 ? '+' + thread.unread.toString() : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(12)
      }
      .width('100%')

      Text(thread.snippet)
        .fontSize(14)
        .fontColor('#E6E2E8F0')
        .width('100%')

      Row({ space: 8 }) {
        Text(thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(12)

        Button('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
          .backgroundColor(Color.Transparent)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(12)
    .width('100%')
    .backgroundColor(Colors.surface)
    .borderRadius(20)
    .border({ width: 1, color: Colors.outline, radius: 20 })
    .margin({ left: 16, right: 16 })
  }

  @Builder
  ActionFooter() {
    Column({ space: 8 }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)

      Row({ space: 8 }) {
        Button('Calm')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(16)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })

        Button('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onTertiary)
          .backgroundColor(Colors.tertiary)
          .borderRadius(16)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(16)
    .width('100%')
    .backgroundColor(Colors.surfaceVariant)
    .borderRadius(20)
    .margin({ left: 16, right: 16 })
  }
}