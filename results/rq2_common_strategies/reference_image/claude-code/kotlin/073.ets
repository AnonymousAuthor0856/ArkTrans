// HoloChat Dock - Dark Neon Glow Messenger UI
// Converted from Kotlin Compose to ArkTS

class AppTokens {
  static class Colors {
    static primary: string = '#7C3AED'
    static secondary: string = '#22D3EE'
    static tertiary: string = '#F97316'
    static background: string = '#050714'
    static surface: string = '#0F172A'
    static surfaceVariant: string = '#1F2937'
    static outline: string = '#334155'
    static success: string = '#34D399'
    static warning: string = '#FBBF24'
    static error: string = '#F87171'
    static onPrimary: string = '#050714'
    static onSecondary: string = '#011014'
    static onTertiary: string = '#110200'
    static onBackground: string = '#F8FAFC'
    static onSurface: string = '#E2E8F0'
  }

  static class Spacing {
    static xs: number = 4
    static sm: number = 8
    static md: number = 12
    static lg: number = 16
    static xl: number = 24
    static xxl: number = 32
    static xxxl: number = 44
  }

  static class Shapes {
    static small: number = 12
    static medium: number = 16
    static large: number = 20
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
    { name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true }
  ]

  build() {
    Stack() {
      Column() {
        // Top App Bar
        Row() {
          Text('Hub')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onSurface)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.md })

          Column() {
            Text('HoloChat Dock')
              .fontSize(28)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onBackground)
            Text('Dark neon bridge')
              .fontSize(18)
              .fontColor(AppTokens.Colors.onSurface + 'B3')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text('Status')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.secondary)
            .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.lg })
        }
        .width('100%')
        .padding({ top: AppTokens.Spacing.xl, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surface)
        .alignItems(VerticalAlign.Center)

        // Scrollable content
        Scroll() {
          Column() {
            // Filter chips
            Row() {
              ForEach(this.filters, (label: string) => {
                Text(label)
                  .fontSize(20)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.activeFilter === label ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
                  .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
                  .backgroundColor(this.activeFilter === label ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
                  .borderRadius(AppTokens.Shapes.small + 16)
                  .border({
                    width: 2,
                    color: this.activeFilter === label ? AppTokens.Colors.secondary : AppTokens.Colors.outline
                  })
                  .onClick(() => {
                    this.activeFilter = label
                  })
              })
            }
            .width('100%')
            .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.sm })

            // Status Summary
            Row() {
              this.SummaryBlock('Live docks', '12', AppTokens.Colors.secondary)
              this.SummaryBlock('Escalations', '3', AppTokens.Colors.tertiary)
              this.SummaryBlock('Queued', '5', AppTokens.Colors.primary)
            }
            .width('100%')
            .padding({ top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.md })

            // Chat thread cards
            ForEach(this.threads, (thread: ChatThread) => {
              this.ChatThreadCard(thread)
            })

            // Action Footer
            this.ActionFooter()
          }
          .width('100%')
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        // Bottom Bar - Message input
        Row() {
          TextInput({ placeholder: 'Message dock...', text: this.draft })
            .placeholderColor(AppTokens.Colors.onSurface + '99')
            .fontColor(AppTokens.Colors.onSurface)
            .fontSize(22)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(AppTokens.Shapes.medium + 12)
            .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
            .layoutWeight(1)
            .onChange((value: string) => {
              this.draft = value
            })
            .margin({ right: AppTokens.Spacing.sm })

          Button('Send')
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium + 18)
            .padding({ left: AppTokens.Spacing.xl, right: AppTokens.Spacing.xl, top: AppTokens.Spacing.lg + 2, bottom: AppTokens.Spacing.lg + 2 })
        }
        .width('100%')
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.lg })
        .backgroundColor(AppTokens.Colors.surfaceVariant)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppTokens.Colors.background)

      // FAB - New button
      Button('New')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium + 16)
        .padding({ left: AppTokens.Spacing.xl + 4, right: AppTokens.Spacing.xl + 4, top: AppTokens.Spacing.lg + 6, bottom: AppTokens.Spacing.lg + 6 })
        .position({
          right: AppTokens.Spacing.xl,
          bottom: AppTokens.Spacing.xxxl + AppTokens.Spacing.xxl
        })
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  SummaryBlock(title: string, value: string, accent: string) {
    Column() {
      Circle({ width: 20, height: 20 })
        .fill(accent)
        .margin({ bottom: AppTokens.Spacing.sm })

      Text(title.toUpperCase())
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface + 'B3')
        .margin({ bottom: AppTokens.Spacing.xs })

      Text(value)
        .fontSize(48)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(accent)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.md + 4)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium + 16)
    .margin({ right: AppTokens.Spacing.sm })
  }

  @Builder
  ChatThreadCard(thread: ChatThread) {
    Column() {
      Row() {
        Column() {
          Text(thread.name)
            .fontSize(36)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onBackground)
            .margin({ bottom: AppTokens.Spacing.xs })

          Text(thread.status)
            .fontSize(20)
            .fontColor(thread.isPriority ? AppTokens.Colors.secondary : AppTokens.Colors.onSurface + 'B3')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text(thread.unread > 0 ? '+' + thread.unread : '✓')
          .fontSize(22)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small + 10)
      }
      .width('100%')
      .margin({ bottom: AppTokens.Spacing.sm })

      Text(thread.snippet)
        .fontSize(24)
        .fontColor(AppTokens.Colors.onSurface + 'E6')
        .margin({ bottom: AppTokens.Spacing.sm })

      Row() {
        Text(thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small + 8)

        Text('Open')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppTokens.Colors.secondary)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppTokens.Spacing.md + 4)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large + 12)
    .border({
      width: 1.5,
      color: AppTokens.Colors.outline
    })
    .margin({ bottom: AppTokens.Spacing.md })
  }

  @Builder
  ActionFooter() {
    Column() {
      Text('Dock filters')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppTokens.Colors.onSurface)
        .margin({ bottom: AppTokens.Spacing.sm })

      Row() {
        Button('Calm')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppTokens.Colors.primary)
          .fontColor(AppTokens.Colors.onPrimary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
          .margin({ right: AppTokens.Spacing.sm })

        Button('Fire')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(AppTokens.Colors.tertiary)
          .fontColor(AppTokens.Colors.onTertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(AppTokens.Spacing.lg)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large + 12)
    .margin({ top: AppTokens.Spacing.sm })
  }
}
