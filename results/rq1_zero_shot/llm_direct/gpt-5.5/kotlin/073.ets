class AppColors {
  static readonly primary: string = '#7C3AED'
  static readonly secondary: string = '#22D3EE'
  static readonly tertiary: string = '#F97316'
  static readonly background: string = '#050714'
  static readonly surface: string = '#0F172A'
  static readonly surfaceVariant: string = '#1F2937'
  static readonly outline: string = '#334155'
  static readonly success: string = '#34D399'
  static readonly warning: string = '#FBBF24'
  static readonly error: string = '#F87171'
  static readonly onPrimary: string = '#050714'
  static readonly onSecondary: string = '#011014'
  static readonly onTertiary: string = '#110200'
  static readonly onBackground: string = '#F8FAFC'
  static readonly onSurface: string = '#E2E8F0'
  static readonly onSurface70: string = '#B3E2E8F0'
  static readonly onSurface60: string = '#99E2E8F0'
  static readonly onSurface90: string = '#E6E2E8F0'
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

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevation {
  static readonly level1: ShadowSpec = new ShadowSpec(2, 6, 2, 0.14)
  static readonly level2: ShadowSpec = new ShadowSpec(6, 10, 4, 0.18)
  static readonly level3: ShadowSpec = new ShadowSpec(10, 14, 6, 0.22)
  static readonly level4: ShadowSpec = new ShadowSpec(14, 18, 8, 0.26)
  static readonly level5: ShadowSpec = new ShadowSpec(18, 22, 10, 0.3)
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
struct HoloChatDockPage {
  @State activeFilter: string = 'Live'
  @State draft: string = ''

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ]

  @Builder
  TopBar() {
    Row() {
      Button() {
        Text('Hub')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .borderRadius(AppShapes.small)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })

      Column() {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .lineHeight(22)

        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface70)
          .lineHeight(16)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 8 })

      Button() {
        Text('Status')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
      }
      .type(ButtonType.Normal)
      .backgroundColor(Color.Transparent)
      .borderRadius(AppShapes.small)
      .padding({ left: 8, right: 8, top: 6, bottom: 6 })
    }
    .width('100%')
    .height(64)
    .padding({ left: 12, right: 12 })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  FilterChip(label: string) {
    Button() {
      Text(label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.activeFilter === label ? AppColors.onSecondary : AppColors.onSurface)
    }
    .type(ButtonType.Normal)
    .backgroundColor(this.activeFilter === label ? AppColors.secondary : AppColors.surfaceVariant)
    .borderRadius(AppShapes.small)
    .padding({ left: 12, right: 12, top: 8, bottom: 8 })
    .onClick(() => {
      this.activeFilter = label
    })
  }

  @Builder
  BottomBar() {
    Row({ space: AppSpacing.sm }) {
      TextInput({ placeholder: 'Message dock...', text: this.draft })
        .placeholderColor(AppColors.onSurface60)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .fontWeight(FontWeight.Normal)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .layoutWeight(1)
        .height(44)
        .caretColor(AppColors.secondary)
        .onChange((value: string) => {
          this.draft = value
        })

      Button() {
        Text('Send')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
      }
      .type(ButtonType.Normal)
      .backgroundColor(AppColors.primary)
      .fontColor(AppColors.onPrimary)
      .borderRadius(AppShapes.medium)
      .height(44)
      .padding({ left: 18, right: 18 })
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({
      radius: AppElevation.level2.radius,
      color: '#2E000000',
      offsetX: 0,
      offsetY: AppElevation.level2.dy
    })
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Stack() {
      Column() {
        this.TopBar()

        Scroll() {
          Column({ space: AppSpacing.md }) {
            Row({ space: AppSpacing.sm }) {
              ForEach(this.filters, (label: string) => {
                this.FilterChip(label)
              }, (label: string) => label)
            }
            .width('100%')

            StatusSummary()

            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
            }, (thread: ChatThread) => thread.name)

            ActionFooter()

            Blank()
              .height(16)
          }
          .width('100%')
          .padding({
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.md,
            bottom: AppSpacing.md
          })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Column() {
        Blank()
          .layoutWeight(1)

        Row() {
          Blank()
            .layoutWeight(1)

          Button() {
            Text('New')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
          .type(ButtonType.Normal)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .width(64)
          .height(56)
          .shadow({
            radius: AppElevation.level3.radius,
            color: '#38000000',
            offsetX: 0,
            offsetY: AppElevation.level3.dy
          })
        }
        .width('100%')
        .padding({ right: AppSpacing.lg, bottom: 76 })
      }
      .width('100%')
      .height('100%')
      .hitTestBehavior(HitTestMode.Transparent)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
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
  title: string = ''
  value: string = ''
  accent: string = AppColors.secondary

  build() {
    Column({ space: AppSpacing.xs }) {
      Circle()
        .width(12)
        .height(12)
        .fill(this.accent)

      Text(this.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface70)
        .lineHeight(16)

      Text(this.value)
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(this.accent)
        .lineHeight(34)
    }
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .padding(AppSpacing.md)
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
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .lineHeight(28)

          Text(this.thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.thread.isPriority ? AppColors.secondary : AppColors.onSurface70)
            .lineHeight(16)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
          .padding({
            left: AppSpacing.sm,
            right: AppSpacing.sm,
            top: AppSpacing.xs,
            bottom: AppSpacing.xs
          })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.thread.snippet)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(AppColors.onSurface90)
        .lineHeight(20)

      Row({ space: AppSpacing.sm }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
          .padding({
            left: AppSpacing.sm,
            right: AppSpacing.sm,
            top: AppSpacing.xs,
            bottom: AppSpacing.xs
          })

        Button() {
          Text('Open')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
        }
        .type(ButtonType.Normal)
        .backgroundColor(Color.Transparent)
        .borderRadius(AppShapes.small)
        .padding({ left: 8, right: 8, top: 4, bottom: 4 })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
    .shadow({
      radius: AppElevation.level1.radius,
      color: '#24000000',
      offsetX: 0,
      offsetY: AppElevation.level1.dy
    })
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: AppSpacing.sm }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .lineHeight(22)

      Row({ space: AppSpacing.sm }) {
        Button() {
          Text('Calm')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
        }
        .type(ButtonType.Normal)
        .backgroundColor(AppColors.primary)
        .fontColor(AppColors.onPrimary)
        .borderRadius(AppShapes.medium)

        Button() {
          Text('Fire')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
        }
        .type(ButtonType.Normal)
        .backgroundColor(AppColors.tertiary)
        .borderRadius(AppShapes.medium)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
  }
}