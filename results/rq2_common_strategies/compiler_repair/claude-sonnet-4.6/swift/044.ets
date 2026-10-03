// App Tokens
class ColorsClass {
  primary: string = '#FF7043';
  secondary: string = '#FFB84D';
  tertiary: string = '#FFD180';
  background: string = '#FFF3E0';
  surface: string = '#FFFFFF';
  surfaceVariant: string = '#FFE0B2';
  outline: string = '#D6CCC7';
  success: string = '#66BB6A';
  warning: string = '#FFCA28';
  error: string = '#D42E2E';
  onPrimary: string = '#FFFFFF';
  onSecondary: string = '#3D2623';
  onBackground: string = '#3D2623';
  onSurface: string = '#3D2623';
}

class SpacingClass {
  sm: number = 6;
  md: number = 10;
  lg: number = 16;
  xl: number = 24;
}

class ShapesClass {
  small: number = 6;
  medium: number = 10;
  large: number = 16;
}

const Colors = new ColorsClass();
const Spacing = new SpacingClass();
const Shapes = new ShapesClass();

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.42;
  @State sliderValue: number = 42;

  build() {
    Stack() {
      // Background
      Column() {}
      .width('100%')
      .height('100%')
      .backgroundColor(Colors.background)

      // Main content
      Column({ space: Spacing.lg }) {
        // Title
        Text('Order Tracking')
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground)
          .width('100%')
          .textAlign(TextAlign.Start)

        // Order Info Card
        Column({ space: Spacing.md }) {
          Text('Order #25491')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Start)

          Text('Estimated Delivery: 2 days')
            .fontSize(14)
            .fontWeight(FontWeight.Normal)
            .fontColor(Colors.secondary)
            .width('100%')
            .textAlign(TextAlign.Start)

          // Progress Bar
          Stack({ alignContent: Alignment.Start }) {
            // Inactive track
            Row() {}
            .width('100%')
            .height(10)
            .borderRadius(5)
            .backgroundColor(Colors.surfaceVariant)

            // Active track
            Row() {}
            .width(`${this.progress * 100}%`)
            .height(10)
            .borderRadius(5)
            .backgroundColor(Colors.primary)
          }
          .width('100%')
          .height(10)

          // Progress text row
          Row() {
            Text('Processing')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.secondary)

            Blank()

            Text(`${Math.round(this.progress * 100)}%`)
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor(Colors.primary)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .padding(Spacing.lg)
        .width('100%')
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.large)
        .shadow({
          radius: 8,
          color: '#26000000',
          offsetX: 0,
          offsetY: 4,
        })

        // Adjust Progress Card
        Column({ space: Spacing.md }) {
          Text('Adjust Progress')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onSurface)
            .width('100%')
            .textAlign(TextAlign.Center)

          // Custom Slider
          Slider({
            value: this.sliderValue,
            min: 0,
            max: 100,
            step: 1,
            style: SliderStyle.OutSet,
          })
            .width('100%')
            .trackThickness(10)
            .selectedColor(Colors.primary)
            .trackColor(Colors.surfaceVariant)
            .blockColor(Colors.primary)
            .onChange((value: number) => {
              this.sliderValue = value;
              this.progress = value / 100;
            })

          // Mark as Delivered Button
          Button('Mark as Delivered')
            .fontSize(12)
            .fontWeight(FontWeight.Medium)
            .fontColor(Colors.onPrimary)
            .width('100%')
            .height(40)
            .backgroundColor(Colors.primary)
            .borderRadius(Shapes.medium)
            .onClick(() => {
              this.progress = 1.0;
              this.sliderValue = 100;
            })
        }
        .padding(Spacing.lg)
        .width('100%')
        .backgroundColor(Colors.surface)
        .borderRadius(Shapes.large)
        .shadow({
          radius: 8,
          color: '#26000000',
          offsetX: 0,
          offsetY: 4,
        })
      }
      .padding(Spacing.lg)
      .width('100%')
      .alignItems(HorizontalAlign.Start)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background)
  }
}