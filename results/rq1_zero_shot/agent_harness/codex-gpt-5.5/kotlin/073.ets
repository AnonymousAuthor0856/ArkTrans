const NAME: string = "201_HoloChatDock_en";
const UI_TYPE: string = "Social Messenger";
const STYLE_THEME: string = "Dark Neon Glow";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";
const DENSITY_SPACING: string = "Compact";
const COMPLEXITY: string = "Combines FAB and BottomBar controls to handle quick actions and message composition in a dense messenger workspace.";
const EXTRA: string = "Include all widgets listed in KeyWidgets at least once in the layout, use rounded corners between 12 dp and 20 dp, and rely only on shape or text placeholders instead of external images or custom fonts.";

class AppColors {
  static readonly primary: string = '#7C3AED';
  static readonly secondary: string = '#22D3EE';
  static readonly tertiary: string = '#F97316';
  static readonly background: string = '#050714';
  static readonly surface: string = '#0F172A';
  static readonly surfaceVariant: string = '#1F2937';
  static readonly outline: string = '#334155';
  static readonly onPrimary: string = '#050714';
  static readonly onSecondary: string = '#011014';
  static readonly onTertiary: string = '#110200';
  static readonly onSurface: string = '#E2E8F0';
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
}

class ChatThread {
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;

  constructor(name: string, status: string, unread: number, snippet: string, isPriority: boolean) {
    this.name = name;
    this.status = status;
    this.unread = unread;
    this.snippet = snippet;
    this.isPriority = isPriority;
  }
}

@Entry
@Component
struct MainActivity {
  @State activeFilter: string = 'Live';
  @State draft: string = '';

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ];

  @Builder
  TopBar() {
    Row() {
      Button('Hub')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor(Color.Transparent)
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
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      Button('Status')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .backgroundColor(Color.Transparent)
    }
    .width('100%')
    .height(64)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
  }

  @Builder
  FilterChip(label: string) {
    Text(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.activeFilter === label ? AppColors.onSecondary : AppColors.onSurface)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.activeFilter === label ? AppColors.secondary : AppColors.surfaceVariant)
      .borderRadius(12)
      .onClick(() => {
        this.activeFilter = label;
      })
  }

  @Builder
  SummaryBlock(title: string, value: string, accent: string) {
    Column({ space: AppSpacing.xs }) {
      Circle().width(12).height(12).fill(accent)
      Text(title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .opacity(0.7)
      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(accent)
    }
    .layoutWeight(1)
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
  }

  @Builder
  StatusSummary() {
    Row({ space: AppSpacing.sm }) {
      this.SummaryBlock('Live docks', '12', AppColors.secondary)
      this.SummaryBlock('Escalations', '3', AppColors.tertiary)
      this.SummaryBlock('Queued', '5', AppColors.primary)
    }
    .width('100%')
  }

  @Builder
  ChatThreadCard(thread: ChatThread) {
    Column({ space: AppSpacing.sm }) {
      Row() {
        Column({ space: AppSpacing.xs }) {
          Text(thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(thread.isPriority ? AppColors.secondary : AppColors.onSurface)
            .opacity(thread.isPriority ? 1 : 0.7)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Start)

        Text(thread.unread > 0 ? `+${thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(thread.snippet)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .opacity(0.9)
        .width('100%')

      Row({ space: AppSpacing.sm }) {
        Text(thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
        Button('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .backgroundColor(Color.Transparent)
      }
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .border({ width: 1, color: AppColors.outline })
    .shadow({ radius: 6, color: '#24000000', offsetY: 2 })
  }

  @Builder
  ActionFooter() {
    Column({ space: AppSpacing.sm }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
      Row({ space: AppSpacing.sm }) {
        Button('Calm')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .height(38)
          .borderRadius(16)
        Button('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
          .height(38)
          .backgroundColor(AppColors.tertiary)
          .borderRadius(16)
      }
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(20)
  }

  @Builder
  BottomBar() {
    Row({ space: AppSpacing.sm }) {
      TextInput({ text: this.draft, placeholder: 'Message dock...' })
        .onChange((value: string) => { this.draft = value; })
        .layoutWeight(1)
        .height(42)
        .backgroundColor(AppColors.surface)
        .borderRadius(16)
      Button('Send')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .height(42)
        .borderRadius(16)
    }
    .width('100%')
    .height(62)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({ radius: 10, color: '#2E000000', offsetY: -4 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column({ space: AppSpacing.md }) {
            Row({ space: AppSpacing.sm }) {
              ForEach(this.filters, (label: string) => {
                this.FilterChip(label)
              })
            }
            .width('100%')
            this.StatusSummary()
            ForEach(this.threads, (thread: ChatThread) => {
              this.ChatThreadCard(thread)
            })
            this.ActionFooter()
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
        }
        .layoutWeight(1)
        .width('100%')
        .scrollBar(BarState.Off)
        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(AppColors.background)

      Text('New')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .width(56)
        .height(56)
        .lineHeight(56)
        .backgroundColor(AppColors.primary)
        .borderRadius(16)
        .margin({ right: 18, bottom: 76 })
    }
    .width('100%')
    .height('100%')
  }
}
