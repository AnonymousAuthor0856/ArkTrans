// index.ets
import { EntryAbility } from '../entryability/EntryAbility'; // Not strictly needed for UI, but good practice
import { common } from '@kit.AbilityKit';

// Colors
const PrimaryBlack: string = '#121212';
const BackgroundWhite: string = '#FFFFFF';
const SurfaceGray: string = '#F5F5F5';
const TextSecondary: string = '#757575';
const AccentGreen: string = '#4CAF50';
const Gold: string = '#FFD700';

interface HabitItemData {
  icon: Resource;
  title: string;
  subtitle: string;
  isCompleted: boolean;
}

@Entry
@Component
struct HabitTrackerScreen {
  @State habits: HabitItemData[] = [
    { icon: $r('sys.symbol.face_smiling'), title: 'Morning Meditation', subtitle: '15 minutes mindfulness', isCompleted: true },
    { icon: $r('sys.symbol.play'), title: 'Gym Session', subtitle: 'Upper body workout', isCompleted: false },
    { icon: $r('sys.symbol.star'), title: 'Learn Spanish', subtitle: 'Daily lesson completed', isCompleted: false },
    { icon: $r('sys.symbol.heart'), title: 'Drink Water', subtitle: '2L target', isCompleted: false }
  ];

  aboutToAppear() {
    // Set immersive mode
    const window = (this.getUIContext().getHostContext() as common.UIAbilityContext).windowStage.getMainWindow();
    window.setWindowSystemBarEnable([]).then(() => {
      window.setWindowSystemBarProperties({
        statusBarColor: '#00000000',
        navigationBarColor: '#00000000'
      });
    });
  }

  build() {
    Scroll() {
      Column() {
        // Top Bar
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
              .fontWeight(900) // Black weight
          }
          .alignItems(HorizontalAlign.Start)

          Button() {
            Image($r('sys.symbol.gearshape'))
              .width(24)
              .height(24)
              .fillColor(PrimaryBlack)
          }
          .width(40)
          .height(40)
          .borderRadius(20)
          .backgroundColor(BackgroundWhite)
          .border({ width: 1, color: SurfaceGray })
          .type(ButtonType.Normal)
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({ top: 24, bottom: 32 })

        // Stats Card
        this.StatsCard()

        // Today's Goals Header
        Text("TODAY'S GOALS")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor(TextSecondary)
          .letterSpacing(1.5)
          .width('100%')
          .margin({ top: 32, bottom: 16 })

        // Habit List
        ForEach(this.habits, (habit: HabitItemData, index: number) => {
          HabitItem({ item: habit, onChange: (val) => this.habits[index].isCompleted = val })
        })

        // Inspiration Section
        Row() {
          Column() {
            Image($r('sys.symbol.checkmark_circle'))
              .width(20)
              .height(20)
              .fillColor(TextSecondary)
              .margin({ bottom: 12 })
            Text('Small steps every day add up to big results over time.')
              .fontSize(14)
              .fontColor(PrimaryBlack)
              .italic(true)
              .lineHeight(20)
          }
        }
        .width('100%')
        .backgroundColor(SurfaceGray)
        .borderRadius(16)
        .padding(20)
        .margin({ top: 24, bottom: 48 })
      }
      .width('100%')
      .padding({ left: 24, right: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(BackgroundWhite)
    .scrollBar(BarState.Off)
  }

  @Builder StatsCard() {
    Row() {
      Column() {
        Text('Overall Progress')
          .fontColor('#B3FFFFFF') // White 70% opacity
          .fontSize(14)
        Text('85%')
          .fontColor('#FFFFFF')
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 8, bottom: 4 })
        Row() {
          Image($r('sys.symbol.star_fill'))
            .width(16)
            .height(16)
            .fillColor(Gold)
          Text('12 Day Streak!')
            .fontColor('#FFFFFF')
            .fontSize(14)
            .fontWeight(FontWeight.Medium)
            .margin({ left: 4 })
        }
      }
      .height('100%')
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height(140)
    .backgroundColor(PrimaryBlack)
    .borderRadius(24)
    .padding(24)
  }
}

@Component
struct HabitItem {
  @Prop item: HabitItemData;
  onChange: (val: boolean) => void = () => {};

  build() {
    Row() {
      // Icon Box
      Row() {
        Image(this.item.icon)
          .width(24)
          .height(24)
          .fillColor(PrimaryBlack)
      }
      .width(48)
      .height(48)
      .backgroundColor(SurfaceGray)
      .borderRadius(24)
      .justifyContent(FlexAlign.Center)

      // Text Info
      Column() {
        Text(this.item.title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.item.isCompleted ? TextSecondary : PrimaryBlack)
          .decoration({
            type: this.item.isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None,
            color: this.item.isCompleted ? TextSecondary : PrimaryBlack
          })
        Text(this.item.subtitle)
          .fontSize(12)
          .fontColor(TextSecondary)
          .margin({ top: 2 })
      }
      .layoutWeight(1)
      .margin({ left: 16 })

      // Checkbox Button
      Row() {
        if (this.item.isCompleted) {
          Image($r('sys.symbol.checkmark'))
            .width(18)
            .height(18)
            .fillColor('#FFFFFF')
        }
      }
      .width(32)
      .height(32)
      .backgroundColor(this.item.isCompleted ? AccentGreen : 'transparent')
      .borderRadius(16)
      .border({
        width: 2,
        color: this.item.isCompleted ? AccentGreen : SurfaceGray
      })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
    .backgroundColor(BackgroundWhite)
    .borderRadius(16)
    .border({ width: 1, color: SurfaceGray })
    .margin({ top: 8, bottom: 8 })
    .onClick(() => {
      this.onChange(!this.item.isCompleted);
    })
  }
}