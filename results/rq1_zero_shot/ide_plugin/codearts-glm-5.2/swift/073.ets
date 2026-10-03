class AppTokens {
  static readonly Colors = {
    primary: '#FF7C3AED',
    secondary: '#FF22D3EE',
    tertiary: '#FFF97316',
    background: '#FF050714',
    surface: '#FF0F172A',
    surfaceVariant: '#FF1F2937',
    outline: '#FF334155',
    onPrimary: '#FF050714',
    onSecondary: '#FF011014',
    onTertiary: '#FF110200',
    onBackground: '#FFF8FAFC',
    onSurface: '#FFE2E8F0',
    onSurface70: '#B3E2E8F0',
    onSurface90: '#E6E2E8F0',
    onSurface60: '#99E2E8F0',
  }
  static readonly Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 44,
  }
  static readonly Shapes = {
    small: 12,
    medium: 16,
    large: 20,
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

@Entry
@Component
struct Index {
  @State activeFilter: string = 'Live'
  @State draftMessage: string = ''
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true),
  ]

  build() {
    Stack() {
      Column() {
        CustomTopBar()

        Scroll() {
          Column() {
            Scroll() {
              Row() {
                ForEach(this.filters, (filter: string) => {
                  AssistChip({
                    label: filter,
                    isSelected: this.activeFilter === filter,
                    onSelect: (f: string) => { this.activeFilter = f }
                  })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            StatusSummary()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({
                threadName: thread.name,
                threadStatus: thread.status,
                threadUnread: thread.unread,
                threadSnippet: thread.snippet,
                threadIsPriority: thread.isPriority
              })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            })

            ActionFooter()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            Blank().height(100)
          }
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }

      Stack() {
        Row() {
          Blank()
          Text('New')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .shadow({ radius: 4, color: '#66000000', offsetY: 2 })
        }
        .padding({ right: AppTokens.Spacing.lg, bottom: 80 })
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .alignContent(Alignment.Bottom)

      BottomInputBar({ text: this.draftMessage })
    }
    .backgroundColor(AppTokens.Colors.background)
    .width('100%')
    .height('100%')
    .alignContent(Alignment.Bottom)
  }
}

@Component
struct CustomTopBar {
  build() {
    Row() {
      Text('Hub')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Blank()

      Column() {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface70)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('Status')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.secondary)
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surface)
  }
}

@Component
struct AssistChip {
  @Prop label: string = ''
  @Prop isSelected: boolean = false
  onSelect: (filter: string) => void = (filter: string) => {}

  build() {
    Text(this.label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: this.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
      .onClick(() => { this.onSelect(this.label) })
  }
}

@Component
struct StatusSummary {
  build() {
    Row() {
      SummaryBlock({ title: 'Live docks', value: '12', accent: AppTokens.Colors.secondary })
      SummaryBlock({ title: 'Escalations', value: '3', accent: AppTokens.Colors.tertiary })
      SummaryBlock({ title: 'Queued', value: '5', accent: AppTokens.Colors.primary })
    }
  }
}

@Component
struct SummaryBlock {
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop accent: string = '#FFFFFF'

  build() {
    Column() {
      Circle({ width: 12, height: 12 })
        .fill(this.accent)

      Text(this.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface70)
        .margin({ top: AppTokens.Spacing.xs })

      Text(this.value)
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.accent)
    }
    .padding(AppTokens.Spacing.md)
    .layoutWeight(1)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChatThreadCard {
  @Prop threadName: string = ''
  @Prop threadStatus: string = ''
  @Prop threadUnread: number = 0
  @Prop threadSnippet: string = ''
  @Prop threadIsPriority: boolean = false

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.threadName)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)

          Text(this.threadStatus)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.threadIsPriority ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface70)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(this.threadUnread > 0 ? `+${this.threadUnread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
      }

      Text(this.threadSnippet)
        .fontSize(14)
        .fontColor(AppTokens.Colors.onSurface90)
        .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Text(this.threadIsPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

        Text('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ActionFooter {
  build() {
    Column() {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)

      Row() {
        Text('Calm')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)

        Text('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onTertiary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .margin({ top: AppTokens.Spacing.sm })
    }
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct BottomInputBar {
  @Prop text: string = ''

  build() {
    Row() {
      TextInput({ text: this.text, placeholder: 'Message dock...' })
        .fontSize(14)
        .fontColor(AppTokens.Colors.onSurface)
        .placeholderColor(AppTokens.Colors.onSurface60)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .height(48)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .layoutWeight(1)

      Text('Send')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: 20, right: 20 })
        .height(48)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .shadow({ radius: 6, color: '#33000000', offsetY: -2 })
  }
}