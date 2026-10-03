const AppColors = {
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

const AppSpacing = {
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

@Component
struct VideoCard {
  private video: VideoItem = { title: '', duration: '' }

  build() {
    Column({ space: AppSpacing.sm }) {
      Text('Thumbnail')
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor('#99082F49')
        .width('100%')
        .height(120)
        .backgroundColor(AppColors.surfaceVariant)
        .borderRadius(8)
        .textAlign(TextAlign.Center)

      Text(this.video.title)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)

      Text(this.video.duration)
        .fontSize(13)
        .fontColor('#B3082F49')

      Button('Play')
        .type(ButtonType.Normal)
        .fontSize(11)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .width('100%')
        .height(40)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
  }
}

@Entry
@Component
struct Index {
  private videos: VideoItem[] = [
    { title: 'Nature Documentary', duration: '24:18' },
    { title: 'AI Explained', duration: '18:52' },
    { title: 'Space Travel', duration: '31:09' },
    { title: 'Modern Art Review', duration: '15:45' },
    { title: 'Retro Music Visuals', duration: '22:10' },
    { title: 'Daily News Recap', duration: '12:34' }
  ]

  build() {
    Column() {
      Text('Video Library')
        .fontSize(26)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.md }) {
        Text('Explore the latest videos')
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)

        Grid() {
          ForEach(this.videos, (item: VideoItem, index: number) => {
            GridItem() {
              VideoCard({ video: item })
            }
          }, (item: VideoItem, index: number) => index.toString())
        }
        .columnsTemplate('1fr 1fr')
        .columnsGap(AppSpacing.md)
        .rowsGap(AppSpacing.md)
        .width('100%')
        .layoutWeight(1)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.TopBottom,
        colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}