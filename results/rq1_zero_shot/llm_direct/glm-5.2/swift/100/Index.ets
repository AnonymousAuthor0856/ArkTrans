// HabitTrackerPage.ets
import { Length } from '@ohos.arkui.component';

// MARK: - UI Constants & Colors

@Extend(Text)
function titleFont(size: number, weight: number | string) {
  .fontSize(size)
  .fontWeight(weight)
}

class AppColors {
  static readonly primaryBlack: string = '#121212';
  static readonly backgroundWhite: string = '#FFFFFF';
  static readonly surfaceGray: string = '#F5F5F5';
  static readonly textSecondary: string = '#757575';
  static readonly accentGreen: string = '#4CAF50';
  static readonly gold: string = '#FFD700';
}

// MARK: - Main Screen

@Entry
@Component
struct HabitTrackerScreen {
  build() {
    Stack() {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor(AppColors.backgroundWhite)

      // Scrollable Content
      Scroll() {
        Column() {
          // Top Spacing
          Blank().height(24)

          // -- Top Bar --
          Row() {
            Column() {
              Text('THURSDAY')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor(AppColors.textSecondary)
                .letterSpacing(1)
              
              Text('Dec 04')
                .fontSize(24)
                .fontWeight(FontWeight.Black)
                .fontColor(AppColors.primaryBlack)
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)

            Blank() // SpaceBetween

            // Settings Button
            Button() {
              Image($r('sys.media.ohos_ic_public_settings'))
                .width(24)
                .height(24)
                .fillColor(AppColors.primaryBlack)
            }
            .width(40)
            .height(40)
            .backgroundColor(Color.Transparent)
            .borderRadius(20)
            .border({ width: 1, color: AppColors.surfaceGray })
          }
          .width('100%')

          Blank().height(32)

          // -- Hero Stats Card --
          StatsCard()

          Blank().height(32)

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(AppColors.textSecondary)
            .letterSpacing(1.5)
            .width('100%')
            .textAlign(TextAlign.Start)

          Blank().height(16)

          // -- Habit List --
          HabitItem({ 
            iconName: $r('sys.media.ohos_ic_public_face'), 
            title: 'Morning Meditation', 
            subtitle: '15 minutes mindfulness', 
            isCompleted: true 
          })
          
          HabitItem({ 
            iconName: $r('sys.media.ohos_ic_public_play'), 
            title: 'Gym Session', 
            subtitle: 'Upper body workout', 
            isCompleted: false 
          })

          HabitItem({ 
            iconName: $r('sys.media.ohos_ic_public_star'), 
            title: 'Learn Spanish', 
            subtitle: 'Daily lesson completed', 
            isCompleted: false 
          })

          HabitItem({ 
            iconName: $r('sys.media.ohos_ic_public_heart'), 
            title: 'Drink Water', 
            subtitle: '2L target', 
            isCompleted: false 
          })

          Blank().height(24)

          // -- Inspiration Section --
          Column() {
            Image($r('sys.media.ohos_ic_public_checkmark_filled'))
              .width(20)
              .height(20)
              .fillColor(AppColors.textSecondary)
            
            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor(AppColors.primaryBlack)
              .lineHeight(20)
              .margin({ top: 12 })
          }
          .padding(20)
          .width('100%')
          .backgroundColor(AppColors.surfaceGray)
          .borderRadius(16)
          .alignItems(HorizontalAlign.Start)

          Blank().height(48)
        }
        .padding(24)
        .width('100%')
      }
      .scrollBar(BarState.Off)
      .align(Alignment.Top)
    }
    .width('100%')
    .height('100%')
  }
}

// MARK: - Components

@Component
struct StatsCard {
  build() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontSize(14)
          .fontColor('#FFFFFFB3') // 70% opacity white
          .margin({ bottom: 8 })

        Text('85%')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .margin({ bottom: 4 })

        Row() {
          Image($r('sys.media.ohos_ic_public_star'))
            .width(16)
            .height(16)
            .fillColor(AppColors.gold)
            .margin({ right: 4 })
          
          Text('12 Day Streak!')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1) // fillMaxSize() for Column inside Row
    }
    .width('100%')
    .height(140)
    .padding(24)
    .backgroundColor(AppColors.primaryBlack)
    .borderRadius(24)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HabitItem {
  @Prop iconName: Resource;
  @Prop title: string;
  @Prop subtitle: string;
  @State isCompleted: boolean = false;

  build() {
    Row() {
      // Icon Box
      Stack() {
        Column()
          .width(48)
          .height(48)
          .backgroundColor(AppColors.surfaceGray)
          .borderRadius(24)

        Image(this.iconName)
          .width(24)
          .height(24)
          .fillColor(AppColors.primaryBlack)
      }
      .width(48)
      .height(48)

      Blank().width(16)

      // Text Info
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? AppColors.textSecondary : AppColors.primaryBlack)
          .decoration({ type: TextDecorationType.LineThrough, color: AppColors.textSecondary })
          .margin({ bottom: 2 })

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(AppColors.textSecondary)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank().width(8)

      // Checkbox Button
      Stack() {
        Column()
          .width(32)
          .height(32)
          .backgroundColor(this.isCompleted ? AppColors.accentGreen : Color.Transparent)
          .borderRadius(16)
          .border({ width: 2, color: this.isCompleted ? AppColors.accentGreen : AppColors.surfaceGray })

        if (this.isCompleted) {
          Image($r('sys.media.ohos_ic_public_checkmark'))
            .width(18)
            .height(18)
            .fillColor(Color.White)
        }
      }
      .width(32)
      .height(32)
    }
    .padding(16)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: AppColors.surfaceGray })
    .margin({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.isCompleted = !this.isCompleted;
    })
  }
}