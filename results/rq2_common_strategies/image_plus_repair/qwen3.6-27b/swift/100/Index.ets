// src/main/ets/components/HabitItem.ets
import { Image, ImageFit } from '@kit.ArkUI';

@Component
export struct HabitItem {
  @Prop iconName: string;
  @Prop title: string;
  @Prop subtitle: string;
  @State isCompleted: boolean = false;

  build() {
    Row() {
      // Icon Box
      Stack() {
        Circle()
          .fill('#F5F5F5')
        
        Image(this.iconName)
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .opacity(this.isCompleted ? 0.5 : 1.0)
      }
      .width(48)
      .height(48)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? '#757575' : '#121212')
          .decoration({ type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None, color: '#757575' })
          .margin({ bottom: 2 })
        
        Text(this.subtitle)
          .fontSize(12)
          .fontColor('#757575')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Checkbox Button
      Stack() {
        if (this.isCompleted) {
          Circle()
            .fill('#4CAF50')
          
          Image($r('app.media.ic_check')) // Assuming a check icon exists, or use path
            .width(18)
            .height(18)
            .fillColor(Color.White)
        } else {
          Circle()
            .stroke('#F5F5F5')
            .strokeWidth(2)
        }
      }
      .width(32)
      .height(32)
    }
    .padding(16)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#F5F5F5', radius: 16 })
    .onClick(() => {
      this.isCompleted = !this.isCompleted;
    })
  }
}

// src/main/ets/components/StatsCard.ets
import { Image } from '@kit.ArkUI';

@Component
export struct StatsCard {
  build() {
    Column() {
      Text("Overall Progress")
        .fontColor('#B3FFFFFF') // White with opacity
        .fontSize(14)
        .margin({ bottom: 8 })
      
      Text("85%")
        .fontColor(Color.White)
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 4 })
      
      Row() {
        Image($r('app.media.ic_star')) // Assuming star icon
          .width(16)
          .height(16)
          .fillColor('#FFD700') // Gold
          .margin({ right: 4 })
        
        Text("12 Day Streak!")
          .fontColor(Color.White)
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
      }
      .alignItems(VerticalAlign.Center)
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .height(140)
    .padding(24)
    .backgroundColor('#121212')
    .borderRadius(24)
  }
}

// src/main/ets/pages/Index.ets
import { router } from '@kit.ArkUI';
import { SystemBarMode } from '@kit.ArkUI';
import { Image } from '@kit.ArkUI';
import { HabitItem } from '../components/HabitItem';
import { StatsCard } from '../components/StatsCard';

@Entry
@Component
struct Index {
  build() {
    Column() {
      Scroll() {
        Column() {
          // Top Bar
          Row() {
            Column() {
              Text("THURSDAY")
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(1)
                .fontColor('#757575')
              
              Text("Dec 04")
                .fontSize(24)
                .fontWeight(FontWeight.Bold)
                .fontColor('#121212')
            }
            .alignItems(HorizontalAlign.Start)
            
            Blank()
            
            // Settings Button
            Row() {
              Image($r('app.media.ic_settings')) // Assuming settings icon
                .width(24)
                .height(24)
                .fillColor('#121212')
            }
            .width(40)
            .height(40)
            .justifyContent(FlexAlign.Center)
            .alignItems(VerticalAlign.Center)
            .border({ width: 1, color: '#F5F5F5', radius: 20 })
          }
          .width('100%')
          .margin({ bottom: 32 })

          // Hero Stats Card
          StatsCard()
            .margin({ bottom: 32 })

          // Today's Goals Header
          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1.5)
            .fontColor('#757575')
            .margin({ bottom: 16 })

          // Habit List
          HabitItem({
            iconName: $r('app.media.ic_face'), // Placeholder for face icon
            title: "Morning Meditation",
            subtitle: "15 minutes mindfulness",
            isCompleted: true
          })
          .margin({ bottom: 16 })

          HabitItem({
            iconName: $r('app.media.ic_play'), // Placeholder for play icon
            title: "Gym Session",
            subtitle: "Upper body workout",
            isCompleted: false
          })
          .margin({ bottom: 16 })

          HabitItem({
            iconName: $r('app.media.ic_star'), // Placeholder for star icon
            title: "Learn Spanish",
            subtitle: "Daily lesson completed",
            isCompleted: false
          })
          .margin({ bottom: 16 })

          HabitItem({
            iconName: $r('app.media.ic_heart'), // Placeholder for heart icon
            title: "Drink Water",
            subtitle: "2L target",
            isCompleted: false
          })
          .margin({ bottom: 24 })

          // Inspiration Section
          Column() {
            Image($r('app.media.ic_check_circle')) // Placeholder for check circle icon
              .width(20)
              .height(20)
              .fillColor('#757575')
              .margin({ bottom: 12 })
            
            Text("Small steps every day add up to big results over time.")
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor('#121212')
              .lineHeight(20)
          }
          .alignItems(HorizontalAlign.Start)
          .padding(20)
          .width('100%')
          .backgroundColor('#F5F5F5')
          .borderRadius(16)
          
          // Bottom Spacer
          Blank().height(48)
        }
        .padding(24)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .systemBar({ statusBarMode: SystemBarMode.Custom, statusBarColor: Color.Transparent })
  }
}