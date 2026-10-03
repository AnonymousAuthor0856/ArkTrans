import { BusinessError } from '@kit.BasicServicesKit';

// Define color constants matching the SwiftUI AppTokens
const COLORS = {
  primary: '#FF7042', // rgb(1.0, 0.44, 0.26)
  secondary: '#FFB84D', // rgb(1.0, 0.72, 0.3)
  tertiary: '#FFD180', // rgb(1.0, 0.82, 0.5)
  background: '#FFF2E0', // rgb(1.0, 0.95, 0.88)
  surface: '#FFFFFF',
  surfaceVariant: '#FFE0B2', // rgb(1.0, 0.88, 0.7)
  outline: '#D6CCC8', // rgb(0.84, 0.8, 0.78)
  success: '#66BB6A', // rgb(0.4, 0.73, 0.42)
  warning: '#FFCA28', // rgb(1.0, 0.79, 0.16)
  error: '#D32F2F', // rgb(0.83, 0.18, 0.18)
  onPrimary: '#FFFFFF',
  onSecondary: '#3D2624', // rgb(0.24, 0.15, 0.14)
  onBackground: '#3D2624',
  onSurface: '#3D2624'
};

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42;
  private sliderController: SliderController = new SliderController();

  build() {
    Column() {
      Column() {
        // Title
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(COLORS.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)
          .margin({ bottom: 16 })

        // Order Info Card
        Column() {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLORS.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })

          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontWeight(FontWeight.Regular)
            .fontColor(COLORS.secondary)
            .width('100%')
            .textAlign(TextAlign.Start)
            .margin({ bottom: 10 })

          // Progress Bar (Static visual representation)
          Row() {
            Row()
              .backgroundColor(COLORS.surfaceVariant)
              .borderRadius(5)
              .height(10)
              .width(`${this.progress * 100}%`)
              .linearGradient({
                direction: GradientDirection.Right,
                colors: [[COLORS.primary, 0], [COLORS.primary, 1]]
              })
            
            Row()
              .backgroundColor(COLORS.surfaceVariant)
              .borderRadius(5)
              .height(10)
              .width(`${(1 - this.progress) * 100}%`)
          }
          .width('100%')
          .borderRadius(5)
          .margin({ bottom: 10 })

          // Progress Labels
          Row() {
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLORS.secondary)
            
            Blank()
            
            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLORS.primary)
          }
          .width('100%')
        }
        .padding(16)
        .backgroundColor(COLORS.surface)
        .borderRadius(16)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.15)',
          offsetX: 0,
          offsetY: 4
        })
        .margin({ bottom: 16 })

        // Adjust Progress Card
        Column() {
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(COLORS.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)
            .margin({ bottom: 10 })

          // Custom Slider Implementation
          Slider({
            value: this.progress * 100,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.InSet,
            controller: this.sliderController
          })
            .trackColor(COLORS.surfaceVariant)
            .selectedColor(COLORS.primary)
            .blockColor(COLORS.primary)
            .width('100%')
            .height(20)
            .onChange((value: number) => {
              this.progress = value / 100;
            })
            .margin({ bottom: 10 })

          Button('Mark as Delivered') {
            Text('Mark as Delivered')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(COLORS.onPrimary)
          }
          .type(ButtonType.Normal)
          .backgroundColor(COLORS.primary)
          .borderRadius(10)
          .width('100%')
          .height(40)
          .onClick(() => {
            this.progress = 1.0;
          })
        }
        .padding(16)
        .backgroundColor(COLORS.surface)
        .borderRadius(16)
      }
      .padding(16)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(COLORS.background)
  }
}