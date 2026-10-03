// entry/src/main/ets/pages/Index.ets
const NAME: string = '086_SleepCycle_en';
const UI_TYPE: string = 'Health Auth';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly tertiary: string = '#60A5FA';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly surfaceVariant: string = '#E2E8F0';
  static readonly outline: string = '#CBD5E1';
  static readonly success: string = '#22C55E';
  static readonly warning: string = '#F59E0B';
  static readonly error: string = '#EF4444';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onSecondary: string = '#0F172A';
  static readonly onTertiary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
}

class AppType {
  static readonly displaySize: number = 28;
  static readonly displayWeight: FontWeight = FontWeight.Bold;
  static readonly headlineSize: number = 20;
  static readonly headlineWeight: FontWeight = FontWeight.SemiBold;
  static readonly titleSize: number = 16;
  static readonly titleWeight: FontWeight = FontWeight.Medium;
  static readonly bodySize: number = 14;
  static readonly bodyWeight: FontWeight = FontWeight.Normal;
  static readonly labelSize: number = 12;
  static readonly labelWeight: FontWeight = FontWeight.Medium;
}

class AppShapes {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSpacing {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

class Elevation {
  readonly elevation: number;
  readonly radius: number;
  readonly dy: number;
  readonly opacity: number;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

class ElevationMapping {
  static readonly level1: Elevation = new Elevation(2, 4, 2, 0.12);
  static readonly level2: Elevation = new Elevation(4, 8, 4, 0.14);
  static readonly level3: Elevation = new Elevation(8, 12, 6, 0.16);
}

@Entry
@Component
struct Index {
  @State private headerTitle: string = 'Sleep Cycle';
  @State private welcomeTitle: string = 'Welcome Back';
  @State private welcomeBody: string = 'Track your sleep patterns and improve rest quality.';
  @State private actionLabel: string = 'Sign In';

  build() {
    Column() {
      this.Header()

      Column({ space: AppSpacing.xl }) {
        Stack() {
          Text('😴')
            .fontSize(48)
        }
        .width(160)
        .height(160)
        .borderRadius(80)
        .backgroundColor(AppColors.surface)
        .border({ width: 2, color: AppColors.outline })
        .shadow({
          radius: ElevationMapping.level2.radius,
          color: '#1E293B',
          offsetX: 0,
          offsetY: ElevationMapping.level2.dy,
          fill: false
        })

        Text(this.welcomeTitle)
          .fontSize(AppType.headlineSize)
          .fontWeight(AppType.headlineWeight)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .width('100%')

        Text(this.welcomeBody)
          .fontSize(AppType.bodySize)
          .fontWeight(AppType.bodyWeight)
          .fontColor(AppColors.onSurface)
          .textAlign(TextAlign.Center)
          .maxLines(2)
          .width('100%')

        Button(this.actionLabel, { type: ButtonType.Normal, stateEffect: true })
          .width('80%')
          .height(52)
          .fontSize(AppType.titleSize)
          .fontWeight(AppType.titleWeight)
          .fontColor(AppColors.onPrimary)
          .backgroundColor(AppColors.primary)
          .borderRadius(AppShapes.large)
          .onClick(() => {
          })
      }
      .width('100%')
      .layoutWeight(1)
      .padding(AppSpacing.lg)
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Start)
      .linearGradient({
        angle: 180,
        colors: [['#2638BDF8', 0.0], ['#1A2563EB', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }

  @Builder
  Header() {
    Stack({ alignContent: Alignment.Center }) {
      Text(this.headerTitle)
        .fontSize(AppType.displaySize)
        .fontWeight(AppType.displayWeight)
        .fontColor(AppColors.onBackground)

      Row() {
        Stack() {
          Text('<')
            .fontSize(AppType.labelSize)
            .fontWeight(AppType.labelWeight)
            .fontColor(AppColors.onPrimary)
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(AppColors.primary)
        .onClick(() => {
        })

        Blank()

        Stack() {
          Text('?')
            .fontSize(AppType.labelSize)
            .fontWeight(AppType.labelWeight)
            .fontColor(AppColors.onSecondary)
        }
        .width(24)
        .height(24)
        .borderRadius(12)
        .backgroundColor(AppColors.secondary)
        .onClick(() => {
        })
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(56)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .backgroundColor(AppColors.surface)
  }
}