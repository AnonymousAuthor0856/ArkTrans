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

class AppTokens {
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
  static readonly onSurface70: ResourceColor = 'rgba(226, 232, 240, 0.70)'
  static readonly onSurface60: ResourceColor = 'rgba(226, 232, 240, 0.60)'
  static readonly onSurface90: ResourceColor = 'rgba(226, 232, 240, 0.90)'

  static readonly radiusSmall: number = 12
  static readonly radiusMedium: number = 16
  static readonly radiusLarge: number = 20

  static readonly xs: number = 4
  static readonly sm: number = 8
  static readonly md: number = 12
  static readonly lg: number = 16
  static readonly xl: number = 24
}

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

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: AppTokens.md }) {
            this.FilterRow()
            this.StatusSummary()

            ForEach(this.threads, (thread: ChatThread) => {
              this.ChatThreadCard(thread)
            }, (thread: ChatThread) => thread.name)

            this.ActionFooter()

            Blank()
              .height(8)
          }
          .width('100%')
          .padding({
            left: AppTokens.lg,
            right: AppTokens.lg,
            top: AppTokens.md,
            bottom: AppTokens.md
          })
        }
        .layoutWeight(1)
        .width('100%')
        .backgroundColor(AppTokens.background)
        .scrollBar(BarState.Off)

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.background)

      Button('New', { type: ButtonType.Normal, stateEffect: true })
        .width(56)
        .height(56)
        .borderRadius(AppTokens.radiusLarge)
        .backgroundColor(AppTokens.primary)
        .fontColor(AppTokens.onPrimary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .margin({ right: AppTokens.lg, bottom: 78 })
        .zIndex(2)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.background)
  }

  @Builder
  TopBar() {
    Row() {
      Text('Hub')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)
        .margin({ right: AppTokens.xl })

      Column() {
        Text('HoloChat Dock')
          .fontSize(16)
          .lineHeight(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)

        Text('Dark neon bridge')
          .fontSize(12)
          .lineHeight(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface70)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Text('Status')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.secondary)
    }
    .width('100%')
    .height(84)
    .padding({
      left: AppTokens.lg,
      right: AppTokens.lg,
      top: AppTokens.lg,
      bottom: AppTokens.md
    })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.surface)
  }

  @Builder
  BottomBar() {
    Row({ space: AppTokens.sm }) {
      TextInput({
        text: this.draft,
        placeholder: 'Message dock...'
      })
        .layoutWeight(1)
        .height(40)
        .borderRadius(AppTokens.radiusMedium)
        .backgroundColor(AppTokens.surface)
        .fontSize(14)
        .fontColor(AppTokens.onSurface)
        .placeholderColor(AppTokens.onSurface60)
        .caretColor(AppTokens.secondary)
        .padding({ left: AppTokens.md, right: AppTokens.md })
        .onChange((value: string) => {
          this.draft = value
        })

      Button('Send', { type: ButtonType.Normal, stateEffect: true })
        .width(76)
        .height(40)
        .borderRadius(AppTokens.radiusLarge)
        .backgroundColor(AppTokens.primary)
        .fontColor(AppTokens.onPrimary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
    }
    .width('100%')
    .height(72)
    .padding({
      left: AppTokens.lg,
      right: AppTokens.lg,
      top: AppTokens.sm,
      bottom: AppTokens.sm
    })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppTokens.surfaceVariant)
  }

  @Builder
  FilterRow() {
    Row({ space: AppTokens.sm }) {
      ForEach(this.filters, (label: string) => {
        this.FilterChip(label)
      }, (label: string) => label)
    }
    .width('100%')
    .height(48)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  FilterChip(label: string) {
    Text(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.activeFilter === label ? AppTokens.onSecondary : AppTokens.onSurface)
      .backgroundColor(this.activeFilter === label ? AppTokens.secondary : AppTokens.surfaceVariant)
      .borderRadius(AppTokens.radiusMedium)
      .border({
        width: 1,
        color: this.activeFilter === label ? AppTokens.secondary : AppTokens.outline
      })
      .padding({
        left: AppTokens.lg,
        right: AppTokens.lg,
        top: AppTokens.sm,
        bottom: AppTokens.sm
      })
      .onClick(() => {
        this.activeFilter = label
      })
  }

  @Builder
  StatusSummary() {
    Row({ space: AppTokens.sm }) {
      this.SummaryBlock('LIVE DOCKS', '12', AppTokens.secondary)
      this.SummaryBlock('ESCALATIONS', '3', AppTokens.tertiary)
      this.SummaryBlock('QUEUED', '5', AppTokens.primary)
    }
    .width('100%')
  }

  @Builder
  SummaryBlock(title: string, value: string, accent: ResourceColor) {
    Column({ space: AppTokens.xs }) {
      Blank()
        .width(12)
        .height(12)
        .borderRadius(6)
        .backgroundColor(accent)

      Text(title)
        .fontSize(12)
        .lineHeight(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface70)

      Text(value)
        .fontSize(28)
        .lineHeight(34)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(accent)
    }
    .layoutWeight(1)
    .height(91)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .padding(AppTokens.md)
    .borderRadius(AppTokens.radiusMedium)
    .backgroundColor(AppTokens.surface)
  }

  @Builder
  ChatThreadCard(thread: ChatThread) {
    Column({ space: AppTokens.sm }) {
      Row() {
        Column({ space: AppTokens.xs }) {
          Text(thread.name)
            .fontSize(22)
            .lineHeight(28)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.onSurface)

          Text(thread.status)
            .fontSize(12)
            .lineHeight(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(thread.isPriority ? AppTokens.secondary : AppTokens.onSurface70)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(thread.unread > 0 ? `+${thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)
          .textAlign(TextAlign.Center)
          .width(30)
          .height(24)
          .borderRadius(AppTokens.radiusSmall)
          .backgroundColor(AppTokens.surfaceVariant)
          .padding({ top: 4 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(thread.snippet)
        .fontSize(14)
        .lineHeight(20)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppTokens.onSurface90)

      Row({ space: AppTokens.sm }) {
        Text(thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.onSurface)
          .backgroundColor(AppTokens.surfaceVariant)
          .borderRadius(AppTokens.radiusSmall)
          .padding({
            left: AppTokens.sm,
            right: AppTokens.sm,
            top: AppTokens.xs,
            bottom: AppTokens.xs
          })

        Text('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.secondary)
          .padding({
            left: AppTokens.lg,
            right: AppTokens.lg,
            top: AppTokens.xs,
            bottom: AppTokens.xs
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.md)
    .borderRadius(AppTokens.radiusLarge)
    .border({ width: 1, color: AppTokens.outline })
    .backgroundColor(AppTokens.surface)
  }

  @Builder
  ActionFooter() {
    Column({ space: AppTokens.sm }) {
      Text('Dock filters')
        .fontSize(16)
        .lineHeight(22)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.onSurface)

      Row({ space: AppTokens.sm }) {
        Button('Calm', { type: ButtonType.Normal, stateEffect: true })
          .height(40)
          .borderRadius(AppTokens.radiusMedium)
          .backgroundColor(AppTokens.primary)
          .fontColor(AppTokens.onPrimary)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)

        Button('Fire', { type: ButtonType.Normal, stateEffect: true })
          .height(40)
          .borderRadius(AppTokens.radiusMedium)
          .backgroundColor(AppTokens.tertiary)
          .fontColor(AppTokens.onTertiary)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
      }
    }
    .width('100%')
    .padding(AppTokens.lg)
    .borderRadius(AppTokens.radiusLarge)
    .backgroundColor(AppTokens.surfaceVariant)
  }
}