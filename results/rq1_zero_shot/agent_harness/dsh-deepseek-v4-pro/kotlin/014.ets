const Colors = {
  primary: '#38BDF8',
  secondary: '#0EA5E9',
  tertiary: '#0284C7',
  background: '#F0F9FF',
  surface: '#FFFFFF',
  surfaceVariant: '#E0F2FE',
  outline: '#BFE0F4',
  success: '#16A34A',
  warning: '#F59E0B',
  error: '#DC2626',
  onPrimary: '#001F2F',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#082F49',
  onSurface: '#082F49'
}

const Spacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

const TABS: string[] = ['Trending', 'Following', 'Recent']
const PODCASTS: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow']

@Entry
@Component
struct Index {
  @State selectedTab: number = 0
  @State showDialog: boolean = false

  build() {
    Stack() {
      Column() {
        Row() {
          Text('Podcasts')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(Colors.onSurface)
            .layoutWeight(1)
            .textAlign(TextAlign.Center)
        }
        .width('100%')
        .height(56)
        .padding({ left: Spacing.lg, right: Spacing.lg })
        .backgroundColor(Colors.background)

        Column({ space: Spacing.lg }) {
          Row({ space: Spacing.sm }) {
            ForEach(TABS, (tab: string, index: number) => {
              Button(tab, { type: ButtonType.Normal })
                .backgroundColor(this.selectedTab == index ? Colors.primary : Colors.surface)
                .fontColor(this.selectedTab == index ? Colors.onPrimary : Colors.onSurface)
                .fontSize(14)
                .height(40)
                .borderRadius(8)
                .layoutWeight(1)
                .onClick(() => { this.selectedTab = index })
            }, (tab: string, index: number) => tab + '_' + index)
          }
          .width('100%')

          Column({ space: Spacing.md }) {
            ForEach(PODCASTS, (podcast: string) => {
              Row() {
                Column() {
                  Text(podcast)
                    .fontSize(18)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)

                  Text('30 min episode')
                    .fontSize(14)
                    .fontColor(Colors.onSurface)
                    .opacity(0.7)
                }
                .alignItems(HorizontalAlign.Start)

                Button('Play', { type: ButtonType.Normal })
                  .backgroundColor(Colors.secondary)
                  .fontColor(Colors.onSecondary)
                  .fontSize(14)
                  .borderRadius(8)
                  .padding({ left: Spacing.md, right: Spacing.md, top: Spacing.xs, bottom: Spacing.xs })
                  .onClick(() => { this.showDialog = true })
              }
              .width('100%')
              .padding(Spacing.lg)
              .justifyContent(FlexAlign.SpaceBetween)
              .alignItems(VerticalAlign.Center)
              .backgroundColor(Colors.surface)
              .borderRadius(12)
              .shadow({ radius: 4, color: '#14000000', offsetY: 2 })
            }, (podcast: string) => podcast)
          }
        }
        .layoutWeight(1)
        .width('100%')
        .padding(Spacing.lg)
        .linearGradient({ angle: 180, colors: [[Colors.surfaceVariant, 0.0], [Colors.background, 1.0]] })
      }
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)

      if (this.showDialog) {
        Stack({ alignContent: Alignment.Center }) {
          Column({ space: Spacing.md }) {
            Text('Playing Podcast')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.onSurface)

            Text('Streaming audio...')
              .fontSize(14)
              .fontColor(Colors.onSurface)
              .opacity(0.8)

            Text('OK')
              .fontSize(16)
              .fontColor(Colors.primary)
              .onClick(() => { this.showDialog = false })
          }
          .width('80%')
          .padding(Spacing.lg)
          .backgroundColor(Colors.surface)
          .borderRadius(16)
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#80000000')
      }
    }
    .width('100%')
    .height('100%')
  }
}
