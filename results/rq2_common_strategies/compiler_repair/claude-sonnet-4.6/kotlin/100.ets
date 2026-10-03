import { router } from '@kit.ArkUI';

const PrimaryBlack = '#121212';
const BackgroundWhite = '#FFFFFF';
const SurfaceGray = '#F5F5F5';
const TextSecondary = '#757575';
const AccentGreen = '#4CAF50';

interface HabitData {
  icon: Resource;
  title: string;
  subtitle: string;
  isCompleted: boolean;
}

@Entry
@Component
struct HabitTrackerScreen {
  @State habitList: HabitData[] = [
    { icon: $r('app.media.startIcon'), title: 'Morning Meditation', subtitle: '15 minutes mindfulness', isCompleted: true },
    { icon: $r('app.media.startIcon'), title: 'Gym Session', subtitle: 'Upper body workout', isCompleted: false },
    { icon: $r('app.media.startIcon'), title: 'Learn Spanish', subtitle: 'Daily lesson completed', isCompleted: false },
    { icon: $r('app.media.startIcon'), title: 'Drink Water', subtitle: '2L target', isCompleted: false },
  ];
  @State checkedStates: boolean[] = [true, false, false, false];

  build() {
    Scroll() {
      Column({ space: 0 }) {
        // Top Bar
        Row() {
          Column({ space: 2 }) {
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
          .alignItems(HorizontalAlign.Start)

          Button({ type: ButtonType.Circle }) {
            Text('⚙')
              .fontSize(18)
              .fontColor(PrimaryBlack)
          }
          .width(40)
          .height(40)
          .backgroundColor(BackgroundWhite)
          .border({ width: 1, color: SurfaceGray, radius: 20 })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .margin({ top: 24, bottom: 32 })

        // Stats Card
        Row() {
          Column({ space: 0 }) {
            Text('Overall Progress')
              .fontColor('rgba(255,255,255,0.7)')
              .fontSize(14)
            Text('85%')
              .fontColor('#FFFFFF')
              .fontSize(48)
              .fontWeight(FontWeight.Bold)
              .margin({ top: 8 })
            Row({ space: 4 }) {
              Text('★')
                .fontSize(16)
                .fontColor('#FFD700')
              Text('12 Day Streak!')
                .fontColor('#FFFFFF')
                .fontSize(14)
                .fontWeight(FontWeight.Medium)
            }
            .alignItems(VerticalAlign.Center)
            .margin({ top: 4 })
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
        .margin({ bottom: 32 })

        // Section Title
        Text("TODAY'S GOALS")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextSecondary)
          .letterSpacing(1.5)
          .width('100%')
          .margin({ bottom: 16 })

        // Habit Items
        ForEach(this.habitList, (item: HabitData, index: number) => {
          HabitItemComponent({
            icon: item.icon,
            title: item.title,
            subtitle: item.subtitle,
            isCompleted: this.checkedStates[index],
            onToggle: () => {
              let newStates = [...this.checkedStates];
              newStates[index] = !newStates[index];
              this.checkedStates = newStates;
            }
          })
        })

        // Inspiration Box
        Column({ space: 0 }) {
          Text('✓')
            .fontSize(20)
            .fontColor(TextSecondary)
          Text('Small steps every day add up to big results over time.')
            .fontSize(14)
            .fontColor(PrimaryBlack)
            .fontStyle(FontStyle.Italic)
            .lineHeight(20)
            .margin({ top: 12 })
        }
        .alignItems(HorizontalAlign.Start)
        .width('100%')
        .backgroundColor(SurfaceGray)
        .borderRadius(16)
        .padding(20)
        .margin({ top: 24, bottom: 48 })
      }
      .padding({ left: 24, right: 24 })
      .width('100%')
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
  }
}

@Component
struct HabitItemComponent {
  @Prop icon: Resource;
  @Prop title: string = '';
  @Prop subtitle: string = '';
  @Prop isCompleted: boolean = false;
  onToggle: () => void = () => {};

  build() {
    Row({ space: 0 }) {
      // Icon Box
      Row() {
        Text(this.getIconText())
          .fontSize(22)
          .fontColor(PrimaryBlack)
      }
      .width(48)
      .height(48)
      .borderRadius(24)
      .backgroundColor(SurfaceGray)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

      // Text Info
      Column({ space: 2 }) {
        Text(this.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isCompleted ? TextSecondary : PrimaryBlack)
          .decoration(this.isCompleted ? { type: TextDecorationType.LineThrough } : { type: TextDecorationType.None })
        Text(this.subtitle)
          .fontSize(12)
          .fontColor(TextSecondary)
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 16 })

      // Checkbox
      Row() {
        if (this.isCompleted) {
          Text('✓')
            .fontSize(14)
            .fontColor('#FFFFFF')
            .fontWeight(FontWeight.Bold)
        }
      }
      .width(32)
      .height(32)
      .borderRadius(16)
      .backgroundColor(this.isCompleted ? AccentGreen : 'transparent')
      .border({ width: 2, color: this.isCompleted ? AccentGreen : SurfaceGray, radius: 16 })
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .margin({ left: 8 })
    }
    .width('100%')
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(16)
    .border({ width: 1, color: SurfaceGray, radius: 16 })
    .margin({ top: 8, bottom: 8 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      this.onToggle();
    })
  }

  getIconText(): string {
    if (this.title === 'Morning Meditation') return '😊';
    if (this.title === 'Gym Session') return '▶';
    if (this.title === 'Learn Spanish') return '★';
    if (this.title === 'Drink Water') return '♥';
    return '●';
  }
}