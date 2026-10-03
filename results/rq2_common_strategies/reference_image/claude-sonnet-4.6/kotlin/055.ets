/**
 * pages/Index.ets  —  082_WorkoutPlan_en / Health Auth / Modern Blue
 *
 * 配套配置：
 *   resources/base/profile/main_pages.json  ->  { "src": ["pages/Index"] }
 *   EntryAbility.ets  ->  windowStage.loadContent('pages/Index', ...)
 *                          window.setWindowLayoutFullScreen(true)
 *                          window.setWindowSystemBarEnable([])
 *   module.json5 entry ability 增加 "orientation": "portrait"
 */

const PAGE_NAME: string = '082_WorkoutPlan_en';
const UI_TYPE: string = 'Health Auth';
const STYLE_THEME: string = 'Modern Blue';
const LANG: string = 'en';
const BASELINE_SIZE: string = '720x1280';

/** ------------------------------- Design Tokens ------------------------------ */
class AppColor {
  static readonly primary: string = '#2563EB';
  static readonly secondary: string = '#38BDF8';
  static readonly tertiary: string = '#3B82F6';
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

  // 渐变（AARRGGBB，10% / 15% 透明度）
  static readonly gradientTop: string = '#1A38BDF8';
  static readonly gradientBottom: string = '#262563EB';

  // 阴影（level2 / level3 映射）
  static readonly fabShadow: string = '#332563EB';
  static readonly barShadow: string = '#1FA7B4C8';
}

class AppFont {
  static readonly display: number = 28;
  static readonly headline: number = 20;
  static readonly title: number = 16;
  static readonly body: number = 14;
  static readonly label: number = 12;
}

class AppSpace {
  static readonly xs: number = 4;
  static readonly sm: number = 8;
  static readonly md: number = 12;
  static readonly lg: number = 16;
  static readonly xl: number = 24;
  static readonly xxl: number = 36;
}

class AppRadius {
  static readonly small: number = 8;
  static readonly medium: number = 12;
  static readonly large: number = 16;
}

class AppSize {
  static readonly topBar: number = 56;
  static readonly bottomBar: number = 56;
  static readonly fab: number = 56;
  static readonly previewHeight: number = 200;
  static readonly buttonHeight: number = 52;
}

/** --------------------------------- Screen ---------------------------------- */
@Entry
@Component
struct Index {
  @State activeTab: string = 'Home';

  @Builder
  TopBar() {
    Row() {
      Text('Workout Plan')
        .fontSize(AppFont.display)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColor.onBackground)
    }
    .width('100%')
    .height(AppSize.topBar)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(AppColor.background)
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Home')
        .fontSize(AppFont.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.activeTab === 'Home' ? AppColor.primary : AppColor.onSurface)
        .onClick(() => { this.activeTab = 'Home'; })

      Text('Plan')
        .fontSize(AppFont.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.activeTab === 'Plan' ? AppColor.primary : AppColor.onSurface)
        .onClick(() => { this.activeTab = 'Plan'; })

      Text('Profile')
        .fontSize(AppFont.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.activeTab === 'Profile' ? AppColor.primary : AppColor.onSurface)
        .onClick(() => { this.activeTab = 'Profile'; })
    }
    .width('100%')
    .height(AppSize.bottomBar)
    .padding({ left: AppSpace.lg, right: AppSpace.lg })
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(AppColor.surface)
    .shadow({ radius: 8, color: AppColor.barShadow, offsetX: 0, offsetY: -2 })
  }

  @Builder
  FloatingAction() {
    Button('+')
      .type(ButtonType.Circle)
      .width(AppSize.fab)
      .height(AppSize.fab)
      .fontSize(AppFont.display)
      .fontWeight(FontWeight.Bold)
      .fontColor(AppColor.onPrimary)
      .backgroundColor(AppColor.primary)
      .shadow({ radius: 12, color: AppColor.fabShadow, offsetX: 0, offsetY: 6 })
      .margin({ right: AppSpace.lg, bottom: AppSpace.lg + AppSize.bottomBar + 48 })
      .onClick(() => {})
  }

  @Builder
  Body() {
    Column({ space: AppSpace.lg }) {
      Text('Sign In to Continue')
        .fontSize(AppFont.headline)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColor.onSurface)

      Stack() {
        Text('Workout Preview')
          .fontSize(AppFont.body)
          .fontWeight(FontWeight.Normal)
          .fontColor(AppColor.onSurface)
      }
      .width('100%')
      .height(AppSize.previewHeight)
      .backgroundColor(AppColor.surface)
      .borderRadius(AppRadius.large)
      .border({ width: 1, color: AppColor.outline })

      Button('Authenticate')
        .width('80%')
        .height(AppSize.buttonHeight)
        .fontSize(AppFont.title)
        .fontWeight(FontWeight.Medium)
        .fontColor(AppColor.onPrimary)
        .backgroundColor(AppColor.primary)
        .borderRadius(AppRadius.large)
        .onClick(() => {})
    }
    .width('100%')
    .layoutWeight(1)
    .padding(AppSpace.lg)
    .justifyContent(FlexAlign.Start)
    .alignItems(HorizontalAlign.Center)
    .linearGradient({
      angle: 180,
      colors: [[AppColor.gradientTop, 0.0], [AppColor.gradientBottom, 1.0]]
    })
  }

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        this.TopBar()
        this.Body()
        this.BottomBar()
      }
      .width('100%')
      .height('100%')

      this.FloatingAction()
    }
    .width('100%')
    .height('100%')
    .backgroundColor(AppColor.background)
  }
}