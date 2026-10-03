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
  onSurface: '#E2E8F0'
};

const Spacing = { xs: 4, sm: 8, md: 12, lg: 16, xl: 24, xxl: 32, xxxl: 44 };
const Shapes = { small: 12, medium: 16, large: 20 };

interface ChatThread {
  name: string;
  status: string;
  unread: number;
  snippet: string;
  isPriority: boolean;
}

const filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];

const threads: ChatThread[] = [
  { name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
  { name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
  { name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true }
];

@Entry
@Component
struct Index {
  @State activeFilter: string = 'Live';
  @State draft: string = '';

  @Builder
  summaryBlock(title: string, value: string, accent: string) {
    Column({ space: Spacing.xs }) {
      Column() {
      }
      .width(12)
      .height(12)
      .borderRadius(6)
      .backgroundColor(accent)

      Text(title.toUpperCase())
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3E2E8F0')
      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(accent)
    }
    .layoutWeight(1)
    .borderRadius(Shapes.medium)
    .backgroundColor(Colors.surface)
    .padding(Spacing.md)
  }

  @Builder
  chatThreadCard(thread: ChatThread) {
    Column({ space: Spacing.sm }) {
      Row() {
        Column({ space: Spacing.xs }) {
          Text(thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text(thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(thread.isPriority ? Colors.secondary : '#B3E2E8F0')
        }

        Stack() {
          Text(thread.unread > 0 ? '+' + thread.unread : '✓')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
        }
        .borderRadius(Shapes.small)
        .backgroundColor(Colors.surfaceVariant)
        .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(thread.snippet)
        .fontSize(14)
        .fontColor('#E6E2E8F0')

      Row({ space: Spacing.sm }) {
        Text(thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
          .padding({ left: Spacing.sm, right: Spacing.sm, top: Spacing.xs, bottom: Spacing.xs })
          .borderRadius(Shapes.small)
          .backgroundColor(Colors.surfaceVariant)
        Text('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
          .padding(Spacing.xs)
          .onClick(() => {
          })
      }
    }
    .padding(Spacing.md)
    .width('100%')
    .borderRadius(Shapes.large)
    .backgroundColor(Colors.surface)
    .border({ width: 1, color: Colors.outline })
    .shadow({ radius: 6, color: '#14000000', offsetY: 2 })
  }

  @Builder
  actionFooter() {
    Column({ space: Spacing.sm }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(Colors.onSurface)
      Row({ space: Spacing.sm }) {
        Button('Calm')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .borderRadius(Shapes.medium)
        Button('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .borderRadius(Shapes.medium)
          .backgroundColor(Colors.tertiary)
          .fontColor(Colors.onTertiary)
      }
    }
    .padding(Spacing.lg)
    .width('100%')
    .borderRadius(Shapes.large)
    .backgroundColor(Colors.surfaceVariant)
  }

  build() {
    Column() {
      Row() {
        Text('Hub')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)
        Column() {
          Text('HoloChat Dock')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
          Text('Dark neon bridge')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B3E2E8F0')
        }
        .layoutWeight(1)
        Text('Status')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.secondary)
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Colors.surface)

      Stack({ alignContent: Alignment.BottomEnd }) {
        Scroll() {
          Column({ space: Spacing.md }) {
            Row({ space: Spacing.sm }) {
              ForEach(filters, (label: string) => {
                Text(label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.activeFilter === label ? Colors.onSecondary : Colors.onSurface)
                  .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.xs, bottom: Spacing.xs })
                  .borderRadius(Shapes.small)
                  .backgroundColor(this.activeFilter === label ? Colors.secondary : Colors.surfaceVariant)
                  .onClick(() => {
                    this.activeFilter = label;
                  })
              }, (label: string) => label)
            }

            Row({ space: Spacing.sm }) {
              this.summaryBlock('Live docks', '12', Colors.secondary)
              this.summaryBlock('Escalations', '3', Colors.tertiary)
              this.summaryBlock('Queued', '5', Colors.primary)
            }
            .width('100%')

            ForEach(threads, (thread: ChatThread) => {
              this.chatThreadCard(thread)
            }, (thread: ChatThread) => thread.name)

            this.actionFooter()
          }
          .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.md, bottom: Spacing.md })
        }
        .width('100%')
        .height('100%')

        Button('New')
          .width(64)
          .height(40)
          .borderRadius(Shapes.medium)
          .backgroundColor(Colors.primary)
          .fontColor(Colors.onPrimary)
          .fontSize(12)
          .margin({ right: 16, bottom: 16 })
      }
      .layoutWeight(1)

      Row({ space: Spacing.sm }) {
        TextInput({ placeholder: 'Message dock...', text: this.draft })
          .layoutWeight(1)
          .borderRadius(Shapes.medium)
          .backgroundColor(Colors.surface)
          .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.sm, bottom: Spacing.sm })
          .onChange((v: string) => {
            this.draft = v;
          })
        Button('Send')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .borderRadius(Shapes.medium)
      }
      .width('100%')
      .padding({ left: Spacing.lg, right: Spacing.lg, top: Spacing.sm, bottom: Spacing.sm })
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Colors.surfaceVariant)
      .shadow({ radius: 10, color: '#18000000', offsetY: 4 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
