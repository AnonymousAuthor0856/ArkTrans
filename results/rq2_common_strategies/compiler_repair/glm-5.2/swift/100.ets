// index.ets
interface HabitItemData {
  iconName: ResourceStr;
  title: string;
  subtitle: string;
  isCompleted: boolean;
}

@Entry
@Component
struct HabitTrackerScreen {
  private habits: HabitItemData[] = [
    { iconName: '', title: 'Morning Meditation', subtitle: '15 minutes mindfulness', isCompleted: true },
    { iconName: '', title: 'Gym Session', subtitle: 'Upper body workout', isCompleted: false },
    { iconName: '', title: 'Learn Spanish', subtitle: 'Daily lesson completed', isCompleted: false },
    { iconName: '', title: 'Drink Water', subtitle: '2L target', isCompleted: false }
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // Background
      Column()
        .width('100%')
        .height('100%')
        .backgroundColor('#FFFFFF');

      // Scrollable Content
      Scroll() {
        Column({ space: 0 }) {
          // Top Spacer
          Blank().height(24);

          // -- Top Bar --
          Row() {
            Column() {
              Text('THURSDAY')
                .fontSize(12)
                .fontWeight(FontWeight.Bold)
                .fontColor('#757575')
                .letterSpacing(1);
              Text('Dec 04')
                .fontSize(24)
                .fontWeight(FontWeight.Bolder)
                .fontColor('#121212');
            }
            .alignItems(HorizontalAlign.Start);

            Blank(); // SpaceBetween

            Button({ type: ButtonType.Circle }) {
              Text('⚙️')
                .fontSize(20)
                .fontColor('#121212');
            }
            .width(40)
            .height(40)
            .backgroundColor(Color.Transparent)
            .border({ width: 1, color: '#F5F5F5', radius: 20 });
          }
          .width('100%');

          Blank().height(32);

          // -- Hero Stats Card --
          this.StatsCard();

          Blank().height(32);

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#757575')
            .letterSpacing(1.5)
            .width('100%')
            .textAlign(TextAlign.Start);

          Blank().height(16);

          // -- Habit List --
          ForEach(this.habits, (item: HabitItemData, index: number) => {
            HabitItem({
              iconName: item.iconName,
              title: item.title,
              subtitle: item.subtitle,
              isCompleted: item.isCompleted
            });
          });

          Blank().height(24);

          // -- Inspiration Section --
          Column() {
            Text('✅')
              .fontSize(20)
              .fontColor('#757575');
            
            Blank().height(12);

            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontStyle(FontStyle.Italic)
              .fontColor('#121212')
              .lineHeight(20);
          }
          .padding(20)
          .width('100%')
          .backgroundColor('#F5F5F5')
          .borderRadius(16)
          .alignItems(HorizontalAlign.Start);

          Blank().height(48);
        }
        .padding(24);
      }
      .scrollBar(BarState.Off);
    }
    .width('100%')
    .height('100%');
  }

  @Builder
  StatsCard() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontSize(14)
          .fontColor('rgba(255, 255, 255, 0.7)');
        
        Blank().height(8);

        Text('85%')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF');
        
        Blank().height(4);

        Row() {
          Text('⭐')
            .fontSize(14)
            .fontColor('#FFD700');
          
          Blank().width(4);

          Text('12 Day Streak!')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor('#FFFFFF');
        }
        .alignItems(VerticalAlign.Center);
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1); // fillMaxSize in Row context
    }
    .width('100%')
    .height(140)
    .padding(24)
    .backgroundColor('#121212')
    .borderRadius(24)
    .alignItems(VerticalAlign.Center);
  }
}

@Component
struct HabitItem {
  @Prop iconName: ResourceStr;
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
          .backgroundColor('#F5F5F5')
          .borderRadius(24);
        
        Text('✅')
          .fontSize(24);
      }
      .width(48)
      .height(48);

      Blank().width(16);

      // Text Info
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? '#757575' : '#121212')
          .decoration({
            type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: '#757575'
          });
        
        Blank().height(2);

        Text(this.subtitle)
          .fontSize(12)
          .fontColor('#757575');
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start);

      Blank().width(8);

      // Checkbox Button
      Stack() {
        Column()
          .width(32)
          .height(32)
          .backgroundColor(this.isCompleted ? '#4CAF50' : Color.Transparent)
          .borderRadius(16);
        
        Column()
          .width(32)
          .height(32)
          .border({
            width: 2,
            color: this.isCompleted ? '#4CAF50' : '#F5F5F5',
            radius: 16
          });

        if (this.isCompleted) {
          Text('✔')
            .fontSize(16)
            .fontColor('#FFFFFF');
        }
      }
      .width(32)
      .height(32);
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: '#F5F5F5', radius: 16 })
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.isCompleted = !this.isCompleted;
    });
  }
}