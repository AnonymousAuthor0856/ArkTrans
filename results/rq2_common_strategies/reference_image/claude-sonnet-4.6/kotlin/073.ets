// Index.ets
// 201_HoloChatDock_en — Social Messenger / Dark Neon Glow / en / 720x1280 / Compact
// Entry: main_pages.json -> { "src": ["pages/Index"] }

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

interface Palette {
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
  onSurface: string;
  onSurfaceDim: string;
  onSurfaceSoft: string;
  glow: string;
}

const P: Palette = {
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
  onSurface: '#E2E8F0',
  onSurfaceDim: '#B3E2E8F0',
  onSurfaceSoft: '#E5E2E8F0',
  glow: '#807C3AED'
};

const S_XS: number = 4;
const S_SM: number = 8;
const S_MD: number = 12;
const S_LG: number = 16;
const S_XL: number = 24;

const R_SMALL: number = 12;
const R_MEDIUM: number = 16;
const R_LARGE: number = 20;

@Entry
@Component
struct Index {
  @State activeFilter: string = 'Live';
  @State draft: string = '';

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent'];

  private threads: ChatThread[] = [
    { name: 'Orbital Finance', status: 'Rolling sync', unread: 5, snippet: 'Need rates for Q4', isPriority: true },
    { name: 'Beacon Ops', status: 'Docked', unread: 0, snippet: 'Switching to holo feed', isPriority: false },
    { name: 'Nova Crew', status: 'Hotline', unread: 2, snippet: 'Uploading scan pack now', isPriority: true }
  ];

  private summary: SummaryItem[] = [
    { title: 'Live docks', value: '12', accent: P.secondary },
    { title: 'Escalations', value: '3', accent: P.tertiary },
    { title: 'Queued', value: '5', accent: P.primary }
  ];

  @Builder
  TopBar() {
    Row() {
      Text('Hub')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(P.onSurface)
        .padding({ left: S_SM, right: S_SM, top: S_SM, bottom: S_SM })
        .borderRadius(R_SMALL)
        .onClick(() => {})

      Column({ space: 2 }) {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(P.onSurface)
        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(P.onSurfaceDim)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: S_SM })

      Text('Status')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(P.secondary)
        .padding({ left: S_SM, right: S_SM, top: S_SM, bottom: S_SM })
        .borderRadius(R_SMALL)
        .onClick(() => {})
    }
    .width('100%')
    .height(64)
    .padding({ left: S_LG, right: S_LG })
    .alignItems(VerticalAlign.Center)
    .backgroundColor(P.surface)
    .shadow({ radius: 10, color: '#33000000', offsetX: 0, offsetY: 4 })
  }

  @Builder
  FilterChips() {
    Row({ space: S_SM }) {
      ForEach(this.filters, (label: string) => {
        Row() {
          Text(label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.activeFilter === label ? P.onSecondary : P.onSurface)
        }
        .padding({ left: 14, right: 14, top: S_SM, bottom: S_SM })
        .borderRadius(R_SMALL)
        .backgroundColor(this.activeFilter === label ? P.secondary : P.surfaceVariant)
        .onClick(() => {
          this.activeFilter = label;
        })
      }, (label: string) => label)
    }
    .width('100%')
  }

  @Builder
  SummaryBlock(item: SummaryItem) {
    Column({ space: S_XS }) {
      Row()
        .width(12)
        .height(12)
        .borderRadius(6)
        .backgroundColor(item.accent)

      Text(item.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(P.onSurfaceDim)

      Text(item.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(item.accent)
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
    .padding(S_MD)
    .backgroundColor(P.surface)
    .borderRadius(R_MEDIUM)
  }

  @Builder
  StatusSummary() {
    Row({ space: S_SM }) {
      ForEach(this.summary, (item: SummaryItem) => {
        this.SummaryBlock(item)
      }, (item: SummaryItem) => item.title)
    }
    .width('100%')
  }

  @Builder
  ThreadCard(thread: ChatThread) {
    Column({ space: S_SM }) {
      Row() {
        Column({ space: S_XS }) {
          Text(thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(P.onSurface)
          Text(thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(thread.isPriority ? P.secondary : P.onSurfaceDim)
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Row() {
          Text(thread.unread > 0 ? '+' + thread.unread.toString() : '\u2713')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(P.onSurface)
        }
        .padding({ left: S_SM, right: S_SM, top: S_XS, bottom: S_XS })
        .borderRadius(R_SMALL)
        .backgroundColor(P.surfaceVariant)
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)

      Text(thread.snippet)
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(P.onSurfaceSoft)

      Row({ space: S_SM }) {
        Row() {
          Text(thread.isPriority ? 'Priority' : 'Standard')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(P.onSurface)
        }
        .padding({ left: S_SM, right: S_SM, top: S_XS, bottom: S_XS })
        .borderRadius(R_SMALL)
        .backgroundColor(P.surfaceVariant)

        Text('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(P.secondary)
          .padding({ left: S_SM, right: S_SM, top: S_XS, bottom: S_XS })
          .onClick(() => {})
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(S_MD)
    .backgroundColor(P.surface)
    .borderRadius(R_LARGE)
    .border({ width: 1, color: P.outline })
    .shadow({ radius: 6, color: '#33000000', offsetX: 0, offsetY: 2 })
  }

  @Builder
  ActionFooter() {
    Column({ space: S_MD }) {
      Text('Dock filters')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(P.onSurface)

      Row({ space: S_SM }) {
        Button('Calm')
          .type(ButtonType.Normal)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(P.onPrimary)
          .backgroundColor(P.primary)
          .height(40)
          .borderRadius(R_MEDIUM)
          .padding({ left: S_XL, right: S_XL })
          .onClick(() => {})

        Button('Fire')
          .type(ButtonType.Normal)
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(P.onTertiary)
          .backgroundColor(P.tertiary)
          .height(40)
          .borderRadius(R_MEDIUM)
          .padding({ left: S_XL, right: S_XL })
          .onClick(() => {})
      }
    }
    .width('100%')
    .alignItems(HorizontalAlign.Start)
    .padding(S_LG)
    .backgroundColor(P.surfaceVariant)
    .borderRadius(R_LARGE)
  }

  @Builder
  Feed() {
    Scroll() {
      Column({ space: S_MD }) {
        this.FilterChips()
        this.StatusSummary()

        ForEach(this.threads, (thread: ChatThread) => {
          this.ThreadCard(thread)
        }, (thread: ChatThread) => thread.name)

        this.ActionFooter()
      }
      .width('100%')
      .padding({ left: S_LG, right: S_LG, top: S_MD, bottom: S_LG })
    }
    .layoutWeight(1)
    .width('100%')
    .align(Alignment.Top)
    .scrollBar(BarState.Off)
    .edgeEffect(EdgeEffect.Spring)
  }

  @Builder
  Composer() {
    Row({ space: S_SM }) {
      TextInput({ placeholder: 'Message dock...', text: this.draft })
        .placeholderColor(P.onSurfaceDim)
        .fontSize(14)
        .fontColor(P.onSurface)
        .caretColor(P.secondary)
        .backgroundColor(P.surface)
        .borderRadius(R_MEDIUM)
        .border({ width: 1, color: P.outline })
        .height(44)
        .padding({ left: S_MD, right: S_MD })
        .layoutWeight(1)
        .enterKeyType(EnterKeyType.Send)
        .onChange((value: string) => {
          this.draft = value;
        })
        .onSubmit(() => {
          this.draft = '';
        })

      Button('Send')
        .type(ButtonType.Normal)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(P.onPrimary)
        .backgroundColor(P.primary)
        .height(44)
        .borderRadius(R_MEDIUM)
        .padding({ left: S_LG, right: S_LG })
        .onClick(() => {
          this.draft = '';
        })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
    .padding({ left: S_LG, right: S_LG, top: S_SM, bottom: S_SM })
    .backgroundColor(P.surfaceVariant)
    .shadow({ radius: 12, color: '#33000000', offsetX: 0, offsetY: -4 })
  }

  @Builder
  Fab() {
    Stack() {
      Text('New')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(P.onPrimary)
    }
    .width(64)
    .height(64)
    .backgroundColor(P.primary)
    .borderRadius(R_MEDIUM)
    .shadow({ radius: 18, color: P.glow, offsetX: 0, offsetY: 8 })
    .onClick(() => {})
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()
        this.Feed()
        this.Composer()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(P.background)

      Column() {
        this.Fab()
      }
      .margin({ right: S_LG, bottom: 88 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(P.background)
  }
}