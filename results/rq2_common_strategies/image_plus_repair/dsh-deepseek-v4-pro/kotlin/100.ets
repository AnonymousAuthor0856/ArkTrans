// ArkTS (ArkUI) translation of Kotlin/Compose HabitTrackerScreen
// File 100.kt -> 100.ets

const PrimaryBlack: string = '#121212';
const BackgroundWhite: string = '#FFFFFF';
const SurfaceGray: string = '#F5F5F5';
const TextSecondary: string = '#757575';
const AccentGreen: string = '#4CAF50';
const Gold: string = '#FFD700';
const WhiteColor: string = '#FFFFFF';
const Transparent: string = '#00FFFFFF';
const White70: string = 'rgba(255, 255, 255, 0.7)';

@Entry
@Component
struct HabitTrackerPage {
  @Builder
  StatsCard() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontSize(14)
          .fontColor(White70)
        Blank().height(8)
        Text('85%')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(WhiteColor)
        Blank().height(4)
        Row() {
          Text('★')
            .fontSize(16)
            .fontColor(Gold)
          Blank().width(4)
          Text('12 Day Streak!')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .fontColor(WhiteColor)
        }
        .alignItems(VerticalAlign.Center)
      }
      .layoutWeight(1)
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height(140)
    .backgroundColor(PrimaryBlack)
    .borderRadius(24)
    .padding(24)
    .alignItems(VerticalAlign.Center)
  }

  build() {
    Column() {
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
                .fontWeight(FontWeight.Bolder)
            }
            Stack() {
              Text('⚙')
                .fontSize(20)
                .fontColor(PrimaryBlack)
            }
            .width(40)
            .height(40)
            .border({ width: 1, color: SurfaceGray })
            .borderRadius(20)
            .alignContent(Alignment.Center)
            .onClick(() => {
              // No op
            })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)

          Blank().height(32)

          // -- Hero Stats Card --
          this.StatsCard()

          Blank().height(32)

          Text("TODAY'S GOALS")
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor(TextSecondary)
            .letterSpacing(1.5)
            .width('100%')

          Blank().height(16)

          // -- Habit List --
          HabitItemView({ icon: '🙂', title: 'Morning Meditation', subtitle: '15 minutes mindfulness', isCompleted: true })
          HabitItemView({ icon: '▶', title: 'Gym Session', subtitle: 'Upper body workout', isCompleted: false })
          HabitItemView({ icon: '★', title: 'Learn Spanish', subtitle: 'Daily lesson completed', isCompleted: false })
          HabitItemView({ icon: '♥', title: 'Drink Water', subtitle: '2L target', isCompleted: false })

          Blank().height(24)

          // -- Inspiration Section --
          Stack() {
            Column() {
              Text('✓')
                .fontSize(20)
                .fontColor(TextSecondary)
              Blank().height(12)
              Text('Small steps every day add up to big results over time.')
                .fontSize(14)
                .fontColor(PrimaryBlack)
                .fontStyle(FontStyle.Italic)
                .lineHeight(20)
            }
            .alignItems(HorizontalAlign.Start)
          }
          .width('100%')
          .backgroundColor(SurfaceGray)
          .borderRadius(16)
          .padding(20)

          Blank().height(48)
        }
        .width('100%')
        .padding(24)
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .layoutWeight(1)
      .scrollable(ScrollDirection.Vertical)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
  }
}

@Component
struct HabitItemView {
  icon: string = '';
  title: string = '';
  subtitle: string = '';
  @Prop isCompleted: boolean = false;

  build() {
    Row() {
      // Icon Box
      Stack() {
        Text(this.icon)
          .fontSize(24)
          .fontColor(PrimaryBlack)
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
          .fontColor(this.isCompleted ? TextSecondary : PrimaryBlack)
          .decoration({
            type: this.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: this.isCompleted ? TextSecondary : PrimaryBlack
          })
        Blank().height(2)
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(TextSecondary)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank().width(8)

      // Checkbox Button
      Stack() {
        if (this.isCompleted) {
          Text('✓')
            .fontSize(18)
            .fontColor(WhiteColor)
        }
      }
      .width(32)
      .height(32)
      .backgroundColor(this.isCompleted ? AccentGreen : Transparent)
      .borderRadius(16)
      .border({ width: 2, color: this.isCompleted ? AccentGreen : SurfaceGray })
      .alignContent(Alignment.Center)
    }
    .width('100%')
    .margin({ top: 8, bottom: 8 })
    .backgroundColor(WhiteColor)
    .borderRadius(16)
    .border({ width: 1, color: SurfaceGray })
    .padding(16)
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.isCompleted = !this.isCompleted
    })
  }
}
