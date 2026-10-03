const AppColors = {
  primary: '#6366F1',
  secondary: '#EC4899',
  tertiary: '#10B981',
  background: '#F8FAFC',
  surface: '#FFFFFF',
  surfaceVariant: '#F1F5F9',
  outline: '#E2E8F0',
  success: '#10B981',
  warning: '#F59E0B',
  error: '#EF4444',
  onPrimary: '#FFFFFF',
  onSecondary: '#FFFFFF',
  onTertiary: '#FFFFFF',
  onBackground: '#0F172A',
  onSurface: '#0F172A'
}

const AppSpacing = {
  xs: 2,
  sm: 4,
  md: 8,
  lg: 12,
  xl: 16,
  xxl: 20,
  xxxl: 24
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

@Component
struct WorkoutView {
  private workout: Workout = { id: 0, name: '', duration: '', calories: '', iconColor: '' }

  build() {
    Row({ space: AppSpacing.md }) {
      Column()
        .width(44)
        .height(44)
        .backgroundColor(this.workout.iconColor)
        .borderRadius(12)

      Column({ space: AppSpacing.xs }) {
        Text(this.workout.name)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor(AppColors.onSurface)
        Row({ space: AppSpacing.lg }) {
          Text(this.workout.duration)
            .fontSize(14)
            .fontColor('#B30F172A')
          Text(this.workout.calories)
            .fontSize(14)
            .fontColor('#B30F172A')
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Button('Start')
        .type(ButtonType.Normal)
        .fontSize(10)
        .fontColor(AppColors.onPrimary)
        .backgroundColor(AppColors.primary)
        .borderRadius(8)
        .height(32)
        .width(70)
    }
    .width('100%')
    .padding(AppSpacing.md)
    .backgroundColor(AppColors.surface)
    .borderRadius(12)
    .alignItems(VerticalAlign.Center)
  }
}

@Entry
@Component
struct Index {
  @State selectedNav: number = 0
  private metrics: HealthMetric[] = [
    { id: 1, title: 'Heart', value: '72', unit: 'bpm', progress: 0.6, color: '#EC4899' },
    { id: 2, title: 'Steps', value: '842', unit: 'steps', progress: 0.8, color: '#6366F1' },
    { id: 3, title: 'Sleep', value: '7.2', unit: 'hours', progress: 0.9, color: '#10B981' },
    { id: 4, title: 'Calories', value: '420', unit: 'kcal', progress: 0.4, color: '#EF4444' }
  ]
  private workouts: Workout[] = [
    { id: 1, name: 'Morning Run', duration: '32 min', calories: '284 kcal', iconColor: '#6366F1' },
    { id: 2, name: 'Yoga Flow', duration: '45 min', calories: '156 kcal', iconColor: '#EC4899' },
    { id: 3, name: 'Strength Training', duration: '28 min', calories: '320 kcal', iconColor: '#10B981' }
  ]
  private navItems: NavItem[] = [
    { id: 0, label: 'Dashboard' },
    { id: 1, label: 'Workouts' },
    { id: 2, label: 'Nutrition' },
    { id: 3, label: 'Profile' }
  ]

  build() {
    Column() {
      Text('Health Dashboard')
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .width('100%')
        .textAlign(TextAlign.Center)
        .padding({ top: 16, bottom: 16 })

      List({ space: AppSpacing.lg }) {
        ListItem() {
          this.HeroCard()
        }
        ListItem() {
          Text("Today's Metrics")
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onBackground)
            .padding({ left: AppSpacing.sm, right: AppSpacing.sm })
        }
        ListItem() {
          this.MetricsRow()
        }
        ListItem() {
          this.WorkoutHeader()
        }
        ForEach(this.workouts, (w: Workout) => {
          ListItem() {
            WorkoutView({ workout: w })
          }
        }, (w: Workout) => w.id.toString())
        ListItem() {
          Blank().height(AppSpacing.xxxl)
        }
      }
      .width('100%')
      .layoutWeight(1)
      .padding({ left: AppSpacing.md, right: AppSpacing.md, bottom: AppSpacing.xxxl })
      .scrollBar(BarState.Off)

      this.BottomNav()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }

  @Builder
  HeroCard() {
    Column({ space: AppSpacing.sm }) {
      Text('Good Morning!')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
      Text('Ready for your workout?')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onPrimary)
      Button('Start Workout')
        .type(ButtonType.Normal)
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
        .backgroundColor(AppColors.onPrimary)
        .borderRadius(12)
        .width('100%')
        .height(44)
    }
    .width('100%')
    .padding(AppSpacing.xl)
    .backgroundColor(AppColors.primary)
    .borderRadius(16)
    .alignItems(HorizontalAlign.Start)
  }

  @Builder
  MetricsRow() {
    Row({ space: AppSpacing.md }) {
      ForEach(this.metrics, (m: HealthMetric) => {
        Column({ space: AppSpacing.xs }) {
          Column()
            .width(36)
            .height(36)
            .backgroundColor(m.color)
            .borderRadius(18)
          Text(m.value)
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onSurface)
          Text(m.title)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor('#B30F172A')
        }
        .layoutWeight(1)
        .padding(AppSpacing.md)
        .backgroundColor(AppColors.surface)
        .borderRadius(12)
        .alignItems(HorizontalAlign.Center)
      }, (m: HealthMetric) => m.id.toString())
    }
    .width('100%')
  }

  @Builder
  WorkoutHeader() {
    Row() {
      Text('Recent Workouts')
        .fontSize(20)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onBackground)
        .layoutWeight(1)
      Text('View All')
        .fontSize(12)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomNav() {
    Row() {
      ForEach(this.navItems, (item: NavItem) => {
        Column({ space: 4 }) {
          Column()
            .width(20)
            .height(20)
            .backgroundColor(this.selectedNav === item.id ? AppColors.primary : AppColors.outline)
            .borderRadius(10)
          Text(item.label)
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.selectedNav === item.id ? AppColors.primary : AppColors.onSurface)
        }
        .layoutWeight(1)
        .alignItems(HorizontalAlign.Center)
        .onClick(() => {
          this.selectedNav = item.id
        })
      }, (item: NavItem) => item.id.toString())
    }
    .width('100%')
    .padding({ top: AppSpacing.sm, bottom: AppSpacing.sm })
    .backgroundColor(AppColors.surface)
    .justifyContent(FlexAlign.SpaceEvenly)
    .alignItems(VerticalAlign.Center)
  }
}