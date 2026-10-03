import { window } from '@kit.ArkUI';
import { common, UIAbility, Want } from '@kit.AbilityKit';

@Entry
@Component
struct RootScreen {
  @State markerPosition: { x: number, y: number } = { x: 200, y: 400 };
  @State progress: number = 0.4;

  build() {
    Column() {
      // Top Bar
      Row() {
        Text("Transfer Wizard")
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1E1E1E')
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#FFFBF2')

      // Main Content Area
      Stack({ alignContent: Alignment.Bottom }) {
        // Background Gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            direction: GradientDirection.Top,
            colors: [
              ['#FFC300', 0.2],
              ['#FFFBF2', 0.5],
              ['#FFA500', 0.2]
            ]
          })

        // Canvas Layer
        Canvas(this)
          .width('100%')
          .height('100%')
          .padding({ left: 24, right: 24, top: 24, bottom: 24 })

        // Bottom Controls
        Column() {
          Text("Transfer Progress")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E1E1E')
            .margin({ bottom: 16 })

          // Progress Bar
          Row() {
            Row()
              .width(`${this.progress * 100}%`)
              .height(8)
              .borderRadius(4)
              .backgroundColor('#FFA500')
          }
          .width('80%')
          .height(8)
          .backgroundColor('#FFEED6')
          .borderRadius(4)
          .margin({ bottom: 16 })

          // Buttons
          Row() {
            Button("+")
              .type(ButtonType.Circle)
              .backgroundColor('#FFA500')
              .fontColor('#FFFFFF')
              .onClick(() => {
                this.progress = Math.min(this.progress + 0.1, 1.0);
              })

            Button("-")
              .type(ButtonType.Circle)
              .backgroundColor('#FFC300')
              .fontColor('#1E1E1E')
              .margin({ left: 12 })
              .onClick(() => {
                this.progress = Math.max(this.progress - 0.1, 0.0);
              })
          }
          .justifyContent(FlexAlign.Center)
        }
        .alignItems(HorizontalAlign.Center)
        .padding({ bottom: 32 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFFBF2')
  }

  draw(canvas: Canvas, rect: Rect) {
    const centerX = rect.width / 2;
    const centerY = rect.height / 2;

    // Draw large circle
    canvas.beginPath();
    canvas.arc(centerX, centerY, 260, 0, 2 * Math.PI, false);
    canvas.fillStyle = '#FFEED6';
    canvas.fill();

    // Draw marker
    canvas.beginPath();
    canvas.arc(this.markerPosition.x, this.markerPosition.y, 20, 0, 2 * Math.PI, false);
    canvas.fillStyle = '#FFA500';
    canvas.fill();
  }
}

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: common.AbilityConstant.LaunchParam): void {
    // Hide system bars for immersive experience
    try {
      let windowClass = window.getWindowSync(this.context);
      windowClass.setWindowSystemBarEnable([], {
        statusBarColor: '#FFFBF2',
        navigationBarColor: '#FFFBF2'
      });
    } catch (e) {
      console.error('Failed to set window system bar');
    }
  }

  onDestroy(): void {
  }

  onNewWant(want: Want): void {
  }
}