// HoloChatDock.ets
import { Length, ResourceStr } from '@ohos.kit.UIKit';

// --- Constants ---
const NAME = "201_HoloChatDock_en";
const UI_TYPE = "Social Messenger";
const STYLE_THEME = "Dark Neon Glow";
const LANG = "en";
const BASELINE_SIZE = "720x1280";
const DENSITY_SPACING = "Compact";
const COMPLEXITY = "Combines FAB and BottomBar controls to handle quick actions and message composition in a dense messenger workspace.";
const EXTRA = "Include all widgets listed in KeyWidgets at least once in the layout, use rounded corners between 12 dp and 20 dp, and rely only on shape or text placeholders instead of external images or custom fonts.";

// --- Design Tokens ---
class AppColors {
  static readonly primary: string = '#7C3AED';
  static readonly secondary: string = '#22D3EE';
  static readonly tertiary: string = '#F97316';
  static readonly background: string = '#050714';
  static readonly surface: string = '#0F172A';
  static readonly surfaceVariant: string = '#1F2937';
  static readonly outline: string = '#334155';
  static readonly success: string = '#34D399';
  static readonly warning: string = '#FBBF24';
  static readonly error: string = '#F87171';
  static readonly onPrimary: string = '#050714';
  static readonly onSecondary: string = '#011014';
  static readonly onTertiary: string = '#110200';
  static readonly onBackground: string = '#F8FAFC';
  static readonly onSurface: string = '#E2E8F0';
  static readonly onSurfaceVariant: string = '#94A3B8'; // 0.7 alpha approximation
  static readonly onSurfaceHigh: string = '#CBD5E1'; // 0.9 alpha approximation
}

class AppTypography {
  static readonly display: string = '28vp';
  static readonly headline: string = '22vp';
  static readonly title: string = '16vp';
  static readonly body: string = '14vp';
  static readonly label: string = '12vp';
}

class AppShapes {
  static readonly small: number = 12;
  static readonly medium: number = 16;
  static readonly large: number = 20;
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

// --- Data Models ---
interface ChatThread {
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;
}

// --- Main Entry Point ---
@Entry
@Component
struct HoloChatDock {
  @State activeFilter: string = "Live";
  @State draft: string = "";
  private filters: string[] = ["Live", "Pinned", "Escalated", "Silent"];
  private threads: ChatThread[] = [
    { name: "Orbital Finance", status: "Rolling sync", unread: 5, snippet: "Need rates for Q4", isPriority: true },
    { name: "Beacon Ops", status: "Docked", unread: 0, snippet: "Switching to holo feed", isPriority: false },
    { name: "Nova Crew", status: "Hotline", unread: 2, snippet: "Uploading scan pack now", isPriority: true }
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        TextButton({ type: ButtonType.Text }) {
          Text('Hub')
            .fontSize(AppTypography.label)
            .fontColor(AppColors.onSurface)
        }
        .margin({ left: AppSpacing.sm })

        Column() {
          Text('HoloChat Dock')
            .fontSize(AppTypography.title)
            .fontColor(AppColors.onSurface)
          Text('Dark neon bridge')
            .fontSize(AppTypography.label)
            .fontColor(AppColors.onSurfaceVariant)
        }
        .margin({ left: AppSpacing.lg })
        .alignItems(HorizontalAlign.Start)

        Blank()

        TextButton({ type: ButtonType.Text }) {
          Text('Status')
            .fontSize(AppTypography.label)
            .fontColor(AppColors.secondary)
        }
        .margin({ right: AppSpacing.sm })
      }
      .width('100%')
      .height(56)
      .backgroundColor(AppColors.surface)
      .padding({ left: AppSpacing.sm, right: AppSpacing.sm })

      // Scrollable Content
      Scroll() {
        Column() {
          // Filter Chips
          Row() {
            ForEach(this.filters, (label: string) => {
              Text(label)
                .fontSize(AppTypography.label)
                .fontColor(this.activeFilter === label ? AppColors.onSecondary : AppColors.onSurface)
                .backgroundColor(this.activeFilter === label ? AppColors.secondary : AppColors.surfaceVariant)
                .borderRadius(AppShapes.small)
                .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
                .margin({ right: AppSpacing.sm })
                .onClick(() => {
                  this.activeFilter = label;
                })
            })
          }
          .margin({ bottom: AppSpacing.md })

          // Status Summary
          Row() {
            SummaryBlock({ title: "Live docks", value: "12", accent: AppColors.secondary })
            SummaryBlock({ title: "Escalations", value: "3", accent: AppColors.tertiary })
            SummaryBlock({ title: "Queued", value: "5", accent: AppColors.primary })
          }
          .width('100%')
          .margin({ bottom: AppSpacing.md })

          // Chat Threads
          ForEach(this.threads, (thread: ChatThread) => {
            ChatThreadCard({ thread: thread })
              .margin({ bottom: AppSpacing.md })
          })

          // Action Footer
          ActionFooter()
        }
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: 80 }) // Bottom padding for FAB/Bar
      }
      .layoutWeight(1)
      .backgroundColor(AppColors.background)

      // Bottom Bar
      Row() {
        TextInput({ text: this.draft, placeholder: 'Message dock...' })
          .layoutWeight(1)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.medium)
          .height(40)
          .fontSize(AppTypography.body)
          .fontColor(AppColors.onSurface)
          .placeholderColor(AppColors.onSurfaceVariant)
          .onChange((value: string) => {
            this.draft = value;
          })

        Button('Send') {
          Text('Send')
            .fontSize(AppTypography.label)
            .fontColor(AppColors.onPrimary)
        }
        .type(ButtonType.Capsule)
        .backgroundColor(AppColors.primary)
        .margin({ left: AppSpacing.sm })
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(AppColors.surfaceVariant)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}

// --- Reusable Components ---

@Component
struct SummaryBlock {
  @Prop title: string;
  @Prop value: string;
  @Prop accent: string;

  build() {
    Column() {
      Row() {
        // Accent Dot
        Circle({ width: 12, height: 12 })
          .fillColor(this.accent)
          .margin({ bottom: AppSpacing.xs })
      }
      .width('100%')
      .alignItems(HorizontalAlign.Start)

      Text(this.title.toUpperCase())
        .fontSize(AppTypography.label)
        .fontColor(AppColors.onSurfaceVariant)
        .margin({ bottom: AppSpacing.xs })

      Text(this.value)
        .fontSize(AppTypography.display)
        .fontColor(this.accent)
    }
    .layoutWeight(1)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .padding(AppSpacing.md)
    .margin({ right: AppSpacing.sm })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct ChatThreadCard {
  @Prop thread: ChatThread;

  build() {
    Column() {
      Row() {
        Column() {
          Text(this.thread.name)
            .fontSize(AppTypography.headline)
            .fontColor(AppColors.onSurface)
            .margin({ bottom: AppSpacing.xs })

          Text(this.thread.status)
            .fontSize(AppTypography.label)
            .fontColor(this.thread.isPriority ? AppColors.secondary : AppColors.onSurfaceVariant)
        }
        .alignItems(HorizontalAlign.Start)

        // Unread Badge
        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(AppTypography.label)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppSpacing.sm })

      Text(this.thread.snippet)
        .fontSize(AppTypography.body)
        .fontColor(AppColors.onSurfaceHigh)
        .margin({ bottom: AppSpacing.sm })

      Row() {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(AppTypography.label)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .margin({ right: AppSpacing.sm })

        TextButton({ type: ButtonType.Text }) {
          Text('Open')
            .fontSize(AppTypography.label)
            .fontColor(AppColors.secondary)
        }
      }
    }
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .border({ width: 1, color: AppColors.outline })
    .padding(AppSpacing.md)
  }
}

@Component
struct ActionFooter {
  build() {
    Column() {
      Text('Dock filters')
        .fontSize(AppTypography.title)
        .fontColor(AppColors.onSurface)
        .margin({ bottom: AppSpacing.sm })

      Row() {
        Button('Calm') {
          Text('Calm')
            .fontSize(AppTypography.label)
            .fontColor(AppColors.onPrimary)
        }
        .type(ButtonType.Capsule)
        .backgroundColor(AppColors.primary)
        .margin({ right: AppSpacing.sm })

        Button('Fire') {
          Text('Fire')
            .fontSize(AppTypography.label)
            .fontColor(AppColors.onTertiary)
        }
        .type(ButtonType.Capsule)
        .backgroundColor(AppColors.tertiary)
      }
    }
    .width('100%')
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.large)
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
  }
}