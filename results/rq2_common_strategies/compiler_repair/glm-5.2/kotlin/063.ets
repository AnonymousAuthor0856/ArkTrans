// Index.ets
import { Length, ResourceStr } from '@ohos.arkui';

class AppColors {
  primary: ResourceColor = '#FF3B82F6';
  secondary: ResourceColor = '#FF22C55E';
  background: ResourceColor = '#FFF5F5F4';
  surface: ResourceColor = '#FFFFFFFF';
  outline: ResourceColor = '#FFD4D4D8';
  onPrimary: ResourceColor = '#FFFFFFFF';
  onBackground: ResourceColor = '#FF111827';
  onSurface: ResourceColor = '#FF1F2937';
  accent: ResourceColor = '#FFF59E0B';
}

class AppSpacing {
  sm: Length = 6;
  md: Length = 10;
  lg: Length = 14;
  xl: Length = 20;
}

const Colors = new AppColors();
const Spacing = new AppSpacing();

@Entry
@Component
struct RootScreen {
  @State progress: number = 0.45;

  build() {
    Column() {
      // Top App Bar
      Row() {
        Image($r('app.media.ic_car'))
          .width(24)
          .height(24)
          .fillColor(Colors.primary as ResourceColor)
          .margin({ right: 8 })

        Text('Charging Progress')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground as ResourceColor)
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Image($r('app.media.ic_settings'))
          .width(24)
          .height(24)
          .fillColor(Colors.accent as ResourceColor)
          .margin({ left: 8 })
      }
      .width('100%')
      .height(56)
      .padding({ left: 16, right: 16 })
      .backgroundColor(Colors.surface as ResourceColor)

      // Content
      Column() {
        Image($r('app.media.ic_battery'))
          .width(72)
          .height(72)
          .fillColor(Colors.primary as ResourceColor)
          .margin({ top: 20, bottom: 20 })

        Text(`${Math.floor(this.progress * 100)}%`)
          .fontSize(40)
          .fontWeight(FontWeight.Bold)
          .fontColor(Colors.onBackground as ResourceColor)
          .margin({ bottom: 20 })

        // Progress Bar
        Stack({ alignContent: Alignment.Start }) {
          // Track
          Column()
            .width('100%')
            .height(14)
            .backgroundColor(Colors.surface as ResourceColor)
            .border({ width: 1, color: Colors.outline as ResourceColor, radius: 7 })

          // Progress
          Column()
            .width(`${this.progress * 100}%`)
            .height(14)
            .backgroundColor(Colors.primary as ResourceColor)
            .borderRadius(7)
        }
        .width('80%')
        .height(14)
        .margin({ bottom: 20 })

        Button('Simulate Charge')
          .type(ButtonType.Capsule)
          .backgroundColor(Colors.secondary as ResourceColor)
          .fontColor(Colors.onPrimary as ResourceColor)
          .onClick(() => {
            let next = this.progress + 0.1;
            if (next > 1.0) {
              this.progress = 0.0;
            } else {
              this.progress = next;
            }
          })
          .margin({ bottom: 20 })

        Text(this.progress < 1.0 ? 'Charging...' : 'Fully Charged!')
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.progress < 1.0 ? Colors.primary as ResourceColor : Colors.secondary as ResourceColor)
      }
      .width('100%')
      .layoutWeight(1)
      .padding(Spacing.lg)
      .alignItems(HorizontalAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(Colors.background as ResourceColor)
  }
}