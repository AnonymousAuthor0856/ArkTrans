// index.ets
import { window } from '@kit.ArkUI';
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct RootScreen {
  @State private scrollOffset: number = 0;
  private context: common.UIAbilityContext = getContext(this) as common.UIAbilityContext;
  private mainWindow: window.Window | null = null;

  aboutToAppear() {
    // Hide status bar for full-screen effect
    window.getLastWindow(this.context).then((win: window.Window) => {
      this.mainWindow = win;
      this.mainWindow.setWindowLayoutFullScreen(true);
    }).catch((err: BusinessError) => {
      console.error(`Failed to get main window. Code:${err.code || 'Unknown'}, message:${err.message}`);
    });
  }

  build() {
    Column() {
      // Top Bar
      Text("Glass Doc Reader")
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#1E1E1E')
        .padding({ top: 20, bottom: 16 })
        .width('100%')
        .textAlign(TextAlign.Center)
        .backgroundColor('#F1F5F9')

      // Main Content Area
      Stack({ alignContent: Alignment.Center }) {
        // Background Gradient
        Column()
          .width('100%')
          .height('100%')
          .linearGradient({
            angle: 90,
            colors: [
              ['#E2E8F0', 0.8],
              ['#F1F5F9', 0.5],
              ['#E2E8F0', 0.8]
            ]
          })

        // Glass Surface Card
        Column({ space: 12 }) {
          Text("Document Reader")
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#38BDF8')

          ForEach([1, 2, 3, 4, 5, 6, 7, 8], (index: number) => {
            Text(`This is a sample line of text content number ${index}.`)
              .fontSize(14)
              .fontColor('#1E1E1E')
              .lineHeight(24)
          })
          
          // Spacer to push content up if needed, though fixed height handles layout
          Blank().layoutWeight(1)
        }
        .padding(16)
        .width('90%')
        .height(400)
        .backgroundColor(Color.White.withAlpha(0.7))
        .borderRadius(20)
        .shadow({
          radius: 8,
          color: '#0000002D', // ~0.18 opacity black
          offsetX: 0,
          offsetY: 4
        })
        .translate({ y: this.scrollOffset / 5 })
        .gesture(
          PanGesture()
            .onActionUpdate((event?: GestureEvent) => {
              if (event) {
                this.scrollOffset += event.offsetY;
              }
            })
        )
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F5F9')
    .systemBarProperties({ statusBarColor: '#F1F5F9' })
  }
}