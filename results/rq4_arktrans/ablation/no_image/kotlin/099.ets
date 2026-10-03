@Entry
@Component
struct Index {
  @State MATCHA_RITUAL: string = 'MATCHA RITUAL'
  @State fontSize14: number = 14
  @State Ceremonial_Grade: string = 'Ceremonial Grade'
  @State fontSize28: number = 28
  @State h_0_42f: string = ''
  @State h_0_15f: string = ''
  @State h_0_3f: string = ''
  @State h_0_25f: string = ''
  @State h_0_1f: string = ''
  @State label: string = 'label'
  @State fontSize10: number = 10
  @State value: string = 'value'
  @State fontSize16: number = 16
  @State Sift_2g_of_matcha_powder: string = 'Sift 2g of matcha powder.'
  @State number: string = 'number'
  @State fontSize12: number = 12
  @State text: string = 'text'
  @State Add_hot_water_Whisk_in_M_shape: string = "Add hot water. Whisk in 'M' shape."
  @State START_TIMER: string = 'START TIMER'

  build() {
    Stack() {
      Column({ space: 0 }) {
        // === Column (Header) ===
        Column({ space: 0 }) {
          Blank().height(48)
          Text(this.MATCHA_RITUAL)
            .fontSize(this.fontSize14)
            .letterSpacing(4)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.Gray)
          Blank().height(8)
          Text(this.Ceremonial_Grade)
            .fontSize(this.fontSize28)
            .fontWeight(FontWeight.Normal)
            .fontColor(Color.Black)
        }.alignItems(HorizontalAlign.Center)

        // === Column (Bowl & Info) ===
        Column({ space: 0 }) {
          // MatchaBowlCanvas placeholder
          Canvas()
            .width(160)
            .height(160)
            .backgroundColor('#E0E0E0') // Placeholder for visual structure

          Blank().height(40)

          Row({ space: 0 }) {
            // InfoItem 1
            Column({ space: 0 }) {
              Text('TEMP')
                .fontSize(this.fontSize10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#D3D3D3')
              Blank().height(4)
              Text('80°C')
                .fontSize(this.fontSize16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
            }.alignItems(HorizontalAlign.Center)

            // InfoItem 2
            Column({ space: 0 }) {
              Text('WATER')
                .fontSize(this.fontSize10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#D3D3D3')
              Blank().height(4)
              Text('70ml')
                .fontSize(this.fontSize16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
            }.alignItems(HorizontalAlign.Center)

            // InfoItem 3
            Column({ space: 0 }) {
              Text('BAMBOO')
                .fontSize(this.fontSize10)
                .fontWeight(FontWeight.Bold)
                .fontColor('#D3D3D3')
              Blank().height(4)
              Text('Whisk')
                .fontSize(this.fontSize16)
                .fontWeight(FontWeight.Medium)
                .fontColor(Color.Black)
            }.alignItems(HorizontalAlign.Center)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceEvenly)
        }.alignItems(HorizontalAlign.Center)

        // === Column (Steps & Button) ===
        Column({ space: 0 }) {
          // StepCard 1
          Row({ space: 0 }) {
            Stack({ alignContent: Alignment.Center }) {
              Text('01')
                .fontSize(this.fontSize12)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
            }
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor('#F5F5F5')

            Blank().width(16)

            Text(this.Sift_2g_of_matcha_powder)
              .fontSize(14)
              .fontColor('#A9A9A9')
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .padding(16)
          .borderRadius(12)
          .border({ width: 1, color: '#EEEEEE' })

          Blank().height(12)

          // StepCard 2
          Row({ space: 0 }) {
            Stack({ alignContent: Alignment.Center }) {
              Text('02')
                .fontSize(this.fontSize12)
                .fontWeight(FontWeight.Bold)
                .fontColor(Color.Black)
            }
            .width(32)
            .height(32)
            .borderRadius(16)
            .backgroundColor('#F5F5F5')

            Blank().width(16)

            Text(this.Add_hot_water_Whisk_in_M_shape)
              .fontSize(14)
              .fontColor('#A9A9A9')
          }
          .alignItems(VerticalAlign.Center)
          .width('100%')
          .padding(16)
          .borderRadius(12)
          .border({ width: 1, color: '#EEEEEE' })

          Blank().height(32)

          // Button
          Button() {
            Row() {
              Image($r('app.media.startIcon'))
                .width(20)
                .height(20)
              Blank().width(8)
              Text(this.START_TIMER)
                .fontSize(this.fontSize16)
                .fontWeight(FontWeight.Medium)
            }
            .justifyContent(FlexAlign.Start)
            .alignItems(VerticalAlign.Center)
          }
          .width('100%')
          .height(56)
          .backgroundColor('#556B2F')
          .borderRadius(28)
          .onClick(() => {
            /* No logic required */
          })

          Blank().height(24)
        }
        .alignItems(HorizontalAlign.Center)
        .width('100%')
      }
      .alignItems(HorizontalAlign.Center)
      .width('100%')
      .height('100%')
      .padding(24)
      .justifyContent(FlexAlign.SpaceBetween)
    }
    .width('100%')
    .height('100%')
  }
}