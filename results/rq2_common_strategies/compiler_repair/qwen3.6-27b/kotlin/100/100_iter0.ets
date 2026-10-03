import { router } from '@kit.ArkRouter'
import { window } from '@kit.ArkUI'

// UI Constants & Colors
const PrimaryBlack: string = '#121212'
const BackgroundWhite: string = '#FFFFFF'
const SurfaceGray: string = '#F5F5F5'
const TextSecondary: string = '#757575'
const AccentGreen: string = '#4CAF50'
const GoldColor: string = '#FFD700'

@Entry
@Component
struct HabitTrackerApp {
  @State isCompletedMeditation: boolean = true
  @State isCompletedGym: boolean = false
  @State isCompletedSpanish: boolean = false
  @State isCompletedWater: boolean = false

  aboutToAppear() {
    // Logic to hide system bars for full immersion (Immersive Sticky Mode)
    let windowClass: window.Window | undefined = undefined;
    try {
      windowClass = window.getWindowSync(this.context);
      if (windowClass) {
        windowClass.setWindowLayoutFullScreen(true);
        windowClass.setWindowSystemBarProperties({
          statusBarContentColor: '#00000000',
          navigationBarContentColor: '#00000000',
          statusBarColor: '#00000000',
          navigationBarColor: '#00000000'
        });
      }
    } catch (e) {
      console.error('Failed to set immersive mode');
    }
  }

  build() {
    Column() {
      Scroll() {
        Column({ space: 32 }) {
          // Top Bar
          Row() {
            Column() {
              Text("THURSDAY")
                .fontSize(12)
                .fontColor(TextSecondary)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(1)
              Text("Dec 04")
                .fontSize(24)
                .fontColor(PrimaryBlack)
                .fontWeight(FontWeight.Black)
            }
            Blank()
            Button('', { type: ButtonType.Circle, stateEffect: false })
              .width(40)
              .height(40)
              .borderWidth(1)
              .borderColor(SurfaceGray)
              .backgroundColor(Color.Transparent)
              .onClick(() => { /* No op */ })
              .build() {
                Image($r('app.media.ic_settings')) // Placeholder for Settings Icon
                  .width(24)
                  .height(24)
                  .fillColor(PrimaryBlack)
              }
          }
          .width('100%')
          .padding({ top: 24 })

          // Hero Stats Card
          this.StatsCard()

          // Section Title
          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(TextSecondary)
            .letterSpacing(1.5)
            .width('100%')

          // Habit List
          Column({ space: 8 }) {
            this.HabitItem(
              'ic_face', // Placeholder resource name
              "Morning Meditation",
              "15 minutes mindfulness",
              this.isCompletedMeditation,
              () => { this.isCompletedMeditation = !this.isCompletedMeditation }
            )
            this.HabitItem(
              'ic_play_arrow',
              "Gym Session",
              "Upper body workout",
              this.isCompletedGym,
              () => { this.isCompletedGym = !this.isCompletedGym }
            )
            this.HabitItem(
              'ic_star',
              "Learn Spanish",
              "Daily lesson completed",
              this.isCompletedSpanish,
              () => { this.isCompletedSpanish = !this.isCompletedSpanish }
            )
            this.HabitItem(
              'ic_favorite',
              "Drink Water",
              "2L target",
              this.isCompletedWater,
              () => { this.isCompletedWater = !this.isCompletedWater }
            )
          }

          // Inspiration Section
          Row() {
            Column({ space: 12 }) {
              Image($r('app.media.ic_check_circle')) // Placeholder resource name
                .width(20)
                .height(20)
                .fillColor(TextSecondary)
              Text("Small steps every day add up to big results over time.")
                .fontSize(14)
                .fontColor(PrimaryBlack)
                .fontStyle(FontStyle.Italic)
                .lineHeight(20)
            }
          }
          .width('100%')
          .padding(20)
          .backgroundColor(SurfaceGray)
          .borderRadius(16)

          Spacer().height(48)
        }
        .padding({ left: 24, right: 24 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
  }

  @Builder
  StatsCard() {
    Row() {
      Column({ space: 8 }) {
        Text("Overall Progress")
          .fontColor('#B3FFFFFF') // White with 0.7 alpha approx
          .fontSize(14)
        
        Text("85%")
          .fontColor(Color.White)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
        
        Row({ space: 4 }) {
          Image($r('app.media.ic_star')) // Placeholder resource name
            .width(16)
            .height(16)
            .fillColor(GoldColor)
          
          Text("12 Day Streak!")
            .fontColor(Color.White)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .width('100%')
    }
    .width('100%')
    .height(140)
    .backgroundColor(PrimaryBlack)
    .borderRadius(24)
    .padding(24)
  }

  @Builder
  HabitItem(iconRes: string, title: string, subtitle: string, isChecked: boolean, onClick: () => void) {
    Row() {
      // Icon Box
      Row() {
        Image($r(`app.media.${iconRes}`)) // Dynamic resource loading based on string
          .width(24)
          .height(24)
          .fillColor(PrimaryBlack)
      }
      .width(48)
      .height(48)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(SurfaceGray)
      .borderRadius(24)

      Spacer().width(16)

      // Text Info
      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(isChecked ? TextSecondary : PrimaryBlack)
          .decoration(isChecked ? TextDecorationType.LineThrough : TextDecorationType.None)
        
        Text(subtitle)
          .fontSize(12)
          .fontColor(TextSecondary)
          .margin({ top: 2 })
      }
      .layoutWeight(1)

      Spacer().width(8)

      // Checkbox Button
      Row() {
        if (isChecked) {
          Image($r('app.media.ic_check')) // Placeholder resource name
            .width(18)
            .height(18)
            .fillColor(Color.White)
        }
      }
      .width(32)
      .height(32)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .backgroundColor(isChecked ? AccentGreen : Color.Transparent)
      .borderWidth(2)
      .borderColor(isChecked ? AccentGreen : SurfaceGray)
      .borderRadius(16)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: SurfaceGray })
    .onClick(onClick)
  }
}