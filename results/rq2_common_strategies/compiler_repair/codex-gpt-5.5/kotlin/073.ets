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

class SummaryBlockData {
  title: string;
  value: string;
  accent: string;

  constructor(title: string, value: string, accent: string) {
    this.title = title;
    this.value = value;
    this.accent = accent;
  }
}

class ChatColors {
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

@Entry
@Component
struct Index {
  @State activeFilter: string = 'Live';
  @State draft: string = '';
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ];
  private summaries: SummaryBlockData[] = [
    new SummaryBlockData('LIVE DOCKS', '12', ChatColors.secondary),
    new SummaryBlockData('ESCALATIONS', '3', ChatColors.tertiary),
    new SummaryBlockData('QUEUED', '5', ChatColors.primary)
  ];

  @Builder
  TopBar() {
    Row() {
      Button('Hub')
        .fontSize(12)
        .fontColor(ChatColors.onSurface)
        .backgroundColor(ChatColors.surface)

      Column() {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(ChatColors.onSurface)
        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3E2E8F0')
          .margin({ top: 4 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)

      Button('Status')
        .fontSize(12)
        .fontColor(ChatColors.secondary)
        .backgroundColor(ChatColors.surface)
    }
    .width('100%')
    .height(66)
    .padding({ left: 8, right: 8 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(ChatColors.surface)
  }

  @Builder
  FilterRow() {
    Row() {
      ForEach(this.filters, (label: string) => {
        Button(label)
          .height(34)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.activeFilter === label ? ChatColors.onSecondary : ChatColors.onSurface)
          .backgroundColor(this.activeFilter === label ? ChatColors.secondary : ChatColors.surfaceVariant)
          .borderRadius(12)
          .margin({ right: label === 'Silent' ? 0 : 8 })
          .onClick(() => {
            this.activeFilter = label;
          })
      }, (label: string) => label)
    }
    .width('100%')
  }

  @Builder
  SummaryBlock(item: SummaryBlockData) {
    Column() {
      Circle()
        .width(12)
        .height(12)
        .fill(item.accent)
      Text(item.title)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3E2E8F0')
        .margin({ top: 4 })
      Text(item.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(item.accent)
        .margin({ top: 4 })
    }
    .layoutWeight(1)
    .padding(12)
    .backgroundColor(ChatColors.surface)
    .borderRadius(16)
  }

  @Builder
  StatusSummary() {
    Row() {
      ForEach(this.summaries, (item: SummaryBlockData, index: number) => {
        Column() {
          this.SummaryBlock(item)
        }
        .layoutWeight(1)
        .margin({ right: index === 2 ? 0 : 8 })
      }, (item: SummaryBlockData) => item.title)
    }
    .width('100%')
  }

  @Builder
  ChatThreadCard(thread: ChatThread) {
    Column() {
      Row() {
        Column() {
          Text(thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(ChatColors.onSurface)
          Text(thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(thread.isPriority ? ChatColors.secondary : '#B3E2E8F0')
            .margin({ top: 4 })
        }
        .layoutWeight(1)

        Text(thread.unread > 0 ? '+' + thread.unread.toString() : 'OK')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ChatColors.onSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(ChatColors.surfaceVariant)
          .borderRadius(12)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(thread.snippet)
        .fontSize(14)
        .fontColor('#E6E2E8F0')
        .width('100%')
        .margin({ top: 8 })

      Row() {
        Text(thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(ChatColors.onSurface)
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .backgroundColor(ChatColors.surfaceVariant)
          .borderRadius(12)
        Button('Open')
          .fontSize(12)
          .fontColor(ChatColors.secondary)
          .backgroundColor(ChatColors.surface)
          .margin({ left: 8 })
      }
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(12)
    .backgroundColor(ChatColors.surface)
    .borderRadius(20)
    .border({ width: 1, color: ChatColors.outline })
    .shadow({ radius: 6, color: '#24000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  ActionFooter() {
    Column() {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(ChatColors.onSurface)
        .width('100%')
      Row() {
        Button('Calm')
          .fontSize(12)
          .fontColor(ChatColors.onPrimary)
          .backgroundColor(ChatColors.primary)
          .borderRadius(16)
        Button('Fire')
          .fontSize(12)
          .fontColor(ChatColors.onTertiary)
          .backgroundColor(ChatColors.tertiary)
          .borderRadius(16)
          .margin({ left: 8 })
      }
      .margin({ top: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(ChatColors.surfaceVariant)
    .borderRadius(20)
  }

  @Builder
  ComposerBar() {
    Row() {
      TextInput({ placeholder: 'Message dock...', text: this.draft })
        .height(42)
        .fontSize(14)
        .fontColor(ChatColors.onSurface)
        .backgroundColor(ChatColors.surface)
        .borderRadius(16)
        .layoutWeight(1)
        .onChange((value: string) => {
          this.draft = value;
        })
      Button('Send')
        .height(42)
        .fontSize(12)
        .fontColor(ChatColors.onPrimary)
        .backgroundColor(ChatColors.primary)
        .borderRadius(16)
        .margin({ left: 8 })
    }
    .width('100%')
    .height(66)
    .padding({ left: 16, right: 16, top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(ChatColors.surfaceVariant)
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()
        Scroll() {
          Column() {
            this.FilterRow()
            Column() { this.StatusSummary() }.margin({ top: 12 })
            ForEach(this.threads, (thread: ChatThread) => {
              Column() {
                this.ChatThreadCard(thread)
              }
              .margin({ top: 12 })
            }, (thread: ChatThread) => thread.name)
            Column() { this.ActionFooter() }.margin({ top: 12 })
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 12, bottom: 92 })
        }
        .layoutWeight(1)
      }
      .width('100%')
      .height('100%')
      .backgroundColor(ChatColors.background)

      this.ComposerBar()

      Button('New')
        .width(58)
        .height(58)
        .fontSize(12)
        .fontColor(ChatColors.onPrimary)
        .backgroundColor(ChatColors.primary)
        .borderRadius(16)
        .margin({ right: 20, bottom: 78 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(ChatColors.background)
  }
}
