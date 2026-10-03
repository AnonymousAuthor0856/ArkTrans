@Entry
@Component
struct HabitTrackerScreen {
  @State habits: Array<HabitData> = [
    { id: 1, title: 'Morning Meditation', subtitle: '15 minutes mindfulness', icon: $r('app.media.startIcon'), isCompleted: true },
    { id: 2, title: 'Gym Session', subtitle: 'Upper body workout', icon: $r('app.media.startIcon'), isCompleted: false },
    { id: 3, title: 'Learn Spanish', subtitle: 'Daily lesson completed', icon: $r('app.media.startIcon'), isCompleted: false },
    { id: 4, title: 'Drink Water', subtitle: '2L target', icon: $r('app.media.startIcon'), isCompleted: false }
  ]

  build() {
    Column() {
      // === Top Bar ===
      Row() {
        Column() {
          Text('THURSDAY')
            .fontSize(12)
            .fontColor('#757575')
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1)
          Text('Dec 04')
            .fontSize(24)
            .fontColor('#121212')
            .fontWeight(FontWeight.Bold)
        }
        Blank()
        Image($r('app.media.startIcon'))
          .width(40)
          .height(40)
          .borderRadius(20)
          .border({ width: 1, color: '#F5F5F5' })
          .objectFit(ImageFit.Contain)
          .aspectRatio(1)
      }
      .width('100%')
      .margin({ top: 24 })

      // === Hero Stats Card ===
      Column() {
        Text('Overall Progress')
          .fontColor('#B3FFFFFF')
          .fontSize(14)
        Text('85%')
          .fontColor('#FFF')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 8 })
        Row() {
          Image($r('app.media.startIcon'))
            .width(16)
            .height(16)
            .fillColor('#FFD700')
          Text('12 Day Streak!')
            .fontColor('#FFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ left: 4 })
        }.margin({ top: 4 })
      }
      .width('100%')
      .height(140)
      .backgroundColor('#121212')
      .borderRadius(24)
      .padding(24)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .margin({ top: 32 })

      // === Section Header ===
      Text("TODAY'S GOALS")
        .fontSize(12)
        .fontWeight(FontWeight.Bold)
        .fontColor('#757575')
        .letterSpacing(1.5)
        .width('100%')
        .margin({ top: 32 })

      // === Habit List ===
      Column() {
        ForEach(this.habits, (habit: HabitData) => {
          this.HabitItemComponent(habit)
        })
      }.margin({ top: 16 })

      // === Inspiration Section ===
      Column() {
        Image($r('app.media.startIcon'))
          .width(20)
          .height(20)
          .fillColor('#757575')
        Text("Small steps every day add up to big results over time.")
          .fontSize(14)
          .fontColor('#121212')
          .fontStyle(FontStyle.Italic)
          .lineHeight(20)
          .margin({ top: 12 })
      }
      .width('100%')
      .backgroundColor('#F5F5F5')
      .borderRadius(16)
      .padding(20)
      .margin({ top: 24 })

      Blank().height(48)
    }
    .width('100%')
    .height('100%')
    .padding(24)
    .backgroundColor('#FFF')
  }

  @Builder
  HabitItemComponent(habit: HabitData) {
    Row() {
      // Icon Box
      Image($r('app.media.startIcon'))
        .width(48)
        .height(48)
        .borderRadius(24)
        .backgroundColor('#F5F5F5')
        .objectFit(ImageFit.Contain)
        .aspectRatio(1)

      // Text Info
      Column() {
        Text(habit.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(habit.isCompleted ? '#757575' : '#121212')
          .decoration({ type: habit.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None })
        Text(habit.subtitle)
          .fontSize(12)
          .fontColor('#757575')
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .margin({ left: 16 })

      // Checkbox Button
      Stack() {
        if (habit.isCompleted) {
          Image($r('app.media.startIcon'))
            .width(18)
            .height(18)
            .fillColor('#FFF')
        }
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(habit.isCompleted ? '#4CAF50' : Color.Transparent)
      .border({ width: 2, color: habit.isCompleted ? '#4CAF50' : '#F5F5F5' })
      .margin({ left: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFF')
    .borderRadius(16)
    .border({ width: 1, color: '#F5F5F5' })
    .margin({ bottom: 16 })
    .onClick(() => {
      const index = this.habits.findIndex(item => item.id === habit.id);
      if (index !== -1) {
        this.habits[index].isCompleted = !this.habits[index].isCompleted;
      }
    })
  }
}

interface HabitData {
  id: number;
  title: string;
  subtitle: string;
  icon: Resource;
  isCompleted: boolean;
}