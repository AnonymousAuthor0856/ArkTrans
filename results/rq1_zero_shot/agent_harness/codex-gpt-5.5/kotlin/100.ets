class HabitGoal {
  icon: string;
  title: string;
  subtitle: string;
  completed: boolean;

  constructor(icon: string, title: string, subtitle: string, completed: boolean) {
    this.icon = icon;
    this.title = title;
    this.subtitle = subtitle;
    this.completed = completed;
  }
}

@Entry
@Component
struct MainActivity {
  @State private habits: HabitGoal[] = [
    new HabitGoal('☺', 'Morning Meditation', '15 minutes mindfulness', true),
    new HabitGoal('▶', 'Gym Session', 'Upper body workout', false),
    new HabitGoal('★', 'Learn Spanish', 'Daily lesson completed', false),
    new HabitGoal('♥', 'Drink Water', '2L target', false)
  ];

  @Builder
  StatsCard() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontSize(14)
          .fontColor('#B8B8B8')
        Text('85%')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .margin({ top: 8 })
        Row() {
          Text('★')
            .fontSize(16)
            .fontColor('#FFD700')
          Text('12 Day Streak!')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF')
            .margin({ left: 4 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ top: 4 })
      }
      .justifyContent(FlexAlign.Center)
      .layoutWeight(1)
    }
    .width('100%')
    .height(140)
    .padding(24)
    .backgroundColor('#121212')
    .borderRadius(24)
  }

  private toggleHabit(index: number): void {
    const updated: HabitGoal[] = this.habits.slice();
    const habit = updated[index];
    updated[index] = new HabitGoal(habit.icon, habit.title, habit.subtitle, !habit.completed);
    this.habits = updated;
  }

  @Builder
  HabitItem(habit: HabitGoal, index: number) {
    Row() {
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill('#F5F5F5')
        Text(habit.icon)
          .fontSize(24)
          .fontColor('#121212')
      }
      .width(48)
      .height(48)
      .margin({ right: 16 })

      Column() {
        Text(habit.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(habit.completed ? '#757575' : '#121212')
          .decoration({ type: habit.completed ? TextDecorationType.LineThrough : TextDecorationType.None })
        Text(habit.subtitle)
          .fontSize(12)
          .fontColor('#757575')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill(habit.completed ? '#4CAF50' : Color.Transparent)
          .stroke(habit.completed ? '#4CAF50' : '#F5F5F5')
          .strokeWidth(2)
        if (habit.completed) {
          Text('✓')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
        }
      }
      .width(32)
      .height(32)
      .margin({ left: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .border({ width: 1, color: '#F5F5F5', radius: 16 })
    .borderRadius(16)
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.toggleHabit(index);
    })
  }

  @Builder
  InspirationCard() {
    Column() {
      Text('✓')
        .fontSize(20)
        .fontColor('#757575')
      Text('Small steps every day add up to big results over time.')
        .fontSize(14)
        .fontStyle(FontStyle.Italic)
        .fontColor('#121212')
        .lineHeight(20)
        .margin({ top: 12 })
    }
    .alignItems(HorizontalAlign.Start)
    .width('100%')
    .padding(20)
    .backgroundColor('#F5F5F5')
    .borderRadius(16)
  }

  build() {
    Scroll() {
      Column() {
        Blank()
          .height(24)

        Row() {
          Column() {
            Text('THURSDAY')
              .fontSize(12)
              .fontWeight(FontWeight.Bold)
              .fontColor('#757575')
              .letterSpacing(1)
            Text('Dec 04')
              .fontSize(24)
              .fontWeight(FontWeight.Black)
              .fontColor('#121212')
          }
          .alignItems(HorizontalAlign.Start)
          .layoutWeight(1)

          Button('⚙')
            .fontSize(20)
            .fontColor('#121212')
            .backgroundColor('#FFFFFF')
            .width(40)
            .height(40)
            .border({ width: 1, color: '#F5F5F5', radius: 20 })
            .borderRadius(20)
        }
        .width('100%')
        .alignItems(VerticalAlign.Center)
        .justifyContent(FlexAlign.SpaceBetween)

        this.StatsCard()
          .margin({ top: 32 })

        Text("TODAY'S GOALS")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
          .letterSpacing(1.5)
          .width('100%')
          .margin({ top: 32, bottom: 8 })

        ForEach(this.habits, (habit: HabitGoal, index: number) => {
          this.HabitItem(habit, index)
        }, (habit: HabitGoal) => habit.title)

        this.InspirationCard()
          .margin({ top: 24 })

        Blank()
          .height(48)
      }
      .width('100%')
      .padding(24)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFFFF')
  }
}
