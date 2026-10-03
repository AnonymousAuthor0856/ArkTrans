@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 60
  @State ambientGlow: number = 35

  build() {
    // === Stack ===
    // props: {}
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack() {
      // === Column ===
      // props: { space: 12 }
      // modifier: { width: '100%', height: '100%', padding: { left: 16, right: 16, top: 8, bottom: 8 }, backgroundColor: '#F9F4EB', layoutWeight: 1 }
      // children: 5
      Column({ space: 12 }) {
        // === Row ===
        // props: { space: 8 }
        // modifier: { width: '100%' }
        // children: 3
        Row({ space: 8 }) {
          // === Button (Chip) ===
          // modifier: { flexShrink: 1, backgroundColor: this.activeMode === 'Orbit' ? '#F0E3D1' : '#FFF', borderColor: '#E1CDB2', borderWidth: 1, borderRadius: 12 }
          // children: 1
          Button('Orbit')
            .backgroundColor(this.activeMode === 'Orbit' ? '#F0E3D1' : '#FFF')
            .borderColor('#E1CDB2').borderWidth(1).borderRadius(12)
            .onClick(() => { this.activeMode = 'Orbit' })
          
          // === Button (Chip) ===
          // modifier: { flexShrink: 1, backgroundColor: this.activeMode === 'Eclipse' ? '#F0E3D1' : '#FFF', borderColor: '#E1CDB2', borderWidth: 1, borderRadius: 12 }
          // children: 1
          Button('Eclipse')
            .backgroundColor(this.activeMode === 'Eclipse' ? '#F0E3D1' : '#FFF')
            .borderColor('#E1CDB2').borderWidth(1).borderRadius(12)
            .onClick(() => { this.activeMode = 'Eclipse' })

          // === Button (Chip) ===
          // modifier: { flexShrink: 1, backgroundColor: this.activeMode === 'Manual' ? '#F0E3D1' : '#FFF', borderColor: '#E1CDB2', borderWidth: 1, borderRadius: 12 }
          // children: 1
          Button('Manual')
            .backgroundColor(this.activeMode === 'Manual' ? '#F0E3D1' : '#FFF')
            .borderColor('#E1CDB2').borderWidth(1).borderRadius(12)
            .onClick(() => { this.activeMode = 'Manual' })
        }

        // === Card (Solar Wash) ===
        // modifier: { width: '100%', backgroundColor: '#FFF', borderRadius: 20 }
        // children: 1
        Column() {
          // === Column ===
          // props: { space: 8 }
          // modifier: { width: '100%', padding: 16 }
          // children: 7
          Column({ space: 8 }) {
            // === Text ===
            // props: { text: 'Solar wash' }
            // modifier: { fontSize: 20, fontWeight: FontWeight.SemiBold, color: '#2E2924' }
            Text('Solar wash').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#2E2924')
            
            // === Text ===
            // props: { text: 'Adjust orbital window glow' }
            // modifier: { fontSize: 13, color: '#2E2924' }
            Text('Adjust orbital window glow').fontSize(13).fontColor('#2E2924')

            // === Slider ===
            // props: { value: this.solarLevel, min: 0, max: 100 }
            // modifier: { width: '100%' }
            Slider({ value: this.solarLevel, min: 0, max: 100 }).width('100%')
              .trackColor('#EADDFF').selectedColor('#D95F02')

            // === Row ===
            // props: { justifyContent: FlexAlign.SpaceBetween }
            // modifier: { width: '100%' }
            // children: 2
            Row() {
              // === Text ===
              // props: { text: '0%' }
              // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, color: '#2E2924' }
              Text('0%').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#2E2924')
              
              // === Text ===
              // props: { text: '${this.solarLevel}%' }
              // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#D95F02' }
              Text(`${this.solarLevel}%`).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#D95F02')
            }.width('100%').justifyContent(FlexAlign.SpaceBetween)

            // === Text ===
            // props: { text: 'Ambient glow' }
            // modifier: { fontSize: 20, fontWeight: FontWeight.SemiBold, color: '#2E2924' }
            Text('Ambient glow').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#2E2924')

            // === Slider ===
            // props: { value: this.ambientGlow, min: 0, max: 100 }
            // modifier: { width: '100%' }
            Slider({ value: this.ambientGlow, min: 0, max: 100 }).width('100%')
              .trackColor('#EADDFF').selectedColor('#1B9AAA')

            // === Progress ===
            // props: { value: this.ambientGlow, total: 100, type: ProgressType.Linear }
            // modifier: { width: '100%', height: 4, color: '#1B9AAA', trackColor: '#F0E3D1' }
            Progress({ value: this.ambientGlow, total: 100, type: ProgressType.Linear })
              .width('100%').height(4).color('#1B9AAA').backgroundColor('#F0E3D1')
          }.width('100%').padding(16)
        }.width('100%').backgroundColor('#FFF').borderRadius(20)

        // === Card (Orbit Health) ===
        // modifier: { width: '100%', backgroundColor: '#F0E3D1', borderRadius: 20 }
        // children: 1
        Column() {
          // === Column ===
          // props: { space: 8 }
          // modifier: { width: '100%', padding: 16 }
          // children: 4
          Column({ space: 8 }) {
            // === Text ===
            // props: { text: 'Orbit health' }
            // modifier: { fontSize: 20, fontWeight: FontWeight.SemiBold, color: '#2E2924' }
            Text('Orbit health').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#2E2924')

            // === StatusRow (Atmos mix) ===
            // children: 2
            Column() {
              // === Row ===
              // props: { justifyContent: FlexAlign.SpaceBetween }
              // modifier: { width: '100%' }
              // children: 2
              Row() {
                // === Text ===
                // props: { text: 'Atmos mix' }
                // modifier: { fontSize: 13, color: '#2E2924' }
                Text('Atmos mix').fontSize(13).fontColor('#2E2924')
                // === Text ===
                // props: { text: '74%' }
                // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, color: '#1B9AAA' }
                Text('74%').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#1B9AAA')
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)
              
              // === Progress ===
              // props: { value: 74, total: 100, type: ProgressType.Linear }
              // modifier: { width: '100%', height: 4, color: '#1B9AAA', trackColor: '#FFF' }
              Progress({ value: 74, total: 100, type: ProgressType.Linear })
                .width('100%').height(4).color('#1B9AAA').backgroundColor('#FFF')
            }

            // === StatusRow (Hull temp) ===
            // children: 2
            Column() {
              // === Row ===
              // props: { justifyContent: FlexAlign.SpaceBetween }
              // modifier: { width: '100%' }
              // children: 2
              Row() {
                // === Text ===
                // props: { text: 'Hull temp' }
                // modifier: { fontSize: 13, color: '#2E2924' }
                Text('Hull temp').fontSize(13).fontColor('#2E2924')
                // === Text ===
                // props: { text: '42%' }
                // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, color: '#D95F02' }
                Text('42%').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#D95F02')
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)
              
              // === Progress ===
              // props: { value: 42, total: 100, type: ProgressType.Linear }
              // modifier: { width: '100%', height: 4, color: '#D95F02', trackColor: '#FFF' }
              Progress({ value: 42, total: 100, type: ProgressType.Linear })
                .width('100%').height(4).color('#D95F02').backgroundColor('#FFF')
            }

            // === StatusRow (Shield sync) ===
            // children: 2
            Column() {
              // === Row ===
              // props: { justifyContent: FlexAlign.SpaceBetween }
              // modifier: { width: '100%' }
              // children: 2
              Row() {
                // === Text ===
                // props: { text: 'Shield sync' }
                // modifier: { fontSize: 13, color: '#2E2924' }
                Text('Shield sync').fontSize(13).fontColor('#2E2924')
                // === Text ===
                // props: { text: '88%' }
                // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, color: '#FEC601' }
                Text('88%').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#FEC601')
              }.width('100%').justifyContent(FlexAlign.SpaceBetween)
              
              // === Progress ===
              // props: { value: 88, total: 100, type: ProgressType.Linear }
              // modifier: { width: '100%', height: 4, color: '#FEC601', trackColor: '#FFF' }
              Progress({ value: 88, total: 100, type: ProgressType.Linear })
                .width('100%').height(4).color('#FEC601').backgroundColor('#FFF')
            }
          }.width('100%').padding(16)
        }.width('100%').backgroundColor('#F0E3D1').borderRadius(20)

        // === Blank ===
        Blank()
      }.width('100%').height('100%').padding({ left: 16, right: 16, top: 8, bottom: 8 }).backgroundColor('#F9F4EB').layoutWeight(1)

      // === Column (Bottom Bar) ===
      // props: { space: 4 }
      // modifier: { width: '100%', padding: { left: 16, right: 16, top: 8, bottom: 8 }, backgroundColor: '#FFF', shadow: { radius: 8, color: '#29000000' } }
      // children: 2
      Column({ space: 4 }) {
        // === Row ===
        // props: { justifyContent: FlexAlign.SpaceBetween, verticalAlign: VerticalAlign.Center }
        // modifier: { width: '100%' }
        // children: 2
        Row() {
          // === Column ===
          // props: { space: 4 }
          // children: 2
          Column({ space: 4 }) {
            // === Text ===
            // props: { text: 'Grid draw' }
            // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, color: '#2E2924' }
            Text('Grid draw').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#2E2924')
            // === Text ===
            // props: { text: '18.4 kWh' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, color: '#D95F02' }
            Text('18.4 kWh').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#D95F02')
          }

          // === Button ===
          // modifier: { backgroundColor: '#D95F02', borderRadius: 16, fontColor: '#FFF' }
          // children: 1
          Button('Engage eco hold')
            .backgroundColor('#D95F02').borderRadius(16).fontColor('#FFF')
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)
      }.width('100%').padding({ left: 16, right: 16, top: 8, bottom: 8 }).backgroundColor('#FFF').shadow({ radius: 8, color: '#29000000' })
    }.width('100%').height('100%')
  }
}