@Entry
@Component
struct HabitTrackerScreen {
  @State habits: HabitItem[] = [
    new HabitItem('Morning Meditation', '15 minutes mindfulness', true, 'meditation'),
    new HabitItem('Gym Session', 'Upper body workout', false, 'gym'),
    new HabitItem('Learn Spanish', 'Daily lesson completed', false, 'spanish')
  ];

  build() {
    Column() {
      // Main Scrollable Content
      Scroll() {
        Column({ space: 32 }) {
          // Header Section
          this.buildHeader();

          // Stats Card
          this.buildStatsCard();

          // Goals List
          Column() {
            Text("TODAY'S GOALS")
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#757575')
              .letterSpacing(1.5)
              .textAlign(TextAlign.Start)
              .width('100%')
              .margin({ top: 16 })

            ForEach(this.habits, (habit: HabitItem) => {
              this.buildHabitRow(habit)
            }, (item: HabitItem) => item.title)
          }.width('100%')

          // Bottom Spacing
          Blank().height(48)
        }
        .padding({ left: 24, right: 24, top: 24 })
        .width('100%')
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .backgroundColor(Color.White)
    .width('100%')
    .height('100%')
  }

  @Builder
  buildHeader() {
    Row() {
      Column() {
        Text("THURSDAY")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
          .letterSpacing(1)
        
        Text("Dec 04")
          .fontSize(32)
          .fontWeight(FontWeight.Bold)
          .fontColor('#121212')
          .margin({ top: 4 })
      }

      Blank()

      // Settings Icon Button
      Row() {
        Image($r('app.media.settings')) // Placeholder for system icon or custom asset
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor('#121212')
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .border({ width: 1, color: '#F5F5F5' })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
  }

  @Builder
  buildStatsCard() {
    Row() {
      Column() {
        Text("Overall Progress")
          .fontSize(16)
          .fontColor('#B3FFFFFF') // White with alpha
          .margin({ bottom: 8 })
        
        Text("85%")
          .fontSize(56)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .lineHeight(60)
        
        Row() {
          // Star Icon placeholder
          Image($r('app.media.star')) 
            .width(16)
            .height(16)
            .fillColor('#FFD700')
          
          Text("12 Day Streak!")
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(Color.White)
            .margin({ left: 4 })
        }
        .margin({ top: 4 })
      }
    }
    .width('100%')
    .height(140)
    .backgroundColor('#121212')
    .borderRadius(24)
    .padding(24)
  }

  @Builder
  buildHabitRow(habit: HabitItem) {
    Row() {
      // Left Icon Circle
      Row() {
        Image(this.getIconResource(habit.iconType))
          .width(24)
          .height(24)
          .objectFit(ImageFit.Contain)
          .fillColor('#121212')
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor('#F5F5F5')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      Blank().width(16)

      // Text Content
      Column() {
        Text(habit.title)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor(habit.isCompleted ? '#757575' : '#121212')
          .decoration({ type: habit.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None })
          .lineHeight(24)
        
        Text(habit.subtitle)
          .fontSize(14)
          .fontColor('#757575')
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)

      // Right Checkbox
      Row() {
        if (habit.isCompleted) {
           Image($r('app.media.check'))
             .width(18)
             .height(18)
             .fillColor(Color.White)
        }
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(habit.isCompleted ? '#4CAF50' : Color.Transparent)
      .border({ width: 2, color: habit.isCompleted ? '#4CAF50' : '#E0E0E0' })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(Color.White)
    .border({ width: 1, color: '#F0F0F0' })
    .borderRadius(16)
    .onClick(() => {
      habit.isCompleted = !habit.isCompleted;
    })
    .margin({ bottom: 16 })
  }

  getIconResource(type: string): Resource {
    // In a real project, map these to actual media assets
    switch (type) {
      case 'meditation': return $r('app.media.meditation');
      case 'gym': return $r('app.media.gym');
      case 'spanish': return $r('app.media.spanish');
      default: return $r('app.media.default');
    }
  }
}

class HabitItem {
  title: string;
  subtitle: string;
  isCompleted: boolean;
  iconType: string;

  constructor(title: string, subtitle: string, isCompleted: boolean, iconType: string) {
    this.title = title;
    this.subtitle = subtitle;
    this.isCompleted = isCompleted;
    this.iconType = iconType;
  }
}