@Entry
@Component
struct Index {
  @State solarLevel: number = 0.5
  @State ambientGlow: number = 0.3

  build() {
    Stack() {
      Column({ space: 0 }) {
        Row() {
          Button('Menu')
            .type(ButtonType.Capsule)
            .backgroundColor(Color.Transparent)
            .borderWidth(1)
            .borderColor('#E0E0E0')
            .width(40)
            .height(40)
        
          Blank()
          
          Text('Smart Orbit Panel')
            .fontColor('#2E2924')
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
          
          Blank()
          
          Button('More')
            .type(ButtonType.Capsule)
            .backgroundColor(Color.Transparent)
            .borderWidth(1)
            .borderColor('#E0E0E0')
            .width(40)
            .height(40)
        }
        .width('100%')
        .height(56)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FDFBF7')

        Scroll() {
          Column() {
            // Mode Selection Row
            Row() {
              ForEach(['Mode A', 'Mode B', 'Mode C'], (mode: string) => {
                Button(mode)
                  .margin({ right: 8 })
                  .backgroundColor(mode === 'Mode A' ? '#D95F02' : '#F0E3D1')
                  .fontColor(mode === 'Mode A' ? '#FFFFFF' : '#2E2924')
                  .borderRadius(16)
                  .padding({ left: 12, right: 12, top: 8, bottom: 8 })
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.Start)

            // Solar Wash Card
            Column() {
              Text('Solar wash')
                .fontColor('#2E2924')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
              
              Text('Adjust orbital window glow')
                .fontColor('#2E2924')
                .opacity(0.7)
                .fontSize(13)
                .margin({ top: 4 })
              
              Slider({ value: this.solarLevel, min: 0, max: 1 })
                .width('100%')
                .trackThickness(4)
                .selectedColor('#D95F02')
                .margin({ top: 16, bottom: 16 })
              
              Row() {
                Text('0%')
                  .fontColor('#2E2924')
                  .fontSize(11)
                
                Blank()
                
                Text(`${Math.round(this.solarLevel * 100)}%`)
                  .fontColor('#D95F02')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
              }
              .width('100%')
              
              Text('Ambient glow')
                .fontColor('#2E2924')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
                .margin({ top: 16 })
              
              Slider({ value: this.ambientGlow, min: 0, max: 1 })
                .width('100%')
                .trackThickness(4)
                .selectedColor('#1B9AAA')
                .margin({ top: 16, bottom: 16 })
              
              Progress({
                value: this.ambientGlow,
                total: 1,
                type: ProgressType.Linear
              })
                .width('100%')
                .height(4)
                .borderRadius(2)
                .backgroundColor('#F0E3D1')
                .color('#1B9AAA')
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FDFBF7')
            .borderRadius(16)
            .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
            .margin({ bottom: 16 })

            // Orbit Health Card
            Column() {
              Text('Orbit health')
                .fontColor('#2E2924')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
              
              // Health Item 1
              Column() {
                Row() {
                  Text('Stability')
                    .fontColor('#2E2924')
                    .fontSize(13)
                  
                  Blank()
                  
                  Text('85%')
                    .fontColor('#D95F02')
                    .fontSize(11)
                }
                .width('100%')
                
                Progress({
                  value: 0.85,
                  total: 1,
                  type: ProgressType.Linear
                })
                  .width('100%')
                  .height(4)
                  .borderRadius(2)
                  .backgroundColor('#FFFFFF')
                  .color('#D95F02')
                  .margin({ top: 4 })
              }
              .margin({ top: 16 })

              // Health Item 2
              Column() {
                Row() {
                  Text('Efficiency')
                    .fontColor('#2E2924')
                    .fontSize(13)
                  
                  Blank()
                  
                  Text('92%')
                    .fontColor('#1B9AAA')
                    .fontSize(11)
                }
                .width('100%')
                
                Progress({
                  value: 0.92,
                  total: 1,
                  type: ProgressType.Linear
                })
                  .width('100%')
                  .height(4)
                  .borderRadius(2)
                  .backgroundColor('#FFFFFF')
                  .color('#1B9AAA')
                  .margin({ top: 4 })
              }
              .margin({ top: 16 })

              // Health Item 3
              Column() {
                Row() {
                  Text('Output')
                    .fontColor('#2E2924')
                    .fontSize(13)
                  
                  Blank()
                  
                  Text('78%')
                    .fontColor('#D95F02')
                    .fontSize(11)
                }
                .width('100%')
                
                Progress({
                  value: 0.78,
                  total: 1,
                  type: ProgressType.Linear
                })
                  .width('100%')
                  .height(4)
                  .borderRadius(2)
                  .backgroundColor('#FFFFFF')
                  .color('#D95F02')
                  .margin({ top: 4 })
              }
              .margin({ top: 16 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#F0E3D1')
            .borderRadius(16)
            .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
            .margin({ bottom: 16 })

            // Deck Zones Card
            Column() {
              Text('Deck zones')
                .fontColor('#2E2924')
                .fontSize(20)
                .fontWeight(FontWeight.Bold)
              
              ForEach([
                { name: 'Zone Alpha', temp: '24°C', humidity: 0.6 },
                { name: 'Zone Beta', temp: '22°C', humidity: 0.4 },
                { name: 'Zone Gamma', temp: '26°C', humidity: 0.8 }
              ] as ZoneData[], (zone: ZoneData) => {
                Column() {
                  Row() {
                    Text(zone.name)
                      .fontColor('#2E2924')
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                    
                    Blank()
                    
                    Text(zone.temp)
                      .fontColor('#D95F02')
                      .fontSize(11)
                  }
                  .width('100%')
                  
                  Progress({
                    value: zone.humidity,
                    total: 1,
                    type: ProgressType.Linear
                  })
                    .width('100%')
                    .height(4)
                    .borderRadius(2)
                    .backgroundColor('#FFFFFF')
                    .color('#1B9AAA')
                    .margin({ top: 8 })
                }
                .width('100%')
                .padding(12)
                .backgroundColor('#F0E3D1')
                .opacity(0.5)
                .borderRadius(8)
                .margin({ bottom: 8 })
              })
            }
            .width('100%')
            .padding(16)
            .backgroundColor('#FDFBF7')
            .borderRadius(16)
            .shadow({ radius: 4, color: '#1A000000', offsetY: 2 })
            .margin({ bottom: 16 })
          }
          .width('100%')
          .padding({ top: 8, bottom: 8, left: 16, right: 16 })
        }
        .layoutWeight(1)

        // Bottom Bar
        Row() {
          Column() {
            Text('Grid draw')
              .fontColor('#2E2924')
              .fontSize(11)
            
            Text('18.4 kWh')
              .fontColor('#D95F02')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
          }
          
          Blank()
          
          Button('Settings')
            .fontColor('#2E2924')
        }
        .width('100%')
        .height(60)
        .padding({ left: 16, right: 16 })
        .backgroundColor('#FDFBF7')
        .shadow({ radius: 4, color: '#26000000', offsetY: -2 })
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}

interface ZoneData {
  name: string;
  temp: string;
  humidity: number;
}