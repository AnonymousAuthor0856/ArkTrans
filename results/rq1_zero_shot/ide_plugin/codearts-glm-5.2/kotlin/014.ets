const AppColors = {
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

const AppSpacing = {
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32
}

@Entry
@Component
struct Index {
  @State selectedTab: number = 0
  @State showDialog: boolean = false
  private tabs: string[] = ['Trending', 'Following', 'Recent']
  private podcasts: string[] = ['AI Insights', 'Mindful Moments', 'History Flash', 'Tech Hour', 'Design Flow']

  build() {
    Column() {
      Text('Podcasts')
        .fontSize(28)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })
        .backgroundColor(AppColors.background)

      Column({ space: AppSpacing.lg }) {
        Row() {
          ForEach(this.tabs, (label: string, index: number) => {
            Text(label)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedTab === index ? AppColors.onPrimary : AppColors.onSurface)
              .backgroundColor(this.selectedTab === index ? AppColors.primary : AppColors.surface)
              .borderRadius(8)
              .padding({ left: 16, right: 16, top: 8, bottom: 8 })
              .layoutWeight(1)
              .textAlign(TextAlign.Center)
              .onClick(() => {
                this.selectedTab = index
              })
          }, (label: string, index: number) => index.toString())
        }
        .width('100%')

        Column({ space: AppSpacing.md }) {
          ForEach(this.podcasts, (title: string, index: number) => {
            Row() {
              Column() {
                Text(title)
                  .fontSize(18)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppColors.onSurface)
                Text('30 min episode')
                  .fontSize(14)
                  .fontColor('#B3082F49')
              }
              .alignItems(HorizontalAlign.Start)
              .layoutWeight(1)

              Button('Play')
                .type(ButtonType.Normal)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSecondary)
                .backgroundColor(AppColors.secondary)
                .borderRadius(8)
                .onClick(() => {
                  this.showDialog = true
                })
            }
            .width('100%')
            .padding(AppSpacing.lg)
            .backgroundColor(AppColors.surface)
            .borderRadius(12)
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
          }, (title: string, index: number) => index.toString())
        }
        .width('100%')
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .linearGradient({
        direction: GradientDirection.TopBottom,
        colors: [['#E0F2FE', 0], ['#F0F9FF', 1]]
      })

      if (this.showDialog) {
        Stack({ alignContent: Alignment.Center }) {
          Column() {
            Text('Playing Podcast')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
            Text('Streaming audio...')
              .fontSize(14)
              .fontColor('#CC082F49')
              .margin({ top: AppSpacing.sm })
            Button('OK')
              .type(ButtonType.Normal)
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.primary)
              .backgroundColor(AppColors.surface)
              .borderRadius(8)
              .margin({ top: AppSpacing.lg })
              .onClick(() => {
                this.showDialog = false
              })
          }
          .padding(AppSpacing.xl)
          .backgroundColor(AppColors.surface)
          .borderRadius(12)
        }
        .width('100%')
        .height('100%')
        .backgroundColor('#80000000')
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}