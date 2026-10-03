import { Colors } from '@kit.ArkUI';

interface ChatThread {
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean
}

interface AppTokenColors {
  primary: string;
  secondary: string;
  tertiary: string;
  background: string;
  surface: string;
  surfaceVariant: string;
  outline: string;
  onPrimary: string;
  onSecondary: string;
  onTertiary: string;
  onBackground: string;
  onSurface: string;
}

interface AppTokenTypographyItem {
  size: number;
  weight: FontWeight;
}

interface AppTokenTypography {
  display: AppTokenTypographyItem;
  headline: AppTokenTypographyItem;
  title: AppTokenTypographyItem;
  body: AppTokenTypographyItem;
  label: AppTokenTypographyItem;
}

interface AppTokenSpacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
}

interface AppTokenShapes {
  small: number;
  medium: number;
  large: number;
}

class AppTokens {
  static Colors: AppTokenColors = {
    primary: '#7C3AED',
    secondary: '#22D3EE',
    tertiary: '#F97316',
    background: '#050714',
    surface: '#0F172A',
    surfaceVariant: '#1F2937',
    outline: '#334155',
    onPrimary: '#050714',
    onSecondary: '#011014',
    onTertiary: '#110200',
    onBackground: '#F8FAFC',
    onSurface: '#E2E8F0'
  }

  static Typography: AppTokenTypography = {
    display: { size: 28, weight: FontWeight.SemiBold },
    headline: { size: 22, weight: FontWeight.Medium },
    title: { size: 16, weight: FontWeight.Medium },
    body: { size: 14, weight: FontWeight.Normal },
    label: { size: 12, weight: FontWeight.Medium }
  }

  static Spacing: AppTokenSpacing = {
    xs: 4,
    sm: 8,
    md: 12,
    lg: 16,
    xl: 24,
    xxl: 32,
    xxxl: 44
  }

  static Shapes: AppTokenShapes = {
    small: 12,
    medium: 16,
    large: 20
  }
}

@Entry
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = "Live"
  @State draftMessage: string = ""

  private filters: string[] = ["Live", "Pinned", "Escalated", "Silent"]
  private threads: ChatThread[] = [
    { name: "Orbital Finance", status: "Rolling sync", unread: 5, snippet: "Need rates for Q4", isPriority: true },
    { name: "Beacon Ops", status: "Docked", unread: 0, snippet: "Switching to holo feed", isPriority: false },
    { name: "Nova Crew", status: "Hotline", unread: 2, snippet: "Uploading scan pack now", isPriority: true }
  ]

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // === Background ===
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#050714')

      // === Main Content Column ===
      Column() {
        // === Top Bar ===
        Row() {
          Button() {
            Text("Hub")
              .font(AppTokens.Typography.label)
              .fontColor(AppTokens.Colors.onSurface)
          }

          Blank()

          Column({ space: 0 }) {
            Text("HoloChat Dock")
              .font(AppTokens.Typography.title)
              .fontColor(AppTokens.Colors.onSurface)
            Text("Dark neon bridge")
              .font(AppTokens.Typography.label)
              .fontColor(Color(AppTokens.Colors.onSurface).withOpacity(0.7))
          }.alignItems(HorizontalAlign.Start)

          Blank()

          Button() {
            Text("Status")
              .font(AppTokens.Typography.label)
              .fontColor(AppTokens.Colors.secondary)
          }
        }
        .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
        .backgroundColor(AppTokens.Colors.surface)

        // === Scrollable Content ===
        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Filters
            Scroll() {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  AssistChip({
                    props: {
                      label: filter,
                      isSelected: this.activeFilter === filter,
                      action: () => { this.activeFilter = filter }
                    }
                  })
                })
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }.scrollable(ScrollDirection.Horizontal).scrollBar(BarState.Off)

            // Status Summary
            StatusSummary()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Threads List
            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({
                props: {
                  thread: thread
                }
              })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            })

            // Action Footer
            ActionFooter()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Spacer for bottom bar + FAB area
            Blank().height(100)
          }
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
        }.scrollable(ScrollDirection.Vertical).scrollBar(BarState.Off)
      }.layoutWeight(1)

      // === FAB (Floating Action Button) overlay ===
      Column() {
        Blank()
        Row() {
          Blank()
          Button() {
            Text("New")
              .font(AppTokens.Typography.label)
              .fontColor(AppTokens.Colors.onPrimary)
          }
          .padding({ left: 16, right: 16, top: 16, bottom: 16 })
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .shadow({ radius: 4, color: '#3F000000' })
          .margin({ right: AppTokens.Spacing.lg, bottom: 80 })
        }
      }.width('100%').height('100%')

      // === Bottom Bar ===
      BottomInputBar({ text: $draftMessage })
    }.width('100%').height('100%')
  }
}

// MARK: - Components

@Component
struct CustomTopBar {
  build() {
    Row() {
      Button() {
        Text("Hub")
          .font(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.onSurface)
      }

      Blank()

      Column({ space: 0 }) {
        Text("HoloChat Dock")
          .font(AppTokens.Typography.title)
          .fontColor(AppTokens.Colors.onSurface)
        Text("Dark neon bridge")
          .font(AppTokens.Typography.label)
          .fontColor(Color(AppTokens.Colors.onSurface).withOpacity(0.7))
      }.alignItems(HorizontalAlign.Start)

      Blank()

      Button() {
        Text("Status")
          .font(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.secondary)
      }
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surface)
  }
}

interface AssistChipProps {
  label: string;
  isSelected: boolean;
  action: () => void;
}

@Component
struct AssistChip {
  @Prop props: AssistChipProps

  build() {
    Button() {
      Text(this.props.label)
        .font(AppTokens.Typography.label)
        .fontColor(this.props.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
    }
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .backgroundColor(this.props.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.small)
    .border({ width: this.props.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
    .onClick(this.props.action)
  }
}

@Component
struct StatusSummary {
  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      SummaryBlock({
        props: {
          title: "Live docks",
          value: "12",
          accent: AppTokens.Colors.secondary
        }
      })
      SummaryBlock({
        props: {
          title: "Escalations",
          value: "3",
          accent: AppTokens.Colors.tertiary
        }
      })
      SummaryBlock({
        props: {
          title: "Queued",
          value: "5",
          accent: AppTokens.Colors.primary
        }
      })
    }
  }
}

interface SummaryBlockProps {
  title: string;
  value: string;
  accent: string;
}

@Component
struct SummaryBlock {
  @Prop props: SummaryBlockProps

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Circle()
        .fill(this.props.accent)
        .width(12)
        .height(12)

      Text(this.props.title.toUpperCase())
        .font(AppTokens.Typography.label)
        .fontColor(Color(AppTokens.Colors.onSurface).withOpacity(0.7))

      Text(this.props.value)
        .font(AppTokens.Typography.display)
        .fontColor(this.props.accent)
    }
    .padding(AppTokens.Spacing.md)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
  }
}

interface ChatThreadCardProps {
  thread: ChatThread;
}

@Component
struct ChatThreadCard {
  @Prop props: ChatThreadCardProps

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text(this.props.thread.name)
            .font(AppTokens.Typography.headline)
            .fontColor(AppTokens.Colors.onSurface)

          Text(this.props.thread.status)
            .font(AppTokens.Typography.label)
            .fontColor(this.props.thread.isPriority ? AppTokens.Colors.secondary : Color(AppTokens.Colors.onSurface).withOpacity(0.7))
        }.alignItems(HorizontalAlign.Start)

        Blank()

        Text(this.props.thread.unread > 0 ? `+${this.props.thread.unread}` : "✓")
          .font(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
      }

      Text(this.props.thread.snippet)
        .font(AppTokens.Typography.body)
        .fontColor(Color(AppTokens.Colors.onSurface).withOpacity(0.9))

      Row({ space: AppTokens.Spacing.sm }) {
        Text(this.props.thread.isPriority ? "Priority" : "Standard")
          .font(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

        Button() {
          Text("Open")
            .font(AppTokens.Typography.label)
            .fontColor(AppTokens.Colors.secondary)
        }
      }
    }
    .padding(AppTokens.Spacing.md)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text("Dock filters")
        .font(AppTokens.Typography.title)
        .fontColor(AppTokens.Colors.onSurface)

      Row({ space: AppTokens.Spacing.sm }) {
        Button() {
          Text("Calm")
            .font(AppTokens.Typography.label)
            .fontColor(AppTokens.Colors.onPrimary)
        }
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)

        Button() {
          Text("Fire")
            .font(AppTokens.Typography.label)
            .fontColor(AppTokens.Colors.onTertiary)
        }
        .padding({ left: 16, right: 16, top: 10, bottom: 10 })
        .backgroundColor(AppTokens.Colors.tertiary)
        .borderRadius(AppTokens.Shapes.medium)
      }
    }
    .padding(AppTokens.Spacing.lg)
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
  }
}

@Component
struct BottomInputBar {
  @Link text: string

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      Stack({ alignContent: Alignment.Start }) {
        if (this.text.length === 0) {
          Text("Message dock...")
            .font(AppTokens.Typography.label)
            .fontColor(Color(AppTokens.Colors.onSurface).withOpacity(0.6))
            .margin({ left: AppTokens.Spacing.md })
        }
        TextInput({ placeholder: '' })
          .type(InputType.Normal)
          .textAlign(TextAlign.Start)
          .height(48)
          .backgroundColor(AppTokens.Colors.surface)
          .borderRadius(AppTokens.Shapes.medium)
          .margin({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
          .onChange((value: string) => { this.text = value })
      }
      .layoutWeight(1)
      .height(48)

      Button() {
        Text("Send")
          .font(AppTokens.Typography.label)
          .fontColor(AppTokens.Colors.onPrimary)
      }
      .padding({ left: 20, right: 20 })
      .height(48)
      .backgroundColor(AppTokens.Colors.primary)
      .borderRadius(AppTokens.Shapes.medium)
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .shadow({ radius: 6, color: '#33000000', offsetY: -2 })
  }
}