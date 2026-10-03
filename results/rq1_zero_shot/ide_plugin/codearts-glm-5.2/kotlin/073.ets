const AppColors = {
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
  onSurface: '#E2E8F0',
  onSurfaceAlpha70: '#B3E2E8F0',
  onSurfaceAlpha60: '#99E2E8F0',
  onSurfaceAlpha90: '#E6E2E8F0',
}

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
  xxxl: 44,
}

const AppShapes = {
  small: 12,
  medium: 16,
  large: 20,
}

class ChatThread {
  name: string = ''
  status: string = ''
  unread: number = 0
  snippet: string = ''
  isPriority: boolean = false
  constructor(name: string, status: string, unread: number, snippet: string, isPriority: boolean) {
    this.name = name
    this.status = status
    this.unread = unread
    this.snippet = snippet
    this.isPriority = isPriority
  }
}

@Entry
@Component
struct RootScreen {
  @State activeFilter: string = 'Live'
  @State draft: string = ''
  private filters: string[] = ['Live', 'Pinned', 'Escalated', 'Silent']
  private threads: ChatThread[] = [
    new ChatThread('Orbital Finance', 'Rolling sync', 5, 'Need rates for Q4', true),
    new ChatThread('Beacon Ops', 'Docked', 0, 'Switching to holo feed', false),
    new ChatThread('Nova Crew', 'Hotline', 2, 'Uploading scan pack now', true),
  ]

  @Builder
  FilterChipBuilder(label: string) {
    Text(label)
      .fontSize(12)
      .fontWeight(FontWeight.Medium)
      .fontColor(this.activeFilter === label ? AppColors.onSecondary : AppColors.onSurface)
      .backgroundColor(this.activeFilter === label ? AppColors.secondary : AppColors.surfaceVariant)
      .borderRadius(AppShapes.small)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, top: AppSpacing.sm, bottom: AppSpacing.sm })
      .onClick(() => {
        this.activeFilter = label
      })
  }

  @Builder
  SummaryBlockBuilder(title: string, value: string, accent: string) {
    Column() {
      Column() {}
        .width(12)
        .height(12)
        .backgroundColor(accent)
        .borderRadius(6)
      Text(title.toUpperCase())
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurfaceAlpha70)
        .margin({ top: AppSpacing.xs })
      Text(value)
        .fontSize(28)
        .fontWeight(FontWeight.SemiBold)
        .fontColor(accent)
        .margin({ top: AppSpacing.xs })
    }
    .layoutWeight(1)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.medium)
    .padding(AppSpacing.md)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  ChatThreadCardBuilder(thread: ChatThread) {
    Column() {
      Row() {
        Column() {
          Text(thread.name)
            .fontSize(22)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(thread.status)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(thread.isPriority ? AppColors.secondary : AppColors.onSurfaceAlpha70)
            .margin({ top: AppSpacing.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)

        Text(thread.unread > 0 ? `+${thread.unread}` : '✓')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)

      Text(thread.snippet)
        .fontSize(14)
        .fontColor(AppColors.onSurfaceAlpha90)
        .margin({ top: AppSpacing.sm })

      Row() {
        Text(thread.isPriority ? 'Priority' : 'Standard')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(AppShapes.small)
          .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })

        Text('Open')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.secondary)
          .margin({ left: AppSpacing.sm })
      }
      .margin({ top: AppSpacing.sm })
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(AppShapes.large)
    .borderWidth(1)
    .borderColor(AppColors.outline)
  }

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Hub')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)

          Column() {
            Text('HoloChat Dock')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
            Text('Dark neon bridge')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurfaceAlpha70)
              .margin({ top: 2 })
          }
          .layoutWeight(1)
          .alignItems(HorizontalAlign.Start)
          .margin({ left: AppSpacing.md })

          Text('Status')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.secondary)
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
        .backgroundColor(AppColors.surface)

        Scroll() {
          Column() {
            Row() {
              ForEach(this.filters, (label: string) => {
                this.FilterChipBuilder(label)
              }, (label: string) => label)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)

            Row() {
              this.SummaryBlockBuilder('Live docks', '12', AppColors.secondary)
              this.SummaryBlockBuilder('Escalations', '3', AppColors.tertiary)
              this.SummaryBlockBuilder('Queued', '5', AppColors.primary)
            }
            .width('100%')
            .margin({ top: AppSpacing.md })

            ForEach(this.threads, (thread: ChatThread) => {
              this.ChatThreadCardBuilder(thread)
            }, (thread: ChatThread) => thread.name)

            Column() {
              Text('Dock filters')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)

              Row() {
                Button('Calm') {
                  Text('Calm')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onPrimary)
                }
                  .type(ButtonType.Normal)
                  .backgroundColor(AppColors.primary)
                  .borderRadius(AppShapes.medium)
                  .height(36)

                Button('Fire') {
                  Text('Fire')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(AppColors.onTertiary)
                }
                  .type(ButtonType.Normal)
                  .backgroundColor(AppColors.tertiary)
                  .borderRadius(AppShapes.medium)
                  .height(36)
                  .margin({ left: AppSpacing.sm })
              }
              .margin({ top: AppSpacing.sm })
            }
            .width('100%')
            .padding(AppSpacing.lg)
            .backgroundColor(AppColors.surfaceVariant)
            .borderRadius(AppShapes.large)
            .margin({ top: AppSpacing.md })
          }
          .width('100%')
          .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })
        }
        .layoutWeight(1)
        .scrollBar(BarState.Off)

        Row() {
          TextInput({ text: this.draft, placeholder: 'Message dock...' })
            .layoutWeight(1)
            .height(40)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.medium)
            .onChange((value: string) => {
              this.draft = value
            })

          Button('Send') {
            Text('Send')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onPrimary)
          }
            .type(ButtonType.Normal)
            .backgroundColor(AppColors.primary)
            .borderRadius(AppShapes.medium)
            .height(40)
            .margin({ left: AppSpacing.sm })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.sm })
        .backgroundColor(AppColors.surfaceVariant)
      }
      .width('100%')
      .height('100%')

      Button('New') {
        Text('New')
          .fontSize(12)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onPrimary)
      }
        .type(ButtonType.Normal)
        .backgroundColor(AppColors.primary)
        .borderRadius(AppShapes.medium)
        .width(56)
        .height(56)
        .position({ x: '82%', y: '78%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}