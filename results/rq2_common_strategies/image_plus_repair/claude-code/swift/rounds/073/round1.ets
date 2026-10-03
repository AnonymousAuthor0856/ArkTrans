class AppColors {
  static readonly primary: string = '#FF7C3AED'
  static readonly secondary: string = '#FF22D3EE'
  static readonly tertiary: string = '#FFF97316'
  static readonly background: string = '#FF050714'
  static readonly surface: string = '#FF0F172A'
  static readonly surfaceVariant: string = '#FF1F2937'
  static readonly outline: string = '#FF334155'
  static readonly onPrimary: string = '#FF050714'
  static readonly onSecondary: string = '#FF011014'
  static readonly onTertiary: string = '#FF110200'
  static readonly onBackground: string = '#FFF8FAFC'
  static readonly onSurface: string = '#FFE2E8F0'
}

class FontSpec {
  size: number = 0
  weight: FontWeight = FontWeight.Regular
  constructor(size: number, weight: FontWeight) {
    this.size = size
    this.weight = weight
  }
}

class AppTypography {
  static readonly display: FontSpec = new FontSpec(28, FontWeight.SemiBold)
  static readonly headline: FontSpec = new FontSpec(22, FontWeight.Medium)
  static readonly title: FontSpec = new FontSpec(16, FontWeight.Medium)
  static readonly body: FontSpec = new FontSpec(14, FontWeight.Regular)
  static readonly label: FontSpec = new FontSpec(12, FontWeight.Medium)
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

interface ChatThread {
  id: string
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean
}

@Component
struct CustomTopBar {
  build() {
    Row() {
      Text('Hub')
        .fontSize(AppTypography.label.size)
        .fontWeight(AppTypography.label.weight)
        .fontColor(AppColors.onSurface)

      Column() {
        Text('HoloChat Dock')
          .fontSize(AppTypography.title.size)
          .fontWeight(AppTypography.title.weight)
          .fontColor(AppColors.onSurface)
        Text('Dark neon bridge')
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('Status')
        .fontSize(AppTypography.label.size)
        .fontWeight(AppTypography.label.weight)
        .fontColor(AppColors.secondary)
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
  onSelect: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(AppTypography.label.size)
      .fontWeight(AppTypography.label.weight)
      .fontColor(this.isSelected ? AppColors.onSecondary : AppColors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppColors.secondary : AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .border({ width: this.isSelected ? 0 : 1, color: AppColors.outline })
      .onClick(() => this.onSelect())
  }
}

@Component
struct SummaryBlock {
  title: string = ''
  value: string = ''
  accent: string = ''

  build() {
    Column() {
      Circle({ width: 12, height: 12 })
        .fill(this.accent)

      Text(this.title.toUpperCase())
        .fontSize(AppTypography.label.size)
        .fontWeight(AppTypography.label.weight)
        .fontColor(AppColors.onSurface)
        .opacity(0.7)
        .margin({ top: AppSpacing.xs })

      Text(this.value)
        .fontSize(AppTypography.display.size)
        .fontWeight(AppTypography.display.weight)
        .fontColor(this.accent)
        .margin({ top: AppSpacing.xs })
    }
    .alignItems(HorizontalAlign.Start)
    .width('33%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
  }
}

@Component
struct StatusSummary {
  build() {
    Row() {
      SummaryBlock({ title: 'Live docks', value: '12', accent: AppColors.secondary })
      SummaryBlock({ title: 'Escalations', value: '3', accent: AppColors.tertiary })
      SummaryBlock({ title: 'Queued', value: '5', accent: AppColors.primary })
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

@Component
struct ChatThreadCard {
  thread: ChatThread = { id: '', name: '', status: '', unread: 0, snippet: '', isPriority: false }

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.thread.name)
            .fontSize(AppTypography.headline.size)
            .fontWeight(AppTypography.headline.weight)
            .fontColor(AppColors.onSurface)

          Text(this.thread.status)
            .fontSize(AppTypography.label.size)
            .fontWeight(AppTypography.label.weight)
            .fontColor(this.thread.isPriority ? AppColors.secondary : AppColors.onSurface)
            .opacity(this.thread.isPriority ? 1 : 0.7)
            .margin({ top: AppSpacing.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
      }
      .width('100%')

      Text(this.thread.snippet)
        .fontSize(AppTypography.body.size)
        .fontWeight(AppTypography.body.weight)
        .fontColor(AppColors.onSurface)
        .opacity(0.9)
        .margin({ top: AppSpacing.sm })

      Row() {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)

        Text('Open')
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(AppColors.secondary)
          .margin({ left: AppSpacing.sm })
      }
      .width('100%')
      .margin({ top: AppSpacing.sm })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
  }
}

@Component
struct ActionFooter {
  build() {
    Column() {
      Text('Dock filters')
        .fontSize(AppTypography.title.size)
        .fontWeight(AppTypography.title.weight)
        .fontColor(AppColors.onSurface)

      Row() {
        Text('Calm')
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(AppColors.onPrimary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)

        Text('Fire')
          .fontSize(AppTypography.label.size)
          .fontWeight(AppTypography.label.weight)
          .fontColor(AppColors.onTertiary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppColors.tertiary)
          .borderRadius(AppShapes.medium)
          .margin({ left: AppSpacing.sm })
      }
      .width('100%')
      .margin({ top: AppSpacing.sm })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
  }
}

@Component
struct BottomInputBar {
  @State text: string = ''

  build() {
    Row() {
      TextInput({ placeholder: 'Message dock...', text: this.text })
        .placeholderColor(AppColors.onSurface + '99')
        .fontSize(AppTypography.body.size)
        .fontColor(AppColors.onSurface)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .height(48)
        .padding({ left: AppSpacing.md, right: AppSpacing.md })
        .layoutWeight(1)
        .onChange((val: string) => { this.text = val })

      Text('Send')
        .fontSize(AppTypography.label.size)
        .fontWeight(AppTypography.label.weight)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 20, right: 20 })
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .margin({ left: AppSpacing.sm })
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surfaceVariant)
  }
}

@Component
struct FloatingActionButton {
  build() {
    Text('New')
      .fontSize(AppTypography.label.size)
      .fontWeight(AppTypography.label.weight)
      .fontColor(AppColors.onPrimary)
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor(AppColors.primary)
      .borderRadius(AppShapes.medium)
  }
}

@Entry
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live'
  @State draftMessage: string = ''

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThread[] = [
    { id: '1', name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
    { id: '2', name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
    { id: '3', name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
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
                    onSelect: () => { this.activeFilter = filter }
                  })
                }, (filter: string) => filter)
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            StatusSummary()
              .margin({ top: AppSpacing.md })
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
                .margin({ top: AppSpacing.md })
                .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }, (thread: ChatThread) => thread.id)

            ActionFooter()
              .margin({ top: AppSpacing.md })
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
          FloatingActionButton()
            .margin({ right: AppSpacing.lg, bottom: 80 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      BottomInputBar()
    }
    .width('100%')
    .height('100%')
  }
}
