const AppColors = {
  primary: '#FF8A2A',
  secondary: '#FFC857',
  tertiary: '#68D672',
  background: '#FFF9F2',
  surface: '#FFFFFF',
  surfaceVariant: '#FFE4CC',
  outline: '#E2B088',
  success: '#2AC28B',
  warning: '#FFB347',
  error: '#F45B69',
  onPrimary: '#2C0D00',
  onSecondary: '#301A00',
  onTertiary: '#083919',
  onBackground: '#1E1205',
  onSurface: '#311F10',
  onSurfaceAlpha70: '#B3311F10',
  primaryAlpha35: '#59FF8A2A',
  primaryAlpha20: '#33FF8A2A',
  secondaryAlpha20: '#33FFC857',
}

const AppSpacing = {
  xxs: 4,
  xs: 8,
  sm: 12,
  md: 16,
  lg: 20,
  xl: 28,
  xxl: 36,
  xxxl: 46,
}

const AppShapes = {
  small: 10,
  medium: 18,
  large: 28,
}

class StreakCard {
  label: string = ''
  value: string = ''
  constructor(label: string, value: string) {
    this.label = label
    this.value = value
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedIndex: number = -1
  private category: string = 'Citrus crafts'
  private prompt: string = 'Which zest carrier gives the brightest aroma when infused cold?'
  private options: string[] = ['Dried peel sachet', 'Twist garnish', 'Zester microplane', 'Candied strip']
  private hint: string = 'Think surface area'
  private progress: number = 0.45
  private streaks: StreakCard[] = [
    new StreakCard('Current streak', '5 days'),
    new StreakCard('Accuracy', '84%'),
    new StreakCard('Rank', 'Top 12%'),
  ]

  @Builder
  OptionChipBuilder(option: string, index: number) {
    Text(option)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
      .fontColor(AppColors.onSurface)
      .width('100%')
      .padding(AppSpacing.sm)
      .backgroundColor(this.selectedIndex === index ? AppColors.primaryAlpha20 : AppColors.surfaceVariant)
      .borderRadius(AppShapes.medium)
      .borderWidth(1)
      .borderColor(this.selectedIndex === index ? AppColors.primary : AppColors.outline)
      .onClick(() => {
        this.selectedIndex = index
      })
  }

  @Builder
  StreakCardBuilder(streak: StreakCard) {
    Column() {
      Text(streak.label)
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurfaceAlpha70)
      Text(streak.value)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
        .margin({ top: AppSpacing.xxs })
    }
    .layoutWeight(1)
    .backgroundColor(AppColors.surfaceVariant)
    .borderRadius(AppShapes.medium)
    .padding(AppSpacing.sm)
    .alignItems(HorizontalAlign.Center)
  }

  build() {
    Column() {
      Row() {
        Column() {}
          .width(30)
          .height(30)
          .backgroundColor(AppColors.surfaceVariant)
          .borderRadius(15)

        Column() {
          Text('QuizForge')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text('Aroma sprint')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurfaceAlpha70)
            .margin({ top: 2 })
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)

        Column() {}
          .width(30)
          .height(30)
          .backgroundColor(AppColors.primaryAlpha35)
          .borderRadius(15)
      }
      .width('100%')
      .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.md, bottom: AppSpacing.md })

      Scroll() {
        Column() {
          Column() {
            Row() {
              Text(this.category)
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onSurface)
              Text('45%')
                .fontSize(14)
                .fontColor(AppColors.secondary)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)

            Progress({ value: 45, total: 100, type: ProgressType.Linear })
              .width('100%')
              .color(AppColors.primary)
              .backgroundColor(AppColors.surfaceVariant)
              .margin({ top: AppSpacing.sm })

            Text(this.prompt)
              .fontSize(22)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)
              .margin({ top: AppSpacing.sm })

            ForEach(this.options, (option: string, index: number) => {
              this.OptionChipBuilder(option, index)
            }, (option: string) => option)

            Text(`Hint: ${this.hint}`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppColors.onSurface)
              .backgroundColor(AppColors.secondaryAlpha20)
              .borderRadius(AppShapes.small)
              .padding({ left: AppSpacing.sm, right: AppSpacing.sm, top: AppSpacing.xs, bottom: AppSpacing.xs })
              .margin({ top: AppSpacing.xs })
          }
          .width('100%')
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)

          Column() {
            Text('Trackers')
              .fontSize(22)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppColors.onSurface)

            Row() {
              ForEach(this.streaks, (streak: StreakCard) => {
                this.StreakCardBuilder(streak)
              }, (streak: StreakCard) => streak.label)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ top: AppSpacing.xs })

            Button('Submit answer') {
              Text('Submit answer')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor(AppColors.onPrimary)
            }
              .type(ButtonType.Normal)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.medium)
              .width('100%')
              .height(48)
              .margin({ top: AppSpacing.xs })
          }
          .width('100%')
          .padding(AppSpacing.md)
          .backgroundColor(AppColors.surface)
          .borderRadius(AppShapes.large)
          .margin({ top: AppSpacing.md })
        }
        .width('100%')
        .padding({ left: AppSpacing.lg, right: AppSpacing.lg, top: AppSpacing.sm, bottom: AppSpacing.md })
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}