import { router } from '@kit.ArkUI'

// ─── Design Tokens ───────────────────────────────────────────────────────────

const Colors = {
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

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
  xxxl: 44,
}

const Radius = {
  small: 12,
  medium: 16,
  large: 20,
}

// ─── Data ─────────────────────────────────────────────────────────────────────

interface ChatThread {
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean
}

const THREADS: ChatThread[] = [
  { name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
  { name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
  { name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true },
]

const FILTERS: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']

// ─── SummaryBlock ─────────────────────────────────────────────────────────────

@Component
struct SummaryBlock {
  title: string = ''
  value: string = ''
  accent: string = Colors.secondary

  build() {
    Column({ space: Spacing.xs }) {
      Row()
        .width(12)
        .height(12)
        .borderRadius(6)
        .backgroundColor(this.accent)

      Text(this.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface + 'B3')

      Text(this.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(Colors.surface)
    .borderRadius(Radius.medium)
    .padding(Spacing.md)
    .layoutWeight(1)
  }
}

// ─── StatusSummary ────────────────────────────────────────────────────────────

@Component
struct StatusSummary {
  build() {
    Row({ space: Spacing.sm }) {
      SummaryBlock({ title: 'Live docks', value: '12', accent: Colors.secondary })
      SummaryBlock({ title: 'Escalations', value: '3', accent: Colors.tertiary })
      SummaryBlock({ title: 'Queued', value: '5', accent: Colors.primary })
    }
    .width('100%')
  }
}

// ─── ChatThreadCard ───────────────────────────────────────────────────────────

@Component
struct ChatThreadCard {
  thread: ChatThread = { name: '', status: '', unread: 0, snippet: '', isPriority: false }

  build() {
    Column({ space: Spacing.sm }) {
      // Header row
      Row() {
        Column({ space: Spacing.xs }) {
          Text(this.thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)

          Text(this.thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.thread.isPriority ? Colors.secondary : Colors.onSurface + 'B3')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(Radius.small)
          .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      // Snippet
      Text(this.thread.snippet)
        .fontSize(14)
        .fontColor(Colors.onSurface + 'E6')

      // Footer row
      Row({ space: Spacing.sm }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .backgroundColor(Colors.surfaceVariant)
          .borderRadius(Radius.small)
          .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })

        Text('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
          .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(Spacing.md)
    .backgroundColor(Colors.surface)
    .borderRadius(Radius.large)
    .border({ width: 1, color: Colors.outline })
  }
}

// ─── ActionFooter ─────────────────────────────────────────────────────────────

@Component
struct ActionFooter {
  build() {
    Column({ space: Spacing.sm }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)

      Row({ space: Spacing.sm }) {
        Button('Calm')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(Radius.medium)
          .height(36)

        Button('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onTertiary)
          .backgroundColor(Colors.tertiary)
          .borderRadius(Radius.medium)
          .height(36)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(Spacing.lg)
    .backgroundColor(Colors.surfaceVariant)
    .borderRadius(Radius.large)
  }
}

// ─── RootScreen ───────────────────────────────────────────────────────────────

@Entry
@Component
struct RootScreen {
  @State activeFilter: string = FILTERS[0]
  @State draft: string = ''

  build() {
    Column() {
      // ── TopAppBar ──────────────────────────────────────────────────────────
      Row() {
        Text('Hub')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })

        Column({ space: 2 }) {
          Text('HoloChat Dock')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)

          Text('Dark neon bridge')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface + 'B3')
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)
        .padding({ left: Spacing.sm })

        Text('Status')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
          .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.surface)
      .alignItems(VerticalAlign.Center)

      // ── Scrollable body ───────────────────────────────────────────────────
      Scroll() {
        Column({ space: Spacing.md }) {
          // Filter chips
          Row({ space: Spacing.sm }) {
            ForEach(FILTERS, (label: string) => {
              Text(label)
                .fontSize(12)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.activeFilter === label ? Colors.onSecondary : Colors.onSurface)
                .backgroundColor(this.activeFilter === label ? Colors.secondary : Colors.surfaceVariant)
                .borderRadius(Radius.small)
                .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
                .onClick(() => { this.activeFilter = label })
            })
          }
          .width('100%')

          // Status summary
          StatusSummary()

          // Thread cards
          ForEach(THREADS, (thread: ChatThread) => {
            ChatThreadCard({ thread: thread })
          })

          // Action footer
          ActionFooter()

          // Bottom padding so FAB doesn't overlap last card
          Row().height(Spacing.xxxl)
        }
        .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .backgroundColor(Colors.background)

      // ── BottomBar ─────────────────────────────────────────────────────────
      Row({ space: Spacing.sm }) {
        Stack({ alignContent: Alignment.TopStart }) {
          if (this.draft.length === 0) {
            Text('Message dock...')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface + '99')
              .padding({ left: 0, top: 0 })
          }
          TextInput({ placeholder: '', text: this.draft })
            .placeholderColor('transparent')
            .fontSize(14)
            .fontColor(Colors.onSurface)
            .caretColor(Colors.secondary)
            .backgroundColor('transparent')
            .border({ width: 0 })
            .padding(0)
            .onChange((val: string) => { this.draft = val })
        }
        .layoutWeight(1)
        .backgroundColor(Colors.surface)
        .borderRadius(Radius.medium)
        .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })

        Button('Send')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onPrimary)
          .backgroundColor(Colors.primary)
          .borderRadius(Radius.medium)
          .height(40)
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
      .backgroundColor(Colors.surfaceVariant)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
    // ── FAB (overlaid) ────────────────────────────────────────────────────
    .bindContentCover(undefined, undefined)
    .overlay(
      Button('New')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onPrimary)
        .backgroundColor(Colors.primary)
        .borderRadius(Radius.medium)
        .width(64)
        .height(48),
      { align: Alignment.BottomEnd, offset: { x: -Spacing.lg, y: -(56 + Spacing.lg) } }
    )
  }
}