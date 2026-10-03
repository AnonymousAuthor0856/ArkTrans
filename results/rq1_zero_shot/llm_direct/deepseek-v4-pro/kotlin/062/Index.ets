import { display } from '@kit.ArkUI';

@Entry
@Component
struct RootScreen {
  @State targetTemp: number = 22;
  @State mode: string = 'Cool';
  @State currentMode: string = 'Cool';

  private readonly primaryColor: string = '#3B82F6';
  private readonly secondaryColor: string = '#06B6D4';
  private readonly tertiaryColor: string = '#0EA5E9';
  private readonly backgroundColor: string = '#F0F9FF';
  private readonly surfaceColor: string = '#FFFFFF';
  private readonly surfaceVariantColor: string = '#E0F2FE';
  private readonly outlineColor: string = '#CBD5E1';
  private readonly onPrimaryColor: string = '#FFFFFF';
  private readonly onBackgroundColor: string = '#0F172A';
  private readonly onSurfaceColor: string = '#1E293B';

  @Builder
  ModeButton(label: string, icon: string, current: string, onSelect: (label: string) => void) {
    Column({ space: 4 }) {
      Button({ type: ButtonType.Capsule }) {
        Column({ space: 4 }) {
          Text(icon, { fontSize: 32 })
          Text(label, { fontSize: 14, fontWeight: FontWeight.Medium })
        }
      }
      .width(100)
      .height(100)
      .backgroundColor(label === current ? this.primaryColor : this.surfaceVariantColor)
      .fontColor(label === current ? this.onPrimaryColor : this.onSurfaceColor)
      .onClick(() => {
        onSelect(label);
      })
    }
  }

  build() {
    Column() {
      // Top App Bar
      Row() {
        Text('🌡️', { fontSize: 24 })
          .margin({ left: 12 })
        Text('ThermoCurve', { fontSize: 26, fontWeight: FontWeight.Bold })
          .layoutWeight(1)
          .textAlign(TextAlign.Center)
        Button({ type: ButtonType.Circle }) {
          Text('☀️', { fontSize: 24 })
        }
        .width(40)
        .height(40)
        .backgroundColor(Color.Transparent)
        .margin({ right: 12 })
        .onClick(() => {
          this.targetTemp++;
        })
      }
      .width('100%')
      .height(56)
      .backgroundColor(this.surfaceVariantColor)
      .alignItems(VerticalAlign.Center)

      // Main Content
      Column({ space: 26 }) {
        Text('Target Temperature', { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: this.onSurfaceColor })
          .margin({ top: 18 })

        Text(`${this.targetTemp}°C`, { fontSize: 48, fontWeight: FontWeight.Bold, fontColor: this.primaryColor })

        Row({ space: 12 }) {
          Button() {
            Text('–', { fontSize: 20, fontColor: this.onPrimaryColor })
          }
          .width(60)
          .height(40)
          .backgroundColor(this.primaryColor)
          .onClick(() => {
            if (this.targetTemp > 10) {
              this.targetTemp--;
            }
          })

          Button() {
            Text('+', { fontSize: 20, fontColor: this.onPrimaryColor })
          }
          .width(60)
          .height(40)
          .backgroundColor(this.primaryColor)
          .onClick(() => {
            if (this.targetTemp < 35) {
              this.targetTemp++;
            }
          })
        }

        Divider()
          .width('80%')
          .height(1)
          .backgroundColor(this.outlineColor)
          .opacity(0.5)

        Text('Mode', { fontSize: 18, fontWeight: FontWeight.Medium, fontColor: this.onSurfaceColor })

        Row({ space: 18 }) {
          this.ModeButton('Cool', '💨', this.mode, (label: string) => {
            this.mode = label;
          })
          this.ModeButton('Heat', '☀️', this.mode, (label: string) => {
            this.mode = label;
          })
        }

        Text(`Current Mode: ${this.mode}`, { fontSize: 12, fontColor: this.onSurfaceColor })
      }
      .width('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      .linearGradient({
        direction: GradientDirection.Bottom,
        colors: [[this.secondaryColor, 0.15], [this.primaryColor, 0.2]]
      })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.backgroundColor)
  }
}