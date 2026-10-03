@Entry
@Component
struct Index {
  @State yourStoryPreview: string = 'Your Story Preview'
  @State uploadStatus: string = 'Upload Status'
  @State syncProgress: number = 0.3
  @State layerType: string = 'layer.type'
  @State layerContent: string = 'layer.content'
  @State storyEditor: string = 'Story Editor'
  @State exitText: string = 'Exit'
  @State postText: string = 'Post'
  @State layerProperties: string = 'Layer Properties'
  @State opacityLabel: string = 'Opacity'
  @State fontSize: number = 24

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === Scaffold Content ===
      Column({ space: 16 }) {
        // === Card (Story Preview) ===
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            Text(this.yourStoryPreview)
              .fontSize(28)
              .fontColor('#FFFFFF')
              .textAlign(TextAlign.Center)
          }
          .width('100%')
          .height('100%')
        }
        .backgroundColor('#D0BCFF') // AppTokens.Colors.tertiary approx
        .borderRadius(12)
        .shadow({ radius: 4, color: '#1A000000' })
        .width('100%')
        .layoutWeight(1)
        .padding(16)

        // === Upload Status Column ===
        Column({ space: 8 }) {
          Text(this.uploadStatus)
            .fontSize(12)
            .fontColor('#607D8B')
          
          Progress({ value: this.syncProgress, total: 1, type: ProgressType.Linear })
            .width('100%')
            .height(4)
            .color('#4CAF50')
            .trackColor('#CFD8DC')
        }
        .width('100%')
        .padding({ left: 16, right: 16 })

        // === LazyRow (Layers) ===
        List({ space: 12 }) {
          ListItem() {
            Column() {
              Column({ space: 8 }) {
                // Box (Icon placeholder)
                Stack({ alignContent: Alignment.Center }) {
                  // Empty box for background
                }
                .width(32)
                .height(32)
                .borderRadius(16)
                .backgroundColor('#CFD8DC')

                Text(this.layerType)
                  .fontSize(12)
                  .fontColor('#1C1B1F')
                
                Text(this.layerContent)
                  .fontSize(14)
                  .fontColor('#49454F')
              }
              .alignItems(HorizontalAlign.Center)
              .padding({ left: 16, right: 16, top: 12, bottom: 12 })
            }
            .backgroundColor('#FFFFFF')
            .borderRadius(12)
            .shadow({ radius: 4, color: '#1A000000' })
            .width(100)
          }
        }
        .listDirection(Axis.Horizontal)
        .width('100%')
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(16)

      // === TopAppBar ===
      Row() {
        Button() {
          Text(this.exitText)
            .fontColor('#1C1B1F')
        }
        .backgroundColor(Color.Transparent)
        .padding({ left: 8, right: 8 })

        Blank()

        Text(this.storyEditor)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1C1B1F')

        Blank()

        Button() {
          Text(this.postText)
            .fontColor('#FFFFFF')
        }
        .backgroundColor('#6750A4') // AppTokens.Colors.primary approx
        .borderRadius(8)
        .padding({ left: 8, right: 8 })
      }
      .width('100%')
      .height(56)
      .backgroundColor('#F4F4F4') // AppTokens.Colors.surface approx
      .justifyContent(FlexAlign.SpaceBetween)
      .alignItems(VerticalAlign.Center)
      .position({ x: 0, y: 0 })

      // === Surface (Layer Properties Bottom Sheet) ===
      Column() {
        Column({ space: 0 }) {
          Text(this.layerProperties)
            .fontSize(12)
            .fontColor('#607D8B')
          
          Blank().height(12)
          
          Row({ space: 0 }) {
            Text(this.opacityLabel)
              .fontSize(14)
              .width(80)
            
            Slider({ value: 50, min: 0, max: 100 })
              .layoutWeight(1)
          }
          .alignItems(VerticalAlign.Center)
        }
        .padding(16)
      }
      .backgroundColor('#FFFFFF')
      .shadow({ radius: 4, color: '#1A000000' })
      .width('100%')
      .position({ x: 0, y: -100 }) // Positioned at bottom roughly
      .borderRadius({ topLeft: 16, topRight: 16 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ECEFF1')
  }
}