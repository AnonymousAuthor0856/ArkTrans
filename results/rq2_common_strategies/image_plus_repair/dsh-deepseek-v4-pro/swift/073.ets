// MARK: - App Entry Point
// The SwiftUI `@main struct HoloChatApp: App` with a `WindowGroup` maps to a
// single HarmonyOS page entry; the window's root scene renders `ContentView`.
@Entry
@Component
struct HoloChatApp {
  build() {
    Column() {
      ContentView()
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Root View
@Component
struct ContentView {
  build() {
    // `.preferredColorScheme(.dark)` is represented by the dark `background`
    // color applied at the root of `HoloChatDockScreen`; `.statusBarHidden(true)`
    // is represented by expanding the safe area over the system bars.
    HoloChatDockScreen()
  }
}

// MARK: - Color Hex Extension
// Mirrors the SwiftUI `Color(hex:alpha:)` extension and `Color.opacity(_:)`
// by building an 8-digit `#AARRGGBB` color string.
function toHex2(v: number): string {
  const s: string = v.toString(16);
  return s.length < 2 ? '0' + s : s;
}

function hexColor(hex: number, alpha: number): string {
  const r: number = (hex >> 16) & 0xff;
  const g: number = (hex >> 8) & 0xff;
  const b: number = hex & 0xff;
  const a: number = Math.round(alpha * 255);
  return '#' + toHex2(a) + toHex2(r) + toHex2(g) + toHex2(b);
}

function withAlpha(hex: string, alpha: number): string {
  const a: number = Math.round(alpha * 255);
  return '#' + toHex2(a) + hex.substring(1);
}

// MARK: - App Tokens & Colors
class AppColors {
  static readonly primary: string = hexColor(0x7C3AED, 1);
  static readonly secondary: string = hexColor(0x22D3EE, 1);
  static readonly tertiary: string = hexColor(0xF97316, 1);
  static readonly background: string = hexColor(0x050714, 1);
  static readonly surface: string = hexColor(0x0F172A, 1);
  static readonly surfaceVariant: string = hexColor(0x1F2937, 1);
  static readonly outline: string = hexColor(0x334155, 1);
  static readonly onPrimary: string = hexColor(0x050714, 1);
  static readonly onSecondary: string = hexColor(0x011014, 1);
  static readonly onTertiary: string = hexColor(0x110200, 1);
  static readonly onBackground: string = hexColor(0xF8FAFC, 1);
  static readonly onSurface: string = hexColor(0xE2E8F0, 1);
}

class AppTypography {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold; // .semibold
  static readonly headlineSize: number = 22;
  static readonly headlineWeight: FontWeight = FontWeight.Medium;
  static readonly titleSize: number = 16;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Regular;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 32;
  static readonly xxxl: number = 44;
}

class AppShapes {
  static readonly small: number = 12;
  static readonly medium: number = 16;
  static readonly large: number = 20;
}

// Note: the SwiftUI `AppTokens` nesting is flattened in ArkTS because a
// class cannot be referenced as an object; use AppColors / AppTypography /
// AppSpacing / AppShapes directly (same values, same behavior).

// MARK: - Models
let chatThreadId: number = 0;

class ChatThread {
  id: string = '';
  name: string = '';
  status: string = '';
  unread: number = 0;
  snippet: string = '';
  isPriority: boolean = false;

  constructor(name: string, status: string, unread: number, snippet: string, isPriority: boolean) {
    chatThreadId = chatThreadId + 1;
    this.id = 'thread-' + chatThreadId.toString();
    this.name = name;
    this.status = status;
    this.unread = unread;
    this.snippet = snippet;
    this.isPriority = isPriority;
  }
}

// MARK: - Main Screen
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live';
  @State draftMessage: string = '';

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background
      // (AppColors.background applied to the root Stack below, with safe-area expansion)

      Column({ space: 0 }) {
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
                      this.activeFilter = filter;
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
            Blank().height(100)
          }
          .width('100%')
          .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      // FAB (Floating Action Button) overlay
      Column() {
        Blank()
        Row() {
          Blank()
          Text('New')
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(AppColors.onPrimary)
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
            .shadow({ radius: 4 })
            .onClick(() => {})
            .padding({ right: AppSpacing.lg, bottom: 80 }) // Lift above bottom bar
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      // Bottom Bar
      BottomInputBar({ text: $draftMessage })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}

// MARK: - Components

@Component
struct CustomTopBar {
  build() {
    Row() {
      Text('Hub')
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(AppColors.onSurface)
        .onClick(() => {})

      Blank()

      Column({ space: 0 }) {
        Text('HoloChat Dock')
          .fontSize(AppTypography.titleSize)
          .fontWeight(AppTypography.titleWeight)
          .fontColor(AppColors.onSurface)
        Text('Dark neon bridge')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(withAlpha(AppColors.onSurface, 0.7))
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Text('Status')
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(AppColors.secondary)
        .onClick(() => {})
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
  }
}

@Component
struct AssistChip {
  label: string = '';
  isSelected: boolean = false;
  action: () => void = () => {};

  build() {
    Text(this.label)
      .fontSize(AppTypography.labelSize)
      .fontWeight(AppTypography.labelWeight)
      .fontColor(this.isSelected ? AppColors.onSecondary : AppColors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.isSelected ? AppColors.secondary : AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .border({ width: this.isSelected ? 0 : 1, color: AppColors.outline })
      .onClick(() => {
        this.action();
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
  title: string = '';
  value: string = '';
  accent: string = '';

  build() {
    Column({ space: AppSpacing.xs }) {
      Circle({ width: 12, height: 12 })
        .fill(this.accent)

      Text(this.title.toUpperCase())
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(withAlpha(AppColors.onSurface, 0.7))

      Text(this.value)
        .fontSize(AppTypography.displaySize)
        .fontWeight(AppTypography.displayWeight)
        .fontColor(this.accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
  }
}

@Component
struct ChatThreadCard {
  thread: ChatThread = new ChatThread('', '', 0, '', false);

  build() {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Column({ space: AppSpacing.xs }) {
          Text(this.thread.name)
            .fontSize(AppTypography.headlineSize)
            .fontWeight(AppTypography.headlineWeight)
            .fontColor(AppColors.onSurface)

          Text(this.thread.status)
            .fontSize(AppTypography.labelSize)
            .fontWeight(AppTypography.labelWeight)
            .fontColor(this.thread.isPriority ? AppColors.secondary : withAlpha(AppColors.onSurface, 0.7))
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(this.thread.unread > 0 ? '+' + this.thread.unread.toString() : '✓')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(this.thread.snippet)
        .fontSize(AppTypography.bodySize)
        .fontWeight(AppTypography.bodyWeight)
        .fontColor(withAlpha(AppColors.onSurface, 0.9))
        .width('100%')

      Row({ space: AppSpacing.sm }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)

        Text('Open')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.secondary)
          .onClick(() => {})
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
        .fontSize(AppTypography.titleSize)
        .fontWeight(AppTypography.titleWeight)
        .fontColor(AppColors.onSurface)

      Row({ space: AppSpacing.sm }) {
        Text('Calm')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.primary) // Default button text color
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppColors.onPrimary) // Using onPrimary (white/light) for surface feel if not specified, assuming default button style
          .borderRadius(AppShapes.medium)
          // Note: Android default Button uses primary color usually, but code uses 'Button' with no color spec for 'Calm', implying default Primary container.
          // Let's match Android Button default: Primary container, OnPrimary content.
          .backgroundColor(AppColors.primary)
          .fontColor(AppColors.onPrimary)
          .onClick(() => {})

        Text('Fire')
          .fontSize(AppTypography.labelSize)
          .fontWeight(AppTypography.labelWeight)
          .fontColor(AppColors.onTertiary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppColors.tertiary)
          .borderRadius(AppShapes.medium)
          .onClick(() => {})
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
  @Link text: string;

  build() {
    Row({ space: AppSpacing.sm }) {
      // The Swift `ZStack` + conditional placeholder `Text` maps to TextInput's
      // native `placeholder`, shown automatically when the field is empty.
      TextInput({ text: this.text, placeholder: 'Message dock...' })
        .placeholderColor(withAlpha(AppColors.onSurface, 0.6))
        .fontSize(AppTypography.bodySize)
        .fontColor(AppColors.onSurface)
        .height(48)
        .padding({ left: AppSpacing.md, right: AppSpacing.md })
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .onChange((value: string) => {
          this.text = value;
        })
        .layoutWeight(1)

      Text('Send')
        .fontSize(AppTypography.labelSize)
        .fontWeight(AppTypography.labelWeight)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 20, right: 20 })
        .height(48)
        .textAlign(TextAlign.Center)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {})
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({ radius: 6, color: withAlpha('#000000', 0.2), offsetX: 0, offsetY: -2 })
  }
}
