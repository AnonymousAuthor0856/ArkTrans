@Entry
@Component
struct HoloChatApp {
  build() {
    HoloChatDockScreen()
  }
}

// App Tokens
class AppTokens {
  static readonly Colors = {
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
    onSurface: '#E2E8F0'
  }

  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 44
  }

  static readonly Shapes = {
    small: 12,
    medium: 16,
    large: 20
  }
}

// Model
interface ChatThread {
  id: string
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean
}

@Component
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live'
  @State draftMessage: string = ''

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThread[] = [
    {
      id: '1',
      name: 'Orbital Finance',
      status: 'Rolling sync',
      unread: 5,
      snippet: 'Need rates for Q4',
      isPriority: true
    },
    {
      id: '2',
      name: 'Beacon Ops',
      status: 'Docked',
      unread: 0,
      snippet: 'Switching to holo feed',
      isPriority: false
    },
    {
      id: '3',
      name: 'Nova Crew',
      status: 'Hotline',
      unread: 2,
      snippet: 'Uploading scan pack now',
      isPriority: true
    }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppTokens.Colors.background)

      // Main content
      Column() {
        CustomTopBar()

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Filters
            Scroll() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  AssistChip({
                    label: filter,
                    isSelected: this.activeFilter === filter,
                    onTap: () => {
                      this.activeFilter = filter
                    }
                  })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Status Summary
            StatusSummary()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Threads List
            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            })

            // Action Footer
            ActionFooter()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Spacer
            Row()
              .height(100)
          }
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // FAB
      Column() {
        Blank()
          .layoutWeight(1)
        Row() {
          Blank()
            .layoutWeight(1)
          Button('New')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .shadow({ radius: 4, color: '#40000000', offsetY: 2 })
            .margin({ right: AppTokens.Spacing.lg, bottom: 80 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      BottomInputBar({ text: $draftMessage })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

@Component
struct CustomTopBar {
  build() {
    Row() {
      Button('Hub')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(Color.Transparent)

      Blank()
        .layoutWeight(1)

      Column({ space: 2 }) {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3E2E8F0')
      }
      .alignItems(HorizontalAlign.Center)

      Blank()
        .layoutWeight(1)

      Button('Status')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.secondary)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct AssistChip {
  label: string = ''
  isSelected: boolean = false
  onTap: () => void = () => {}

  build() {
    Button(this.label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .border({
        width: this.isSelected ? 0 : 1,
        color: AppTokens.Colors.outline,
        radius: AppTokens.Shapes.small
      })
      .onClick(() => {
        this.onTap()
      })
  }
}

@Component
struct StatusSummary {
  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      SummaryBlock({ title: 'Live docks', value: '12', accent: AppTokens.Colors.secondary })
        .layoutWeight(1)
      SummaryBlock({ title: 'Escalations', value: '3', accent: AppTokens.Colors.tertiary })
        .layoutWeight(1)
      SummaryBlock({ title: 'Queued', value: '5', accent: AppTokens.Colors.primary })
        .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct SummaryBlock {
  title: string = ''
  value: string = ''
  accent: string = '#FFFFFF'

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Circle()
        .width(12)
        .height(12)
        .fill(this.accent)

      Text(this.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3E2E8F0')

      Text(this.value)
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
  }
}

@Component
struct ChatThreadCard {
  thread: ChatThread = {
    id: '',
    name: '',
    status: '',
    unread: 0,
    snippet: '',
    isPriority: false
  }

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text(this.thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Text(this.thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.thread.isPriority ? AppTokens.Colors.secondary : '#B3E2E8F0')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
          .layoutWeight(1)

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')

      Text(this.thread.snippet)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor('#E6E2E8F0')
        .width('100%')

      Row({ space: AppTokens.Spacing.sm }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

        Button('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
          .backgroundColor(Color.Transparent)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({
      width: 1,
      color: AppTokens.Colors.outline,
      radius: AppTokens.Shapes.large
    })
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Row({ space: AppTokens.Spacing.sm }) {
        Button('Calm')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)

        Button('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onTertiary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
  }
}

@Component
struct BottomInputBar {
  @Link text: string

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      Stack({ alignContent: Alignment.Start }) {
        if (this.text === '') {
          Text('Message dock...')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#99E2E8F0')
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        }
        TextInput({ placeholder: '', text: $text })
          .fontSize(14)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .backgroundColor(Color.Transparent)
          .height(48)
      }
      .height(48)
      .backgroundColor(AppTokens.Colors.surface)
      .borderRadius(AppTokens.Shapes.medium)
      .layoutWeight(1)

      Button('Send')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: 20, right: 20 })
        .height(48)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .shadow({ radius: 6, color: '#33000000', offsetY: -2 })
  }
}