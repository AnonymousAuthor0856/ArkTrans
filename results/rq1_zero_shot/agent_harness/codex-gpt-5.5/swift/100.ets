const HABIT_PRIMARY_BLACK: string = '#121212';
const HABIT_BACKGROUND_WHITE: string = '#FFFFFF';
const HABIT_SURFACE_GRAY: string = '#F5F5F5';
const HABIT_TEXT_SECONDARY: string = '#757575';
const HABIT_ACCENT_GREEN: string = '#4CAF50';
const HABIT_GOLD: string = '#FFD700';

@Entry
@Component
struct HabitTrackerScreen {
  build() {
    Stack() {
      Scroll() {
        Column() {
          Blank()
            .height(24)

          Row() {
            Column() {
              Text('THURSDAY')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(1)
                .fontColor(HABIT_TEXT_SECONDARY)

              Text('Dec 04')
                .fontSize(24)
                .fontWeight(FontWeight.Black)
                .fontColor(HABIT_PRIMARY_BLACK)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Button() {
              Text('⚙')
                .fontSize(24)
                .fontColor(HABIT_PRIMARY_BLACK)
            }
            .width(40)
            .height(40)
            .type(ButtonType.Circle)
            .backgroundColor(Color.Transparent)
            .border({ width: 1, color: HABIT_SURFACE_GRAY })
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')

          Blank()
            .height(32)

          StatsCard()

          Blank()
            .height(32)

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1.5)
            .fontColor(HABIT_TEXT_SECONDARY)
            .width('100%')

          Blank()
            .height(16)

          HabitItem({ iconName: '☺', title: 'Morning Meditation', subtitle: '15 minutes mindfulness', initialCompleted: true })
          HabitItem({ iconName: '▶', title: 'Gym Session', subtitle: 'Upper body workout', initialCompleted: false })
          HabitItem({ iconName: '★', title: 'Learn Spanish', subtitle: 'Daily lesson completed', initialCompleted: false })
          HabitItem({ iconName: '♥', title: 'Drink Water', subtitle: '2L target', initialCompleted: false })

          Blank()
            .height(24)

          Column() {
            Text('✓')
              .fontSize(20)
              .fontColor(HABIT_TEXT_SECONDARY)

            Blank()
              .height(12)

            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor(HABIT_PRIMARY_BLACK)
              .lineHeight(20)
          }
          .alignItems(HorizontalAlign.Start)
          .padding(20)
          .width('100%')
          .backgroundColor(HABIT_SURFACE_GRAY)
          .borderRadius(16)

          Blank()
            .height(48)
        }
        .alignItems(HorizontalAlign.Center)
        .padding(24)
        .width('100%')
      }
      .scrollBar(BarState.Off)
    }
    .backgroundColor(HABIT_BACKGROUND_WHITE)
    .width('100%')
    .height('100%')
  }
}

@Component
struct StatsCard {
  build() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontColor('#B8B8B8')
          .fontSize(14)

        Blank()
          .height(8)

        Text('85%')
          .fontColor(Color.White)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)

        Blank()
          .height(4)

        Row() {
          Text('★')
            .fontSize(16)
            .fontColor(HABIT_GOLD)

          Blank()
            .width(4)

          Text('12 Day Streak!')
            .fontColor(Color.White)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
    }
    .alignItems(VerticalAlign.Center)
    .height(140)
    .width('100%')
    .backgroundColor(HABIT_PRIMARY_BLACK)
    .borderRadius(24)
    .padding(24)
  }
}

@Component
struct HabitItem {
  @Prop iconName: string;
  @Prop title: string;
  @Prop subtitle: string;
  @Prop initialCompleted: boolean;
  @State isCompleted: boolean = false;

  aboutToAppear() {
    this.isCompleted = this.initialCompleted;
  }

  build() {
    Row() {
      Stack() {
        Circle()
          .fill(HABIT_SURFACE_GRAY)
          .width(48)
          .height(48)

        Text(this.iconName)
          .fontSize(24)
          .fontColor(HABIT_PRIMARY_BLACK)
      }
      .width(48)
      .height(48)

      Blank()
        .width(16)

      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? HABIT_TEXT_SECONDARY : HABIT_PRIMARY_BLACK)
          .decoration({ type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None, color: HABIT_TEXT_SECONDARY })

        Blank()
          .height(2)

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(HABIT_TEXT_SECONDARY)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank()
        .width(8)

      Stack() {
        Circle()
          .fill(this.isCompleted ? HABIT_ACCENT_GREEN : Color.Transparent)
          .stroke(this.isCompleted ? HABIT_ACCENT_GREEN : HABIT_SURFACE_GRAY)
          .strokeWidth(2)
          .width(32)
          .height(32)

        if (this.isCompleted) {
          Text('✓')
            .fontSize(18)
            .fontColor(Color.White)
        }
      }
      .width(32)
      .height(32)
    }
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: HABIT_SURFACE_GRAY })
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.isCompleted = !this.isCompleted;
    })
  }
}
