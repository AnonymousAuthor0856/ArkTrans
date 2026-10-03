import { Image, PixelMap } from '@kit.ArkGraphics'

// MARK: - UI Constants & Colors

interface ColorConstants {
  primaryBlack: string;
  backgroundWhite: string;
  surfaceGray: string;
  textSecondary: string;
  accentGreen: string;
  gold: string;
}

const COLORS: ColorConstants = {
  primaryBlack: '#121212',
  backgroundWhite: '#FFFFFF',
  surfaceGray: '#F5F5F5',
  textSecondary: '#757575',
  accentGreen: '#4CAF50',
  gold: '#FFD700'
}

// MARK: - Main Screen

@Entry
@Component
struct HabitTrackerScreen {
  build() {
    Column() {
      // Background
      Row()
        .width('100%')
        .height('100%')
        .backgroundColor(COLORS.backgroundWhite)
        .position({ x: 0, y: 0 })
        .zIndex(-1)

      Scroll() {
        Column() {
          // Top Spacer
          Blank().height(24)

          // -- Top Bar --
          Row() {
            Column() {
              Text("THURSDAY")
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(1)
                .fontColor(COLORS.textSecondary)
              
              Text("Dec 04")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor(COLORS.primaryBlack)
            }
            .alignItems(HorizontalAlign.Start)
            
            Blank()
            
            Button() {
              Image($r('app.media.settings_icon')) // Placeholder for gear icon
                .width(24)
                .height(24)
                .fillColor(COLORS.primaryBlack)
            }
            .width(40)
            .height(40)
            .borderRadius(20)
            .border({ width: 1, color: COLORS.surfaceGray })
            .backgroundColor(Color.Transparent)
          }
          .width('100%')
          .padding({ left: 24, right: 24 })

          // Spacer
          Blank().height(32)

          // -- Hero Stats Card --
          StatsCard()

          // Spacer
          Blank().height(32)

          // Section Title
          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1.5)
            .fontColor(COLORS.textSecondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Spacer
          Blank().height(16)

          // -- Habit List --
          HabitItem({
            iconName: $r('app.media.face_icon'), // Placeholder
            title: "Morning Meditation",
            subtitle: "15 minutes mindfulness",
            isCompleted: true
          })

          HabitItem({
            iconName: $r('app.media.play_icon'), // Placeholder
            title: "Gym Session",
            subtitle: "Upper body workout",
            isCompleted: false
          })

          HabitItem({
            iconName: $r('app.media.star_icon'), // Placeholder
            title: "Learn Spanish",
            subtitle: "Daily lesson completed",
            isCompleted: false
          })

          HabitItem({
            iconName: $r('app.media.heart_icon'), // Placeholder
            title: "Drink Water",
            subtitle: "2L target",
            isCompleted: false
          })

          // Spacer
          Blank().height(24)

          // -- Inspiration Section --
          Column() {
            Image($r('app.media.check_circle_icon')) // Placeholder
              .width(20)
              .height(20)
              .fillColor(COLORS.textSecondary)
            
            Blank().height(12)
            
            Text("Small steps every day add up to big results over time.")
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor(COLORS.primaryBlack)
              .lineHeight(20)
          }
          .alignItems(HorizontalAlign.Start)
          .width('100%')
          .padding(20)
          .backgroundColor(COLORS.surfaceGray)
          .borderRadius(16)

          // Bottom Spacer
          Blank().height(48)
        }
        .padding({ left: 24, right: 24 })
      }
      .width('100%')
      .height('100%')
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.backgroundWhite)
  }
}

// MARK: - Components

@Component
struct StatsCard {
  build() {
    Row() {
      Column() {
        Text("Overall Progress")
          .fontColor('#B3FFFFFF') // White with 70% opacity approx
          .fontSize(14)
        
        Blank().height(8)
        
        Text("85%")
          .fontColor(Color.White)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
        
        Blank().height(4)
        
        Row() {
          Image($r('app.media.star_icon')) // Placeholder
            .width(16)
            .height(16)
            .fillColor(COLORS.gold)
          
          Blank().width(4)
          
          Text("12 Day Streak!")
            .fontColor(Color.White)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .width('100%')
    }
    .width('100%')
    .height(140)
    .backgroundColor(COLORS.primaryBlack)
    .borderRadius(24)
    .padding(24)
  }
}

@Component
struct HabitItem {
  @Prop iconName: Resource
  @Prop title: string
  @Prop subtitle: string
  @State isCompleted: boolean = false

  build() {
    Row() {
      // Icon Box
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(COLORS.surfaceGray)
        
        Image(this.iconName)
          .width(24)
          .height(24)
          .fillColor(COLORS.primaryBlack)
      }
      .width(48)
      .height(48)

      Blank().width(16)

      // Text Info
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? COLORS.textSecondary : COLORS.primaryBlack)
          .decoration({ type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None, color: COLORS.textSecondary })
        
        Blank().height(2)
        
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(COLORS.textSecondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(8)

      // Checkbox Button
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill(this.isCompleted ? COLORS.accentGreen : Color.Transparent)
          .border({ width: 2, color: this.isCompleted ? COLORS.accentGreen : COLORS.surfaceGray })
        
        if (this.isCompleted) {
          Image($r('app.media.check_icon')) // Placeholder
            .width(18)
            .height(18)
            .fillColor(Color.White)
        }
      }
      .width(32)
      .height(32)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: COLORS.surfaceGray })
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.isCompleted = !this.isCompleted
    })
  }
}