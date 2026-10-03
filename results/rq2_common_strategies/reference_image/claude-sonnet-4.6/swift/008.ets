// HealthDashboard.ets — ArkTS (HarmonyOS ArkUI) port of the SwiftUI health dashboard.

class HDColors {
  static readonly primary: string = '#6366F1';
  static readonly secondary: string = '#EC4899';
  static readonly tertiary: string = '#10B981';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#F1F5F9';
  static readonly outline: string = '#E2E8F0';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#0F172A';
}

class FontSpec {
  size: number;
  weight: FontWeight;

  constructor(size: number, weight: FontWeight) {
    this.size = size;
    this.weight = weight;
  }
}

class HDTypography {
  static readonly display: FontSpec = new FontSpec(24, FontWeight.Bold);
  static readonly headline: FontSpec = new FontSpec(20, FontWeight.SemiBold);
  static readonly title: FontSpec = new FontSpec(16, FontWeight.Medium);
  static readonly body: FontSpec = new FontSpec(14, FontWeight.Normal);
  static readonly label: FontSpec = new FontSpec(12, FontWeight.Medium);
  static readonly small: FontSpec = new FontSpec(10, FontWeight.Normal);
}

class HDShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class HDSpacing {
  static readonly xs: number = 2;
  static readonly sm: number = 4;
  static readonly md: number = 8;
  static readonly lg: number = 12;
  static readonly xl: number = 16;
  static readonly xxl: number = 20;
  static readonly xxxl: number = 24;
}

class HDElevation {
  static readonly level1: ShadowOptions = { radius: 4, color: '#26000000', offsetX: 0, offsetY: 1 };
  static readonly level2: ShadowOptions = { radius: 8, color: '#2E000000', offsetX: 0, offsetY: 2 };
  static readonly level3: ShadowOptions = { radius: 12, color: '#38000000', offsetX: 0, offsetY: 3 };
  static readonly level4: ShadowOptions = { radius: 16, color: '#40000000', offsetX: 0, offsetY: 4 };
}

class HealthMetric {
  id: number;
  title: string;
  value: string;
  unit: string;
  color: string;

  constructor(id: number, title: string, value: string, unit: string, color: string) {
    this.id = id;
    this.title = title;
    this.value = value;
    this.unit = unit;
    this.color = color;
  }
}

class Workout {
  id: number;
  name: string;
  duration: string;
  calories: string;
  iconColor: string;

  constructor(id: number, name: string, duration: string, calories: string, iconColor: string) {
    this.id = id;
    this.name = name;
    this.duration = duration;
    this.calories = calories;
    this.iconColor = iconColor;
  }
}

class NavItem {
  id: number;
  label: string;

  constructor(id: number, label: string) {
    this.id = id;
    this.label = label;
  }
}

@Entry
@Component
struct HealthDashboard {
  @State selectedNav: number = 0;

  private metrics: HealthMetric[] = [
    new HealthMetric(1, 'Heart', '72', 'bpm', HDColors.secondary),
    new HealthMetric(2, 'Steps', '842', 'steps', HDColors.primary),
    new HealthMetric(3, 'Sleep', '7.2', 'hours', HDColors.tertiary),
    new HealthMetric(4, 'Calories', '420', 'kcal', HDColors.error)
  ];

  private workouts: Workout[] = [
    new Workout(1, 'Morning Run', '32 min', '284 kcal', HDColors.primary),
    new Workout(2, 'Yoga Flow', '45 min', '156 kcal', HDColors.secondary),
    new Workout(3, 'Strength Training', '28 min', '320 kcal', HDColors.tertiary)
  ];

  private navItems: NavItem[] = [
    new NavItem(0, 'Dashboard'),
    new NavItem(1, 'Workouts'),
    new NavItem(2, 'Nutrition'),
    new NavItem(3, 'Profile')
  ];

  private bottomBarHeight: number = 72;

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      // Background layer
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(HDColors.background);

      // Foreground content
      Column() {
        // Top bar
        Text('Health Dashboard')
          .fontSize(HDTypography.display.size)
          .fontWeight(HDTypography.display.weight)
          .fontColor(HDColors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Center)
          .padding({ top: 60, bottom: 28 });

        // Scrollable body
        Scroll() {
          Column({ space: HDSpacing.lg }) {
            // Hero card
            Column({ space: HDSpacing.sm }) {
              Text('Good Morning!')
                .fontSize(HDTypography.title.size)
                .fontWeight(HDTypography.title.weight)
                .fontColor(HDColors.onPrimary);

              Text('Ready for your workout?')
                .fontSize(HDTypography.headline.size)
                .fontWeight(HDTypography.headline.weight)
                .fontColor(HDColors.onPrimary);

              Button({ type: ButtonType.Normal, stateEffect: true }) {
                Text('Start Workout')
                  .fontSize(HDTypography.title.size)
                  .fontWeight(HDTypography.title.weight)
                  .fontColor(HDColors.primary);
              }
              .width('100%')
              .height(44)
              .backgroundColor(HDColors.onPrimary)
              .borderRadius(HDShapes.medium)
              .margin({ top: HDSpacing.sm });
            }
            .alignItems(HorizontalAlign.Start)
            .width('100%')
            .padding(HDSpacing.xl)
            .backgroundColor(HDColors.primary)
            .borderRadius(HDShapes.large)
            .shadow(HDElevation.level3);

            // Section title
            Text("Today's Metrics")
              .fontSize(HDTypography.body.size)
              .fontWeight(HDTypography.body.weight)
              .fontColor(HDColors.onBackground)
              .width('100%')
              .textAlign(TextAlign.Start)
              .padding({ left: HDSpacing.sm, right: HDSpacing.sm });

            // Metrics row
            Row({ space: HDSpacing.md }) {
              ForEach(this.metrics, (metric: HealthMetric) => {
                Row() {
                  Column({ space: HDSpacing.xs }) {
                    Circle()
                      .width(36)
                      .height(36)
                      .fill(metric.color);

                    Text(metric.value)
                      .fontSize(HDTypography.headline.size)
                      .fontWeight(HDTypography.headline.weight)
                      .fontColor(HDColors.onSurface);

                    Text(metric.title)
                      .fontSize(HDTypography.label.size)
                      .fontWeight(HDTypography.label.weight)
                      .fontColor(HDColors.onSurface)
                      .opacity(0.7);
                  }
                  .alignItems(HorizontalAlign.Start);

                  Blank();
                }
                .layoutWeight(1)
                .padding(HDSpacing.md)
                .backgroundColor(HDColors.surface)
                .borderRadius(HDShapes.medium)
                .shadow(HDElevation.level2);
              }, (metric: HealthMetric) => metric.id.toString());
            }
            .width('100%');

            // Recent workouts header
            Row() {
              Text('Recent Workouts')
                .fontSize(HDTypography.headline.size)
                .fontWeight(HDTypography.headline.weight)
                .fontColor(HDColors.onBackground);

              Blank();

              Button({ type: ButtonType.Normal, stateEffect: true }) {
                Text('View All')
                  .fontSize(HDTypography.label.size)
                  .fontWeight(HDTypography.label.weight)
                  .fontColor(HDColors.primary)
                  .padding({ right: 20 });
              }
              .backgroundColor(Color.Transparent);
            }
            .width('100%')
            .padding({ top: 10, bottom: 10 });

            // Workout cards
            ForEach(this.workouts, (workout: Workout) => {
              Row({ space: HDSpacing.md }) {
                Column()
                  .width(44)
                  .height(44)
                  .backgroundColor(workout.iconColor)
                  .borderRadius(HDShapes.medium);

                Column({ space: HDSpacing.xs }) {
                  Text(workout.name)
                    .fontSize(HDTypography.title.size)
                    .fontWeight(HDTypography.title.weight)
                    .fontColor(HDColors.onSurface);

                  Row({ space: HDSpacing.lg }) {
                    Text(workout.duration)
                      .fontSize(HDTypography.body.size)
                      .fontWeight(HDTypography.body.weight)
                      .fontColor(HDColors.onSurface)
                      .opacity(0.7);

                    Text(workout.calories)
                      .fontSize(HDTypography.body.size)
                      .fontWeight(HDTypography.body.weight)
                      .fontColor(HDColors.onSurface)
                      .opacity(0.7);
                  };
                }
                .alignItems(HorizontalAlign.Start)
                .layoutWeight(1);

                Button({ type: ButtonType.Normal, stateEffect: true }) {
                  Text('Start')
                    .fontSize(HDTypography.small.size)
                    .fontWeight(HDTypography.small.weight)
                    .fontColor(HDColors.onPrimary);
                }
                .width(70)
                .height(32)
                .backgroundColor(HDColors.primary)
                .borderRadius(HDShapes.small);
              }
              .width('100%')
              .padding(HDSpacing.lg)
              .backgroundColor(HDColors.surface)
              .borderRadius(HDShapes.medium)
              .shadow(HDElevation.level1);
            }, (workout: Workout) => workout.id.toString());
          }
          .width('100%')
          .padding({
            left: HDSpacing.md,
            right: HDSpacing.md,
            bottom: this.bottomBarHeight + HDSpacing.lg
          });
        }
        .scrollBar(BarState.Off)
        .width('100%')
        .layoutWeight(1);
      }
      .width('100%')
      .height('100%');

      // Floating bottom navigation
      Column() {
        Row({ space: HDSpacing.md }) {
          ForEach(this.navItems, (item: NavItem) => {
            Column({ space: HDSpacing.xs }) {
              Circle()
                .width(20)
                .height(20)
                .fill(this.selectedNav === item.id ? HDColors.primary : HDColors.outline);

              Text(item.label)
                .fontSize(HDTypography.label.size)
                .fontWeight(HDTypography.label.weight)
                .fontColor(HDColors.onSurface);
            }
            .layoutWeight(1)
            .onClick(() => {
              this.selectedNav = item.id;
            });
          }, (item: NavItem) => item.id.toString());
        }
        .width('100%')
        .padding({
          top: HDSpacing.sm,
          bottom: HDSpacing.sm,
          left: HDSpacing.md,
          right: HDSpacing.md
        })
        .backgroundColor(HDColors.surface)
        .borderRadius(HDShapes.large)
        .shadow(HDElevation.level2);
      }
      .width('100%')
      .padding({
        left: HDSpacing.md,
        right: HDSpacing.md,
        bottom: HDSpacing.md
      });
    }
    .width('100%')
    .height('100%')
    .backgroundColor(HDColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM]);
  }
}