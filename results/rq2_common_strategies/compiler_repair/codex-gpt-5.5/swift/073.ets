class AppColors {
  static primary: string = '#7C3AED'
  static secondary: string = '#22D3EE'
  static tertiary: string = '#F97316'
  static background: string = '#050714'
  static surface: string = '#0F172A'
  static surfaceVariant: string = '#1F2937'
  static outline: string = '#334155'
  static onPrimary: string = '#050714'
  static onSecondary: string = '#011014'
  static onTertiary: string = '#110200'
  static onBackground: string = '#F8FAFC'
  static onSurface: string = '#E2E8F0'
}

class AppSpacing {
  static xs: number = 4
  static sm: number = 8
  static md: number = 12
  static lg: number = 16
  static xl: number = 24
  static xxl: number = 32
  static xxxl: number = 44
}

class AppShape {
  static small: number = 12
  static medium: number = 16
  static large: number = 20
}

class ChatThread {
  name: string
  status: string
  unread: number
  snippet: string
  isPriority: boolean

  constructor(name: string, status: string, unread: number, snippet: string, isPriority: boolean) {
    this.name = name
    this.status = status
    this.unread = unread
    this.snippet = snippet
    this.isPriority = isPriority
  }
}

class SummaryData {
  title: string
  value: string
  accent: string

  constructor(title: string, value: string, accent: string) {
    this.title = title
    this.value = value
    this.accent = accent
  }
}

@Entry
@Component
struct Index {
  @State activeFilter: string = 'Live'
  @State draftMessage: string = ''

  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true)
  ]
  private summaries: SummaryData[] = [
    new SummaryData('Live docks', '12', AppColors.secondary),
    new SummaryData('Escalations', '3', AppColors.tertiary),
    new SummaryData('Queued', '5', AppColors.primary)
  ]

  @Builder
  CustomTopBar() {
    Row() {
      Button('Hub')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .backgroundColor('#00000000')

      Blank()
        .layoutWeight(1)

      Column() {
        Text('HoloChat Dock')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Text('Dark neon bridge')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor('#B3E2E8F0')
      }
      .alignItems(HorizontalAlign.Start)

      Blank()
        .layoutWeight(1)

      Button('Status')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.secondary)
        .backgroundColor('#00000000')
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  AssistChip(label: string) {
    Text(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.activeFilter === label ? AppColors.onSecondary : AppColors.onSurface)
      .padding({ left: 16, right: 16, top: 8, bottom: 8 })
      .backgroundColor(this.activeFilter === label ? AppColors.secondary : AppColors.surfaceVariant)
      .border({ width: this.activeFilter === label ? 0 : 1, color: AppColors.outline, radius: AppShape.small })
      .onClick(() => {
        this.activeFilter = label
      })
  }

  @Builder
  SummaryBlock(item: SummaryData) {
    Column({ space: AppSpacing.xs }) {
      Circle()
        .width(12)
        .height(12)
        .fill(item.accent)
      Text(item.title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor('#B3E2E8F0')
      Text(item.value)
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(item.accent)
    }
    .layoutWeight(1)
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShape.medium)
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
            .fontColor(thread.isPriority ? AppColors.secondary : '#B3E2E8F0')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()
          .layoutWeight(1)

        Text(thread.unread > 0 ? '+' + thread.unread.toString() : 'ok')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShape.small)
      }
      .width('100%')

      Text(thread.snippet)
        .fontSize(14)
        .fontColor('#E6E2E8F0')
        .width('100%')

      Row({ space: AppSpacing.sm }) {
        Text(thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShape.small)

        Button('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .backgroundColor('#00000000')
      }
      .width('100%')
    }
    .width('100%')
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surface)
    .border({ width: 1, color: AppColors.outline, radius: AppShape.large })
  }

  @Builder
  ActionFooter() {
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
          .borderRadius(AppShape.medium)
        Button('Fire')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onTertiary)
          .padding({ left: 16, right: 16, top: 10, bottom: 10 })
          .backgroundColor(AppColors.tertiary)
          .borderRadius(AppShape.medium)
      }
    }
    .width('100%')
    .padding(AppSpacing.lg)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShape.large)
  }

  @Builder
  BottomInputBar() {
    Row({ space: AppSpacing.sm }) {
      TextInput({ placeholder: 'Message dock...', text: this.draftMessage })
        .fontSize(14)
        .fontColor(AppColors.onSurface)
        .placeholderColor('#99E2E8F0')
        .height(48)
        .layoutWeight(1)
        .padding({ left: AppSpacing.md, right: AppSpacing.md })
        .backgroundColor(AppColors.surface)
        .borderRadius(AppShape.medium)
        .onChange((text: string) => {
          this.draftMessage = text
        })

      Button('Send')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .height(48)
        .padding({ left: 20, right: 20 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShape.medium)
    }
    .width('100%')
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surfaceVariant)
    .shadow({ radius: 6, color: '#33000000', offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
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
            .width('100%')
            .scrollable(ScrollDirection.Horizontal)
            .scrollBar(BarState.Off)

            Row({ space: AppSpacing.sm }) {
              ForEach(this.summaries, (summary: SummaryData) => {
                this.SummaryBlock(summary)
              })
            }
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            ForEach(this.threads, (thread: ChatThread) => {
              Column() {
                this.ChatThreadCard(thread)
              }
              .width('100%')
              .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
            })

            Column() {
              this.ActionFooter()
            }
            .width('100%')
            .padding({ left: AppSpacing.lg, right: AppSpacing.lg })

            Blank()
              .height(100)
          }
          .width('100%')
          .padding({ top: AppSpacing.md, bottom: AppSpacing.md })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)
      }
      .width('100%')
      .height('100%')

      Button('New')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .padding({ left: 16, right: 16, top: 16, bottom: 16 })
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShape.medium)
        .shadow({ radius: 4, color: '#33000000', offsetY: 2 })
        .margin({ right: AppSpacing.lg, bottom: 80 })

      Column() {
        Blank()
          .layoutWeight(1)
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
