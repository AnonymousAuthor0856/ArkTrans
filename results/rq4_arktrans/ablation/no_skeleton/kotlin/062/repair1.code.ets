@Entry
@Component
struct ThermoCurve {
  @State targetTemp: number = 22
  @State mode: string = 'Cool'

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.Top }
    // children: 2
    Stack({ alignContent: Alignment.Top }) {
      // === Column ===
      // props: { space: 26 }
      // modifier: { width: '100%', height: '100%', padding: 18, backgroundColor: '#F0F9FF' }
      // children: 5
      Column({ space: 26 }) {
        // === Row ===
        // props: { space: 12 }
        // modifier: { width: '100%', justifyContent: FlexAlign.SpaceBetween, alignItems: ItemAlign.Center }
        // children: 3
        Row() {
          // === Image ===
          // modifier: { width: 24, height: 24 }
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor('#3B82F6')

          // === Text ===
          // props: { text: 'ThermoCurve' }
          // modifier: { fontSize: 26, fontWeight: FontWeight.Bold, color: '#1E293B' }
          Text('ThermoCurve')
            .fontSize(26)
            .fontWeight(FontWeight.Bold)
            .fontColor('#1E293B')

          // === Image ===
          // modifier: { width: 24, height: 24 }
          Image($r('app.media.startIcon'))
            .width(24)
            .height(24)
            .objectFit(ImageFit.Contain)
            .fillColor('#06B6D4')
        }.width('100%').justifyContent(FlexAlign.SpaceBetween).alignItems(VerticalAlign.Center)

        // === Column ===
        // props: { space: 12 }
        // modifier: { width: '100%', alignItems: HorizontalAlign.Center }
        // children: 3
        Column({ space: 12 }) {
          // === Text ===
          // props: { text: 'Target Temperature' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold, color: '#1E293B' }
          Text('Target Temperature')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          // === Text ===
          // props: { text: `${this.targetTemp}°C` }
          // modifier: { fontSize: 48, fontWeight: FontWeight.Bold, color: '#3B82F6' }
          Text(`${this.targetTemp}°C`)
            .fontSize(48)
            .fontWeight(FontWeight.Bold)
            .fontColor('#3B82F6')

          // === Row ===
          // props: { space: 12 }
          // modifier: { width: '100%', justifyContent: FlexAlign.Center }
          // children: 2
          Row({ space: 12 }) {
            // === Button ===
            // modifier: { width: 60, height: 60, backgroundColor: '#3B82F6', borderRadius: 30 }
            // children: 1
            Button() {
              // === Text ===
              // props: { text: '–' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, color: '#FFF' }
              Text('–')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFF')
            }
            .width(60)
            .height(60)
            .backgroundColor('#3B82F6')
            .borderRadius(30)
            .onClick(() => {
              if (this.targetTemp > 10) this.targetTemp--
            })

            // === Button ===
            // modifier: { width: 60, height: 60, backgroundColor: '#3B82F6', borderRadius: 30 }
            // children: 1
            Button() {
              // === Text ===
              // props: { text: '+' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Bold, color: '#FFF' }
              Text('+')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .fontColor('#FFF')
            }
            .width(60)
            .height(60)
            .backgroundColor('#3B82F6')
            .borderRadius(30)
            .onClick(() => {
              if (this.targetTemp < 35) this.targetTemp++
            })
          }.width('100%').justifyContent(FlexAlign.Center)
        }.width('100%').alignItems(HorizontalAlign.Center)

        // === Divider ===
        // modifier: { width: '80%', height: 1, color: '#CBD5E1' }
        Divider()
          .width('80%')
          .color('#CBD5E1')

        // === Column ===
        // props: { space: 18 }
        // modifier: { width: '100%', alignItems: HorizontalAlign.Center }
        // children: 3
        Column({ space: 18 }) {
          // === Text ===
          // props: { text: 'Mode' }
          // modifier: { fontSize: 18, fontWeight: FontWeight.SemiBold, color: '#1E293B' }
          Text('Mode')
            .fontSize(18)
            .fontWeight(FontWeight.Medium)
            .fontColor('#1E293B')

          // === Row ===
          // props: { space: 18 }
          // modifier: { width: '100%', justifyContent: FlexAlign.Center }
          // children: 2
          Row({ space: 18 }) {
            // === Button ===
            // modifier: { width: 100, height: 100, backgroundColor: ${this.mode === 'Cool' ? '#3B82F6' : '#E0F2FE'}, borderRadius: 50 }
            // children: 1
            Button() {
              // === Column ===
              // props: { space: 4 }
              // modifier: { alignItems: HorizontalAlign.Center }
              // children: 2
              Column({ space: 4 }) {
                // === Image ===
                // modifier: { width: 32, height: 32 }
                Image($r('app.media.startIcon'))
                  .width(32)
                  .height(32)
                  .objectFit(ImageFit.Contain)
                  .fillColor(this.mode === 'Cool' ? '#FFF' : '#1E293B')

                // === Text ===
                // props: { text: 'Cool' }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: ${this.mode === 'Cool' ? '#FFF' : '#1E293B'} }
                Text('Cool')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.mode === 'Cool' ? '#FFF' : '#1E293B')
              }.alignItems(HorizontalAlign.Center)
            }
            .width(100)
            .height(100)
            .backgroundColor(this.mode === 'Cool' ? '#3B82F6' : '#E0F2FE')
            .borderRadius(50)
            .onClick(() => {
              this.mode = 'Cool'
            })

            // === Button ===
            // modifier: { width: 100, height: 100, backgroundColor: ${this.mode === 'Heat' ? '#3B82F6' : '#E0F2FE'}, borderRadius: 50 }
            // children: 1
            Button() {
              // === Column ===
              // props: { space: 4 }
              // modifier: { alignItems: HorizontalAlign.Center }
              // children: 2
              Column({ space: 4 }) {
                // === Image ===
                // modifier: { width: 32, height: 32 }
                Image($r('app.media.startIcon'))
                  .width(32)
                  .height(32)
                  .objectFit(ImageFit.Contain)
                  .fillColor(this.mode === 'Heat' ? '#FFF' : '#1E293B')

                // === Text ===
                // props: { text: 'Heat' }
                // modifier: { fontSize: 14, fontWeight: FontWeight.Medium, color: ${this.mode === 'Heat' ? '#FFF' : '#1E293B'} }
                Text('Heat')
                  .fontSize(14)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.mode === 'Heat' ? '#FFF' : '#1E293B')
              }.alignItems(HorizontalAlign.Center)
            }
            .width(100)
            .height(100)
            .backgroundColor(this.mode === 'Heat' ? '#3B82F6' : '#E0F2FE')
            .borderRadius(50)
            .onClick(() => {
              this.mode = 'Heat'
            })
          }.width('100%').justifyContent(FlexAlign.Center)

          // === Text ===
          // props: { text: `Current Mode: ${this.mode}` }
          // modifier: { fontSize: 12, fontWeight: FontWeight.Normal, color: '#1E293B' }
          Text(`Current Mode: ${this.mode}`)
            .fontSize(12)
            .fontWeight(FontWeight.Normal)
            .fontColor('#1E293B')
        }.width('100%').alignItems(HorizontalAlign.Center)
      }.width('100%').height('100%').padding(18).backgroundColor('#F0F9FF')
    }.width('100%').height('100%')
  }
}