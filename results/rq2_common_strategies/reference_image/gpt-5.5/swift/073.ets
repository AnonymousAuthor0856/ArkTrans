class AppColors {
  static readonly primary: string = '#7C3AED'
  static readonly secondary: string = '#22D3EE'
  static readonly tertiary: string = '#F97316'
  static readonly background: string = '#050714'
  static readonly surface: string = '#0F172A'
  static readonly surfaceVariant: string = '#1F2937'
  static readonly outline: string = '#334155'
  static readonly onPrimary: string = '#050714'
  static readonly onSecondary: string = '#011014'
  static readonly onTertiary: string = '#110200'
  static readonly onBackground: string = '#F8FAFC'
  static readonly onSurface: string = '#E2E8F0'
  static readonly onSurface70: string = '#B3E2E8F0'
  static readonly onSurface90: string = '#E6E2E8F0'
  static readonly onSurface60: string = '#99E2E8F0'
}

class AppTypography {
  static readonly display: number = 28
  static readonly headline: number = 22
  static readonly title: number = 16
  static readonly body: number = 14
  static readonly label: number = 12
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
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live'
  @State draftMessage: string = ''

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']

  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ]

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
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
                    onTap: () => {
                      this.activeFilter = filter
                    }
                  })
                }, (filter: string) => filter)
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            StatusSummary()
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
                .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }, (thread: ChatThread) => thread.name)

            ActionFooter()
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            Blank()
              .height(112)
          }
          .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Text('New')
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .width(58)
        .height(46)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .shadow({ radius: 4, color: '#66000000', offsetX: 0, offsetY: 2 })
        .margin({ right: AppSpacing.lg, bottom: 80 })
        .onClick(() => {
        })

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
      Text('Hub')
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .onClick(() => {
        })

      Blank()
        .layoutWeight(1)

      Column() {
        Text('HoloChat Dock')
          .fontSize(AppTypography.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Text('Dark neon bridge')
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface70)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Text('Status')
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .onClick(() => {
        })
    }
    .width('100%')
    .height(50)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct AssistChip {
  @Prop label: string = ''
  @Prop isSelected: boolean = false
  onTap: () => void = () => {
  }

  build() {
    Text(this.label)
      .fontSize(AppTypography.label)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppColors.onSecondary : AppColors.onSurface)
      .textAlign(TextAlign.Center)
      .height(30)
      .padding({ left: 16, right: 16 })
      .backgroundColor(this.isSelected ? AppColors.secondary : AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .border({
        width: this.isSelected ? 0 : 1,
        color: AppColors.outline
      })
      .onClick(() => {
        this.onTap()
      })
  }
}

@Component
struct StatusSummary {
  build() {
    Row({ space: AppSpacing.sm }) {
      SummaryBlock({ title: 'Live docks', value: '12', accent: AppColors.secondary })
        .layoutWeight(1)

      SummaryBlock({ title: 'Escalations', value: '3', accent: AppColors.tertiary })
        .layoutWeight(1)

      SummaryBlock({ title: 'Queued', value: '5', accent: AppColors.primary })
        .layoutWeight(1)
    }
    .width('100%')
  }
}

@Component
struct SummaryBlock {
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop accent: string = AppColors.secondary

  build() {
    Column({ space: AppSpacing.xs }) {
      Row()
        .width(12)
        .height(12)
        .borderRadius(6)
        .backgroundColor(this.accent)

      Text(this.title.toUpperCase())
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface70)

      Text(this.value)
        .fontSize(AppTypography.display)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .height(92)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
  }
}

@Component
struct ChatThreadCard {
  @Prop thread: ChatThread = new ChatThread('', '', 0, '', false)

  build() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Column({ space: AppSpacing.xs }) {
          Text(this.thread.name)
            .fontSize(AppTypography.headline)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Text(this.thread.status)
            .fontSize(AppTypography.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.thread.isPriority ? AppColors.secondary : AppColors.onSurface70)
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
          .layoutWeight(1)

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
      }
      .width('100%')

      Text(this.thread.snippet)
        .fontSize(AppTypography.body)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface90)
        .width('100%')

      Row({ space: AppSpacing.sm }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)

        Text('Open')
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .onClick(() => {
          })
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: AppSpacing.sm }) {
      Text('Dock filters')
        .fontSize(AppTypography.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Row({ space: AppSpacing.sm }) {
        Text('Calm')
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .textAlign(TextAlign.Center)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
          })

        Text('Fire')
          .fontSize(AppTypography.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
          .textAlign(TextAlign.Center)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppColors.tertiary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {
          })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
  }
}

@Component
struct BottomInputBar {
  @Link text: string

  build() {
    Row({ space: AppSpacing.sm }) {
      TextInput({ text: this.text, placeholder: 'Message dock...' })
        .fontSize(AppTypography.body)
        .fontColor(AppColors.onSurface)
        .placeholderColor(AppColors.onSurface60)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .height(48)
        .padding({ left: AppSpacing.md, right: AppSpacing.md })
        .layoutWeight(1)
        .onChange((value: string) => {
          this.text = value
        })

      Text('Send')
        .fontSize(AppTypography.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .height(48)
        .padding({ left: 20, right: 20 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({ radius: 6, color: '#33000000', offsetX: 0, offsetY: -2 })
  }
}