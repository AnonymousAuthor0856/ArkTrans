@Entry
@Component
struct Index {
  @State switchState1: boolean = false
  @State switchState2: boolean = false
  @State switchState3: boolean = false
  @State switchState4: boolean = false

  build() {
    Stack() {
      Stack() {
        Scroll() {
          Column() {
            Blank().height(16)

            Row() {
              Column() {
                Text('Good Morning,').fontColor(Color.Gray).fontSize(16).fontWeight(FontWeight.Medium)
                Text('Alex Johnson').fontColor(Color.Black).fontSize(24).fontWeight(FontWeight.Bold)
              }
              Blank()
              Stack() {
                Circle().width(48).height(48).fill(Color.White)
                Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
              }
            }.padding({ left: 24, right: 24 })

            Blank().height(32)

            Column() {
              Row() {
                Column() {
                  Text('Energy Usage').fontColor('#FFFFFFCC').fontSize(14)
                  Text('28.5 kWh').fontColor(Color.White).fontSize(32).fontWeight(FontWeight.Bold)
                  Text('Today').fontColor('#FFFFFF99').fontSize(12)
                }
                Blank()
                Stack() {
                  Circle().width(56).height(56).fill('#FFFFFF33')
                  Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
                }
              }.padding(24)
            }.backgroundColor('#5F60CE').borderRadius(24).shadow({ radius: 8, color: '#0000001A', offsetX: 0, offsetY: 4 }).padding({ left: 24, right: 24 })

            Blank().height(32)

            Text('Scenes').fontColor(Color.Black).fontSize(20).fontWeight(FontWeight.Bold).padding({ left: 24, right: 24 })

            Blank().height(16)

            Scroll() {
              Row({ space: 12 }) {
                Blank().width(24).padding({ right: -12 })

                // Scene Item 1
                Row({ space: 8 }) {
                  Image($r('app.media.startIcon')).width(18).height(18).objectFit(ImageFit.Contain)
                  Text('Scene 1').fontColor(Color.Black).fontSize(14).fontWeight(FontWeight.Medium)
                }.backgroundColor(Color.White).borderRadius(30).padding({ left: 24, right: 24, top: 12, bottom: 12 })

                // Scene Item 2
                Row({ space: 8 }) {
                  Image($r('app.media.startIcon')).width(18).height(18).objectFit(ImageFit.Contain)
                  Text('Scene 2').fontColor(Color.Black).fontSize(14).fontWeight(FontWeight.Medium)
                }.backgroundColor(Color.White).borderRadius(30).padding({ left: 24, right: 24, top: 12, bottom: 12 })

                // Scene Item 3
                Row({ space: 8 }) {
                  Image($r('app.media.startIcon')).width(18).height(18).objectFit(ImageFit.Contain)
                  Text('Scene 3').fontColor(Color.Black).fontSize(14).fontWeight(FontWeight.Medium)
                }.backgroundColor(Color.White).borderRadius(30).padding({ left: 24, right: 24, top: 12, bottom: 12 })

                Blank().width(24).padding({ left: -12 })
              }
            }

            Blank().height(32)

            Text('Devices').fontColor(Color.Black).fontSize(20).fontWeight(FontWeight.Bold).padding({ left: 24, right: 24 })

            Blank().height(16)

            Row({ space: 16 }) {
              Column({ space: 16 }) {
                // Device Card 1
                Column() {
                  Row() {
                    Stack() {
                      Circle().width(40).height(40).fill(this.switchState1 ? '#5F60CE1A' : '#F0F0F0')
                      Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
                    }
                    Blank()
                  }
                  Blank()
                  Column({ space: 4 }) {
                    Text('Device 1').fontColor(Color.Black).fontSize(16).fontWeight(FontWeight.Bold)
                    Text(this.switchState1 ? 'On' : 'Off').fontColor(this.switchState1 ? '#5F60CE' : Color.Gray).fontSize(14).fontWeight(FontWeight.Medium)
                  }
                  Blank()
                  Row() {
                    Blank()
                    Toggle({ type: ToggleType.Switch })
                      .scale({ x: 0.8, y: 0.8 })
                      .switchStyle({ offColor: Color.Gray, onColor: '#5F60CE' })
                  }
                }.width('100%').aspectRatio(0.85).backgroundColor(Color.White).borderRadius(20).shadow({ radius: 2, color: '#0000000D', offsetX: 0, offsetY: 1 }).padding(16)

                // Device Card 2
                Column() {
                  Row() {
                    Stack() {
                      Circle().width(40).height(40).fill(this.switchState2 ? '#5F60CE1A' : '#F0F0F0')
                      Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
                    }
                    Blank()
                  }
                  Blank()
                  Column({ space: 4 }) {
                    Text('Device 2').fontColor(Color.Black).fontSize(16).fontWeight(FontWeight.Bold)
                    Text(this.switchState2 ? 'On' : 'Off').fontColor(this.switchState2 ? '#5F60CE' : Color.Gray).fontSize(14).fontWeight(FontWeight.Medium)
                  }
                  Blank()
                  Row() {
                    Blank()
                    Toggle({ type: ToggleType.Switch })
                      .scale({ x: 0.8, y: 0.8 })
                      .switchStyle({ offColor: Color.Gray, onColor: '#5F60CE' })
                  }
                }.width('100%').aspectRatio(0.85).backgroundColor(Color.White).borderRadius(20).shadow({ radius: 2, color: '#0000000D', offsetX: 0, offsetY: 1 }).padding(16)
              }

              Column({ space: 16 }) {
                // Device Card 3
                Column() {
                  Row() {
                    Stack() {
                      Circle().width(40).height(40).fill(this.switchState3 ? '#5F60CE1A' : '#F0F0F0')
                      Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
                    }
                    Blank()
                  }
                  Blank()
                  Column({ space: 4 }) {
                    Text('Device 3').fontColor(Color.Black).fontSize(16).fontWeight(FontWeight.Bold)
                    Text(this.switchState3 ? 'On' : 'Off').fontColor(this.switchState3 ? '#5F60CE' : Color.Gray).fontSize(14).fontWeight(FontWeight.Medium)
                  }
                  Blank()
                  Row() {
                    Blank()
                    Toggle({ type: ToggleType.Switch })
                      .scale({ x: 0.8, y: 0.8 })
                      .switchStyle({ offColor: Color.Gray, onColor: '#5F60CE' })
                  }
                }.width('100%').aspectRatio(0.85).backgroundColor(Color.White).borderRadius(20).shadow({ radius: 2, color: '#0000000D', offsetX: 0, offsetY: 1 }).padding(16)

                // Device Card 4
                Column() {
                  Row() {
                    Stack() {
                      Circle().width(40).height(40).fill(this.switchState4 ? '#5F60CE1A' : '#F0F0F0')
                      Image($r('app.media.startIcon')).width(24).height(24).objectFit(ImageFit.Contain)
                    }
                    Blank()
                  }
                  Blank()
                  Column({ space: 4 }) {
                    Text('Device 4').fontColor(Color.Black).fontSize(16).fontWeight(FontWeight.Bold)
                    Text(this.switchState4 ? 'On' : 'Off').fontColor(this.switchState4 ? '#5F60CE' : Color.Gray).fontSize(14).fontWeight(FontWeight.Medium)
                  }
                  Blank()
                  Row() {
                    Blank()
                    Toggle({ type: ToggleType.Switch })
                      .scale({ x: 0.8, y: 0.8 })
                      .switchStyle({ offColor: Color.Gray, onColor: '#5F60CE' })
                  }
                }.width('100%').aspectRatio(0.85).backgroundColor(Color.White).borderRadius(20).shadow({ radius: 2, color: '#0000000D', offsetX: 0, offsetY: 1 }).padding(16)
              }
            }.padding({ left: 24, right: 24 })

            Blank().height(24)
          }.padding({ top: 24, bottom: 24 })
        }
      }
    }.width('100%').height('100%')
  }
}