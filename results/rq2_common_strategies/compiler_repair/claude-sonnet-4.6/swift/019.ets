import { router } from '@kit.ArkUI';

@Entry
@Component
struct RootScreen {
  @State fontSize: number = 23.0;
  @State syncProgress: number = 0.3;

  build() {
    Column() {
      // Navigation Bar equivalent
      Row() {
        Text('Subtitle Editor')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor('#FF1E1E1E')
          .textAlign(TextAlign.Center)
          .width('100%')
      }
      .width('100%')
      .height(56)
      .backgroundColor('#FFF9F5FF')
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .padding({ left: 16, right: 16 })

      // Main content area with gradient background
      Column({ space: 24 }) {

        // Surface card with subtitle text
        Column() {
          Text('Sample Subtitle Line')
            .fontSize(this.fontSize)
            .fontColor('#FF1E1E1E')
            .textAlign(TextAlign.Center)
            .width('100%')
            .height('100%')
        }
        .width('100%')
        .height(200)
        .backgroundColor('#FFFFFFFF')
        .borderRadius(22)
        .justifyContent(FlexAlign.Center)
        .alignItems(HorizontalAlign.Center)
        .shadow({
          radius: 8,
          color: '#2E000000',
          offsetX: 0,
          offsetY: 6
        })

        // Font size label
        Text(`Font Size: ${Math.round(this.fontSize)}sp`)
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#FF1E1E1E')
          .width('100%')

        // Slider for font size
        Column() {
          Slider({
            value: this.fontSize,
            min: 16,
            max: 48,
            style: SliderStyle.OutSet
          })
            .trackColor('#FFE3D7FE')
            .selectedColor('#FF8B5CF6')
            .width('100%')
            .onChange((value: number) => {
              this.fontSize = value;
            })
        }
        .width('100%')

        // Sync Progress label
        Text('Sync Progress')
          .fontSize(14)
          .fontWeight(FontWeight.Normal)
          .fontColor('#FF1E1E1E')
          .width('100%')

        // Progress bar
        Column() {
          Progress({
            value: this.syncProgress * 100,
            total: 100,
            type: ProgressType.Linear
          })
            .color('#FF8B5CF6')
            .backgroundColor('#FFF1E9FE')
            .width('100%')
            .height(6)
        }
        .width('100%')
        .height(6)
        .borderRadius(3)
        .clip(true)

        // Buttons row
        Row({ space: 12 }) {
          // Sync + Button
          Button() {
            Text('Sync +')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFFFF')
          }
          .width('50%')
          .height(48)
          .backgroundColor('#FF8B5CF6')
          .borderRadius(14)
          .onClick(() => {
            this.syncProgress = Math.min(this.syncProgress + 0.1, 1.0);
          })

          // Sync - Button
          Button() {
            Text('Sync -')
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFFFF')
          }
          .width('50%')
          .height(48)
          .backgroundColor('#FFD946EF')
          .borderRadius(14)
          .onClick(() => {
            this.syncProgress = Math.max(this.syncProgress - 0.1, 0.0);
          })
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

      }
      .padding(16)
      .width('100%')
      .layoutWeight(1)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#FFF1E9FE', 0.0],
          ['#FFF9F5FF', 0.5],
          ['#FFFFFFFF', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#FFF9F5FF')
  }
}