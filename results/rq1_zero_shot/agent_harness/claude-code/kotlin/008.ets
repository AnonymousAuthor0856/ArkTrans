import promptAction from '@ohos.promptAction'

namespace AppTokens {
  export class Colors {
    static readonly primary: string = '#FF6366F1'
    static readonly secondary: string = '#FFEC4899'
    static readonly tertiary: string = '#FF10B981'
    static readonly background: string = '#FFF8FAFC'
    static readonly surface: string = '#FFFFFFFF'
    static readonly surfaceVariant: string = '#FFF1F5F9'
    static readonly outline: string = '#FFE2E8F0'
    static readonly success: string = '#FF10B981'
    static readonly warning: string = '#FFF59E0B'
    static readonly error: string = '#FFEF4444'
    static readonly onPrimary: string = '#FFFFFFFF'
    static readonly onSecondary: string = '#FFFFFFFF'
    static readonly onTertiary: string = '#FFFFFFFF'
    static readonly onBackground: string = '#FF0F172A'
    static readonly onSurface: string = '#FF0F172A'
  }

  export class Spacing {
    static readonly xs: Length = 2
    static readonly sm: Length = 4
    static readonly md: Length = 8
    static readonly lg: Length = 12
    static readonly xl: Length = 16
    static readonly xxl: Length = 20
    static readonly xxxl: Length = 24
  }
}

interface HealthMetric {
  id: number
  title: string
  value: string
  unit: string
  progress: number
  color: string
}

interface Workout {
  id: number
  name: string
  duration: string
  calories: string
  iconColor: string
}

interface NavItem {
  id: number
  label: string
}

@Entry
@Component
struct HealthDashboard {
  @State selectedNav: number = 0

  private metrics: HealthMetric[] = [
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', progress: 0.6, color: AppTokens.Colors.secondary },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', progress: 0.8, color: AppTokens.Colors.primary },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', progress: 0.9, color: AppTokens.Colors.tertiary },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', progress: 0.4, color: AppTokens.Colors.error }
  ]

  private workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: AppTokens.Colors.primary },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: AppTokens.Colors.secondary },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: AppTokens.Colors.tertiary }
  ]

  private navItems: NavItem[] = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' }
  ]

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('Health Dashboard')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppTokens.Colors.onBackground)
      }
      .width('100%')
      .height(56)
      .justifyContent(FlexAlign.Center)
      .backgroundColor(Color.Transparent)

      // Content
      List({ space: AppTokens.lg }) {
        // Greeting Card
        ListItem() {
          Column({ space: AppTokens.Spacing.sm }) {
            Text('Good Morning!')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor(AppTokens.Colors.onPrimary)

            Text('Ready for your workout?')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onPrimary)

            Button('Start Workout')
              .width('100%')
              .height(44)
              .borderRadius(12)
              .backgroundColor(AppTokens.Colors.onPrimary)
              .fontColor(AppTokens.Colors.primary)
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
                promptAction.showToast({ message: 'Start Workout' })
              })
          }
          .width('100%')
          .padding(AppTokens.Spacing.xl)
          .backgroundColor(AppTokens.Colors.primary)
          .borderRadius(16)
          .shadow({ radius: 12, color: '#33000000', offsetY: 3 })
        }

        // Today's Metrics header
        ListItem() {
          Text('Today\'s Metrics')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppTokens.Colors.onBackground)
            .padding({ left: AppTokens.Spacing.sm, right: AppTokens.Spacing.sm })
        }

        // Metrics Row
        ListItem() {
          Row({ space: AppTokens.Spacing.md }) {
            ForEach(this.metrics, (metric: HealthMetric) => {
              Column({ space: AppTokens.Spacing.xs }) {
                Circle()
                  .width(36)
                  .height(36)
                  .fill(metric.color)

                Text(metric.value)
                  .fontSize(20)
                  .fontWeight(FontWeight.SemiBold)
                  .fontColor(AppTokens.Colors.onSurface)

                Text(metric.title)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface + 'B3')
              }
              .width('25%')
              .layoutWeight(1)
              .padding(AppTokens.Spacing.md)
              .alignItems(HorizontalAlign.Center)
              .backgroundColor(AppTokens.Colors.surface)
              .borderRadius(12)
              .shadow({ radius: 8, color: '#2E000000', offsetY: 2 })
            }, (metric: HealthMetric) => metric.id.toString())
          }
          .width('100%')
        }

        // Recent Workouts header
        ListItem() {
          Row() {
            Text('Recent Workouts')
              .fontSize(20)
              .fontWeight(FontWeight.SemiBold)
              .fontColor(AppTokens.Colors.onBackground)
              .layoutWeight(1)

            Button('View All')
              .backgroundColor(Color.Transparent)
              .fontColor(AppTokens.Colors.primary)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .onClick(() => {
                promptAction.showToast({ message: 'View All' })
              })
          }
          .width('100%')
          .alignItems(VerticalAlign.Center)
        }

        // Workout list items
        ForEach(this.workouts, (workout: Workout) => {
          ListItem() {
            Row({ space: AppTokens.Spacing.md }) {
              // Workout icon
              Rect()
                .width(44)
                .height(44)
                .fill(workout.iconColor)
                .radius(12)

              // Workout info
              Column({ space: AppTokens.Spacing.xs }) {
                Text(workout.name)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(AppTokens.Colors.onSurface)

                Row({ space: AppTokens.Spacing.lg }) {
                  Text(workout.duration)
                    .fontSize(14)
                    .fontColor(AppTokens.Colors.onSurface + 'B3')

                  Text(workout.calories)
                    .fontSize(14)
                    .fontColor(AppTokens.Colors.onSurface + 'B3')
                }
              }
              .layoutWeight(1)
              .alignItems(HorizontalAlign.Start)

              // Start button
              Button('Start')
                .width(70)
                .height(32)
                .borderRadius(8)
                .backgroundColor(AppTokens.Colors.primary)
                .fontColor(AppTokens.Colors.onPrimary)
                .fontSize(10)
                .onClick(() => {
                  promptAction.showToast({ message: `Start ${workout.name}` })
                })
            }
            .width('100%')
            .padding(AppTokens.Spacing.md)
            .alignItems(VerticalAlign.Center)
            .backgroundColor(AppTokens.Colors.surface)
            .borderRadius(12)
            .shadow({ radius: 4, color: '#26000000', offsetY: 1 })
          }
        }, (workout: Workout) => workout.id.toString())
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppTokens.Spacing.md, right: AppTokens.Spacing.md })
      .scrollBar(BarState.Off)

      // Bottom Navigation Bar
      Row() {
        ForEach(this.navItems, (item: NavItem) => {
          Column({ space: 2 }) {
            Circle()
              .width(20)
              .height(20)
              .fill(this.selectedNav === item.id ? AppTokens.Colors.primary : AppTokens.Colors.outline)

            Text(item.label)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.selectedNav === item.id ? AppTokens.Colors.primary : AppTokens.Colors.onSurface + '80')
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
      .height(64)
      .backgroundColor(AppTokens.Colors.surface)
      .shadow({ radius: 8, color: '#2E000000', offsetY: -2 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppTokens.Colors.background)
  }
}
