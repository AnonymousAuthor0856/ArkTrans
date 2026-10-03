// Index.ets

class ShadowSpec {
  elevation: number = 0;
  radius: number = 0;
  dy: number = 0;
  opacity: number = 0;

  constructor(elevation: number, radius: number, dy: number, opacity: number) {
    this.elevation = elevation;
    this.radius = radius;
    this.dy = dy;
    this.opacity = opacity;
  }
}

interface LinearGradientColorStop {
  color: ResourceColor;
  offset?: number;
}

@Entry
@Component
struct RootScreen {
  @State name: string = '';
  @State code: string = '';
  @State selectedSeat: number = 0;
  @State showDialog: boolean = false;

  private seatTabs: string[] = ['Economy', 'Premium', 'Business'];

  private gradientColors: LinearGradientColorStop[] = [
    { color: '#4060A5FA', offset: 0 },
    { color: '#FFF5F8FF', offset: 0.5 },
    { color: '#332563EB', offset: 1 }
  ];

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // Top App Bar
        Row() {
          Circle({ width: 22, height: 22 }).fill('#FF1E3A8A').margin({ left: 18 });

          Text('Flight Check-in')
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FF0B1220')
            .layoutWeight(1)
            .textAlign(TextAlign.Center);

          Circle({ width: 22, height: 22 }).fill('#FF2563EB').margin({ right: 18 });
        }
        .width('100%')
        .height(56);

        // Content
        Column() {
          // Passenger Card
          Column() {
            Text('Passenger')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF0B1220')
              .margin({ bottom: 10 });

            TextInput({ placeholder: 'Full name', text: this.name })
              .onChange((value: string) => {
                this.name = value;
              })
              .backgroundColor('#FFE8EEFA')
              .borderRadius(12)
              .height(48)
              .margin({ bottom: 14 });

            Text('Booking Code')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF0B1220')
              .margin({ bottom: 10 });

            TextInput({ placeholder: 'e.g. XY7ZK2', text: this.code })
              .onChange((value: string) => {
                this.code = value;
              })
              .backgroundColor('#FFE8EEFA')
              .borderRadius(12)
              .height(48)
              .margin({ bottom: 14 });

            Text('Seat Class')
              .fontSize(20)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF0B1220')
              .margin({ bottom: 10 });

            // Segmented Button Row
            Row() {
              ForEach(this.seatTabs, (label: string, index: number) => {
                Button(label)
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor(this.selectedSeat === index ? '#FFFFFFFF' : '#FF0B1220')
                  .backgroundColor(this.selectedSeat === index ? '#FF1E3A8A' : '#FFE8EEFA')
                  .layoutWeight(1)
                  .height(36)
                  .borderRadius(0)
                  .onClick(() => {
                    this.selectedSeat = index;
                  });
              }, (label: string, index: number) => `${label}-${index}`);
            }
            .backgroundColor('#FFE8EEFA')
            .borderRadius(12)
            .clip(true);
          }
          .width('100%')
          .padding(18)
          .backgroundColor('#FFFFFFFF')
          .borderRadius(18)
          .shadow({ radius: 8, color: '#291E3A8A', offsetX: 0, offsetY: 4 })
          .margin({ bottom: 18 });

          // Flight Details Card
          Column() {
            Row() {
              Column() {
                Text('Flight')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FF0B1220');
                Text('BL 213 • HND → CTS')
                  .fontSize(14)
                  .fontColor('#FF0B1220');
              }
              .alignItems(HorizontalAlign.Start);

              Circle({ width: 36, height: 36 }).fill('#FF2563EB');
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .margin({ bottom: 14 });

            Row() {
              Column() {
                Text('Boarding')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FF0B1220');
                Text('12:35')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FF1E3A8A');
              }
              .alignItems(HorizontalAlign.Start);

              Column() {
                Text('Gate')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FF0B1220');
                Text('A12')
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FF1E3A8A');
              }
              .alignItems(HorizontalAlign.Start);

              Column() {
                Text('Seat')
                  .fontSize(12)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FF0B1220');
                Text(this.selectedSeat === 0 ? '23C' : (this.selectedSeat === 1 ? '11A' : '2F'))
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#FF1E3A8A');
              }
              .alignItems(HorizontalAlign.Start);
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .alignItems(VerticalAlign.Center)
            .margin({ bottom: 14 });

            Button('Confirm Check-in')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFFFF')
              .backgroundColor('#FF1E3A8A')
              .width('100%')
              .height(52)
              .borderRadius(18)
              .onClick(() => {
                this.showDialog = true;
              });
          }
          .width('100%')
          .padding(18)
          .backgroundColor('#FFFFFFFF')
          .borderRadius(18)
          .shadow({ radius: 8, color: '#291E3A8A', offsetX: 0, offsetY: 4 });
        }
        .width('100%')
        .layoutWeight(1)
        .padding({ left: 18, right: 18, top: 14, bottom: 14 })
        .linearGradient({
          angle: 180,
          colors: this.gradientColors
        });
      }
      .width('100%')
      .height('100%');

      // Alert Dialog
      if (this.showDialog) {
        Stack({ alignContent: Alignment.Center }) {
          // Backdrop
          Column()
            .width('100%')
            .height('100%')
            .backgroundColor('#80000000')
            .onClick(() => {
              this.showDialog = false;
            });

          // Dialog Content
          Column() {
            Text('Check-in Successful')
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FF0B1220')
              .margin({ bottom: 10 });

            Text('Boarding pass is ready. Have a nice flight.')
              .fontSize(14)
              .fontColor('#FF0B1220')
              .margin({ bottom: 18 });

            Button('Done')
              .fontSize(12)
              .fontWeight(FontWeight.Medium)
              .fontColor('#FFFFFFFF')
              .backgroundColor('#FF2563EB')
              .borderRadius(12)
              .height(36)
              .padding({ left: 16, right: 16 })
              .onClick(() => {
                this.showDialog = false;
              });
          }
          .width('80%')
          .padding(24)
          .backgroundColor('#FFFFFFFF')
          .borderRadius(18)
          .align(Alignment.Center);
        }
        .width('100%')
        .height('100%');
      }
    }
    .width('100%')
    .height('100%');
  }
}