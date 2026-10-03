// Colors
const primaryBlack = '#121212';
const backgroundWhite = '#FFFFFF';
const surfaceGray = '#F5F5F5';
const textSecondary = '#757575';
const accentGreen = '#4CAF50';
const gold = '#FFD700';

@Entry
@Component
struct HabitTrackerScreen {
  build() {
    Stack() {
      Scroll() {
        Column() {
          Blank().height(24)

          // Top Bar
          Row() {
            Column() {
              Text('THURSDAY')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .letterSpacing(1)
                .fontColor(textSecondary)
              Text('Dec 04')
                .fontSize(24)
                .fontWeight(FontWeight.Bolder)
                .fontColor(primaryBlack)
            }
            .alignItems(HorizontalAlign.Start)

            Blank()

            Stack() {
              Text('⚙')
                .fontSize(20)
                .fontColor(primaryBlack)
            }
            .width(40)
            .height(40)
            .border({ width: 1, color: surfaceGray, radius: 20 })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          StatsCard()

          Blank().height(32)

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1.5)
            .fontColor(textSecondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          Blank().height(16)

          HabitItem({
            iconType: 'smile',
            title: 'Morning Meditation',
            subtitle: '15 minutes mindfulness',
            isCompleted: true
          })

          HabitItem({
            iconType: 'play',
            title: 'Gym Session',
            subtitle: 'Upper body workout',
            isCompleted: false
          })

          HabitItem({
            iconType: 'star',
            title: 'Learn Spanish',
            subtitle: 'Daily lesson completed',
            isCompleted: false
          })

          HabitItem({
            iconType: 'heart',
            title: 'Drink Water',
            subtitle: '2L target',
            isCompleted: false
          })

          Blank().height(24)

          // Inspiration Section
          Column() {
            Text('✔')
              .fontSize(20)
              .fontColor(textSecondary)
            Blank().height(12)
            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor(primaryBlack)
              .lineHeight(20)
              .width('100%')
          }
          .alignItems(HorizontalAlign.Start)
          .padding(20)
          .width('100%')
          .backgroundColor(surfaceGray)
          .borderRadius(16)

          Blank().height(48)
        }
        .padding(24)
        .width('100%')
        .alignItems(HorizontalAlign.Center)
      }
      .scrollBar(BarState.Off)
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundWhite)
  }
}

@Component
struct StatsCard {
  build() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontColor('#B3FFFFFF')
          .fontSize(14)
        Blank().height(8)
        Text('85%')
          .fontColor(Color.White)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
        Blank().height(4)
        Row() {
          Text('★')
            .fontSize(16)
            .fontColor(gold)
          Blank().width(4)
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
    .width('100%')
    .height(140)
    .backgroundColor(primaryBlack)
    .borderRadius(24)
    .padding(24)
    .alignItems(VerticalAlign.Center)
  }
}

@Component
struct HabitItem {
  @Prop iconType: string = 'star';
  @Prop title: string = '';
  @Prop subtitle: string = '';
  @State isCompleted: boolean = false;

  getIconSymbol(): string {
    if (this.iconType === 'smile') {
      return '😊';
    } else if (this.iconType === 'play') {
      return '▶';
    } else if (this.iconType === 'star') {
      return '★';
    } else if (this.iconType === 'heart') {
      return '♥';
    } else {
      return '●';
    }
  }

  build() {
    Row() {
      // Icon Circle
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(surfaceGray)
        Text(this.getIconSymbol())
          .fontSize(20)
          .fontColor(primaryBlack)
      }
      .width(48)
      .height(48)

      Blank().width(16)

      // Text Info
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? textSecondary : primaryBlack)
          .decoration({
            type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: textSecondary
          })
          .width('100%')
        Blank().height(2)
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(textSecondary)
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(8)

      // Checkbox
      Stack() {
        Circle()
          .width(32)
          .height(32)
          .fill(this.isCompleted ? accentGreen : Color.Transparent)
          .border({
            width: 2,
            color: this.isCompleted ? accentGreen : surfaceGray,
            radius: 16
          })
        if (this.isCompleted) {
          Text('✓')
            .fontSize(16)
            .fontColor(Color.White)
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(32)
      .height(32)
    }
    .padding(16)
    .width('100%')
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: surfaceGray, radius: 16 })
    .margin({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.isCompleted = !this.isCompleted;
    })
  }
}