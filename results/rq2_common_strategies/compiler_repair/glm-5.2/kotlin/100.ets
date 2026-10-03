import window from '@ohos.window';

@Entry
@Component
struct HabitTrackerScreen {
  @State checked1: boolean = true;
  @State checked2: boolean = false;
  @State checked3: boolean = false;
  @State checked4: boolean = false;

  aboutToAppear() {
    window.getLastWindow(this.getUIContext().getHostContext())
      .then((win) => {
        win.setWindowLayoutFullScreen(true);
        win.setWindowSystemBarProperties({
          statusBarColor: '#00000000',
          navigationBarColor: '#00000000',
          isStatusBarLightIcon: false,
          isNavigationBarLightIcon: false
        });
      })
      .catch((err: Error) => {
        console.error('Failed to set fullscreen: ' + JSON.stringify(err));
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
              .fontColor('#757575')
              .fontWeight(FontWeight.Bold)
              .letterSpacing(1)
            Text('Dec 04')
              .fontSize(24)
              .fontColor('#121212')
              .fontWeight(FontWeight.Bold)
          }
          .alignItems(HorizontalAlign.Start)

          Button() {
            Image($r('sys.media.ohos_ic_public_settings'))
              .width(24)
              .height(24)
              .fillColor('#121212')
          }
          .type(ButtonType.Circle)
          .width(40)
          .height(40)
          .backgroundColor(Color.White)
          .border({ width: 1, color: '#F5F5F5', radius: 20 })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)

        Blank().height(32)

        // Hero Stats Card
        Row() {
          Column() {
            Text('Overall Progress')
              .fontSize(14)
              .fontColor(Color.White)
              .opacity(0.7)
            Blank().height(8)
            Text('85%')
              .fontSize(48)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Bold)
            Blank().height(4)
            Row() {
              Image($r('sys.media.ohos_ic_public_star_filled'))
                .width(16)
                .height(16)
                .fillColor('#FFD700')
              Blank().width(4)
              Text('12 Day Streak!')
                .fontSize(14)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Medium)
            }
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
        .width('100%')
        .height(140)
        .padding(24)
        .backgroundColor('#121212')
        .borderRadius(24)
        .alignItems(VerticalAlign.Center)

        Blank().height(32)

        Text("TODAY'S GOALS")
          .fontSize(12)
          .fontWeight(FontWeight.Bold)
          .fontColor('#757575')
          .letterSpacing(1.5)
          .width('100%')

        Blank().height(16)

        // Habit List
        this.HabitItem('sys.media.ohos_ic_public_contacts', 'Morning Meditation', '15 minutes mindfulness', this.checked1, (val: boolean) => { this.checked1 = val; })
        this.HabitItem('sys.media.ohos_ic_public_play', 'Gym Session', 'Upper body workout', this.checked2, (val: boolean) => { this.checked2 = val; })
        this.HabitItem('sys.media.ohos_ic_public_star_filled', 'Learn Spanish', 'Daily lesson completed', this.checked3, (val: boolean) => { this.checked3 = val; })
        this.HabitItem('sys.media.ohos_ic_public_heart', 'Drink Water', '2L target', this.checked4, (val: boolean) => { this.checked4 = val; })

        Blank().height(24)

        // Inspiration Section
        Column() {
          Image($r('sys.media.ohos_ic_public_check_circle_filled'))
            .width(20)
            .height(20)
            .fillColor('#757575')
          Blank().height(12)
          Text('Small steps every day add up to big results over time.')
            .fontSize(14)
            .fontColor('#121212')
            .fontStyle(FontStyle.Italic)
            .lineHeight(20)
        }
        .width('100%')
        .padding(20)
        .backgroundColor('#F5F5F5')
        .borderRadius(16)
        .alignItems(HorizontalAlign.Start)

        Blank().height(48)
      }
      .width('100%')
      .padding(24)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Color.White)
    .scrollBar(BarState.Off)
  }

  @Builder
  HabitItem(iconRes: string, title: string, subtitle: string, isCompleted: boolean, onChange: (val: boolean) => void) {
    Row() {
      // Icon Box
      Column() {
        Image($r(iconRes))
          .width(24)
          .height(24)
          .fillColor('#121212')
      }
      .width(48)
      .height(48)
      .backgroundColor('#F5F5F5')
      .borderRadius(24)
      .justifyContent(FlexAlign.Center)

      Blank().width(16)

      // Text Info
      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor(isCompleted ? '#757575' : '#121212')
          .decoration({ type: isCompleted ? TextDecorationType.LineThrough : TextDecorationType.None })
        Blank().height(2)
        Text(subtitle)
          .fontSize(12)
          .fontColor('#757575')
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)

      Blank().width(8)

      // Checkbox Button
      Column() {
        if (isCompleted) {
          Image($r('sys.media.ohos_ic_public_check'))
            .width(18)
            .height(18)
            .fillColor(Color.White)
        }
      }
      .width(32)
      .height(32)
      .backgroundColor(isCompleted ? '#4CAF50' : Color.Transparent)
      .borderRadius(16)
      .border({ width: 2, color: isCompleted ? '#4CAF50' : '#F5F5F5' })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .padding(16)
    .margin({ top: 4, bottom: 4 })
    .backgroundColor(Color.White)
    .borderRadius(16)
    .border({ width: 1, color: '#F5F5F5', radius: 16 })
    .alignItems(VerticalAlign.Center)
    .onClick(() => {
      onChange(!isCompleted);
    })
  }
}