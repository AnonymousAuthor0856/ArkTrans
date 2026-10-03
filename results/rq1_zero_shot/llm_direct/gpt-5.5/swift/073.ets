class AppColors {
  static readonly primary: ResourceColor = '#7C3AED'
  static readonly secondary: ResourceColor = '#22D3EE'
  static readonly tertiary: ResourceColor = '#F97316'
  static readonly background: ResourceColor = '#050714'
  static readonly surface: ResourceColor = '#0F172A'
  static readonly surfaceVariant: ResourceColor = '#1F2937'
  static readonly outline: ResourceColor = '#334155'
  static readonly onPrimary: ResourceColor = '#050714'
  static readonly onSecondary: ResourceColor = '#011014'
  static readonly onTertiary: ResourceColor = '#110200'
  static readonly onBackground: ResourceColor = '#F8FAFC'
  static readonly onSurface: ResourceColor = '#E2E8F0'
  static readonly onSurface90: ResourceColor = '#E6E2E8F0'
  static readonly onSurface70: ResourceColor = '#B3E2E8F0'
  static readonly onSurface60: ResourceColor = '#99E2E8F0'
  static readonly black20: ResourceColor = '#33000000'
  static readonly transparent: ResourceColor = '#00000000'
}

class AppTypography {
  static readonly displaySize: number = 28
  static readonly headlineSize: number = 22
  static readonly titleSize: number = 16
  static readonly bodySize: number = 14
  static readonly labelSize: number = 12

  static readonly displayWeight: FontWeight = FontWeight.Medium
  static readonly headlineWeight: FontWeight = FontWeight.Medium
  static readonly titleWeight: FontWeight = FontWeight.Medium
  static readonly bodyWeight: FontWeight = FontWeight.Regular
  static readonly labelWeight: FontWeight = FontWeight.Medium
}

class AppSpacing {
  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
  static readonly xxl: number = 32
  static readonly xxxl: number = 44
}

class AppShapes {
  static readonly small: number = 12
  static readonly medium: number = 16
  static readonly large: number = 20
}

class ChatThread {
  id: string
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean

  constructor(name: string, status: string, unread: number, snippet: string, isPriority: boolean) {
    this.id = `${name}-${status}-${unread}`
    this.name = name
    this.status = status
    this.unread = unread
    this.snippet = snippet
    this.isPriority = isPriority
  }
}

@Entry
@Component
struct ContentView {
  build() {
    HoloChatDockScreen()
  }
}

@Component
struct HoloChatDockScreen {
  @State private activeFilter: string = 'Live'
  @State private draftMessage: string = ''

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        CustomTopBar()

        Scroll() {
          Column({ space: AppSpacing.md }) {
            Scroll() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  AssistChip({
                    label: filter,
                    isSelected: this.activeFilter === filter,
                    action: () => {
                      this.activeFilter = filter
                    }
                  })
                }, (filter: string) => filter)
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            StatusSummary()
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
                .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }, (thread: ChatThread) => thread.id)

            ActionFooter()
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            Blank()
              .height(100)
          }
          .width('100%')
          .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column() {
        Blank()

        Row() {
          Blank()

          Button({ type: ButtonType.Normal, stateEffect: true }) {
            Text('New')
              .fontSize(AppTypography.labelSize)
              .fontWeight(AppTypography.labelWeight)
              .fontColor(AppColors.onPrimary)
          }
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .shadow({ radius: 4, color: AppColors.black20, offsetX: 0, offsetY: 2 })
          .margin({ right: AppSpacing.lg, bottom: 80 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      BottomInputBar({ text: $draftMessage })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

@Component
struct CustomTopBar {
  build() {
    Row() {
      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Hub')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onSurface)
      }
      .padding(0)
      .backgroundColor(AppColors.transparent)

      Blank()

      Column() {
        Text('HoloChat Dock')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)

        Text('Dark neon bridge')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onSurface70)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Status')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.secondary)
      }
      .padding(0)
      .backgroundColor(AppColors.transparent)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct AssistChip {
  label: string = ''
  isSelected: boolean = false
  action: () => void = () => {}

  build() {
    Button({ type: ButtonType.Normal, stateEffect: true }) {
      Text(this.label)
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(this.isSelected ? AppColors.onSecondary : AppColors.onSurface)
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(this.isSelected ? AppColors.secondary : AppColors.surfaceVariant)
    .borderRadius(AppShapes.small)
    .border({
      width: this.isSelected ? 0 : 1,
      color: AppColors.outline,
      radius: AppShapes.small
    })
    .onClick(() => {
      this.action()
    })
  }
}

@Component
struct StatusSummary {
  build() {
    Row({ space: AppSpacing.sm }) {
      SummaryBlock({
        title: 'Live docks',
        value: '12',
        accent: AppColors.secondary
      })
        .layoutWeight(1)

      SummaryBlock({
        title: 'Escalations',
        value: '3',
        accent: AppColors.tertiary
      })
        .layoutWeight(1)

      SummaryBlock({
        title: 'Queued',
        value: '5',
        accent: AppColors.primary
      })
        .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct SummaryBlock {
  title: string = ''
  value: string = ''
  accent: ResourceColor = AppColors.secondary

  build() {
    Column({ space: AppSpacing.xs }) {
      Circle()
        .fill(this.accent)
        .width(12)
        .height(12)

      Text(this.title.toUpperCase())
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(AppColors.onSurface70)

      Text(this.value)
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
  }
}

@Component
struct ChatThreadCard {
  thread: ChatThread = new ChatThread('', '', 0, '', false)

  build() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Column({ space: AppSpacing.xs }) {
          Text(this.thread.name)
            .fontSize(AppTypography.headlineSize)
            .fontWeight(AppTypography.headlineWeight)
            .fontColor(AppColors.onSurface)

          Text(this.thread.status)
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(this.thread.isPriority ? AppColors.secondary : AppColors.onSurface70)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
      }
      .width('100%')

      Text(this.thread.snippet)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface90)
        .width('100%')

      Row({ space: AppSpacing.sm }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Open')
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.secondary)
        }
        .padding(0)
        .backgroundColor(AppColors.transparent)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({
      width: 1,
      color: AppColors.outline,
      radius: AppShapes.large
    })
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: AppSpacing.sm }) {
      Text('Dock filters')
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onSurface)

      Row({ space: AppSpacing.sm }) {
        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Calm')
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onPrimary)
        }
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)

        Button({ type: ButtonType.Normal, stateEffect: true }) {
          Text('Fire')
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onTertiary)
        }
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        .backgroundColor(AppColors.tertiary)
        .borderRadius(AppShapes.medium)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
  }
}

@Component
struct BottomInputBar {
  @Link text: string

  build() {
    Row({ space: AppSpacing.sm }) {
      TextInput({
        placeholder: 'Message dock...',
        text: this.text
      })
        .height(48)
        .layoutWeight(1)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(AppColors.onSurface)
        .placeholderColor(AppColors.onSurface60)
        .caretColor(AppColors.secondary)
        .padding({ left: AppSpacing.md, right: AppSpacing.md })
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .onChange((value: string) => {
          this.text = value
        })

      Button({ type: ButtonType.Normal, stateEffect: true }) {
        Text('Send')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onPrimary)
      }
      .height(48)
      .padding({ left: 20, right: 20 })
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.medium)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({ radius: 6, color: AppColors.black20, offsetX: 0, offsetY: -2 })
  }
}