// AppTokens
const primaryColor: string = '#3B82F6';
const secondaryColor: string = '#06B6D4';
const tertiaryColor: string = '#0EA5E9';
const backgroundColor: string = '#F0F9FF';
const surfaceColor: string = '#FFFFFF';
const surfaceVariantColor: string = '#E0F2FE';
const outlineColor: string = '#CBD5E1';
const onPrimaryColor: string = '#FFFFFF';
const onBackgroundColor: string = '#0F172A';
const onSurfaceColor: string = '#1E293B';

const spacingSm: number = 8;
const spacingMd: number = 12;
const spacingLg: number = 18;
const spacingXl: number = 26;

const shapeSmall: number = 8;
const shapeMedium: number = 12;
const shapeLarge: number = 18;

@Component
struct ModeButton {
  label: string = '';
  isCool: boolean = true;
  @Prop currentMode: string = '';
  onSelect: (mode: string) => void = () => {};

  build() {
    Button() {
      Column({ space: 6 }) {
        if (this.isCool) {
          // Wind icon drawn with shapes
          Column() {
            Row() {
              Text('≋')
                .fontSize(28)
                .fontColor(this.label === this.currentMode ? onPrimaryColor : onSurfaceColor)
                .fontWeight(FontWeight.Bold)
            }
          }
          .width(32)
          .height(32)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
        } else {
          // Sun icon drawn with shapes
          Stack() {
            Circle()
              .width(16)
              .height(16)
              .fill(this.label === this.currentMode ? onPrimaryColor : onSurfaceColor)
            Text('✦')
              .fontSize(28)
              .fontColor(this.label === this.currentMode ? onPrimaryColor : onSurfaceColor)
          }
          .width(32)
          .height(32)
          .alignContent(Alignment.Center)
        }
        Text(this.label)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(this.label === this.currentMode ? onPrimaryColor : onSurfaceColor)
      }
      .width(100)
      .height(100)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
    }
    .width(100)
    .height(100)
    .borderRadius(50)
    .backgroundColor(this.label === this.currentMode ? primaryColor : surfaceVariantColor)
    .shadow({ radius: 5, color: '#1A000000', offsetX: 0, offsetY: 5 })
    .onClick(() => {
      this.onSelect(this.label);
    })
  }
}

@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';

  build() {
    Column() {
      // Top Bar
      Row() {
        // Thermometer icon using text symbol
        Text('🌡')
          .fontSize(22)
          .fontColor(primaryColor)
          .margin({ left: spacingMd })
          .width(32)
          .textAlign(TextAlign.Center)

        Blank()

        Text('ThermoCurve')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor(onSurfaceColor)

        Blank()

        // Sun icon button using text symbol
        Button() {
          Text('☀')
            .fontSize(22)
            .fontColor(secondaryColor)
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
        .margin({ right: spacingMd })
        .onClick(() => {
          this.targetTemp += 1;
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor(surfaceVariantColor)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column({ space: spacingXl }) {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(primaryColor)

        Row({ space: spacingMd }) {
          Button('–')
            .fontSize(20)
            .fontWeight(FontWeight.Normal)
            .fontColor(onPrimaryColor)
            .width(60)
            .height(60)
            .backgroundColor(primaryColor)
            .borderRadius(shapeSmall)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp -= 1;
              }
            })

          Button('+')
            .fontSize(20)
            .fontWeight(FontWeight.Normal)
            .fontColor(onPrimaryColor)
            .width(60)
            .height(60)
            .backgroundColor(primaryColor)
            .borderRadius(shapeSmall)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp += 1;
              }
            })
        }

        Divider()
          .width('80%')
          .strokeWidth(1)
          .color('#80CBD5E1')

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(onSurfaceColor)

        Row({ space: spacingLg }) {
          ModeButton({
            label: 'Cool',
            isCool: true,
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            }
          })

          ModeButton({
            label: 'Heat',
            isCool: false,
            currentMode: this.mode,
            onSelect: (selectedMode: string) => {
              this.mode = selectedMode;
            }
          })
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontWeight(FontWeight.Normal)
          .fontColor(onSurfaceColor)
      }
      .padding(spacingLg)
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [
          ['#2606B6D4', 0.0],
          ['#333B82F6', 1.0]
        ]
      })
      .backgroundColor(backgroundColor)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(backgroundColor)
  }
}