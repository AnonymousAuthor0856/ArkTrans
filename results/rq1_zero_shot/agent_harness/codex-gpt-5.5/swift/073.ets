class AppColors {
  static primary: string = '#7C3AED';
  static secondary: string = '#22D3EE';
  static tertiary: string = '#F97316';
  static background: string = '#050714';
  static surface: string = '#0F172A';
  static surfaceVariant: string = '#1F2937';
  static outline: string = '#334155';
  static onPrimary: string = '#050714';
  static onSecondary: string = '#011014';
  static onTertiary: string = '#110200';
  static onBackground: string = '#F8FAFC';
  static onSurface: string = '#E2E8F0';
}

class AppSpacing {
  static xs: number = 4;
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 16;
  static xl: number = 24;
  static xxl: number = 32;
  static xxxl: number = 44;
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
struct HoloChatDockScreen {
  @State private activeFilter: string = 'Live';
  @State private draftMessage: string = '';
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ];

  @Builder
  private CustomTopBar() {
    Row() {
      Button('Hub')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor(Color.Transparent)
      Blank()
      Column() {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#E2E8F0B3')
      }
      .alignItems(HorizontalAlign.Start)
      Blank()
      Button('Status')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .backgroundColor(Color.Transparent)
    }
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .width('100%')
    .backgroundColor(AppColors.surface)
  }

  @Builder
  private AssistChip(label: string) {
    Text(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.activeFilter === label ? AppColors.onSecondary : AppColors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.activeFilter === label ? AppColors.secondary : AppColors.surfaceVariant)
      .borderRadius(12)
      .border({ width: this.activeFilter === label ? 0 : 1, color: AppColors.outline })
      .onClick(() => {
        this.activeFilter = label;
      })
  }

  @Builder
  private SummaryBlock(title: string, value: string, accent: string) {
    Column({ space: AppSpacing.xs }) {
      Circle()
        .width(12)
        .height(12)
        .fill(accent)
      Text(title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#E2E8F0B3')
      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(accent)
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .layoutWeight(1)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
  }

  @Builder
  private StatusSummary() {
    Row({ space: AppSpacing.sm }) {
      this.SummaryBlock('Live docks', '12', AppColors.secondary)
      this.SummaryBlock('Escalations', '3', AppColors.tertiary)
      this.SummaryBlock('Queued', '5', AppColors.primary)
    }
    .width('100%')
  }

  @Builder
  private ChatThreadCard(thread: ChatThread) {
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
            .fontColor(thread.isPriority ? AppColors.secondary : '#E2E8F0B3')
        }
        .alignItems(HorizontalAlign.Start)
        Blank()
        Text(thread.unread > 0 ? `+${thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
      }
      .width('100%')

      Text(thread.snippet)
        .fontSize(14)
        .fontColor('#E2E8F0E6')
        .width('100%')
        .textAlign(TextAlign.Start)

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
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.md)
    .width('100%')
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .border({ width: 1, color: AppColors.outline })
  }

  @Builder
  private ActionFooter() {
    Column({ space: AppSpacing.sm }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Row({ space: AppSpacing.sm }) {
        Button('Calm')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppColors.primary)
          .borderRadius(16)
        Button('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppColors.tertiary)
          .borderRadius(16)
      }
    }
    .alignItems(HorizontalAlign.Start)
    .padding(AppSpacing.lg)
    .width('100%')
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(20)
  }

  @Builder
  private BottomInputBar() {
    Row({ space: AppSpacing.sm }) {
      TextInput({ placeholder: 'Message dock...', text: this.draftMessage })
        .height(48)
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .backgroundColor(AppColors.surface)
        .borderRadius(16)
        .layoutWeight(1)
        .onChange((text: string) => {
          this.draftMessage = text;
        })
      Button('Send')
        .height(48)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 20, right: 20 })
        .backgroundColor(AppColors.primary)
        .borderRadius(16)
    }
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .width('100%')
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({ radius: 6, color: '#00000033', offsetX: 0, offsetY: -2 })
  }

  build() {
    Stack() {
      Column({ space: 0 }) {
        this.CustomTopBar()

        Scroll() {
          Column({ space: AppSpacing.md }) {
            Scroll() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  this.AssistChip(filter)
                })
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            this.StatusSummary()
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            ForEach(this.threads, (thread: ChatThread) => {
              this.ChatThreadCard(thread)
                .margin({ left: AppSpacing.lg, right: AppSpacing.lg })
            })

            this.ActionFooter()
              .margin({ left: AppSpacing.lg, right: AppSpacing.lg })

            Blank()
              .height(100)
          }
          .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
          .width('100%')
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        Row() {
          Blank()
          Button('New')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
            .backgroundColor(AppColors.primary)
            .borderRadius(16)
            .shadow({ radius: 4, color: '#00000066', offsetX: 0, offsetY: 2 })
            .margin({ right: AppSpacing.lg, bottom: 80 })
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')

      Column() {
        Blank()
        this.BottomInputBar()
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
