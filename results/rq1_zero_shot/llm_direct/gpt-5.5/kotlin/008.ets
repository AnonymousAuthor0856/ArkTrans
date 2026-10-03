const NAME: string = '011_HealthDashboard_en'
const UI_TYPE: string = 'Health Fitness Dashboard'
const STYLE_THEME: string = 'Vibrant Gradient'
const LANG: string = 'en'
const BASELINE_SIZE: string = '1280x720'

class AppColors {
  static readonly primary: string = '#6366F1'
  static readonly secondary: string = '#EC4899'
  static readonly tertiary: string = '#10B981'
  static readonly background: string = '#F8FAFC'
  static readonly surface: string = '#FFFFFF'
  static readonly surfaceVariant: string = '#F1F5F9'
  static readonly outline: string = '#E2E8F0'
  static readonly success: string = '#10B981'
  static readonly warning: string = '#F59E0B'
  static readonly error: string = '#EF4444'
  static readonly onPrimary: string = '#FFFFFF'
  static readonly onSecondary: string = '#FFFFFF'
  static readonly onTertiary: string = '#FFFFFF'
  static readonly onBackground: string = '#0F172A'
  static readonly onSurface: string = '#0F172A'
  static readonly onSurface70: string = '#B30F172A'
}

class AppTypographyTokens {
  static readonly displaySize: number = 24
  static readonly displayLineHeight: number = 30
  static readonly headlineSize: number = 20
  static readonly headlineLineHeight: number = 26
  static readonly titleSize: number = 16
  static readonly titleLineHeight: number = 22
  static readonly bodySize: number = 14
  static readonly bodyLineHeight: number = 20
  static readonly labelSize: number = 12
  static readonly labelLineHeight: number = 16
  static readonly smallSize: number = 10
  static readonly smallLineHeight: number = 14
}

class AppShapes {
  static readonly small: number = 8
  static readonly medium: number = 12
  static readonly large: number = 16
}

class AppSpacing {
  static readonly xs: number = 2
  static readonly sm: number = 4
  static readonly md: number = 8
  static readonly lg: number = 12
  static readonly xl: number = 16
  static readonly xxl: number = 20
  static readonly xxxl: number = 24
}

class ShadowSpec {
  elevation: number
  radius: number
  dy: number
  opacity: number

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation
    this.radius = radius
    this.dy = dy
    this.opacity = opacity
  }
}

class AppElevationMapping {
  static readonly level1: ShadowSpec = new ShadowSpec(1, 4, 1, 0.15)
  static readonly level2: ShadowSpec = new ShadowSpec(3, 8, 2, 0.18)
  static readonly level3: ShadowSpec = new ShadowSpec(6, 12, 3, 0.22)
  static readonly level4: ShadowSpec = new ShadowSpec(8, 16, 4, 0.25)
}

class HealthMetric {
  id: number
  title: string
  value: string
  unit: string
  progress: number
  color: string

  constructor(id: number, title: string, value: string, unit: string, progress: number, color: string) {
    this.id = id
    this.title = title
    this.value = value
    this.unit = unit
    this.progress = progress
    this.color = color
  }
}

class Workout {
  id: number
  name: string
  duration: string
  calories: string
  iconColor: string

  constructor(id: number, name: string, duration: string, calories: string, iconColor: string) {
    this.id = id
    this.name = name
    this.duration = duration
    this.calories = calories
    this.iconColor = iconColor
  }
}

class NavItem {
  id: number
  label: string

  constructor(id: number, label: string) {
    this.id = id
    this.label = label
  }
}

@Entry
@Component
struct RootScreen {
  @State selectedNav: number = 0

  private metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', 0.6, AppColors.secondary),
    new HealthMetric(2, 'Steps', '842', 'steps', 0.8, AppColors.primary),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', 0.9, AppColors.tertiary),
    new HealthMetric(4, 'Calories', '420', 'kcal', 0.4, AppColors.error)
  ]

  private workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', AppColors.primary),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', AppColors.secondary),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', AppColors.tertiary)
  ]

  private navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ]

  build() {
    Column() {
      Row() {
        Text('Health Dashboard')
          .fontSize(AppTypographyTokens.displaySize)
          .fontWeight(FontWeight.Bold)
          .lineHeight(AppTypographyTokens.displayLineHeight)
          .fontColor(AppColors.onBackground)
      }
      .width('100%')
      .height(64)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(Color.Transparent)

      Scroll() {
        Column({ space: AppSpacing.lg }) {
          Column({ space: AppSpacing.sm }) {
            Text('Good Morning!')
              .fontSize(AppTypographyTokens.titleSize)
              .fontWeight(FontWeight.Medium)
              .lineHeight(AppTypographyTokens.titleLineHeight)
              .fontColor(AppColors.onPrimary)

            Text('Ready for your workout?')
              .fontSize(AppTypographyTokens.headlineSize)
              .fontWeight(FontWeight.SemiBold)
              .lineHeight(AppTypographyTokens.headlineLineHeight)
              .fontColor(AppColors.onPrimary)

            Button() {
              Text('Start Workout')
                .fontSize(AppTypographyTokens.titleSize)
                .fontWeight(FontWeight.Medium)
                .lineHeight(AppTypographyTokens.titleLineHeight)
                .fontColor(AppColors.primary)
            }
            .type(ButtonType.Normal)
            .width('100%')
            .height(44)
            .backgroundColor(AppColors.onPrimary)
            .borderRadius(AppShapes.medium)
            .margin({ top: AppSpacing.sm })
          }
          .width('100%')
          .padding(AppSpacing.xl)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .shadow({ radius: AppElevationMapping.level3.radius, color: '#38000000', offsetX: 0, offsetY: AppElevationMapping.level3.dy })

          Text('Today\'s Metrics')
            .width('100%')
            .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
            .fontSize(AppTypographyTokens.headlineSize)
            .fontWeight(FontWeight.SemiBold)
            .lineHeight(AppTypographyTokens.headlineLineHeight)
            .fontColor(AppColors.onBackground)

          Row({ space: AppSpacing.md }) {
            ForEach(this.metrics, (metric: HealthMetric) => {
              Column({ space: AppSpacing.xs }) {
                Blank()
                  .width(36)
                  .height(36)
                  .backgroundColor(metric.color)
                  .borderRadius(18)

                Text(metric.value)
                  .fontSize(AppTypographyTokens.headlineSize)
                  .fontWeight(FontWeight.SemiBold)
                  .lineHeight(AppTypographyTokens.headlineLineHeight)
                  .fontColor(AppColors.onSurface)

                Text(metric.title)
                  .fontSize(AppTypographyTokens.labelSize)
                  .fontWeight(FontWeight.Medium)
                  .lineHeight(AppTypographyTokens.labelLineHeight)
                  .fontColor(AppColors.onSurface70)
              }
              .layoutWeight(1)
              .padding(AppSpacing.md)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor(AppColors.surface)
              .borderRadius(AppShapes.medium)
              .shadow({ radius: AppElevationMapping.level2.radius, color: '#2E000000', offsetX: 0, offsetY: AppElevationMapping.level2.dy })
            }, (metric: HealthMetric) => metric.id.toString())
          }
          .width('100%')

          Row() {
            Text('Recent Workouts')
              .fontSize(AppTypographyTokens.headlineSize)
              .fontWeight(FontWeight.SemiBold)
              .lineHeight(AppTypographyTokens.headlineLineHeight)
              .fontColor(AppColors.onBackground)

            Button() {
              Text('View All')
                .fontSize(AppTypographyTokens.labelSize)
                .fontWeight(FontWeight.Medium)
                .lineHeight(AppTypographyTokens.labelLineHeight)
                .fontColor(AppColors.primary)
            }
            .type(ButtonType.Normal)
            .backgroundColor(Color.Transparent)
            .stateEffect(false)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          ForEach(this.workouts, (workout: Workout) => {
            Row({ space: AppSpacing.md }) {
              Blank()
                .width(44)
                .height(44)
                .backgroundColor(workout.iconColor)
                .borderRadius(AppShapes.medium)

              Column({ space: AppSpacing.xs }) {
                Text(workout.name)
                  .fontSize(AppTypographyTokens.titleSize)
                  .fontWeight(FontWeight.Medium)
                  .lineHeight(AppTypographyTokens.titleLineHeight)
                  .fontColor(AppColors.onSurface)

                Row({ space: AppSpacing.lg }) {
                  Text(workout.duration)
                    .fontSize(AppTypographyTokens.bodySize)
                    .fontWeight(FontWeight.Normal)
                    .lineHeight(AppTypographyTokens.bodyLineHeight)
                    .fontColor(AppColors.onSurface70)

                  Text(workout.calories)
                    .fontSize(AppTypographyTokens.bodySize)
                    .fontWeight(FontWeight.Normal)
                    .lineHeight(AppTypographyTokens.bodyLineHeight)
                    .fontColor(AppColors.onSurface70)
                }
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              Button() {
                Text('Start')
                  .fontSize(AppTypographyTokens.smallSize)
                  .fontWeight(FontWeight.Normal)
                  .lineHeight(AppTypographyTokens.smallLineHeight)
                  .fontColor(AppColors.onPrimary)
              }
              .type(ButtonType.Normal)
              .width(70)
              .height(32)
              .backgroundColor(AppColors.primary)
              .borderRadius(AppShapes.small)
            }
            .width('100%')
            .padding(AppSpacing.md)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(AppColors.surface)
            .borderRadius(AppShapes.medium)
            .shadow({ radius: AppElevationMapping.level1.radius, color: '#26000000', offsetX: 0, offsetY: AppElevationMapping.level1.dy })
          }, (workout: Workout) => workout.id.toString())

          Blank()
            .height(AppSpacing.xxxl)
        }
        .width('100%')
        .padding({ left: AppSpacing.md, right: AppSpacing.md })
      }
      .layoutWeight(1)
      .width('100%')
      .scrollBar(BarState.Off)

      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column({ space: AppSpacing.xs }) {
            Blank()
              .width(20)
              .height(20)
              .backgroundColor(this.selectedNav === item.id ? AppColors.primary : AppColors.outline)
              .borderRadius(10)

            Text(item.label)
              .fontSize(AppTypographyTokens.labelSize)
              .fontWeight(FontWeight.Medium)
              .lineHeight(AppTypographyTokens.labelLineHeight)
              .fontColor(this.selectedNav === item.id ? AppColors.primary : AppColors.onSurface70)
          }
          .layoutWeight(1)
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .onClick(() => {
            this.selectedNav = item.id
          })
        }, (item: NavItem) => item.id.toString())
      }
      .width('100%')
      .height(72)
      .backgroundColor(AppColors.surface)
      .shadow({ radius: AppElevationMapping.level2.radius, color: '#2E000000', offsetX: 0, offsetY: -AppElevationMapping.level2.dy })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}