@Entry
@Component
struct Index {
  @State targetTemp: number = 21.5
  @State isActive: boolean = true

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // === HeaderSection ===
        Row() {
          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#1C1C1E')
          }
          .backgroundColor(Color.Transparent)
          .borderRadius(8)

          Column() {
            Text('LIVING ROOM')
              .fontSize(14)
              .fontWeight(FontWeight.Bold)
              .fontColor('#8E8E93')
              .letterSpacing(2)
            Text('Connected')
              .fontSize(12)
              .fontColor('#007AFF')
          }
          .alignItems(HorizontalAlign.Center)

          Button() {
            Image($r('app.media.startIcon'))
              .width(24)
              .height(24)
              .fillColor('#1C1C1E')
          }
          .backgroundColor(Color.Transparent)
          .borderRadius(8)
        }
        .justifyContent(FlexAlign.SpaceBetween)
        .alignItems(VerticalAlign.Center)
        .width('100%')
        .padding({ top: 16, bottom: 16 })

        Blank().height(40)

        // === TemperatureDialSection ===
        Column() {
          Stack({ alignContent: Alignment.Center }) {
            // Background Track (Simulated with Circle)
            Circle()
              .width(240)
              .height(240)
              .fill('#F2F2F7')

            // Active Progress Arc (Simulated with Canvas)
            Canvas()
              .width(240)
              .height(240)
              .onDraw((context: CanvasRenderingContext2D) => {
                const centerX = 120;
                const centerY = 120;
                const radius = 110;
                const strokeWidth = 20;
                
                context.lineWidth = strokeWidth;
                context.lineCap = 'round';
                context.strokeStyle = '#007AFF';
                
                // Draw arc from -135deg to roughly -45deg based on temp
                // Start angle: -135 degrees in radians
                const startAngle = -135 * Math.PI / 180;
                // End angle calculation for visual representation
                const endAngle = -45 * Math.PI / 180; 
                
                context.beginPath();
                context.arc(centerX, centerY, radius, startAngle, endAngle, false);
                context.stroke();

                // Draw the "Thumb" dot at the end of the arc
                const thumbX = centerX + radius * Math.cos(endAngle);
                const thumbY = centerY + radius * Math.sin(endAngle);
                
                context.fillStyle = '#FFFFFF';
                context.beginPath();
                context.arc(thumbX, thumbY, 10, 0, 2 * Math.PI);
                context.fill();
                
                context.strokeStyle = '#007AFF';
                context.lineWidth = 3;
                context.stroke();
              })

            Column() {
              Text(`${this.targetTemp}°`)
                .fontSize(56)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.isActive ? '#1C1C1E' : '#8E8E93')
              Text(this.isActive ? 'COOLING' : 'OFF')
                .fontSize(16)
                .fontWeight(FontWeight.Medium)
                .fontColor('#8E8E93')
            }
            .alignItems(HorizontalAlign.Center)
          }
          .width(280)
          .height(280)

          Blank().height(32)

          // Controls Row
          Row() {
            // Down Button
            Button() {
              Image($r('app.media.startIcon'))
                .width(28)
                .height(28)
                .fillColor(this.isActive ? '#1C1C1E' : '#D1D1D6')
            }
            .width(56)
            .height(56)
            .borderRadius(28)
            .backgroundColor(this.isActive ? '#F2F2F7' : '#F9F9F9')
            .onClick(() => {
              if (this.isActive) this.targetTemp -= 0.5;
            })

            // Switch
            Toggle({ type: ToggleType.Switch, isOn: this.isActive })
              .selectedColor('#1C1C1E')
              .width(56)
              .height(32)
              .onChange((isOn: boolean) => {
                this.isActive = isOn;
              })

            // Up Button
            Button() {
              Image($r('app.media.startIcon'))
                .width(28)
                .height(28)
                .fillColor(this.isActive ? '#1C1C1E' : '#D1D1D6')
            }
            .width(56)
            .height(56)
            .borderRadius(28)
            .backgroundColor(this.isActive ? '#F2F2F7' : '#F9F9F9')
            .onClick(() => {
              if (this.isActive) this.targetTemp += 0.5;
            })
          }
          .justifyContent(FlexAlign.SpaceEvenly)
          .width('100%')
        }
        .alignItems(HorizontalAlign.Center)

        Blank().height(40)

        // === ControlGridSection ===
        Column() {
          Text('QUICK ACTIONS')
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .fontColor('#8E8E93')
            .letterSpacing(1)
            .margin({ bottom: 16 })

          Row() {
            // Card 1: Fan Speed
            Column() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#1C1C1E')
                Column() {
                  Text('Fan Speed')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1C1C1E')
                  Text('Auto')
                    .fontSize(12)
                    .fontColor('#8E8E93')
                }
                .alignItems(HorizontalAlign.Start)
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)
              .width('100%')
            }
            .width('100%')
            .height(100)
            .padding(16)
            .backgroundColor('#F2F2F7')
            .borderRadius(20)
            .layoutWeight(1)

            Blank().width(16)

            // Card 2: Eco Mode (Active)
            Column() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#FFFFFF')
                Column() {
                  Text('Eco Mode')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#FFFFFF')
                  Text('On')
                    .fontSize(12)
                    .fontColor('#A1A1A6')
                }
                .alignItems(HorizontalAlign.Start)
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)
              .width('100%')
            }
            .width('100%')
            .height(100)
            .padding(16)
            .backgroundColor('#1C1C1E')
            .borderRadius(20)
            .layoutWeight(1)
          }
          .width('100%')

          Blank().height(16)

          Row() {
             // Card 3: Timer
            Column() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#1C1C1E')
                Column() {
                  Text('Timer')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1C1C1E')
                  Text('Set 2h')
                    .fontSize(12)
                    .fontColor('#8E8E93')
                }
                .alignItems(HorizontalAlign.Start)
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)
              .width('100%')
            }
            .width('100%')
            .height(100)
            .padding(16)
            .backgroundColor('#F2F2F7')
            .borderRadius(20)
            .layoutWeight(1)

            Blank().width(16)

            // Card 4: Away
            Column() {
              Row() {
                Image($r('app.media.startIcon'))
                  .width(24)
                  .height(24)
                  .fillColor('#1C1C1E')
                Column() {
                  Text('Away')
                    .fontSize(14)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#1C1C1E')
                  Text('Off')
                    .fontSize(12)
                    .fontColor('#8E8E93')
                }
                .alignItems(HorizontalAlign.Start)
              }
              .justifyContent(FlexAlign.Start)
              .alignItems(VerticalAlign.Center)
              .width('100%')
            }
            .width('100%')
            .height(100)
            .padding(16)
            .backgroundColor('#F2F2F7')
            .borderRadius(20)
            .layoutWeight(1)
          }
          .width('100%')
        }
        .width('100%')
      }
      .width('100%')
      .height('100%')
      .padding(24)
      .backgroundColor('#FFFFFF')
    }
    .width('100%')
    .height('100%')
  }
}