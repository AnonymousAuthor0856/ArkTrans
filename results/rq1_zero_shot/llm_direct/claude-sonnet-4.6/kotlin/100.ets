import { router } from '@kit.ArkUI';

// -----------------------------------------------------------------------------------
// UI Constants & Colors
// -----------------------------------------------------------------------------------

const PrimaryBlack: string = '#FF121212';
const BackgroundWhite: string = '#FFFFFFFF';
const SurfaceGray: string = '#FFF5F5F5';
const TextSecondary: string = '#FF757575';
const AccentGreen: string = '#FF4CAF50';
const GoldColor: string = '#FFFFD700';

// -----------------------------------------------------------------------------------
// Habit Data Model
// -----------------------------------------------------------------------------------

interface HabitData {
  icon: Resource;
  title: string;
  subtitle: string;
  isCompleted: boolean;
}

// -----------------------------------------------------------------------------------
// StatsCard Component
// -----------------------------------------------------------------------------------

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
          Image($r('app.media.ic_star'))
            .width(16)
            .height(16)
            .fillColor(GoldColor)

          Blank().width(4)

          Text('12 Day Streak!')
            .fontColor(Color.White)
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
        }
        .alignItems(VerticalAlign.Center)
      }
      .alignItems(HorizontalAlign.Start)
      .justifyContent(FlexAlign.Center)
      .width('100%')
    }
    .width('100%')
    .height(140)
    .backgroundColor(PrimaryBlack)
    .borderRadius(24)
    .padding(24)
    .justifyContent(FlexAlign.SpaceBetween)
    .alignItems(VerticalAlign.Center)
  }
}

// -----------------------------------------------------------------------------------
// HabitItem Component
// -----------------------------------------------------------------------------------

@Component
struct HabitItem {
  @Prop icon: Resource;
  @Prop title: string = '';
  @Prop subtitle: string = '';
  @Prop initialCompleted: boolean = false;
  @State checked: boolean = false;

  aboutToAppear() {
    this.checked = this.initialCompleted;
  }

  build() {
    Row() {
      // Icon Box
      Stack() {
        Image(this.icon)
          .width(24)
          .height(24)
          .fillColor(PrimaryBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(SurfaceGray)
      .borderRadius(24)
      .alignContent(Alignment.Center)

      Blank().width(16)

      // Text Info
      Column() {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.checked ? TextSecondary : PrimaryBlack)
          .decoration(this.checked
            ? { type: TextDecorationType.LineThrough }
            : { type: TextDecorationType.None })

        Blank().height(2)

        Text(this.subtitle)
          .fontSize(12)
          .fontColor(TextSecondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Blank().width(8)

      // Checkbox
      Stack() {
        if (this.checked) {
          Image($r('app.media.ic_check'))
            .width(18)
            .height(18)
            .fillColor(Color.White)
        }
      }
      .width(32)
      .height(32)
      .backgroundColor(this.checked ? AccentGreen : Color.Transparent)
      .borderRadius(16)
      .border({
        width: 2,
        color: this.checked ? AccentGreen : SurfaceGray,
        style: BorderStyle.Solid
      })
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .padding({ top: 8, bottom: 8 })
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: SurfaceGray, style: BorderStyle.Solid })
    .alignItems(VerticalAlign.Center)
    .padding(16)
    .onClick(() => {
      this.checked = !this.checked;
    })
    .margin({ top: 4, bottom: 4 })
  }
}

// -----------------------------------------------------------------------------------
// Main Screen
// -----------------------------------------------------------------------------------

@Entry
@Component
struct HabitTrackerScreen {
  private habits: HabitData[] = [
    {
      icon: $r('app.media.ic_face'),
      title: 'Morning Meditation',
      subtitle: '15 minutes mindfulness',
      isCompleted: true
    },
    {
      icon: $r('app.media.ic_play_arrow'),
      title: 'Gym Session',
      subtitle: 'Upper body workout',
      isCompleted: false
    },
    {
      icon: $r('app.media.ic_star'),
      title: 'Learn Spanish',
      subtitle: 'Daily lesson completed',
      isCompleted: false
    },
    {
      icon: $r('app.media.ic_favorite'),
      title: 'Drink Water',
      subtitle: '2L target',
      isCompleted: false
    }
  ];

  build() {
    Scroll() {
      Column() {
        Blank().height(24)

        // -- Top Bar --
        Row() {
          Column() {
            Text('THURSDAY')
              .fontSize(12)
              .fontColor(TextSecondary)
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)

            Text('Dec 04')
              .fontSize(24)
              .fontColor(PrimaryBlack)
              .fontWeight(FontWeight.Bold)
          }
          .alignItems(HorizontalAlign.Start)

          // Settings Button
          Stack() {
            Image($r('app.media.ic_settings'))
              .width(20)
              .height(20)
              .fillColor(PrimaryBlack)
          }
          .width(40)
          .height(40)
          .borderRadius(20)
          .border({ width: 1, color: SurfaceGray, style: BorderStyle.Solid })
          .alignContent(Alignment.Center)
          .onClick(() => {})
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(32)

        // -- Hero Stats Card --
        StatsCard()

        Blank().height(32)

        // -- Section Title --
        Text("TODAY'S GOALS")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextSecondary)
          .letterSpacing(1.5)
          .width('100%')

        Blank().height(16)

        // -- Habit List --
        ForEach(this.habits, (habit: HabitData) => {
          HabitItem({
            icon: habit.icon,
            title: habit.title,
            subtitle: habit.subtitle,
            initialCompleted: habit.isCompleted
          })
        })

        Blank().height(24)

        // -- Inspiration Section --
        Column() {
          Image($r('app.media.ic_check_circle'))
            .width(20)
            .height(20)
            .fillColor(TextSecondary)

          Blank().height(12)

          Text('Small steps every day add up to big results over time.')
            .fontSize(14)
            .fontColor(PrimaryBlack)
            .fontStyle(FontStyle.Italic)
            .lineHeight(20)
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .backgroundColor(SurfaceGray)
        .borderRadius(16)
        .padding(20)

        Blank().height(48)
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
    .scrollBar(BarState.Off)
  }
}