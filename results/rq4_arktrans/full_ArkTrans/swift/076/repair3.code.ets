@Entry
@Component
struct Index {
  @State selectedSceneIndex: number = 0
  @State lampSwitchState: boolean = true
  @State lockSwitchState: boolean = false

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Scroll() {
        Column() {
          Blank().height(16)

          Row() {
            Column() {
              Text('Good Morning,').fontColor('#999999').fontSize(16).fontWeight(FontWeight.Medium)
              Text('Alex Johnson').fontColor('#000000').fontSize(24).fontWeight(FontWeight.Bold)
            }
            Blank()
            Stack() {
              Circle().width(48).height(48).fill('#FFFFFF')
              Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain).fillColor('#000000')
            }
          }.padding({ left: 24, right: 24 })

          Blank().height(32)

          // Energy Card
          Column() {
            Row() {
              Column() {
                Text('Energy Usage').fontColor('#CCFFFFFF').fontSize(14)
                Text('28.5 kWh').fontColor('#FFFFFF').fontSize(32).fontWeight(FontWeight.Bold)
                Text('Today').fontColor('#99FFFFFF').fontSize(12)
              }
              Blank()
              Stack() {
                Circle().width(56).height(56).fill('#33FFFFFF')
                Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain).fillColor('#FFFFFF')
              }
            }.padding(24)
          }.backgroundColor('#5F60CE').borderRadius(24).shadow({ radius: 8, color: '#1A000000', offsetY: 4 }).padding({ left: 24, right: 24 })

          Blank().height(32)

          // Scenes Section
          Text('Scenes').fontColor('#000000').fontSize(20).fontWeight(FontWeight.Bold).padding({ left: 24, right: 24 })
          Blank().height(16)

          Scroll() {
            Row({ space: 12 }) {
              Blank().width(24)
              
              // Home Scene
              this.SceneButton('Home', $r('app.media.startIcon'), 0)
              // Away Scene
              this.SceneButton('Away', $r('app.media.startIcon'), 1)
              // Sleep Scene
              this.SceneButton('Sleep', $r('app.media.startIcon'), 2)
              
              Blank().width(24)
            }
          }.scrollable(ScrollDirection.Horizontal).scrollBar(BarState.Off)

          Blank().height(32)

          // Devices Section
          Text('Devices').fontColor('#000000').fontSize(20).fontWeight(FontWeight.Bold).padding({ left: 24, right: 24 })
          Blank().height(16)

          Row({ space: 16 }) {
            Column({ space: 16 }) {
              this.DeviceCard('Smart Lamp', 'On', this.lampSwitchState, (val: boolean) => { this.lampSwitchState = val }, '#FFC107', '#FFF3E0')
              this.DeviceCard('Thermostat', 'Off', false, () => {}, '#FF5252', '#FFEBEE')
            }
            Column({ space: 16 }) {
              this.DeviceCard('Main Lock', 'Off', this.lockSwitchState, (val: boolean) => { this.lockSwitchState = val }, '#757575', '#EEEEEE')
              this.DeviceCard('Fan', 'On', true, () => {}, '#2196F3', '#E3F2FD')
            }
          }.padding({ left: 24, right: 24 })

          Blank().height(24)
        }.padding({ top: 0, bottom: 0 })
      }.width('100%').layoutWeight(1)
    }.width('100%').height('100%').backgroundColor('#F5F5F7')
  }

  @Builder
  SceneButton(text: string, iconRes: Resource, index: number) {
    Row({ space: 8 }) {
      Image(iconRes).width(18).height(18).objectFit(ImageFit.Contain)
        .fillColor(this.selectedSceneIndex === index ? '#FFFFFF' : '#000000')
      Text(text).fontSize(14).fontWeight(FontWeight.Medium)
        .fontColor(this.selectedSceneIndex === index ? '#FFFFFF' : '#000000')
    }
    .onClick(() => { this.selectedSceneIndex = index })
    .width('auto').height(48).justifyContent(FlexAlign.Center)
    .padding({ left: 24, right: 24 })
    .borderRadius(30)
    .backgroundColor(this.selectedSceneIndex === index ? '#212121' : '#FFFFFF')
  }

  @Builder
  DeviceCard(name: string, status: string, isOn: boolean, toggleFn: (val: boolean) => void, accentColor: string, bgColor: string) {
    Column() {
      Row() {
        Stack() {
          Circle().width(40).height(40).fill(isOn ? `${accentColor}1A` : '#F0F0F0')
          Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
            .fillColor(isOn ? accentColor : '#999999')
        }
        Blank()
      }
      Blank()
      Column({ space: 4 }) {
        Text(name).fontColor('#000000').fontSize(16).fontWeight(FontWeight.Bold)
        Text(status).fontColor(isOn ? accentColor : '#999999').fontSize(14).fontWeight(FontWeight.Medium)
      }
      Blank()
      Row() {
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: isOn })
          .onChange((val: boolean) => { toggleFn(val) })
          .scale({ x: 0.8, y: 0.8 })
          .width(40)
      }
    }
    .width('100%')
    .aspectRatio(0.85)
    .padding(16)
    .backgroundColor('#FFFFFF')
    .borderRadius(20)
    .shadow({ radius: 2, color: '#0D000000', offsetY: 1 })
  }
}