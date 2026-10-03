import { Activity, Window, Color } from '@ohos/arkui';
import { UIAbility } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';

@Entry
@Component
struct HabitTrackerScreen {
  @State private checkedStates: boolean[] = [true, false, false, false];

  build() {
    Column() {
      Scroll() {
        Column({ space: 0 }) {
          // Top Bar
          Row() {
            Column({ space: 4 }) {
              Text('THURSDAY')
                .fontSize(12)
                .fontColor('#757575')
                .fontWeight(FontWeight.Bold)
                .letterSpacing(1)
              Text('Dec 04')
                .fontSize(24)
                .fontColor('#121212')
                .fontWeight(FontWeight.Black)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button({ type: ButtonType.Circle, stateEffect: true }) {
              Text('⚙')
                .fontSize(20)
                .fontColor('#121212')
            }
            .width(40)
            .height(40)
            .backgroundColor(Color.Transparent)
            .border({ width: 1, color: '#F5F5F5', radius: 20 })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          // Stats Card
          Row() {
            Column({ space: 8 }) {
              Text('Overall Progress')
                .fontSize(14)
                .fontColor('#B3FFFFFF')
              Text('85%')
                .fontSize(48)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.White)
              Row({ space: 4 }) {
                Text('★')
                  .fontSize(16)
                  .fontColor('#FFD700')
                Text('12 Day Streak!')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(Color.White)
              }
              .alignItems(VerticalAlign.Center)
            }
            .alignItems(HorizontalAlign.Start)
            .justifyContent(FlexAlign.Center)
            .height('100%')
          }
          .width('100%')
          .height(140)
          .padding(24)
          .backgroundColor('#121212')
          .borderRadius(24)
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#757575')
            .letterSpacing(1.5)
            .width('100%')

          Blank().height(16)

          // Habit Items
          this.HabitItem('😊', 'Morning Meditation', '15 minutes mindfulness', 0)
          this.HabitItem('▶', 'Gym Session', 'Upper body workout', 1)
          this.HabitItem('★', 'Learn Spanish', 'Daily lesson completed', 2)
          this.HabitItem('❤', 'Drink Water', '2L target', 3)

          Blank().height(24)

          // Inspiration Section
          Column({ space: 12 }) {
            Text('✓')
              .fontSize(20)
              .fontColor('#757575')
            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontColor('#121212')
              .fontStyle(FontStyle.Italic)
              .lineHeight(20)
          }
          .width('100%')
          .padding(20)
          .backgroundColor('#F5F5F5')
          .borderRadius(16)
          .alignItems(HorizontalAlign.Start)

          Blank().height(48)
        }
        .width('100%')
        .padding({ left: 24, right: 24, top: 24, bottom: 24 })
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .height('100%')
      .scrollable(ScrollDirection.Vertical)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }

  @Builder
  HabitItem(icon: string, title: string, subtitle: string, index: number) {
    Row({ space: 16 }) {
      // Icon Box
      Column() {
        Text(icon)
          .fontSize(24)
          .fontColor('#121212')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

      // Text Info
      Column({ space: 2 }) {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checkedStates[index] ? '#757575' : '#121212')
          .decoration({ type: this.checkedStates[index] ? TextDecorationType.LineThrough : TextDecorationType.None })
        Text(subtitle)
          .fontSize(12)
          .fontColor('#757575')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      // Checkbox Button
      Column() {
        if (this.checkedStates[index]) {
          Text('✓')
            .fontSize(18)
            .fontColor(Color.White)
        }
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(this.checkedStates[index] ? '#4CAF50' : Color.Transparent)
      .border({ width: 2, color: this.checkedStates[index] ? '#4CAF50' : '#F5F5F5', radius: 16 })
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#F5F5F5', radius: 16 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.checkedStates[index] = !this.checkedStates[index];
    })
  }
}

@Entry
@Component
struct MainPage {
  build() {
    HabitTrackerScreen()
  }
}