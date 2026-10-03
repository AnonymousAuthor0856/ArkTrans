@Entry
@Component
struct Index {
  @State LUMEN_LOG: string = '0'
  @State _14: number = 0
  @State Roll_034: string = '0'
  @State _24: number = 0
  @State aperture: number = 0
  @State _56: number = 0
  @State APERTURE: string = '0'
  @State _12: number = 0
  @State value: string = '0'
  @State _20: number = 0
  @State label: string = '0'
  @State _10: number = 0
  @State Film_Stock_ISO: string = '0'
  @State iso: string = '0'
  @State _13: number = 0
  @State Aperture_Control: string = '0'
  @State fontSize: number = 24
  @State f_1_4: string = '0'
  @State f_16: string = '0'
  @State Shutter_Speed: string = '0'
  @State prev: string = '0'
  @State text: string = '0'
  @State if_isSelected_22_sp_else_16_sp: number = 0
  @State curr: string = '0'
  @State next: string = '0'
  @State LOG_EXPOSURE: string = '0'
  @State _16: number = 0

  build() {
    Stack() {
      Column({ space: 0 }) {
        // HeaderSection
        Row({ space: 0 }) {
          Column({ space: 0 }) {
            Text('LUMEN LOG').fontSize(14).fontWeight(FontWeight.Bold).letterSpacing(2).fontColor(Color.Gray)
            Text('Roll #034').fontSize(24).fontWeight(FontWeight.Bolder).fontColor(Color.Black)
          }
          Row({ space: 0 }) {
            Button() {
              Image($r('app.media.startIcon'))
            }.onClick(() => { /* No-op */ })
            Button() {
              Image($r('app.media.startIcon'))
            }.onClick(() => { /* No-op */ })
          }
        }.alignItems(VerticalAlign.Center).width('100%').padding({ bottom: 16 })

        // CurrentSettingsDisplay
        Column() {
          Row({ space: 0 }) {
            Column({ space: 0 }) {
              Text(`f/${this.aperture}`).fontSize(56).fontWeight(FontWeight.Normal).fontColor(Color.Black).letterSpacing(-2)
              Text('APERTURE').fontSize(12).fontWeight(FontWeight.Bold).fontColor(Color.Gray)
            }.layoutWeight(1.5).padding({ left: 24 })
            
            Divider().vertical(false).width(1).height(80).color('#D3D3D3')
            
            Column({ space: 0 }) {
              // SettingItemSmall ISO
              Column({ space: 0 }) {
                Text(this.value).fontSize(20).fontWeight(FontWeight.Medium).fontColor(Color.Black)
                Text(this.label).fontSize(10).fontWeight(FontWeight.Bold).fontColor(Color.Gray)
              }
              Blank().height(16)
              // SettingItemSmall SHUTTER
              Column({ space: 0 }) {
                Text(this.value).fontSize(20).fontWeight(FontWeight.Medium).fontColor(Color.Black)
                Text(this.label).fontSize(10).fontWeight(FontWeight.Bold).fontColor(Color.Gray)
              }
            }.layoutWeight(1).padding({ left: 24 })
          }.alignItems(VerticalAlign.Center).width('100%').height('100%')
        }.backgroundColor('#FFFFFF').borderRadius(12).shadow({ radius: 4, color: '#1A000000' }).width('100%').height(160)

        // Controls Column
        Column({ space: 32 }) {
          // IsoSelector
          Column({ space: 0 }) {
            Text('Film Stock ISO').fontSize(14).fontWeight(FontWeight.Medium).padding({ bottom: 12 })
            List({ space: 12 }) {
              ListItem() {
                Stack({ alignContent: Alignment.Center }) {
                  Text(this.iso).fontSize(13).fontWeight(FontWeight.Medium).fontColor(Color.Black)
                }.width(60).height(36).backgroundColor(Color.Transparent).borderRadius(50)
              }
            }.width('100%').listDirection(Axis.Horizontal)
          }

          // ApertureControl
          Column({ space: 0 }) {
            Row({ space: 0 }) {
              Text('Aperture Control').fontSize(14).fontWeight(FontWeight.Medium)
              Blank()
              Image($r('app.media.startIcon')).width(16).height(16).fillColor(Color.Gray)
            }.width('100%')
            
            Blank().height(8)
            
            Slider({ value: this.aperture, min: 1.4, max: 16 }).width('100%')
            
            Row({ space: 0 }) {
              Text('f/1.4').fontSize(12).fontColor(Color.Gray)
              Blank()
              Text('f/16').fontSize(12).fontColor(Color.Gray)
            }.width('100%')
          }

          // ShutterSpeedControl
          Column({ space: 0 }) {
            Text('Shutter Speed').fontSize(14).fontWeight(FontWeight.Medium).padding({ bottom: 12 })
            Row({ space: 0 }) {
              // SpeedOption Prev
              Stack({ alignContent: Alignment.Center }) {
                Text(this.prev).fontSize(16).fontWeight(FontWeight.Normal).fontColor('#D3D3D3')
              }.width(100).height(50).backgroundColor(Color.Transparent).borderRadius(12)
              
              // SpeedOption Curr
              Stack({ alignContent: Alignment.Center }) {
                Text(this.curr).fontSize(22).fontWeight(FontWeight.Bold).fontColor(Color.Black)
              }.width(100).height(50).backgroundColor('#F0F0F0').borderRadius(12)
              
              // SpeedOption Next
              Stack({ alignContent: Alignment.Center }) {
                Text(this.next).fontSize(16).fontWeight(FontWeight.Normal).fontColor('#D3D3D3')
              }.width(100).height(50).backgroundColor(Color.Transparent).borderRadius(12)
            }.width('100%')
          }
        }

        // LogShotButton
        Button() {
          Row({ space: 0 }) {
            Stack({ alignContent: Alignment.Center }) {
              Image($r('app.media.startIcon')).width(16).height(16).fillColor(Color.Black)
            }.width(24).height(24).backgroundColor(Color.White).borderRadius(12)
            
            Blank().width(12)
            
            Text('LOG EXPOSURE').fontSize(16).fontWeight(FontWeight.Bold).letterSpacing(1)
          }.alignItems(VerticalAlign.Center)
        }.width('100%').height(56).backgroundColor(Color.Black).borderRadius(12).fontColor(Color.White)
      }.width('100%').height('100%').padding(24)
    }.width('100%').height('100%')
  }
}