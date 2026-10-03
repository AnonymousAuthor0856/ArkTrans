import prompt from '@ohos.promptAction';

// MARK: - Color Hex Helper
function hexColor(hex: number, alpha: number = 1): Color {
  const r = (hex >> 16) & 0xff;
  const g = (hex >> 8) & 0xff;
  const b = hex & 0xff;
  return `rgba(${r}, ${g}, ${b}, ${alpha})` as Color;
}

// MARK: - App Tokens & Colors
namespace AppTokens {
  export namespace Colors {
    export const primary: Color = hexColor(0x7C3AED);
    export const secondary: Color = hexColor(0x22D3EE);
    export const tertiary: Color = hexColor(0xF97316);
    export const background: Color = hexColor(0x050714);
    export const surface: Color = hexColor(0x0F172A);
    export const surfaceVariant: Color = hexColor(0x1F2937);
    export const outline: Color = hexColor(0x334155);
    export const onPrimary: Color = hexColor(0x050714);
    export const onSecondary: Color = hexColor(0x011014);
    export const onTertiary: Color = hexColor(0x110200);
    export const onBackground: Color = hexColor(0xF8FAFC);
    export const onSurface: Color = hexColor(0xE2E8F0);
  }

  export namespace Typography {
    export const displaySize = 28;
    export const displayWeight = FontWeight.SemiBold;
    export const headlineSize = 22;
    export const headlineWeight = FontWeight.Medium;
    export const titleSize = 16;
    export const titleWeight = FontWeight.Medium;
    export const bodySize = 14;
    export const bodyWeight = FontWeight.Regular;
    export const labelSize = 12;
    export const labelWeight = FontWeight.Medium;
  }

  export namespace Spacing {
    export const xs = 4;
    export const sm = 8;
    export const md = 12;
    export const lg = 16;
    export const xl = 24;
    export const xxl = 32;
    export const xxxl = 44;
  }

  export namespace Shapes {
    export const small = 12;
    export const medium = 16;
    export const large = 20;
  }
}

// MARK: - Models
interface ChatThread {
  id: string;
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;
}

// MARK: - App Entry Point
@Entry
@Component
struct HoloChatApp {
  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      HoloChatDockScreen()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - Main Screen
@Component
struct HoloChatDockScreen {
  @State activeFilter: string = 'Live';
  @State draftMessage: string = '';

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];
  private threads: ChatThread[] = [
    { id: '1', name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
    { id: '2', name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
    { id: '3', name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true }
  ];

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        CustomTopBar()

        Scroll() {
          Column({ space: AppTokens.Spacing.md }) {
            // Filters
            Scroll(this.filters) {
              Row({ space: AppTokens.Spacing.sm }) {
                ForEach(this.filters, (filter: string) => {
                  AssistChip({
                    label: filter,
                    isSelected: this.activeFilter === filter,
                    action: () => { this.activeFilter = filter; }
                  })
                }, (filter: string) => filter)
              }
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)
            .width('100%')

            // Status Summary
            StatusSummary()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Threads List
            ForEach(this.threads, (thread: ChatThread) => {
              ChatThreadCard({ thread: thread })
                .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })
            }, (thread: ChatThread) => thread.id)

            // Action Footer
            ActionFooter()
              .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg })

            // Spacer for bottom bar + FAB area
            Blank()
              .height(100)
          }
          .padding({ top: AppTokens.Spacing.md, bottom: AppTokens.Spacing.md })
          .width('100%')
        }
        .scrollBar(BarState.Off)
        .flexGrow(1)
      }
      .width('100%')
      .height('100%')

      // FAB (Floating Action Button) overlay
      Column() {
        Blank()
        Row() {
          Blank()
          Button('New')
            .fontSize(AppTokens.Typography.labelSize)
            .fontColor(AppTokens.Colors.onPrimary)
            .backgroundColor(AppTokens.Colors.primary)
            .borderRadius(AppTokens.Shapes.medium)
            .padding({ left: 16, right: 16, top: 16, bottom: 16 })
            .shadow({ radius: 4, color: '#40000000' })
            .margin({ right: AppTokens.Spacing.lg, bottom: 80 })
            .onClick(() => {
              prompt.showToast({ message: 'New chat' });
            })
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
    .backgroundColor(AppTokens.Colors.background)
  }
}

// MARK: - Components

@Component
struct CustomTopBar {
  build() {
    Row() {
      Button('Hub')
        .fontSize(AppTokens.Typography.labelSize)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(Color.Transparent)
        .onClick(() => {})

      Blank()

      Column() {
        Text('HoloChat Dock')
          .fontSize(AppTokens.Typography.titleSize)
          .fontWeight(AppTokens.Typography.titleWeight)
          .fontColor(AppTokens.Colors.onSurface)
        Text('Dark neon bridge')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(hexColor(0xE2E8F0, 0.7))
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Button('Status')
        .fontSize(AppTokens.Typography.labelSize)
        .fontColor(AppTokens.Colors.secondary)
        .backgroundColor(Color.Transparent)
        .onClick(() => {})
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surface)
    .width('100%')
  }
}

@Component
struct AssistChip {
  label: string = '';
  isSelected: boolean = false;
  action: () => void = () => {};

  build() {
    Button(this.label)
      .fontSize(AppTokens.Typography.labelSize)
      .fontWeight(AppTokens.Typography.labelWeight)
      .fontColor(this.isSelected ? AppTokens.Colors.onSecondary : AppTokens.Colors.onSurface)
      .backgroundColor(this.isSelected ? AppTokens.Colors.secondary : AppTokens.Colors.surfaceVariant)
      .borderRadius(AppTokens.Shapes.small)
      .border({ width: this.isSelected ? 0 : 1, color: AppTokens.Colors.outline })
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .onClick(() => { this.action(); })
  }
}

@Component
struct StatusSummary {
  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      SummaryBlock({ title: 'Live docks', value: '12', accent: AppTokens.Colors.secondary })
      SummaryBlock({ title: 'Escalations', value: '3', accent: AppTokens.Colors.tertiary })
      SummaryBlock({ title: 'Queued', value: '5', accent: AppTokens.Colors.primary })
    }
    .width('100%')
  }
}

@Component
struct SummaryBlock {
  title: string = '';
  value: string = '';
  accent: Color = Color.Black;

  build() {
    Column({ space: AppTokens.Spacing.xs }) {
      Circle({ width: 12, height: 12 })
        .fill(this.accent)

      Text(this.title.toUpperCase())
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(AppTokens.Typography.labelWeight)
        .fontColor(hexColor(0xE2E8F0, 0.7))

      Text(this.value)
        .fontSize(AppTokens.Typography.displaySize)
        .fontWeight(AppTokens.Typography.displayWeight)
        .fontColor(this.accent)
    }
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.medium)
    .layoutWeight(1)
  }
}

@Component
struct ChatThreadCard {
  thread: ChatThread = { id: '', name: '', status: '', unread: 0, snippet: '', isPriority: false };

  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Row() {
        Column({ space: AppTokens.Spacing.xs }) {
          Text(this.thread.name)
            .fontSize(AppTokens.Typography.headlineSize)
            .fontWeight(AppTokens.Typography.headlineWeight)
            .fontColor(AppTokens.Colors.onSurface)

          Text(this.thread.status)
            .fontSize(AppTokens.Typography.labelSize)
            .fontWeight(AppTokens.Typography.labelWeight)
            .fontColor(this.thread.isPriority ? AppTokens.Colors.secondary : hexColor(0xE2E8F0, 0.7))
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Text(this.thread.unread > 0 ? `+${this.thread.unread}` : '✓')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)
      }
      .width('100%')

      Text(this.thread.snippet)
        .fontSize(AppTokens.Typography.bodySize)
        .fontWeight(AppTokens.Typography.bodyWeight)
        .fontColor(hexColor(0xE2E8F0, 0.9))

      Row({ space: AppTokens.Spacing.sm }) {
        Text(this.thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.onSurface)
          .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm, top: AppTokens.Spacing.xs, bottom: AppTokens.Spacing.xs })
          .backgroundColor(AppTokens.Colors.surfaceVariant)
          .borderRadius(AppTokens.Shapes.small)

        Button('Open')
          .fontSize(AppTokens.Typography.labelSize)
          .fontColor(AppTokens.Colors.secondary)
          .backgroundColor(Color.Transparent)
          .onClick(() => {})
      }
    }
    .padding(AppTokens.Spacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surface)
    .borderRadius(AppTokens.Shapes.large)
    .border({ width: 1, color: AppTokens.Colors.outline })
    .width('100%')
  }
}

@Component
struct ActionFooter {
  build() {
    Column({ space: AppTokens.Spacing.sm }) {
      Text('Dock filters')
        .fontSize(AppTokens.Typography.titleSize)
        .fontWeight(AppTokens.Typography.titleWeight)
        .fontColor(AppTokens.Colors.onSurface)

      Row({ space: AppTokens.Spacing.sm }) {
        Button('Calm')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.onPrimary)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .onClick(() => {})

        Button('Fire')
          .fontSize(AppTokens.Typography.labelSize)
          .fontWeight(AppTokens.Typography.labelWeight)
          .fontColor(AppTokens.Colors.onTertiary)
          .backgroundColor(AppTokens.Colors.tertiary)
          .borderRadius(AppTokens.Shapes.medium)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .onClick(() => {})
      }
    }
    .padding(AppTokens.Spacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .borderRadius(AppTokens.Shapes.large)
    .width('100%')
  }
}

@Component
struct BottomInputBar {
  @Link text: string;

  build() {
    Row({ space: AppTokens.Spacing.sm }) {
      TextInput({ placeholder: 'Message dock...', text: this.text })
        .placeholderColor(hexColor(0xE2E8F0, 0.6))
        .fontSize(AppTokens.Typography.bodySize)
        .fontColor(AppTokens.Colors.onSurface)
        .backgroundColor(AppTokens.Colors.surface)
        .borderRadius(AppTokens.Shapes.medium)
        .height(48)
        .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
        .onChange((value: string) => { this.text = value; })
        .layoutWeight(1)

      Button('Send')
        .fontSize(AppTokens.Typography.labelSize)
        .fontWeight(AppTokens.Typography.labelWeight)
        .fontColor(AppTokens.Colors.onPrimary)
        .backgroundColor(AppTokens.Colors.primary)
        .borderRadius(AppTokens.Shapes.medium)
        .height(48)
        .padding({ left: 20, right: 20 })
        .onClick(() => {
          prompt.showToast({ message: 'Message sent' });
        })
    }
    .padding({ left: AppTokens.Spacing.lg, right: AppTokens.Spacing.lg, top: AppTokens.Spacing.sm, bottom: AppTokens.Spacing.sm })
    .backgroundColor(AppTokens.Colors.surfaceVariant)
    .shadow({ radius: 6, color: 'rgba(0,0,0,0.2)', offsetY: -2 })
    .width('100%')
  }
}
