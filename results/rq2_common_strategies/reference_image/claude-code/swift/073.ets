class AppTokens {
  static class Colors {
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

  static class Typography {
    static readonly display: { size: number, weight: FontWeight } = { size: 28, weight: FontWeight.SemiBold }
    static readonly headline: { size: number, weight: FontWeight } = { size: 22, weight: FontWeight.Medium }
    static readonly title: { size: number, weight: FontWeight } = { size: 16, weight: FontWeight.Medium }
    static readonly body: { size: number, weight: FontWeight } = { size: 14, weight: FontWeight.Regular }
    static readonly label: { size: number, weight: FontWeight } = { size: 12, weight: FontWeight.Medium }
  }

  static class Spacing {
    static readonly xs: number = 4
    static readonly sm: number = 8
    static readonly md: number = 12
    static readonly lg: number = 16
    static readonly xl: number = 24
    static readonly xxl: number = 32
    static readonly xxxl: number = 44
  }

  static class Shapes {
    static readonly small: number = 12
    static readonly medium: number = 16
    static readonly large: number = 20
  }
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
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Column() {
        Text('HoloChat Dock')
          .fontSize(AppTokens.Typography.title.size)
          .fontWeight(AppTokens.Typography.title.weight)
          .fontColor(AppTokens.Colors.onSurface)
        Text('Dark neon bridge')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('Status')
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.secondary)
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
  onSelect: () => void = () => {}

  build() {
    Text(this.label)
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: this.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
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
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)
        .margin({ top: AppTokens.Spacing.xs })

      Text(this.value)
        .fontSize(AppTokens.Typography.display.size)
        .fontWeight(AppTokens.Typography.display.weight)
        .fontColor(this.accent)
        .margin({ top: AppTokens.Spacing.xs })
    }
    .alignItems(HorizontalAlign.Start)
    .width('33%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
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
            .fontSize(AppTokens.Typography.headline.size)
            .fontWeight(AppTokens.Typography.headline.weight)
            .fontColor(AppTokens.Colors.onSurface)

          Text(this.thread.status)
            .fontSize(AppTokens.Typography.label.size)
            .fontWeight(AppTokens.Typography.label.weight)
            .fontColor(this.thread.isPriority ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface)
            .opacity(this.thread.isPriority ? 1 : 0.7)
            .margin({ top: AppTokens.Spacing.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')

      Text(this.thread.snippet)
        .fontSize(AppTokens.Typography.body.size)
        .fontWeight(AppTokens.Typography.body.weight)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.9)
        .margin({ top: AppTokens.Spacing.sm })

      Row() {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

        Text('Open')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.secondary)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
  }
}

@Component
struct ActionFooter {
  build() {
    Column() {
      Text('Dock filters')
        .fontSize(AppTokens.Typography.title.size)
        .fontWeight(AppTokens.Typography.title.weight)
        .fontColor(AppTokens.Colors.onSurface)

      Row() {
        Text('Calm')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onPrimary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)

        Text('Fire')
          .fontSize(AppTokens.Typography.label.size)
          .fontWeight(AppTokens.Typography.label.weight)
          .fontColor(AppTokens.Colors.onTertiary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ left: AppTokens.Spacing.sm })
      }
      .width('100%')
      .margin({ top: AppTokens.Spacing.sm })
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
  }
}

@Component
struct BottomInputBar {
  @State text: string = ''

  build() {
    Row() {
      TextInput({ placeholder: 'Message dock...', text: this.text })
        .placeholderColor(AppTokens.Colors.onSurface + '99')
        .fontSize(AppTokens.Typography.body.size)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .height(48)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        .layoutWeight(1)
        .onChange((val: string) => { this.text = val })

      Text('Send')
        .fontSize(AppTokens.Typography.label.size)
        .fontWeight(AppTokens.Typography.label.weight)
        .fontColor(AppTokens.Colors.onPrimary)
        .padding({ left: 20, right: 20 })
        .height(48)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .margin({ left: AppTokens.Spacing.sm })
    }
    .width('100%')
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
  }
}

@Component
struct FloatingActionButton {
  build() {
    Text('New')
      .fontSize(AppTokens.Typography.label.size)
      .fontWeight(AppTokens.Typography.label.weight)
      .fontColor(AppTokens.Colors.onPrimary)
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.medium)
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
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            StatusSummary()
              .margin({ top: AppTokens.Spacing.md })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
                .margin({ top: AppTokens.Spacing.md })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }, (thread: ChatThread) => thread.id)

            ActionFooter()
              .margin({ top: AppTokens.Spacing.md })
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            Blank()
              .height(100)
          }
          .width('100%')
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      Column() {
        Blank()
        Row() {
          Blank()
          FloatingActionButton()
            .margin({ right: AppTokens.Spacing.lg, bottom: 80 })
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
