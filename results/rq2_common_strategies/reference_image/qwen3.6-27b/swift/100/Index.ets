// src/main/ets/components/HabitItem.ets
import { BusinessError } from '@kit.BasicServicesKit';

export interface HabitData {
  id: number;
  title: string;
  subtitle: string;
  iconSrc: string; // In a real app, this would be a resource ID or path
  isCompleted: boolean;
}

@Component
export struct HabitItem {
  @Prop habit: HabitData = {
    id: 0,
    title: '',
    subtitle: '',
    iconSrc: '',
    isCompleted: false
  };
  
  // Local state to handle the toggle interaction
  @State isChecked: boolean = this.habit.isCompleted;

  build() {
    Row() {
      // Icon Container
      Row() {
        Image(this.habit.iconSrc)
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
      .justifyContent(FlexAlign.Center)

      Column() {
        Text(this.habit.title)
          .fontColor(this.isChecked ? '#757575' : '#121212')
          .fontWeight(FontWeight.Bold)
          .fontSize(16)
          .decorationType(this.isChecked ? TextDecorationType.LineThrough : TextDecorationType.None)
          .decorationColor('#757575')
        
        Text(this.habit.subtitle)
          .fontColor('#757575')
          .fontSize(12)
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // Checkbox
      Row() {
        if (this.isChecked) {
          Image($r('app.media.ic_check')) // Placeholder for checkmark icon
            .width(18)
            .height(18)
            .fillColor(Color.White)
        }
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .border({ width: 2, color: this.isChecked ? '#4CAF50' : '#E0E0E0' })
      .backgroundColor(this.isChecked ? '#4CAF50' : Color.Transparent)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.isChecked = !this.isChecked;
      })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#F5F5F5' })
    .margin({ bottom: 16 })
  }
}

// src/main/ets/pages/Index.ets
import { HabitItem, HabitData } from '../components/HabitItem';

@Entry
@Component
struct Index {
  @State habits: HabitData[] = [
    { 
      id: 1, 
      title: 'Morning Meditation', 
      subtitle: '15 minutes mindfulness', 
      iconSrc: $r('app.media.ic_face'), // Placeholder
      isCompleted: true 
    },
    { 
      id: 2, 
      title: 'Gym Session', 
      subtitle: 'Upper body workout', 
      iconSrc: $r('app.media.ic_play'), // Placeholder
      isCompleted: false 
    },
    { 
      id: 3, 
      title: 'Learn Spanish', 
      subtitle: 'Daily lesson completed', 
      iconSrc: $r('app.media.ic_star'), // Placeholder
      isCompleted: false 
    }
  ];

  build() {
    Column() {
      Column() {
        // Top Bar
        Row() {
          Column() {
            Text("THURSDAY")
              .fontColor('#757575')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
            
            Text("Dec 04")
              .fontColor('#121212')
              .fontSize(24)
              .fontWeight(FontWeight.Black)
          }
          .alignItems(HorizontalAlign.Start)

          Row() {
            Image($r('app.media.ic_settings')) // Placeholder
              .width(24)
              .height(24)
              .fillColor('#121212')
          }
          .width(40)
          .height(40)
          .borderRadius(20)
          .border({ width: 1, color: '#F5F5F5' })
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .margin({ top: 24, bottom: 32 })

        // Hero Stats Card
        Row() {
          Column() {
            Text("Overall Progress")
              .fontColor('#B3FFFFFF') // White with opacity
              .fontSize(14)
            
            Text("85%")
              .fontColor(Color.White)
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 8, bottom: 4 })
            
            Row() {
              Image($r('app.media.ic_star_filled')) // Placeholder
                .width(16)
                .height(16)
                .fillColor('#FFD700') // Gold
            
              Text("12 Day Streak!")
                .fontColor(Color.White)
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
                .margin({ left: 4 })
            }
          }
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height(140)
        .padding(24)
        .backgroundColor('#121212')
        .borderRadius(24)
        .margin({ bottom: 32 })

        // Section Header
        Text("TODAY'S GOALS")
          .fontColor('#757575')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1.5)
          .margin({ bottom: 16 })

        // List of Habits
        ForEach(this.habits, (item: HabitData) => {
          HabitItem({ habit: item })
        })

        // Inspiration Box
        Row() {
          Column() {
            Image($r('app.media.ic_check_circle')) // Placeholder
              .width(20)
              .height(20)
              .fillColor('#757575')
            
            Text("Small steps every day add up to big results over time.")
              .fontColor('#121212')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .lineHeight(20)
              .margin({ top: 12 })
          }
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
        .margin({ top: 24, bottom: 48 })

      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
  }
}