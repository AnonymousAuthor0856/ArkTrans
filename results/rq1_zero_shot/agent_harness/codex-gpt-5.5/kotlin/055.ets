const NAME: string = "082_WorkoutPlan_en";
const UI_TYPE: string = "Health Auth";
const STYLE_THEME: string = "Modern Blue";
const LANG: string = "en";
const BASELINE_SIZE: string = "720x1280";

class AppColors {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly background: string = '#F8FAFC';
  static readonly surface: string = '#FFFFFF';
  static readonly outline: string = '#CBD5E1';
  static readonly onPrimary: string = '#FFFFFF';
  static readonly onBackground: string = '#0F172A';
  static readonly onSurface: string = '#1E293B';
}

class AppSpacing {
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
}

@Entry
@Component
struct MainActivity {
  @Builder
  TopBar() {
    Row() {
      Text('Workout Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onBackground)
        .textAlign(TextAlign.Center)
        .width('100%')
    }
    .width('100%')
    .height(68)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.background)
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Home')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.primary)
      Text('Plan')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
      Text('Profile')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColors.onSurface)
    }
    .width('100%')
    .height(66)
    .padding({ left: AppSpacing.lg, right: AppSpacing.lg })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColors.surface)
    .shadow({ radius: 8, color: '#24000000', offsetY: -2 })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()

        Column({ space: AppSpacing.lg }) {
          Text('Sign In to Continue')
            .fontSize(20)
            .fontWeight(FontWeight.SemiBold)
            .fontColor(AppColors.onSurface)

          Column() {
            Text('Workout Preview')
              .fontSize(14)
              .fontColor(AppColors.onSurface)
          }
          .width('100%')
          .height(200)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(AppColors.surface)
          .borderRadius(16)
          .border({ width: 1, color: AppColors.outline })

          Button('Authenticate')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(AppColors.onPrimary)
            .width('80%')
            .height(52)
            .backgroundColor(AppColors.primary)
            .borderRadius(16)
        }
        .layoutWeight(1)
        .width('100%')
        .padding(AppSpacing.lg)
        .alignItems(HorizontalAlign.Center)
        .backgroundColor(AppColors.background)
        .linearGradient({
          angle: 180,
          colors: [['#1A38BDF8', 0.0], ['#262563EB', 1.0]]
        })

        this.BottomBar()
      }
      .width('100%')
      .height('100%')

      Text('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onPrimary)
        .textAlign(TextAlign.Center)
        .width(56)
        .height(56)
        .lineHeight(56)
        .backgroundColor(AppColors.primary)
        .borderRadius(28)
        .shadow({ radius: 12, color: '#33000000', offsetY: 4 })
        .margin({ right: 20, bottom: 78 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColors.background)
  }
}
