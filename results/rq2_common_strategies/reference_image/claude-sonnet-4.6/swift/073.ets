```ts
/* ------------------------------------------------------------------
 * HoloChat Dock — ArkTS (HarmonyOS ArkUI) port of the SwiftUI screen.
 * Entry page: HoloChatDockScreen
 * ------------------------------------------------------------------ */

// MARK: - Design tokens

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
  static readonly onBackground: string = '#F8FAFC';
  static readonly onSurface: string = '#E2E8F0';
}

class AppType {
  static readonly display: number = 28;
  static readonly headline: number = 22;
  static readonly title: number = 16;
  static readonly body: number = 14;
  static readonly label: number = 12;
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

// MARK: - Models

interface ChatThread {
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;
}

interface SummaryItem {
  title: string;
  value: string;
  accent: string;
}

// MARK: - Top bar

@Component
struct CustomTopBar {
  build() {
    Row() {
      Text('Hub')
        .fontSize(AppType.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .onClick(() => {
        })

      Blank()

      Column() {
        Text('HoloChat Dock')
          .fontSize(AppType.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('Dark neon bridge')
          .fontSize(AppType.label)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .opacity(0.7)
      }
      .alignItems(HorizontalAlign.Center)

      Blank()

      Text('Status')
        .fontSize(AppType.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .backgroundColor(AppColors.surface)
  }
}

// MARK: - Assist chip

@Component
struct AssistChip {
  @Prop label: string = '';
  @Prop isSelected: boolean = false;
  onSelect: () => void = () => {
  };

  build() {
    Text(this.label)
      .fontSize(AppType.label)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.isSelected ? AppColors.onSecondary : AppColors.onSurface)
      .padding({ left: 16, right: 16, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .backgroundColor(this.isSelected ? AppColors.secondary : AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .border({ width: this.isSelected ? 0 : 1, color: AppColors.outline })
      .onClick(() => {
        this.onSelect();
      })
  }
}

// MARK: - Chat thread card

@Component
struct ChatThreadCard {
  @Prop name: string = '';
  @Prop status: string = '';
  @Prop unread: number = 0;
  @Prop snippet: string = '';
  @Prop isPriority: boolean = false;

  build() {
    Column() {
      Column({ space: AppSpacing.sm }) {
        Row() {
          Column({ space: AppSpacing.xs }) {
            Text(this.name)
              .fontSize(AppType.headline)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)

            Text(this.status)
              .fontSize(AppType.label)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.isPriority ? AppColors.secondary : AppColors.onSurface)
              .opacity(this.isPriority ? 1 : 0.7)
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Text(this.unread > 0 ? ('+' + this.unread) : '✓')
            .fontSize(AppType.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .padding({
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              top: AppSpacing.xs,
              bottom: AppSpacing.xs
            })
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.small)
        }
        .width('100%')
        .alignItems(VerticalAlign.Top)

        Text(this.snippet)
          .fontSize(AppType.body)
          .fontColor(AppColors.onSurface)
          .opacity(0.9)
          .width('100%')

        Row({ space: AppSpacing.sm }) {
          Text(this.isPriority ? 'Priority' : 'Standard')
            .fontSize(AppType.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
            .padding({
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              top: AppSpacing.xs,
              bottom: AppSpacing.xs
            })
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.small)

          Text('Open')
            .fontSize(AppType.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
            .onClick(() => {
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(AppSpacing.md)
      .backgroundColor(AppColors.surface)
      .borderRadius(AppShapes.large)
      .border({ width: 1, color: AppColors.outline })
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
  }
}

// MARK: - Action footer

@Component
struct ActionFooter {
  build() {
    Column() {
      Column({ space: AppSpacing.sm }) {
        Text('Dock filters')
          .fontSize(AppType.title)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .width('100%')

        Row({ space: AppSpacing.sm }) {
          Text('Calm')
            .fontSize(AppType.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .padding({ left: 16, right: 16, top: 10, bottom: 10 })
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
            })

          Text('Fire')
            .fontSize(AppType.label)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onTertiary)
            .padding({ left: 16, right: 16, top: 10, bottom: 10 })
            .backgroundColor(AppColors.tertiary)
            .borderRadius(AppShapes.medium)
            .onClick(() => {
            })
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
      .padding(AppSpacing.lg)
      .backgroundColor(AppColors.surfaceVariant)
      .borderRadius(AppShapes.large)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
  }
}

// MARK: - Bottom input bar

@Component
struct BottomInputBar {
  @Prop text: string = '';
  onChange: (value: string) => void = () => {
  };

  build() {
    Row({ space: AppSpacing.sm }) {
      TextInput({ placeholder: 'Message dock...', text: this.text })
        .placeholderColor('#99E2E8F0')
        .placeholderFont({ size: AppType.label, weight: FontWeight.Medium })
        .fontSize(AppType.body)
        .fontColor(AppColors.onSurface)
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShapes.medium)
        .height(48)
        .layoutWeight(1)
        .padding({ left: AppSpacing.md, right: AppSpacing.md })
        .onChange((value: string) => {
          this.onChange(value);
        })

      Text('Send')
        .fontSize(AppType.label)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .height(48)
        .padding({ left: 20, right: 20 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .onClick(() => {
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({
      left: AppSpacing.lg,
      right: AppSpacing.lg,
      top: AppSpacing.sm,
      bottom: AppSpacing.sm
    })
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({ radius: 6, color: '#33000000', offsetX: 0, offsetY: -2 })
  }
}

// MARK: - Main screen

@Entry
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live';
  @State draftMessage: string = '';

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];

  private threads: ChatThread[] = [
    {
      name: 'Orbital Finance',
      status: 'Rolling sync',
      unread: 5,
      snippet: 'Need rates for Q4',
      isPriority: true
    },
    {
      name: 'Beacon Ops',
      status: 'Docked',
      unread: 0,
      snippet: 'Switching to holo feed',
      isPriority: false
    },
    {
      name: 'Nova Crew',
      status: 'Hotline',
      unread: 2,
      snippet: 'Uploading scan pack now',
      isPriority: true
    }
  ];

  private summaries: SummaryItem[] = [
    { title: 'Live docks', value: '12', accent: AppColors.secondary },
    { title: 'Escalations', value: '3', accent: AppColors.tertiary },
    { title: 'Queued', value: '5', accent: AppColors.primary }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {

      // MARK: Content column
      Column() {
        CustomTopBar()

        Scroll() {
          Column({ space: AppSpacing.md }) {

            // Filter chips
            Scroll() {
              Row({ space: AppSpacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  AssistChip({
                    label: filter,
                    isSelected: this.activeFilter === filter,
                    onSelect: () => {
                      this.activeFilter = filter;
                    }
                  })
                }, (filter: string) => filter + '_' + (this.activeFilter === filter ? 'on' : 'off'))
              }
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            }
            .width('100%')
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            // Status summary
            Row({ space: AppSpacing.sm }) {
              ForEach(this.summaries, (item: SummaryItem) => {
                Column({ space: AppSpacing.xs }) {
                  Circle({ width: 12, height: 12 })
                    .fill(item.accent)

                  Text(item.title.toUpperCase())
                    .fontSize(AppType.label)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onSurface)
                    .opacity(0.7)

                  Text(item.value)
                    .fontSize(AppType.display)
                    .fontWeight(FontWeight.SemiBold)
                    .fontColor(item.accent)
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1)
                .padding(AppSpacing.md)
                .backgroundColor(AppColors.surface)
                .borderRadius(AppShapes.medium)
              }, (item: SummaryItem) => item.title)
            }
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            // Threads
            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({
                name: thread.name,
                status: thread.status,
                unread: thread.unread,
                snippet: thread.snippet,
                isPriority: thread.isPriority
              })
            }, (thread: ChatThread) => thread.name)

            // Action footer
            ActionFooter()

            // Space reserved for the bottom bar
            Row().height(100)
          }