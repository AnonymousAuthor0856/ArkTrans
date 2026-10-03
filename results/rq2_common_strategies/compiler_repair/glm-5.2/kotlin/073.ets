// Index.ets

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

class ShadowSpec {
  elevation: number;
  radius: number;
  dy: number;
  opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class AppColors {
  static primary: string = '#7C3AED';
  static secondary: string = '#22D3EE';
  static tertiary: string = '#F97316';
  static background: string = '#050714';
  static surface: string = '#0F172A';
  static surfaceVariant: string = '#1F2937';
  static outline: string = '#334155';
  static success: string = '#34D399';
  static warning: string = '#FBBF24';
  static error: string = '#F87171';
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

class AppElevation {
  static level1: ShadowSpec = new ShadowSpec(2, 6, 2, 0.14);
  static level2: ShadowSpec = new ShadowSpec(6, 10, 4, 0.18);
  static level3: ShadowSpec = new ShadowSpec(10, 14, 6, 0.22);
  static level4: ShadowSpec = new ShadowSpec(14, 18, 8, 0.26);
  static level5: ShadowSpec = new ShadowSpec(18, 22, 10, 0.3);
}

@Entry
@Component
struct RootScreen {
  @State activeFilter: string = 'Live';
  @State draft: string = '';
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ];

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Hub')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
        Column() {
          Text('HoloChat Dock')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('Dark neon bridge')
            .fontSize(12)
            .fontColor('#A1A1AA')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        .padding({ left: AppSpacing.sm })

        Text('Status')
          .fontSize(12)
          .fontColor(AppColors.secondary)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
      }
      .width('100%')
      .height(56)
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
      .backgroundColor(AppColors.surface)
      .alignItems(VerticalAlign.Center)

      // Content
      Scroll() {
        Column() {
          // Filters
          Row() {
            ForEach(this.filters, (label: string) => {
              Text(label)
                .fontSize(12)
                .fontColor(this.activeFilter === label ? AppColors.onSecondary : AppColors.onSurface)
                .backgroundColor(this.activeFilter === label ? AppColors.secondary : AppColors.surfaceVariant)
                .borderRadius(12)
                .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
                .margin({ right: AppSpacing.sm })
                .onClick(() => {
                  this.activeFilter = label;
                })
            })
          }
          .width('100%')
          .margin({ bottom: AppSpacing.md })

          // Status Summary
          Row() {
            this.SummaryBlock('Live docks', '12', AppColors.secondary)
            this.SummaryBlock('Escalations', '3', AppColors.tertiary)
            this.SummaryBlock('Queued', '5', AppColors.primary)
          }
          .width('100%')
          .margin({ bottom: AppSpacing.md })

          // Chat Threads
          ForEach(this.threads, (thread: ChatThread) => {
            this.ChatThreadCard(thread)
          })

          // Action Footer
          Column() {
            Text('Dock filters')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .margin({ bottom: AppSpacing.sm })

            Row() {
              Button('Calm')
                .fontSize(12)
                .fontColor(AppColors.onPrimary)
                .backgroundColor(AppColors.primary)
                .borderRadius(16)
                .height(36)
                .margin({ right: AppSpacing.sm })

              Button('Fire')
                .fontSize(12)
                .fontColor(AppColors.onTertiary)
                .backgroundColor(AppColors.tertiary)
                .borderRadius(16)
                .height(36)
            }
          }
          .width('100%')
          .padding(AppSpacing.lg)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(20)
          .margin({ top: AppSpacing.md })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)

      // Bottom Bar
      Row() {
        TextInput({ text: this.draft, placeholder: 'Message dock...' })
          .onChange((value: string) => {
            this.draft = value;
          })
          .layoutWeight(1)
          .height(40)
          .backgroundColor(AppColors.surface)
          .borderRadius(16)
          .fontColor(AppColors.onSurface)
          .fontSize(14)
          .margin({ right: AppSpacing.sm })

        Button('Send')
          .fontSize(12)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(16)
          .height(40)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(AppColors.surfaceVariant)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  SummaryBlock(title: string, value: string, accent: string) {
    Column() {
      Circle({ width: 12, height: 12 })
        .fill(accent)
        .margin({ bottom: AppSpacing.xs })

      Text(title.toUpperCase())
        .fontSize(12)
        .fontColor('#A1A1AA')
        .margin({ bottom: AppSpacing.xs })

      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(accent)
    }
    .layoutWeight(1)
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(16)
    .margin({ right: AppSpacing.sm })
  }

  @Builder
  ChatThreadCard(thread: ChatThread) {
    Column() {
      Row() {
        Column() {
          Text(thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .margin({ bottom: AppSpacing.xs })

          Text(thread.status)
            .fontSize(12)
            .fontColor(thread.isPriority ? AppColors.secondary : '#A1A1AA')
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(thread.unread > 0 ? `+${thread.unread}` : '✓')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .margin({ bottom: AppSpacing.sm })

      Text(thread.snippet)
        .fontSize(14)
        .fontColor('#D1D5DB')
        .margin({ bottom: AppSpacing.sm })

      Row() {
        Text(thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(12)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .margin({ right: AppSpacing.sm })

        Text('Open')
          .fontSize(12)
          .fontColor(AppColors.secondary)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
      }
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(20)
    .border({ width: 1, color: AppColors.outline })
    .margin({ bottom: AppSpacing.md })
  }
}