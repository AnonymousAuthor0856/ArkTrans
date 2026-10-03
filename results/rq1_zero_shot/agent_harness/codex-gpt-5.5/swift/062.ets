class AppColors {
  static primary: string = '#3B82F6';
  static secondary: string = '#06B6D4';
  static tertiary: string = '#0EA5E9';
  static background: string = '#F0F9FF';
  static surface: string = '#FFFFFF';
  static surfaceVariant: string = '#E0F2FE';
  static outline: string = '#CBD5E1';
  static onPrimary: string = '#FFFFFF';
  static onBackground: string = '#0F172A';
  static onSurface: string = '#1E293B';
}

class AppSpacing {
  static sm: number = 8;
  static md: number = 12;
  static lg: number = 18;
  static xl: number = 26;
}

@Entry
@Component
struct RootScreen {
  @State private targetTemp: number = 22;
  @State private mode: string = 'Cool';

  @Builder
  private ModeButton(label: string, icon: string) {
    Column({ space: 6 }) {
      Text(icon)
        .fontSize(32)
        .fontColor(this.mode === label ? AppColors.onPrimary : AppColors.onSurface)
      Text(label)
        .fontSize(12)
        .fontColor(this.mode === label ? AppColors.onPrimary : AppColors.onSurface)
    }
    .justifyContent(FlexAlign.Center)
    .width(100)
    .height(100)
    .backgroundColor(this.mode === label ? AppColors.primary : AppColors.surfaceVariant)
    .borderRadius(50)
    .shadow({ radius: 5, color: '#0000001A', offsetX: 0, offsetY: 5 })
    .onClick(() => {
      this.mode = label;
    })
  }

  @Builder
  private TopBar() {
    Row() {
      Text('♨')
        .fontSize(24)
        .fontColor(AppColors.primary)
        .margin({ left: AppSpacing.md })
      Blank()
      Text('ThermoCurve')
        .fontSize(26)
        .fontWeight(FontWeight.Bold)
        .fontColor(AppColors.onSurface)
      Blank()
      Text('☀')
        .fontSize(24)
        .fontColor(AppColors.secondary)
        .margin({ right: AppSpacing.md })
        .onClick(() => {
          this.targetTemp += 1;
        })
    }
    .width('100%')
    .height(56)
    .backgroundColor(AppColors.surfaceVariant)
  }

  build() {
    Column({ space: 0 }) {
      this.TopBar()

      Column({ space: AppSpacing.xl }) {
        Text('Target Temperature')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        Text(`${this.targetTemp}°C`)
          .fontSize(48)
          .fontWeight(FontWeight.Bold)
          .fontColor(AppColors.primary)

        Row({ space: AppSpacing.md }) {
          Button('–')
            .width(60)
            .height(60)
            .fontSize(20)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(8)
            .onClick(() => {
              if (this.targetTemp > 10) {
                this.targetTemp -= 1;
              }
            })
          Button('+')
            .width(60)
            .height(60)
            .fontSize(20)
            .fontColor(AppColors.onPrimary)
            .backgroundColor(AppColors.primary)
            .borderRadius(8)
            .onClick(() => {
              if (this.targetTemp < 35) {
                this.targetTemp += 1;
              }
            })
        }

        Divider()
          .width('80%')
          .height(1)
          .color('#CBD5E180')

        Text('Mode')
          .fontSize(18)
          .fontWeight(FontWeight.SemiBold)
          .fontColor(AppColors.onSurface)

        Row({ space: AppSpacing.lg }) {
          this.ModeButton('Cool', '≋')
          this.ModeButton('Heat', '☀')
        }

        Text(`Current Mode: ${this.mode}`)
          .fontSize(12)
          .fontColor(AppColors.onSurface)
      }
      .padding(AppSpacing.lg)
      .width('100%')
      .layoutWeight(1)
      .backgroundColor(AppColors.background)
    }
    .width('100%')
    .height('100%')
  }
}
