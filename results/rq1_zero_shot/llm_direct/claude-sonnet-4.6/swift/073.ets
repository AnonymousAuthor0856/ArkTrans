import { router } from '@kit.ArkUI'

// MARK: - App Tokens & Colors
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

// MARK: - Models
class ChatThread {
  id: string
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean

  constructor(id: string, name: string, status: string, unread: number, snippet: string, isPriority: boolean) {
    this.id = id
    this.name = name
    this.status = status
    this.unread = unread
    this.snippet = snippet
    this.isPriority = isPriority
  }
}

// MARK: - Custom Top Bar Component
@Component
struct CustomTopBar {
  build() {
    Row() {
      Button('Hub')
        .fontColor(AppColors.onSurface)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(Color.Transparent)
        .padding(0)

      Blank()

      Column() {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Status')
        .fontColor(AppColors.secondary)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(Color.Transparent)
        .padding(0)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceBetween)
  }
}

// MARK: - Assist Chip Component
@Component
struct AssistChip {
  label: string = ''
  isSelected: boolean = false
  action: () => void = () => {}

  build() {
    Button(this.label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppColors.onSecondary : AppColors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppColors.secondary : AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .border({
        width: this.isSelected ? 0 : 1,
        color: AppColors.outline
      })
      .onClick(() => {
        this.action()
      })
  }
}

// MARK: - Summary Block Component
@Component
struct SummaryBlock {
  title: string = ''
  value: string = ''
  accent: string = ''

  build() {
    Column() {
      Row() {
        Circle()
          .fill(this.accent)
          .width(12)
          .height(12)
      }
      .margin({ bottom: AppSpacing.xs })

      Text(this.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .opacity(0.7)
        .margin({ bottom: AppSpacing.xs })

      Text(this.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .layoutWeight(1)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
  }
}

// MARK: - Status Summary Component
@Component
struct StatusSummary {
  build() {
    Row({ space: AppSpacing.sm }) {
      SummaryBlock({ title: 'Live docks', value: '12', accent: AppColors.secondary })
      SummaryBlock({ title: 'Escalations', value: '3', accent: AppColors.tertiary })
      SummaryBlock({ title: 'Queued', value: '5', accent: AppColors.primary })
    }
    .width('100%')
  }
}

// MARK: - Chat Thread Card Component
@Component
struct ChatThreadCard {
  thread: ChatThread = new ChatThread('', '', '', 0, '', false)

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .margin({ bottom: AppSpacing.xs })

          Text(this.thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.thread.isPriority ? AppColors.secondary : AppColors.onSurface)
            .opacity(this.thread.isPriority ? 1.0 : 0.7)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppSpacing.sm })

      Text(this.thread.snippet)
        .fontSize(14)
        .fontWeight(FontWeight.Regular)
        .fontColor(AppColors.onSurface)
        .opacity(0.9)
        .width('100%')
        .margin({ bottom: AppSpacing.sm })

      Row({ space: AppSpacing.sm }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)

        Button('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .backgroundColor(Color.Transparent)
          .padding(0)
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

// MARK: - Action Footer Component
@Component
struct ActionFooter {
  build() {
    Column() {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.sm })

      Row({ space: AppSpacing.sm }) {
        Button('Calm')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)

        Button('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppColors.tertiary)
          .borderRadius(AppShapes.medium)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
  }
}

// MARK: - Bottom Input Bar Component
@Component
struct BottomInputBar {
  @Link text: string

  build() {
    Row({ space: AppSpacing.sm }) {
      Stack({ alignContent: Alignment.Start }) {
        if (this.text.length === 0) {
          Text('Message dock...')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .opacity(0.6)
            .padding({ left: AppSpacing.md, right: AppSpacing.md })
        }
        TextInput({ text: this.text, placeholder: '' })
          .fontSize(14)
          .fontWeight(FontWeight.Regular)
          .fontColor(AppColors.onSurface)
          .backgroundColor(Color.Transparent)
          .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
          .onChange((value: string) => {
            this.text = value
          })
          .placeholderColor(Color.Transparent)
      }
      .height(48)
      .layoutWeight(1)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.medium)

      Button('Send')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 20, right: 20 })
        .height(48)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({ radius: 6, color: '#33000000', offsetX: 0, offsetY: -2 })
  }
}

// MARK: - Main Screen
@Entry
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live'
  @State draftMessage: string = ''

  filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  threads: ChatThread[] = [
    new ChatThread('1', 'Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('2', 'Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('3', 'Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      Column() {
        // Top Bar
        CustomTopBar()

        // Content
        Scroll() {
          Column({ space: AppSpacing.md }) {
            // Filters
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

            // Status Summary
            StatusSummary()
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            // Threads List
            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
                .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }, (thread: ChatThread) => thread.id)

            // Action Footer
            ActionFooter()
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            // Spacer for bottom bar + FAB area
            Column()
              .height(100)
          }
          .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .layoutWeight(1)
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      // FAB (Floating Action Button) overlay
      Row() {
        Blank()
        Button('New')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.medium)
          .shadow({ radius: 4, color: '#66000000', offsetX: 0, offsetY: 2 })
          .margin({ right: AppSpacing.lg, bottom: 80 })
      }
      .width('100%')
      .justifyContent(FlexAlign.End)

      // Bottom Bar
      BottomInputBar({ text: $draftMessage })
    }
    .width('100%')
    .height('100%')
  }
}