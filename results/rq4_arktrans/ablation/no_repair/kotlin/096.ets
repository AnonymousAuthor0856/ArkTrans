@Entry
@Component
struct Index {
  @State aqi: number = 42

  build() {
    Stack({ alignContent: Alignment.Top }) {
      // === TopHeader ===
      Row() {
        Column() {
          Text('Living Room').fontSize(16).fontColor('#888888')
          Text('AeroSense').fontSize(32).fontWeight(FontWeight.Bold).fontColor('#1A1A1A')
        }
        Blank()
        Button() {
          Image($r('app.media.startIcon')).width(24).height(24)
        }.backgroundColor('#F5F5F5').borderRadius(24).width(48).height(48)
      }.width('100%').padding({ left: 24, right: 24, top: 24, bottom: 24 }).alignItems(VerticalAlign.Center)

      // === MainContent ===
      List({ space: 32 }) {
        ListItem() {
          // === AirQualityCircle ===
          Stack({ alignContent: Alignment.Center }) {
            // Simulated Canvas for the Green Arc
            Image($r('app.media.startIcon'))
              .width(220)
              .height(220)
              .opacity(0.1) 
              .borderRadius(110)
              .position({ x: -110, y: -110 })

            Column({ space: 0 }) {
              Text('AQI').fontSize(16).fontColor('#888888').fontWeight(FontWeight.Bold).letterSpacing(2)
              Text(`${this.aqi}`).fontSize(80).fontColor('#1A1A1A').fontWeight(FontWeight.Medium)
              Text('Excellent')
                .fontSize(16)
                .fontColor('#4CAF50')
                .backgroundColor('#E8F5E9')
                .borderRadius(16)
                .padding({ left: 12, right: 12, top: 6, bottom: 6 })
                .margin({ top: 8 })
            }.alignItems(HorizontalAlign.Center)
          }.width('100%').aspectRatio(1.2)
        }

        ListItem() {
          // === Metric Cards Row 1 ===
          Row({ space: 16 }) {
            // Temp Card
            Column() {
              Row() {
                Image($r('app.media.startIcon')).width(20).height(20).fillColor('#1A1A1A')
                Blank()
              }.width('100%')
              Blank()
              Column() {
                Text('23°C').fontSize(24).fontWeight(FontWeight.Medium).fontColor('#1A1A1A')
                Text('Temp').fontSize(14).fontColor('#888888')
              }
            }.layoutWeight(1).height(110).backgroundColor('#FAFAFA').borderRadius(24).padding(16)

            // Humidity Card
            Column() {
              Row() {
                Image($r('app.media.startIcon')).width(20).height(20).fillColor('#4CAF50')
                Blank()
              }.width('100%')
              Blank()
              Column() {
                Text('45%').fontSize(24).fontWeight(FontWeight.Medium).fontColor('#1A1A1A')
                Text('Humidity').fontSize(14).fontColor('#888888')
              }
            }.layoutWeight(1).height(110).backgroundColor('#FAFAFA').borderRadius(24).padding(16)
          }.width('100%')
        }

        ListItem() {
          // === StatusBanner ===
          Column() {
            Row() {
              Image($r('app.media.startIcon')).width(24).height(24).fillColor('#1A1A1A')
              Blank().width(12)
              Text('Room Analysis').fontSize(16).fontWeight(FontWeight.Bold).fontColor('#1A1A1A')
            }.alignItems(VerticalAlign.Center)
            Blank().height(12)
            Text('Air quality is optimal. Ventilation is not required at this moment. Temperature is stable.')
              .fontSize(14)
              .fontColor('#888888')
              .lineHeight(22)
          }.width('100%').padding(20).border({ width: 1, color: '#EEEEEE', radius: 20 })
        }
      }.width('100%').layoutWeight(1).padding({ left: 24, right: 24, top: 16, bottom: 16 })

      // === BottomControlBar ===
      Column() {
        Divider().color('#EEEEEE')
        Row() {
          // Menu Icon
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.width(48).height(48).borderRadius(24).border({ width: 1, color: '#EEEEEE' })

          // Refresh Button
          Button() {
            Row() {
              Image($r('app.media.startIcon')).width(18).height(18)
              Blank().width(8)
              Text('Refresh Data').fontSize(16).fontColor('#FFFFFF')
            }
          }.backgroundColor('#1A1A1A').borderRadius(16).padding({ left: 24, right: 24, top: 16, bottom: 16 })

          // Add Icon
          Button() {
            Image($r('app.media.startIcon')).width(24).height(24)
          }.width(48).height(48).borderRadius(24).border({ width: 1, color: '#EEEEEE' })
        }.width('100%').padding(24).alignItems(VerticalAlign.Center)
      }.width('100%').backgroundColor('#FFFFFF')
    }.width('100%').height('100%').backgroundColor('#FFFFFF')
  }
}