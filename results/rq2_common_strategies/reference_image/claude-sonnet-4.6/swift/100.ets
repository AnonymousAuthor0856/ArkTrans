// HabitTrackerScreen.ets
// SwiftUI habit tracker -> ArkUI (ArkTS) declarative port.

const PRIMARY_BLACK: string = '#121212';
const BACKGROUND_WHITE: string = '#FFFFFF';
const SURFACE_GRAY: string = '#F5F5F5';
const TEXT_SECONDARY: string = '#757575';
const ACCENT_GREEN: string = '#4CAF50';
const GOLD: string = '#FFD700';
const WHITE_70: string = '#B3FFFFFF';

@Observed
class HabitItemData {
  icon: string;
  title: string;
  subtitle: string;
  isCompleted: boolean;

  constructor(icon: string, title: string, subtitle: string, isCompleted: boolean) {
    this.icon = icon;
    this.title = title;
    this.subtitle = subtitle;
    this.isCompleted = isCompleted;
  }
}

@Entry
@Component
struct HabitTrackerScreen {
  @State habits: HabitItemData[] = [
    new HabitItemData('☺', 'Morning Meditation', '15 minutes mindfulness', true),
    new HabitItemData('▶', 'Gym Session', 'Upper body workout', false),
    new HabitItemData('★', 'Learn Spanish', 'Daily lesson completed', false),
    new HabitItemData('♥', 'Drink Water', '2L target', false)
  ];

  build() {
    Column() {
      Scroll() {
        Column() {
          // Spacer(24)
          Row().height(24)

          // -- Top bar --
          this.TopBar()

          // Spacer(32)
          Row().height(32)

          // -- Hero stats card --
          StatsCard()

          // Spacer(32)
          Row().height(32)

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .letterSpacing(1.5)
            .fontColor(TEXT_SECONDARY)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Spacer(16)
          Row().height(16)

          // -- Habit list --
          ForEach(this.habits, (item: HabitItemData) => {
            HabitItem({ item: item })
          }, (item: HabitItemData) => item.title)

          // Spacer(24)
          Row().height(24)

          // -- Inspiration section --
          this.Inspiration()

          // Spacer(48)
          Row().height(48)
        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollBar(BarState.Off)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BACKGROUND_WHITE)
  }

  @Builder
  TopBar() {
    Row() {
      Column() {
        Text('THURSDAY')
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .letterSpacing(1)
          .fontColor(TEXT_SECONDARY)
        Text('Dec 04')
          .fontSize(24)
          .fontWeight(FontWeight.Black)
          .fontColor(PRIMARY_BLACK)
      }
      .alignItems(HorizontalAlign.Start)

      Blank()

      Stack() {
        Text('⚙')
          .fontSize(22)
          .fontColor(PRIMARY_BLACK)
      }
      .width(40)
      .height(40)
      .borderRadius(20)
      .border({ width: 1, color: SURFACE_GRAY })
      .onClick(() => {
        // no op
      })
    }
    .width('100%')
    .alignItems(VerticalAlign.Center)
  }

  @Builder
  Inspiration() {
    Column() {
      Stack() {
        Circle()
          .width(20)
          .height(20)
          .fill(Color.Transparent)
          .stroke(TEXT_SECONDARY)
          .strokeWidth(2)
        Text('✓')
          .fontSize(12)
          .fontColor(TEXT_SECONDARY)
      }
      .width(20)
      .height(20)

      Row().height(12)

      Text('Small steps every day add up to big results over time.')
        .fontSize(14)
        .fontStyle(FontStyle.Italic)
        .fontColor(PRIMARY_BLACK)
        .lineHeight(20)
        .width('100%')
    }
    .width('100%')
    .padding(20)
    .alignItems(HorizontalAlign.Start)
    .backgroundColor(SURFACE_GRAY)
    .borderRadius(16)
  }
}

@Component
struct StatsCard {
  build() {
    Column() {
      Text('Overall Progress')
        .fontSize(14)
        .fontColor(WHITE_70)

      Row().height(8)

      Text('85%')
        .fontSize(48)
        .fontWeight(FontWeight.Bold)
        .fontColor(Color.White)

      Row().height(4)

      Row() {
        Text('★')
          .fontSize(16)
          .fontColor(GOLD)
        Row().width(4)
        Text('12 Day Streak!')
          .fontSize(14)
          .fontWeight(FontWeight.Medium)
          .fontColor(Color.White)
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .height(140)
    .padding(24)
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.Center)
    .backgroundColor(PRIMARY_BLACK)
    .borderRadius(24)
    .margin({ top: 24, bottom: 24, left: 24, right: 24 })
  }
}

@Component
struct HabitItem {
  @ObjectLink item: HabitItemData;

  build() {
    Row() {
      // -- Icon box --
      Stack() {
        Circle()
          .width(48)
          .height(48)
          .fill(SURFACE_GRAY)
        Text(this.item.icon)
          .fontSize(22)
          .fontColor(PRIMARY_BLACK)
      }
      .width(48)
      .height(48)

      Row().width(16)

      // -- Text info --
      Column() {
        Text(this.item.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.item.isCompleted ? TEXT_SECONDARY : PRIMARY_BLACK)
          .decoration({
            type: this.item.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: TEXT_SECONDARY
          })
        Row().height(2)
        Text(this.item.subtitle)
          .fontSize(12)
          .fontColor(TEXT_SECONDARY)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      Row().width(8)

      // -- Checkbox button --
      Stack() {
        if (this.item.isCompleted) {
          Text('✓')
            .fontSize(16)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
        }
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(this.item.isCompleted ? ACCENT_GREEN : Color.Transparent)
      .border({ width: 2, color: this.item.isCompleted ? ACCENT_GREEN : SURFACE_GRAY })
      .onClick(() => {
        this.item.isCompleted = !this.item.isCompleted;
        this.habits = this.habits.slice();
      })
    }
    .width('100%')
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: SURFACE_GRAY })
    .margin({ top: 8, bottom: 8 })
  }
}