// 201_HoloChatDock_en - Social Messenger - Dark Neon Glow
// Converted from Kotlin Compose to ArkTS

class AppTokens {
  static Colors = {
    primary: '#7C3AED',
    secondary: '#22D3EE',
    tertiary: '#F97316',
    background: '#050714',
    surface: '#0F172A',
    surfaceVariant: '#1F2937',
    outline: '#334155',
    success: '#34D399',
    warning: '#FBBF24',
    error: '#F87171',
    onPrimary: '#050714',
    onSecondary: '#011014',
    onTertiary: '#110200',
    onBackground: '#F8FAFC',
    onSurface: '#E2E8F0',
  }

  static Spacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 44,
  }

  static Radius = {
    small: 12,
    medium: 16,
    large: 20,
  }
}

interface ChatThread {
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean
}

@Entry
@Component
struct HoloChatDock {
  @State activeFilter: string = 'Live'
  @State draft: string = ''
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThread[] = [
    { name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
    { name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
    { name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true },
  ]

  build() {
    Stack() {
      Column() {
        // TopAppBar
        Row() {
          Button('Hub')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(Color.Transparent)
            .height(40)
            .borderRadius(AppTokens.Radius.small)
            .margin({ left: AppTokens.Spacing.sm })

          Column() {
            Text('HoloChat Dock')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
            Text('Dark neon bridge')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onSurface)
              .opacity(0.7)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)
          .margin({ left: AppTokens.Spacing.md })

          Button('Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.secondary)
            .backgroundColor(Color.Transparent)
            .height(40)
            .borderRadius(AppTokens.Radius.small)
            .margin({ right: AppTokens.Spacing.sm })
        }
        .width('100%')
        .height(64)
        .backgroundColor(AppTokens.Colors.surface)
        .alignItems(VerticalAlign.Center)

        // Scrollable content
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Filter chips
            Row({ space: AppTokens.Spacing.sm }) {
              ForEach(this.filters, (label: string) => {
                Text(label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(
                    this.activeFilter === label
                      ? AppTokens.Colors.onSecondary
                      : AppTokens.Colors.onSurface
                  )
                  .padding({
                    left: AppTokens.Spacing.md,
                    right: AppTokens.Spacing.md,
                    top: AppTokens.Spacing.sm,
                    bottom: AppTokens.Spacing.sm,
                  })
                  .backgroundColor(
                    this.activeFilter === label
                      ? AppTokens.Colors.secondary
                      : AppTokens.Colors.surfaceVariant
                  )
                  .borderRadius(AppTokens.Radius.small)
                  .onClick(() => {
                    this.activeFilter = label
                  })
              })
            }
            .width('100%')

            // Status summary
            StatusSummary()

            // Chat thread cards
            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
            })

            // Action footer
            ActionFooter()
          }
          .width('100%')
          .padding({
            left: AppTokens.Spacing.lg,
            right: AppTokens.Spacing.lg,
            top: AppTokens.Spacing.md,
            bottom: AppTokens.Spacing.xxxl + 80,
          })
        }
        .width('100%')
        .layoutWeight(1)
        .scrollBar(BarState.Off)
        .edgeEffect(EdgeEffect.None)

        // BottomBar - message dock
        Row() {
          TextInput({ placeholder: 'Message dock...', text: this.draft })
            .placeholderColor(AppTokens.Colors.onSurface)
            .placeholderFont({ size: 12, weight: FontWeight.Medium })
            .fontSize(14)
            .fontColor(AppTokens.Colors.onSurface)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Radius.medium)
            .height(40)
            .layoutWeight(1)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
            .onChange((value: string) => {
              this.draft = value
            })
            .cursorColor(AppTokens.Colors.secondary)

          Button('Send')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .height(40)
            .borderRadius(AppTokens.Radius.medium)
            .backgroundColor(AppTokens.Colors.primary)
            .fontColor(AppTokens.Colors.onPrimary)
            .margin({ left: AppTokens.Spacing.sm })
        }
        .width('100%')
        .padding({
          left: AppTokens.Spacing.lg,
          right: AppTokens.Spacing.lg,
          top: AppTokens.Spacing.sm,
          bottom: AppTokens.Spacing.sm,
        })
        .backgroundColor(AppTokens.Colors.surfaceVariant)
        .alignItems(VerticalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // Floating Action Button
      Button('New')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Radius.medium)
        .height(56)
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        .position({
          right: AppTokens.Spacing.lg,
          bottom: AppTokens.Spacing.xxxl + AppTokens.Spacing.sm,
        })
        .shadow({
          radius: 14,
          color: 'rgba(124, 58, 237, 0.4)',
          offsetY: 6,
        })
    }
    .width('100%')
    .height('100%')
  }
}

@Component
struct StatusSummary {
  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      SummaryBlock({
        title: 'Live docks',
        value: '12',
        accent: AppTokens.Colors.secondary,
      })
      SummaryBlock({
        title: 'Escalations',
        value: '3',
        accent: AppTokens.Colors.tertiary,
      })
      SummaryBlock({
        title: 'Queued',
        value: '5',
        accent: AppTokens.Colors.primary,
      })
    }
    .width('100%')
  }
}

@Component
struct SummaryBlock {
  @Prop title: string = ''
  @Prop value: string = ''
  @Prop accent: string = ''

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Circle({ width: 12, height: 12 })
        .fill(this.accent)

      Text(this.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.7)

      Text(this.value)
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.accent)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.medium)
    .layoutWeight(1)
  }
}

@Component
struct ChatThreadCard {
  @Prop thread: ChatThread = { name: '', status: '', unread: 0, snippet: '', isPriority: false }

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
            .fontColor(
              this.thread.isPriority
                ? AppTokens.Colors.secondary
                : AppTokens.Colors.onSurface
            )
            .opacity(this.thread.isPriority ? 1 : 0.7)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({
            left: AppTokens.Spacing.sm,
            right: AppTokens.Spacing.sm,
            top: AppTokens.Spacing.xs,
            bottom: AppTokens.Spacing.xs,
          })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Radius.small)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.thread.snippet)
        .fontSize(14)
        .fontColor(AppTokens.Colors.onSurface)
        .opacity(0.9)
        .width('100%')

      Row({ space: AppTokens.Spacing.sm }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({
            left: AppTokens.Spacing.sm,
            right: AppTokens.Spacing.sm,
            top: AppTokens.Spacing.xs,
            bottom: AppTokens.Spacing.xs,
          })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Radius.small)

        Button('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
          .backgroundColor(Color.Transparent)
          .height(32)
          .borderRadius(AppTokens.Radius.small)
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Radius.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
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
          .height(40)
          .borderRadius(AppTokens.Radius.medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)

        Button('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .height(40)
          .borderRadius(AppTokens.Radius.medium)
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
      }
      .width('100%')
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Radius.large)
  }
}
