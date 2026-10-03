import { hilog } from '@kit.PerformanceAnalysisKit';
import { display, window } from '@kit.ArkUI';

@Entry
@Component
struct WorkoutPlanScreen {
  @State private currentTab: string = 'Home';
  private primaryColor: string = '#2563EB';
  private secondaryColor: string = '#38BDF8';
  private tertiaryColor: string = '#3B82F6';
  private backgroundColor: string = '#F8FAFC';
  private surfaceColor: string = '#FFFFFF';
  private surfaceVariantColor: string = '#E2E8F0';
  private outlineColor: string = '#CBD5E1';
  private onPrimaryColor: string = '#FFFFFF';
  private onSurfaceColor: string = '#1E293B';
  private onBackgroundColor: string = '#0F172A';

  @Builder
  TopBar() {
    Row() {
      Text('Workout Plan')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onBackgroundColor)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
    }
    .width('100%')
    .height(64)
    .padding({ left: 16, right: 16 })
    .backgroundColor(this.surfaceColor)
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  BottomBar() {
    Row() {
      Text('Home')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.currentTab === 'Home' ? this.primaryColor : this.onSurfaceColor)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
        .onClick(() => {
          this.currentTab = 'Home';
        })
      Text('Plan')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.currentTab === 'Plan' ? this.primaryColor : this.onSurfaceColor)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
        .onClick(() => {
          this.currentTab = 'Plan';
        })
      Text('Profile')
        .fontSize(16)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.currentTab === 'Profile' ? this.primaryColor : this.onSurfaceColor)
        .textAlign(TextAlign.Center)
        .layoutWeight(1)
        .onClick(() => {
          this.currentTab = 'Profile';
        })
    }
    .width('100%')
    .height(64)
    .padding({ left: 24, right: 24 })
    .backgroundColor(this.surfaceColor)
    .alignItems(VerticalAlign.Center)
    .shadow({ radius: 8, color: '#24000000', offsetY: 4 })
  }

  @Builder
  FloatingActionButton() {
    Stack() {
      Text('+')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.onPrimaryColor)
        .textAlign(TextAlign.Center)
    }
    .width(56)
    .height(56)
    .borderRadius(28)
    .backgroundColor(this.primaryColor)
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .shadow({ radius: 12, color: '#29000000', offsetY: 6 })
  }

  @Builder
  WorkoutPreviewCard() {
    Column() {
      Text('Workout Preview')
        .fontSize(14)
        .fontWeight(FontWeight.Normal)
        .fontColor(this.onSurfaceColor)
        .textAlign(TextAlign.Center)
    }
    .width('100%')
    .height(200)
    .borderRadius(16)
    .backgroundColor(this.surfaceColor)
    .border({ width: 1, color: this.outlineColor, radius: 16 })
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  @Builder
  AuthenticateButton() {
    Button('Authenticate', { type: ButtonType.Normal })
      .width('80%')
      .height(52)
      .borderRadius(16)
      .backgroundColor(this.primaryColor)
      .fontColor(this.onPrimaryColor)
      .fontSize(16)
      .fontWeight(FontWeight.Medium)
  }

  build() {
    Stack() {
      Column() {
        this.TopBar()

        Column() {
          Text('Sign In to Continue')
            .fontSize(20)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.onSurfaceColor)
            .textAlign(TextAlign.Center)
            .width('100%')
            .margin({ top: 24 })

          Column() {
            this.WorkoutPreviewCard()
          }
          .width('100%')
          .padding({ left: 16, right: 16, top: 16 })
          .alignItems(HorizontalAlign.Center)

          Column() {
            this.AuthenticateButton()
          }
          .width('100%')
          .padding({ top: 16 })
          .alignItems(HorizontalAlign.Center)

          Blank()
            .layoutWeight(1)
        }
        .width('100%')
        .layoutWeight(1)
        .linearGradient({
          direction: GradientDirection.Bottom,
          colors: [[this.secondaryColor, 0.1], [this.primaryColor, 0.15]]
        })
        .alignItems(HorizontalAlign.Center)

        this.BottomBar()
      }
      .width('100%')
      .height('100%')
      .backgroundColor(this.backgroundColor)

      Column() {
        Blank()
          .layoutWeight(1)
        Row() {
          Blank()
            .layoutWeight(1)
          this.FloatingActionButton()
          Blank()
            .width(16)
        }
        .width('100%')
        Blank()
          .height(80)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}