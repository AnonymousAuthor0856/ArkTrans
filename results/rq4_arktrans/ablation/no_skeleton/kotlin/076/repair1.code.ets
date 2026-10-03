@Entry
@Component
struct SmartHomeDashboard {
  @State lampActive: boolean = true
  @State thermostatActive: boolean = true
  @State lockActive: boolean = false
  @State wifiActive: boolean = true

  build() {
    // === Column (Root) ===
    // props: {}
    // modifier: { width: '100%', height: '100%', padding: 24, backgroundColor: '#F4F6F8' }
    // children: 7
    Column() {
      // === Spacer ===
      // modifier: { height: 16 }
      Blank().height(16)

      // === Row (Header) ===
      // props: { justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }
      // modifier: { width: '100%' }
      // children: 2
      Row() {
        // === Column (Texts) ===
        // children: 2
        Column() {
          // === Text ===
          // props: { text: 'Good Morning,' }
          // modifier: { fontSize: 16, color: '#9E9E9E', fontWeight: FontWeight.Medium }
          Text('Good Morning,').fontSize(16).fontColor('#9E9E9E').fontWeight(FontWeight.Medium)
          // === Text ===
          // props: { text: 'Alex Johnson' }
          // modifier: { fontSize: 24, color: '#000', fontWeight: FontWeight.Bold }
          Text('Alex Johnson').fontSize(24).fontColor('#000').fontWeight(FontWeight.Bold)
        }

        // === Circle Box (Avatar) ===
        // modifier: { width: 48, height: 48, borderRadius: 24, backgroundColor: '#FFF' }
        // children: 1
        Column() {
          // === Image (Person Icon) ===
          // modifier: { width: 24, height: 24 }
          Image($r('app.media.startIcon')).width(24).height(24)
        }.width(48).height(48).borderRadius(24).backgroundColor('#FFF')
      }.width('100%')

      // === Spacer ===
      // modifier: { height: 32 }
      Blank().height(32)

      // === Card (Energy Usage) ===
      // modifier: { width: '100%', borderRadius: 24, backgroundColor: '#5E60CE', shadow: { radius: 8, color: '#1A000000' }, padding: 24 }
      // children: 1
      Column() {
        // === Row (Content) ===
        // props: { justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }
        // modifier: { width: '100%' }
        // children: 2
        Row() {
          // === Column (Stats) ===
          // children: 3
          Column() {
            // === Text ===
            // props: { text: 'Energy Usage' }
            // modifier: { fontSize: 14, color: '#CCFFFFFF' }
            Text('Energy Usage').fontSize(14).fontColor('#CCFFFFFF')
            // === Text ===
            // props: { text: '28.5 kWh' }
            // modifier: { fontSize: 32, color: '#FFF', fontWeight: FontWeight.Bold }
            Text('28.5 kWh').fontSize(32).fontColor('#FFF').fontWeight(FontWeight.Bold)
            // === Text ===
            // props: { text: 'Today' }
            // modifier: { fontSize: 12, color: '#99FFFFFF' }
            Text('Today').fontSize(12).fontColor('#99FFFFFF')
          }

          // === Circle Box (Bell Icon) ===
          // modifier: { width: 56, height: 56, borderRadius: 28, backgroundColor: '#33FFFFFF' }
          // children: 1
          Column() {
            // === Image (Bell Icon) ===
            // modifier: { width: 24, height: 24 }
            Image($r('app.media.startIcon')).width(24).height(24)
          }.width(56).height(56).borderRadius(28).backgroundColor('#33FFFFFF')
        }.width('100%')
      }.width('100%').borderRadius(24).backgroundColor('#5E60CE').shadow({ radius: 8, color: '#1A000000' }).padding(24)

      // === Spacer ===
      // modifier: { height: 32 }
      Blank().height(32)

      // === Section: Scenes ===
      // children: 3
      Column() {
        // === Text ===
        // props: { text: 'Scenes' }
        // modifier: { fontSize: 20, color: '#000', fontWeight: FontWeight.Bold }
        Text('Scenes').fontSize(20).fontColor('#000').fontWeight(FontWeight.Bold)

        // === Spacer ===
        // modifier: { height: 16 }
        Blank().height(16)

        // === Row (Scene Buttons) ===
        // props: { space: 12 }
        // modifier: { width: '100%' }
        // children: 3
        Row({ space: 12 }) {
          // === Scene Button (Home - Active) ===
          // modifier: { flexShrink: 1, flexGrow: 1, padding: { left: 24, right: 24, top: 12, bottom: 12 }, borderRadius: 30, backgroundColor: '#212121' }
          // children: 1
          Row() {
            // === Image (Home Icon) ===
            // modifier: { width: 18, height: 18 }
            Image($r('app.media.startIcon')).width(18).height(18)
            // === Spacer ===
            // modifier: { width: 8 }
            Blank().width(8)
            // === Text ===
            // props: { text: 'Home' }
            // modifier: { fontSize: 14, color: '#FFF', fontWeight: FontWeight.Medium }
            Text('Home').fontSize(14).fontColor('#FFF').fontWeight(FontWeight.Medium)
          }.flexShrink(1).flexGrow(1).padding({ left: 24, right: 24, top: 12, bottom: 12 }).borderRadius(30).backgroundColor('#212121')

          // === Scene Button (Away - Inactive) ===
          // modifier: { flexShrink: 1, flexGrow: 1, padding: { left: 24, right: 24, top: 12, bottom: 12 }, borderRadius: 30, backgroundColor: '#FFF' }
          // children: 1
          Row() {
            // === Image (Lock Icon) ===
            // modifier: { width: 18, height: 18 }
            Image($r('app.media.startIcon')).width(18).height(18)
            // === Spacer ===
            // modifier: { width: 8 }
            Blank().width(8)
            // === Text ===
            // props: { text: 'Away' }
            // modifier: { fontSize: 14, color: '#000', fontWeight: FontWeight.Medium }
            Text('Away').fontSize(14).fontColor('#000').fontWeight(FontWeight.Medium)
          }.flexShrink(1).flexGrow(1).padding({ left: 24, right: 24, top: 12, bottom: 12 }).borderRadius(30).backgroundColor('#FFF')

          // === Scene Button (Sleep - Inactive) ===
          // modifier: { flexShrink: 1, flexGrow: 1, padding: { left: 24, right: 24, top: 12, bottom: 12 }, borderRadius: 30, backgroundColor: '#FFF' }
          // children: 1
          Row() {
            // === Image (Star Icon) ===
            // modifier: { width: 18, height: 18 }
            Image($r('app.media.startIcon')).width(18).height(18)
            // === Spacer ===
            // modifier: { width: 8 }
            Blank().width(8)
            // === Text ===
            // props: { text: 'Sleep' }
            // modifier: { fontSize: 14, color: '#000', fontWeight: FontWeight.Medium }
            Text('Sleep').fontSize(14).fontColor('#000').fontWeight(FontWeight.Medium)
          }.flexShrink(1).flexGrow(1).padding({ left: 24, right: 24, top: 12, bottom: 12 }).borderRadius(30).backgroundColor('#FFF')
        }.width('100%')
      }

      // === Spacer ===
      // modifier: { height: 32 }
      Blank().height(32)

      // === Section: Devices ===
      // children: 3
      Column() {
        // === Text ===
        // props: { text: 'Devices' }
        // modifier: { fontSize: 20, color: '#000', fontWeight: FontWeight.Bold }
        Text('Devices').fontSize(20).fontColor('#000').fontWeight(FontWeight.Bold)

        // === Spacer ===
        // modifier: { height: 16 }
        Blank().height(16)

        // === Row (Device Grid) ===
        // props: { space: 16 }
        // modifier: { width: '100%' }
        // children: 2
        Row({ space: 16 }) {
          // === Column (Left Col) ===
          // props: { space: 16, layoutWeight: 1 }
          // children: 2
          Column({ space: 16 }) {
            // === Device Card (Lamp) ===
            // modifier: { width: '100%', aspectRatio: 0.85, borderRadius: 20, backgroundColor: '#FFF', shadow: { radius: 2, color: '#1A000000' }, padding: 16 }
            // children: 1
            Column() {
              // === Row (Top) ===
              // props: { justifyContent: FlexAlign.Start }
              // modifier: { width: '100%' }
              // children: 1
              Row() {
                // === Circle Box (Icon) ===
                // modifier: { width: 40, height: 40, borderRadius: 20, backgroundColor: '#FFF8E1' }
                // children: 1
                Column() {
                  // === Image (Star Icon) ===
                  // modifier: { width: 24, height: 24 }
                  Image($r('app.media.startIcon')).width(24).height(24)
                }.width(40).height(40).borderRadius(20).backgroundColor('#FFF8E1')
              }.width('100%')

              // === Blank ===
              Blank()

              // === Column (Bottom Info) ===
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Smart Lamp' }
                // modifier: { fontSize: 16, color: '#000', fontWeight: FontWeight.Bold }
                Text('Smart Lamp').fontSize(16).fontColor('#000').fontWeight(FontWeight.Bold)
                // === Spacer ===
                // modifier: { height: 4 }
                Blank().height(4)
                // === Text ===
                // props: { text: 'On' }
                // modifier: { fontSize: 14, color: '#FFC107', fontWeight: FontWeight.Medium }
                Text('On').fontSize(14).fontColor('#FFC107').fontWeight(FontWeight.Medium)
              }

              // === Row (Switch) ===
              // props: { justifyContent: FlexAlign.End }
              // modifier: { width: '100%' }
              // children: 1
              Row() {
                // === Toggle (Simulated Switch) ===
                // modifier: { width: 42, height: 24, borderRadius: 12, backgroundColor: '#FFC107' }
                // children: 1
                Stack() {
                  // === Circle (Thumb) ===
                  // modifier: { width: 20, height: 20, borderRadius: 10, backgroundColor: '#FFF', margin: { right: 2 } }
                  Column().width(20).height(20).borderRadius(10).backgroundColor('#FFF').margin({ right: 2 })
                }.width(42).height(24).borderRadius(12).backgroundColor('#FFC107')
              }.width('100%')
            }.width('100%').aspectRatio(0.85).borderRadius(20).backgroundColor('#FFF').shadow({ radius: 2, color: '#1A000000' }).padding(16)

            // === Device Card (Thermostat) ===
            // modifier: { width: '100%', aspectRatio: 0.85, borderRadius: 20, backgroundColor: '#FFF', shadow: { radius: 2, color: '#1A000000' }, padding: 16 }
            // children: 1
            Column() {
              // === Row (Top) ===
              // props: { justifyContent: FlexAlign.Start }
              // modifier: { width: '100%' }
              // children: 1
              Row() {
                // === Circle Box (Icon) ===
                // modifier: { width: 40, height: 40, borderRadius: 20, backgroundColor: '#FFEBEE' }
                // children: 1
                Column() {
                  // === Image (Menu Icon) ===
                  // modifier: { width: 24, height: 24 }
                  Image($r('app.media.startIcon')).width(24).height(24)
                }.width(40).height(40).borderRadius(20).backgroundColor('#FFEBEE')
              }.width('100%')

              // === Blank ===
              Blank()

              // === Column (Bottom Info) ===
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Thermostat' }
                // modifier: { fontSize: 16, color: '#000', fontWeight: FontWeight.Bold }
                Text('Thermostat').fontSize(16).fontColor('#000').fontWeight(FontWeight.Bold)
                // === Spacer ===
                // modifier: { height: 4 }
                Blank().height(4)
                // === Text ===
                // props: { text: 'On' }
                // modifier: { fontSize: 14, color: '#FF7043', fontWeight: FontWeight.Medium }
                Text('On').fontSize(14).fontColor('#FF7043').fontWeight(FontWeight.Medium)
              }

              // === Row (Switch) ===
              // props: { justifyContent: FlexAlign.End }
              // modifier: { width: '100%' }
              // children: 1
              Row() {
                // === Toggle (Simulated Switch) ===
                // modifier: { width: 42, height: 24, borderRadius: 12, backgroundColor: '#FF7043' }
                // children: 1
                Stack() {
                  // === Circle (Thumb) ===
                  // modifier: { width: 20, height: 20, borderRadius: 10, backgroundColor: '#FFF', margin: { right: 2 } }
                  Column().width(20).height(20).borderRadius(10).backgroundColor('#FFF').margin({ right: 2 })
                }.width(42).height(24).borderRadius(12).backgroundColor('#FF7043')
              }.width('100%')
            }.width('100%').aspectRatio(0.85).borderRadius(20).backgroundColor('#FFF').shadow({ radius: 2, color: '#1A000000' }).padding(16)
          }.layoutWeight(1)

          // === Column (Right Col) ===
          // props: { space: 16, layoutWeight: 1 }
          // children: 2
          Column({ space: 16 }) {
            // === Device Card (Lock) ===
            // modifier: { width: '100%', aspectRatio: 0.85, borderRadius: 20, backgroundColor: '#FFF', shadow: { radius: 2, color: '#1A000000' }, padding: 16 }
            // children: 1
            Column() {
              // === Row (Top) ===
              // props: { justifyContent: FlexAlign.Start }
              // modifier: { width: '100%' }
              // children: 1
              Row() {
                // === Circle Box (Icon) ===
                // modifier: { width: 40, height: 40, borderRadius: 20, backgroundColor: '#F0F0F0' }
                // children: 1
                Column() {
                  // === Image (Lock Icon) ===
                  // modifier: { width: 24, height: 24 }
                  Image($r('app.media.startIcon')).width(24).height(24)
                }.width(40).height(40).borderRadius(20).backgroundColor('#F0F0F0')
              }.width('100%')

              // === Blank ===
              Blank()

              // === Column (Bottom Info) ===
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Main Lock' }
                // modifier: { fontSize: 16, color: '#000', fontWeight: FontWeight.Bold }
                Text('Main Lock').fontSize(16).fontColor('#000').fontWeight(FontWeight.Bold)
                // === Spacer ===
                // modifier: { height: 4 }
                Blank().height(4)
                // === Text ===
                // props: { text: 'Off' }
                // modifier: { fontSize: 14, color: '#9E9E9E', fontWeight: FontWeight.Medium }
                Text('Off').fontSize(14).fontColor('#9E9E9E').fontWeight(FontWeight.Medium)
              }

              // === Row (Switch) ===
              // props: { justifyContent: FlexAlign.End }
              // modifier: { width: '100%' }
              // children: 1
              Row() {
                // === Toggle (Simulated Switch) ===
                // modifier: { width: 42, height: 24, borderRadius: 12, backgroundColor: '#E0E0E0' }
                // children: 1
                Stack() {
                  // === Circle (Thumb) ===
                  // modifier: { width: 20, height: 20, borderRadius: 10, backgroundColor: '#FFF', margin: { left: 2 } }
                  Column().width(20).height(20).borderRadius(10).backgroundColor('#FFF').margin({ left: 2 })
                }.width(42).height(24).borderRadius(12).backgroundColor('#E0E0E0')
              }.width('100%')
            }.width('100%').aspectRatio(0.85).borderRadius(20).backgroundColor('#FFF').shadow({ radius: 2, color: '#1A000000' }).padding(16)

            // === Device Card (Wi-Fi) ===
            // modifier: { width: '100%', aspectRatio: 0.85, borderRadius: 20, backgroundColor: '#FFF', shadow: { radius: 2, color: '#1A000000' }, padding: 16 }
            // children: 1
            Column() {
              // === Row (Top) ===
              // props: { justifyContent: FlexAlign.Start }
              // modifier: { width: '100%' }
              // children: 1
              Row() {
                // === Circle Box (Icon) ===
                // modifier: { width: 40, height: 40, borderRadius: 20, backgroundColor: '#E3F2FD' }
                // children: 1
                Column() {
                  // === Image (Settings Icon) ===
                  // modifier: { width: 24, height: 24 }
                  Image($r('app.media.startIcon')).width(24).height(24)
                }.width(40).height(40).borderRadius(20).backgroundColor('#E3F2FD')
              }.width('100%')

              // === Blank ===
              Blank()

              // === Column (Bottom Info) ===
              // children: 3
              Column() {
                // === Text ===
                // props: { text: 'Wi-Fi Router' }
                // modifier: { fontSize: 16, color: '#000', fontWeight: FontWeight.Bold }
                Text('Wi-Fi Router').fontSize(16).fontColor('#000').fontWeight(FontWeight.Bold)
                // === Spacer ===
                // modifier: { height: 4 }
                Blank().height(4)
                // === Text ===
                // props: { text: 'On' }
                // modifier: { fontSize: 14, color: '#2196F3', fontWeight: FontWeight.Medium }
                Text('On').fontSize(14).fontColor('#2196F3').fontWeight(FontWeight.Medium)
              }

              // === Row (Switch) ===
              // props: { justifyContent: FlexAlign.End }
              // modifier: { width: '100%' }
              // children: 1
              Row() {
                // === Toggle (Simulated Switch) ===
                // modifier: { width: 42, height: 24, borderRadius: 12, backgroundColor: '#2196F3' }
                // children: 1
                Stack() {
                  // === Circle (Thumb) ===
                  // modifier: { width: 20, height: 20, borderRadius: 10, backgroundColor: '#FFF', margin: { right: 2 } }
                  Column().width(20).height(20).borderRadius(10).backgroundColor('#FFF').margin({ right: 2 })
                }.width(42).height(24).borderRadius(12).backgroundColor('#2196F3')
              }.width('100%')
            }.width('100%').aspectRatio(0.85).borderRadius(20).backgroundColor('#FFF').shadow({ radius: 2, color: '#1A000000' }).padding(16)
          }.layoutWeight(1)
        }.width('100%')
      }

      // === Spacer ===
      // modifier: { height: 24 }
      Blank().height(24)
    }.width('100%').height('100%').padding(24).backgroundColor('#F4F6F8')
  }
}