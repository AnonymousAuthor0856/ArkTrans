const Colors = {
  primary: '#38BDF8',
  secondary: '#0EA5E9',
  tertiary: '#0369A1',
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

interface VideoItem {
  title: string
  duration: string
}

const VIDEOS: VideoItem[] = [
  { title: 'Nature Documentary', duration: '24:18' },
  { title: 'AI Explained', duration: '18:52' },
  { title: 'Space Travel', duration: '31:09' },
  { title: 'Modern Art Review', duration: '15:45' },
  { title: 'Retro Music Visuals', duration: '22:10' },
  { title: 'Daily News Recap', duration: '12:34' }
]

@Entry
@Component
struct Index {
  build() {
    Column() {
      Row() {
        Text('Video Library')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onSurface)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
      }
      .width('100%')
      .height(56)
      .padding({ left: Spacing.lg, right: Spacing.lg })
      .backgroundColor(Colors.background)

      Column({ space: Spacing.md }) {
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(Colors.onSurface)

        Grid() {
          ForEach(VIDEOS, (item: VideoItem) => {
            GridItem() {
              Column({ space: Spacing.sm }) {
                Stack({ alignContent: Alignment.Center }) {
                  Text('Thumbnail')
                    .fontSize(12)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(Colors.onSurface)
                    .opacity(0.6)
                }
                .width('100%')
                .height(120)
                .backgroundColor(Colors.surfaceVariant)
                .borderRadius(8)

                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Colors.onSurface)

                Text(item.duration)
                  .fontSize(13)
                  .fontColor(Colors.onSurface)
                  .opacity(0.7)

                Button('Play', { type: ButtonType.Normal })
                  .backgroundColor(Colors.primary)
                  .fontColor(Colors.onPrimary)
                  .fontSize(12)
                  .width('100%')
                  .height(40)
                  .borderRadius(8)
                  .onClick(() => {})
              }
              .width('100%')
              .padding(Spacing.md)
              .backgroundColor(Colors.surface)
              .borderRadius(12)
              .shadow({ radius: 4, color: '#14000000', offsetY: 2 })
            }
          }, (item: VideoItem) => item.title)
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(Spacing.md)
        .rowsGap(Spacing.md)
        .width('100%')
        .layoutWeight(1)
      }
      .layoutWeight(1)
      .width('100%')
      .padding(Spacing.lg)
      .linearGradient({ angle: 180, colors: [[Colors.surfaceVariant, 0.0], [Colors.background, 1.0]] })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}
