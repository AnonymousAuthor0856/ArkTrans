@Entry
@Component
struct FlightCheckinApp {
  @State name: string = ''
  @State code: string = ''
  @State selectedSeat: number = 0
  @State showDialog: boolean = false

  private seatTabs: string[] = ['Economy', 'Premium', 'Business']

  build() {
    // === Stack (ZStack) ===
    // props: {}
    // children: 2
    Stack() {
      // === Column (Background Gradient) ===
      // modifier: { width: '100%', height: '100%' }
      Column() {
        // Simulating LinearGradient with a solid color or gradient component if available. 
        // Using a simple background color for the base as ArkTS gradients can be verbose, 
        // but to match the visual style of the screenshot which is very light blue/white:
      }.width('100%').height('100%').backgroundColor('#F5F8FF')

      // === Column (Main Content) ===
      // props: { space: 0 }
      // modifier: { width: '100%', height: '100%' }
      // children: 2
      Column() {
        // === Row (Header) ===
        // props: { space: 0 }
        // modifier: { width: '100%', height: 56, marginBottom: 14 }
        // children: 3
        Row() {
          // === Circle (Left Icon) ===
          // modifier: { width: 22, height: 22, backgroundColor: '#1E3A8A', marginLeft: 18 }
          Image($r('app.media.startIcon')).width(22).height(22).objectFit(ImageFit.Cover).borderRadius(11).margin({ left: 18 })
          
          // === Blank ===
          Blank()
          
          // === Text ===
          // props: { text: 'Flight Check-in' }
          // modifier: { fontSize: 28, fontWeight: FontWeight.Bold, fontColor: '#0B1220' }
          Text('Flight Check-in').fontSize(28).fontWeight(FontWeight.Bold).fontColor('#0B1220')
          
          // === Blank ===
          Blank()
          
          // === Circle (Right Icon) ===
          // modifier: { width: 22, height: 22, backgroundColor: '#2563EB', marginRight: 18 }
          Image($r('app.media.startIcon')).width(22).height(22).objectFit(ImageFit.Cover).borderRadius(11).margin({ right: 18 }).backgroundColor('#2563EB')
        }.width('100%').height(56).margin({ bottom: 14 })

        // === Scroll (ScrollView) ===
        // modifier: { width: '100%', layoutWeight: 1, padding: { left: 18, right: 18, top: 14, bottom: 14 } }
        // children: 1
        Scroll() {
          // === Column (Scroll Content) ===
          // props: { space: 18 }
          // modifier: { width: '100%' }
          // children: 2
          Column() {
            // === Column (Passenger Card) ===
            // props: { space: 18 }
            // modifier: { width: '100%', padding: 26, backgroundColor: '#FFF', borderRadius: 18, shadow: { radius: 8, color: '#29000000', offsetY: 4 } }
            // children: 5
            Column() {
              // === Text ===
              // props: { text: 'Passenger' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Semibold, fontColor: '#0B1220' }
              Text('Passenger').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#0B1220')

              // === TextInput ===
              // modifier: { width: '100%', height: 48, backgroundColor: '#E8EEFA', borderRadius: 12, borderColor: '#CBD5E1', borderWidth: 1, placeholderColor: '#9CA3AF', paddingLeft: 14 }
              TextInput({ placeholder: 'Full name' }).type(InputType.Normal).width('100%').height(48).backgroundColor('#E8EEFA').borderRadius(12).border({ width: 1, color: '#CBD5E1' }).placeholderColor('#9CA3AF').margin({ bottom: 18 })

              // === Text ===
              // props: { text: 'Booking Code' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Semibold, fontColor: '#0B1220' }
              Text('Booking Code').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#0B1220')

              // === TextInput ===
              // modifier: { width: '100%', height: 48, backgroundColor: '#E8EEFA', borderRadius: 12, borderColor: '#CBD5E1', borderWidth: 1, placeholderColor: '#9CA3AF', paddingLeft: 14 }
              TextInput({ placeholder: 'e.g. XY7ZK2' }).type(InputType.Normal).width('100%').height(48).backgroundColor('#E8EEFA').borderRadius(12).border({ width: 1, color: '#CBD5E1' }).placeholderColor('#9CA3AF').margin({ bottom: 18 })

              // === Text ===
              // props: { text: 'Seat Class' }
              // modifier: { fontSize: 20, fontWeight: FontWeight.Semibold, fontColor: '#0B1220' }
              Text('Seat Class').fontSize(20).fontWeight(FontWeight.Medium).fontColor('#0B1220')

              // === Custom Segmented Control ===
              // Implemented inline to match structure
              // === Row ===
              // props: { space: 0 }
              // modifier: { width: '100%', height: 40, borderRadius: 12, borderColor: '#CBD5E1', borderWidth: 1, marginTop: 10 }
              // children: 3
              Row() {
                // Segment 1: Economy
                Button() {
                  Row() {
                    if (this.selectedSeat === 0) {
                      Text('✓').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#FFF').margin({ right: 6 })
                    }
                    Text('Economy').fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.selectedSeat === 0 ? '#FFF' : '#0B1220')
                  }.justifyContent(FlexAlign.Center).width('100%')
                }
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedSeat === 0 ? '#1E3A8A' : '#E8EEFA')
                .borderRadius(12)
                .layoutWeight(1)
                .onClick(() => { this.selectedSeat = 0 })

                // Segment 2: Premium
                Button() {
                  Row() {
                    if (this.selectedSeat === 1) {
                      Text('✓').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#FFF').margin({ right: 6 })
                    }
                    Text('Premium').fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.selectedSeat === 1 ? '#FFF' : '#0B1220')
                  }.justifyContent(FlexAlign.Center).width('100%')
                }
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedSeat === 1 ? '#1E3A8A' : '#E8EEFA')
                .borderRadius(0)
                .layoutWeight(1)
                .onClick(() => { this.selectedSeat = 1 })

                // Segment 3: Business
                Button() {
                  Row() {
                    if (this.selectedSeat === 2) {
                      Text('✓').fontSize(14).fontWeight(FontWeight.Medium).fontColor('#FFF').margin({ right: 6 })
                    }
                    Text('Business').fontSize(12).fontWeight(FontWeight.Medium).fontColor(this.selectedSeat === 2 ? '#FFF' : '#0B1220')
                  }.justifyContent(FlexAlign.Center).width('100%')
                }
                .type(ButtonType.Normal)
                .backgroundColor(this.selectedSeat === 2 ? '#1E3A8A' : '#E8EEFA')
                .borderRadius(12)
                .layoutWeight(1)
                .onClick(() => { this.selectedSeat = 2 })
              }.width('100%').height(40).borderRadius(12).border({ width: 1, color: '#CBD5E1' }).margin({ top: 10 })
            }.width('100%').padding(26).backgroundColor('#FFF').borderRadius(18).shadow({ radius: 8, color: '#29000000', offsetY: 4 })

            // === Column (Flight Details Card) ===
            // props: { space: 14 }
            // modifier: { width: '100%', padding: 18, backgroundColor: '#FFF', borderRadius: 18, shadow: { radius: 8, color: '#29000000', offsetY: 4 } }
            // children: 3
            Column() {
              // === Row (Flight Info) ===
              // props: { space: 0 }
              // modifier: { width: '100%', padding: 14, backgroundColor: '#FFF', borderRadius: 12 }
              // children: 2
              Row() {
                // === Column ===
                // props: { space: 6 }
                // modifier: { layoutWeight: 1 }
                // children: 2
                Column() {
                  // === Text ===
                  // props: { text: 'Flight' }
                  // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
                  Text('Flight').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  
                  // === Text ===
                  // props: { text: 'BL 213 • HND → CTS' }
                  // modifier: { fontSize: 14, fontWeight: FontWeight.Regular, fontColor: '#0B1220' }
                  Text('BL 213 • HND → CTS').fontSize(14).fontWeight(FontWeight.Regular).fontColor('#0B1220')
                }.layoutWeight(1)

                // === Image (Plane Icon Placeholder) ===
                // modifier: { width: 36, height: 36, backgroundColor: '#2563EB', borderRadius: 18 }
                Image($r('app.media.startIcon')).width(36).height(36).objectFit(ImageFit.Cover).borderRadius(18).backgroundColor('#2563EB')
              }.width('100%').padding(14).backgroundColor('#FFF').borderRadius(12)

              // === Row (Details Grid) ===
              // props: { space: 0 }
              // modifier: { width: '100%', padding: { top: 14, bottom: 14 } }
              // children: 3
              Row() {
                // === Column (Boarding) ===
                // props: { space: 0 }
                // modifier: { layoutWeight: 1 }
                // children: 2
                Column() {
                  // === Text ===
                  // props: { text: 'Boarding' }
                  // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
                  Text('Boarding').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  
                  // === Text ===
                  // props: { text: '12:35' }
                  // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#1E3A8A' }
                  Text('12:35').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#1E3A8A')
                }.layoutWeight(1)

                // === Column (Gate) ===
                // props: { space: 0 }
                // modifier: { layoutWeight: 1 }
                // children: 2
                Column() {
                  // === Text ===
                  // props: { text: 'Gate' }
                  // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
                  Text('Gate').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  
                  // === Text ===
                  // props: { text: 'A12' }
                  // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#1E3A8A' }
                  Text('A12').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#1E3A8A')
                }.layoutWeight(1)

                // === Column (Seat) ===
                // props: { space: 0 }
                // modifier: { layoutWeight: 1 }
                // children: 2
                Column() {
                  // === Text ===
                  // props: { text: 'Seat' }
                  // modifier: { fontSize: 12, fontWeight: FontWeight.Medium, fontColor: '#0B1220' }
                  Text('Seat').fontSize(12).fontWeight(FontWeight.Medium).fontColor('#0B1220')
                  
                  // === Text ===
                  // props: { text: Seat Number Logic }
                  // modifier: { fontSize: 16, fontWeight: FontWeight.Medium, fontColor: '#1E3A8A' }
                  Text(this.getSeatNumber()).fontSize(16).fontWeight(FontWeight.Medium).fontColor('#1E3A8A')
                }.layoutWeight(1)
              }.width('100%').padding({ top: 14, bottom: 14 })

              // === Button ===
              // modifier: { width: '100%', height: 52, backgroundColor: '#1E3A8A', borderRadius: 18, fontColor: '#FFF', fontSize: 16, fontWeight: FontWeight.Medium }
              // children: 1
              Button() {
                // === Text ===
                // props: { text: 'Confirm Check-in' }
                Text('Confirm Check-in').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFF')
              }.width('100%').height(52).backgroundColor('#1E3A8A').borderRadius(18).onClick(() => { this.showDialog = true })
            }.width('100%').padding(18).backgroundColor('#FFF').borderRadius(18).shadow({ radius: 8, color: '#29000000', offsetY: 4 })
          }.width('100%')
        }.width('100%').layoutWeight(1).padding({ left: 18, right: 18, top: 14, bottom: 14 })
      }.width('100%').height('100%')

      // Dialog implementation using custom overlay since standard AlertDialog might vary by API version
      if (this.showDialog) {
        Stack() {
          Column() {}.width('100%').height('100%').backgroundColor('#000000').opacity(0.5).onClick(() => { this.showDialog = false })
          
          Column() {
            Text('Check-in Successful').fontSize(20).fontWeight(FontWeight.Bold).fontColor('#0B1220').margin({ bottom: 10 })
            Text('Boarding pass is ready. Have a nice flight.').fontSize(14).fontColor('#666666').textAlign(TextAlign.Center).margin({ bottom: 20 })
            
            Button() {
              Text('Done').fontSize(16).fontWeight(FontWeight.Medium).fontColor('#FFF')
            }.width('100%').height(44).backgroundColor('#1E3A8A').borderRadius(12).onClick(() => { this.showDialog = false })
          }.width('80%').padding(24).backgroundColor('#FFF').borderRadius(16)
        }.width('100%').height('100%').position({ x: 0, y: 0 })
      }
    }.width('100%').height('100%')
  }

  getSeatNumber(): string {
    if (this.selectedSeat === 0) return '23C'
    if (this.selectedSeat === 1) return '11A'
    return '2F'
  }
}