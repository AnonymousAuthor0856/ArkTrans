@Entry
@Component
struct SmartOrbitPanel {
  @State activeMode: string = 'Orbit'
  @State solarLevel: number = 0.6
  @State ambientGlow: number = 0.35

  private readonly modes: string[] = ['Orbit', 'Eclipse', 'Manual']
  private readonly zones: Zone[] = [
    { name: 'Atrium', humidity: 0.45, temp: '72°F' },
    { name: 'Lab East', humidity: 0.62, temp: '68°F' },
    { name: 'Hab Deck', humidity: 0.30, temp: '70°F' }
  ]

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.TopStart }
    // modifier: { width: '100%', height: '100%' }
    // children: 2
    Stack({ alignContent: Alignment.TopStart }) {
      // === Column ===
      // props: { space: 0 }
      // modifier: { width: '100%', backgroundColor: '#F9F4EB' }
      // children: 3
      Column() {
        // === Row ===
        // props: { space: 0 }
        // modifier: { width: '100%', height: 56, padding: { left: 16, right: 16 }, backgroundColor: '#FFF' }
        // children: 3
        Row() {
          // === Text ===
          // props: { text: 'Dock' }
          // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, fontColor: '#2E2924' }
          Text('Dock').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#2E2924')
          // === Blank ===
          Blank()
          // === Text ===
          // props: { text: 'Smart Orbit Panel' }
          // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#2E2924' }
          Text('Smart Orbit Panel').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#2E2924')
          // === Blank ===
          Blank()
          // === Text ===
          // props: { text: 'Alerts' }
          // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, fontColor: '#1B9AAA' }
          Text('Alerts').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#1B9AAA')
        }

        // === Scroll ===
        // props: { scroller: new Scroller() }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 1
        Scroll() {
          // === Column ===
          // props: { space: 12 }
          // modifier: { width: '100%', padding: { top: 8, bottom: 8, left: 16, right: 16 } }
          // children: 4
          Column({ space: 12 }) {
            // === Row ===
            // props: { space: 8 }
            // modifier: { width: '100%', justifyContent: FlexAlign.Start }
            // children: 3
            Row({ space: 8 }) {
              // === Button ===
              // modifier: { backgroundColor: this.activeMode === 'Orbit' ? '#FFD95F02'.replace('FF', '26') : '#FFF', borderColor: '#E1CDB2', borderWidth: 1, borderRadius: 12, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Orbit' }
                // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, fontColor: '#2E2924' }
                Text('Orbit').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#2E2924')
              }.backgroundColor(this.activeMode === 'Orbit' ? '#26D95F02' : '#FFF').borderColor('#E1CDB2').borderWidth(1).borderRadius(12).padding({ left: 12, right: 12, top: 8, bottom: 8 }).onClick(() => { this.activeMode = 'Orbit' })

              // === Button ===
              // modifier: { backgroundColor: this.activeMode === 'Eclipse' ? '#FFD95F02'.replace('FF', '26') : '#FFF', borderColor: '#E1CDB2', borderWidth: 1, borderRadius: 12, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Eclipse' }
                // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, fontColor: '#2E2924' }
                Text('Eclipse').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#2E2924')
              }.backgroundColor(this.activeMode === 'Eclipse' ? '#26D95F02' : '#FFF').borderColor('#E1CDB2').borderWidth(1).borderRadius(12).padding({ left: 12, right: 12, top: 8, bottom: 8 }).onClick(() => { this.activeMode = 'Eclipse' })

              // === Button ===
              // modifier: { backgroundColor: this.activeMode === 'Manual' ? '#FFD95F02'.replace('FF', '26') : '#FFF', borderColor: '#E1CDB2', borderWidth: 1, borderRadius: 12, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Manual' }
                // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, fontColor: '#2E2924' }
                Text('Manual').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#2E2924')
              }.backgroundColor(this.activeMode === 'Manual' ? '#26D95F02' : '#FFF').borderColor('#E1CDB2').borderWidth(1).borderRadius(12).padding({ left: 12, right: 12, top: 8, bottom: 8 }).onClick(() => { this.activeMode = 'Manual' })
            }

            // === Column ===
            // props: { space: 8 }
            // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF', borderRadius: 20, shadow: { radius: 4, color: '#1F000000', offsetY: 2 } }
            // children: 6
            Column({ space: 8 }) {
              // === Text ===
              // props: { text: 'Solar wash' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Semibold, fontColor: '#2E2924' }
              Text('Solar wash').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#2E2924')
              // === Text ===
              // props: { text: 'Adjust orbital window glow' }
              // modifier: { fontSize: 13, fontWeight: FontWeight.Regular, fontColor: '#473F37' }
              Text('Adjust orbital window glow').fontSize(13).fontWeight(FontWeight.Regular).fontColor('#473F37')
              // === Slider ===
              // props: { value: this.solarLevel * 100, min: 0, max: 100, style: SliderStyle.OutSet }
              // modifier: { width: '100%', selectedColor: '#D95F02', trackColor: '#E0E0E0', trackHeight: 4 }
              Slider({ value: this.solarLevel * 100, min: 0, max: 100, style: SliderStyle.OutSet }).width('100%').selectedColor('#D95F02').trackColor('#E0E0E0').height(4)
              // === Row ===
              // props: { space: 0 }
              // modifier: { width: '100%' }
              // children: 3
              Row() {
                // === Text ===
                // props: { text: '0%' }
                // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, fontColor: '#2E2924' }
                Text('0%').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#2E2924')
                // === Blank ===
                Blank()
                // === Text ===
                // props: { text: `${Math.round(this.solarLevel * 100)}%` }
                // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#D95F02' }
                Text(`${Math.round(this.solarLevel * 100)}%`).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#D95F02')
              }
              // === Text ===
              // props: { text: 'Ambient glow' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Semibold, fontColor: '#2E2924' }
              Text('Ambient glow').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#2E2924')
              // === Slider ===
              // props: { value: this.ambientGlow * 100, min: 0, max: 100, style: SliderStyle.OutSet }
              // modifier: { width: '100%', selectedColor: '#1B9AAA', trackColor: '#E0E0E0', trackHeight: 4 }
              Slider({ value: this.ambientGlow * 100, min: 0, max: 100, style: SliderStyle.OutSet }).width('100%').selectedColor('#1B9AAA').trackColor('#E0E0E0').height(4)
              // === Progress ===
              // props: { value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear }
              // modifier: { width: '100%', height: 4, color: '#1B9AAA', backgroundColor: '#F0E3D1', borderRadius: 2 }
              Progress({ value: this.ambientGlow * 100, total: 100, type: ProgressType.Linear }).width('100%').height(4).color('#1B9AAA').backgroundColor('#F0E3D1').borderRadius(2)
            }

            // === Column ===
            // props: { space: 8 }
            // modifier: { width: '100%', padding: 16, backgroundColor: '#F0E3D1', borderRadius: 20, shadow: { radius: 4, color: '#1F000000', offsetY: 2 } }
            // children: 4
            Column({ space: 8 }) {
              // === Text ===
              // props: { text: 'Orbit health' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Semibold, fontColor: '#2E2924' }
              Text('Orbit health').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#2E2924')
              // === StatusRow ===
              // props: { label: 'Atmos mix', value: 0.74, accent: '#1B9AAA' }
              StatusRow({ label: 'Atmos mix', value: 0.74, accent: '#1B9AAA' })
              // === StatusRow ===
              // props: { label: 'Hull temp', value: 0.42, accent: '#D95F02' }
              StatusRow({ label: 'Hull temp', value: 0.42, accent: '#D95F02' })
              // === StatusRow ===
              // props: { label: 'Shield sync', value: 0.88, accent: '#FEC601' }
              StatusRow({ label: 'Shield sync', value: 0.88, accent: '#FEC601' })
            }

            // === Column ===
            // props: { space: 8 }
            // modifier: { width: '100%', padding: 16, backgroundColor: '#FFF', borderRadius: 20, shadow: { radius: 4, color: '#1F000000', offsetY: 2 } }
            // children: 4
            Column({ space: 8 }) {
              // === Text ===
              // props: { text: 'Deck zones' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Semibold, fontColor: '#2E2924' }
              Text('Deck zones').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#2E2924')
              // === ForEach ===
              // items: this.zones
              ForEach(this.zones, (item: Zone) => {
                // === ZoneRow ===
                // props: { zone: item }
                ZoneRow({ zone: item })
              })
            }
          }
        }

        // === Row ===
        // props: { space: 0 }
        // modifier: { width: '100%', padding: { left: 16, right: 16, top: 8, bottom: 8 }, backgroundColor: '#FFF', shadow: { radius: 8, color: '#29000000', offsetY: 4 } }
        // children: 2
        Row() {
          // === Column ===
          // props: { space: 4 }
          // modifier: { alignItems: ItemAlign.Start }
          // children: 2
          Column({ space: 4 }) {
            // === Text ===
            // props: { text: 'Grid draw' }
            // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, fontColor: '#2E2924' }
            Text('Grid draw').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#2E2924')
            // === Text ===
            // props: { text: '18.4 kWh' }
            // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#D95F02' }
            Text('18.4 kWh').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#D95F02')
          }
          // === Blank ===
          Blank()
          // === Button ===
          // modifier: { backgroundColor: '#D95F02', borderRadius: 16, padding: { left: 12, right: 12, top: 8, bottom: 8 } }
          // children: 1
          Button() {
            // === Text ===
            // props: { text: 'Engage eco hold' }
            // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, fontColor: '#1B1B1B' }
            Text('Engage eco hold').fontSize(11).fontWeight(FontWeight.Medium).fontColor('#1B1B1B')
          }.backgroundColor('#D95F02').borderRadius(16).padding({ left: 12, right: 12, top: 8, bottom: 8 })
        }
      }
    }
  }
}

interface Zone {
  name: string
  humidity: number
  temp: string
}

@Component
struct StatusRow {
  controller: Scroller = new Scroller()
  label: string = ''
  value: number = 0
  accent: string = ''

  build() {
    // === Column ===
    // props: { space: 4 }
    // modifier: { alignItems: ItemAlign.Start }
    // children: 2
    Column({ space: 4 }) {
      // === Row ===
      // props: { space: 0 }
      // modifier: { width: '100%' }
      // children: 3
      Row() {
        // === Text ===
        // props: { text: this.label }
        // modifier: { fontSize: 13, fontWeight: FontWeight.Regular, fontColor: '#2E2924' }
        Text(this.label).fontSize(13).fontWeight(FontWeight.Regular).fontColor('#2E2924')
        // === Blank ===
        Blank()
        // === Text ===
        // props: { text: `${Math.round(this.value * 100)}%` }
        // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, fontColor: this.accent }
        Text(`${Math.round(this.value * 100)}%`).fontSize(11).fontWeight(FontWeight.Medium).fontColor(this.accent)
      }
      // === Progress ===
      // props: { value: this.value * 100, total: 100, type: ProgressType.Linear }
      // modifier: { width: '100%', height: 4, color: this.accent, backgroundColor: '#E0E0E0', borderRadius: 2 }
      Progress({ value: this.value * 100, total: 100, type: ProgressType.Linear }).width('100%').height(4).color(this.accent).backgroundColor('#E0E0E0').borderRadius(2)
    }
  }
}

@Component
struct ZoneRow {
  controller: Scroller = new Scroller()
  zone: Zone = { name: '', humidity: 0, temp: '' }

  build() {
    // === Column ===
    // props: { space: 4 }
    // modifier: { width: '100%', padding: 8, backgroundColor: '#F0E3D1'.replace('FF', '80'), borderRadius: 12 }
    // children: 2
    Column({ space: 4 }) {
      // === Row ===
      // props: { space: 0 }
      // modifier: { width: '100%' }
      // children: 3
      Row() {
        // === Text ===
        // props: { text: this.zone.name }
        // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#2E2924' }
        Text(this.zone.name).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#2E2924')
        // === Blank ===
        Blank()
        // === Text ===
        // props: { text: this.zone.temp }
        // modifier: { fontSize: 11, fontWeight: FontWeight.Medium, fontColor: '#D95F02' }
        Text(this.zone.temp).fontSize(11).fontWeight(FontWeight.Medium).fontColor('#D95F02')
      }
      // === Progress ===
      // props: { value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear }
      // modifier: { width: '100%', height: 4, color: '#1B9AAA', backgroundColor: '#E0E0E0', borderRadius: 2 }
      Progress({ value: this.zone.humidity * 100, total: 100, type: ProgressType.Linear }).width('100%').height(4).color('#1B9AAA').backgroundColor('#E0E0E0').borderRadius(2)
    }
  }
}